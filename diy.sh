#!/bin/bash
#=================================================
# Description: DIY script for OpenWrt
# Lisence: MIT
# Author: P3TERX & Customized
#=================================================

echo '========= 开始执行 DIY 自定义脚本 ========='

# 1. 核心修改：将默认后台登录 IP 修改为 192.168.88.8
echo '正在修改默认后台登录 IP 为 192.168.88.8 ...'
sed -i 's/192.168.1.1/192.168.88.8/g' package/base-files/files/bin/config_generate

# 2. 修改默认时区为中国上海 (CST-8)
echo '正在修改默认时区...'
sed -i "s/'UTC'/'CST-8'/g" package/base-files/files/bin/config_generate
sed -i "/set system.@system\[-1\].timezone='CST-8'/a \\\t\tset system.@system[-1].zonename='Asia/Shanghai'" package/base-files/files/bin/config_generate

# 3. 下载最新的 Argon 换肤主题及配置插件
echo '正在下载 jerrykuku 的 Argon 主题及配置后台...'
rm -rf package/luci-theme-argon
rm -rf package/luci-app-argon-config
git clone -b 18.06 https://github.com package/luci-theme-argon
git clone -b 18.06 https://github.com package/luci-app-argon-config

# 4. 强制将 Argon 设置为编译时的默认主题
echo '正在将 Argon 设为默认首选主题...'
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

echo '========= DIY 自定义脚本执行完毕 ========='


