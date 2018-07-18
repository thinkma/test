# 工程名 
APP_NAME="Test"
# 证书 
CODE_SIGN_DISTRIBUTION="Beijing Erlingjiujiu Network Technology Co., Ltd."

#打包模式 Debug/Release
development_mode=Debug

#scheme名 将XXX替换成自己的sheme名
scheme_name="Test"

#scheme名 将XXX替换成自己的sheme名
build_path=build

# info.plist路径 
project_infoplist_path="./${APP_NAME}/Info.plist" 

#plist文件所在路径
exportOptionsPlistPath="./shellHandle/exportOptionsPlist.plist"

#导出.ipa文件所在路径
exportIpaPath="./shellHandle/IPADir/${development_mode}"

#取版本号 
#bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleShortVersionString" "${project_infoplist_path}") 
#取build值 
#bundleVersion=$(/usr/libexec/PlistBuddy -c "print CFBundleVersion" "${project_infoplist_path}") 
DATE="$(date +%Y%m%d)" 
IPANAME="${APP_NAME}_V${bundleShortVersion}_${DATE}.ipa" 
#要上传的ipa文件路径 
IPA_PATH="$HOME/${IPANAME}" 
echo ${IPA_PATH} echo "${IPA_PATH}">> text.txt #获取权限 security unlock-keychain -p "打包机器登录密码" $HOME/Library/Keychains/login.keychain # //下面2行是没有Cocopods的用法 
# echo "=================clean=================" 
# xcodebuild -target "${APP_NAME}" -configuration 'Release' clean 
# echo "+++++++++++++++++build+++++++++++++++++" # xcodebuild -target "${APP_NAME}" -sdk iphoneos -configuration 'Release' CODE_SIGN_IDENTITY="${CODE_SIGN_DISTRIBUTION}" SYMROOT='$(PWD)' 
#//下面2行是集成有Cocopods的用法 
echo "=================clean=================" 
echo '///-----------'
echo '/// 正在清理工程'
echo '///-----------'
xcodebuild \
clean -configuration ${development_mode} -quiet  || exit

echo '///-----------'
echo '/// 正在编译工程:'${development_mode}
echo '///-----------'

xcodebuild \
archive -workspace ./${APP_NAME}.xcworkspace \
-scheme ${scheme_name} \
-configuration ${development_mode} \
-archivePath ./${build_path}/${APP_NAME}.xcarchive -quiet  || exit

echo '///--------'
echo '/// 编译完成'
echo '///--------'
echo ''

xcodebuild -exportArchive -archivePath ${build_path}/${APP_NAME}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportIpaPath} \
-exportOptionsPlist ${exportOptionsPlistPath} -allowProvisioningUpdates \
-quiet || exit





