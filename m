Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F279C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269F320811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="U5Mf7vt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfCHJ5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:57:06 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:58422 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:57:04 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x289uSqb003883;
        Fri, 8 Mar 2019 18:56:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x289uSqb003883
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552038989;
        bh=RgPK6RyeZQS/j5UUx+A+6DjCZHX16Ul3T0bN38trg6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5Mf7vt2Lj55D8v4cq5ylCQruTnP6JnFCKh6LKWQK2HqEBRvbN/FDiOjClhBDTklG
         x9BMLQElIweMk+QLXy8OTWdcCSurHVgmXR6X0RMXC9hrZWkIi8BNhU6ASmN4JV9d+G
         53I3XxLaze+i0kTenvYW0oQYAXM+8d8gLVIeblYuGnyIFX/mrGRb+JnEcVzH4hfJ2J
         ee2vMtOpsE0J6hK7R/rXaVqSv/VsUcHNPtrbui+NumMxeWPL1QZXIJfNPJxFnjItJ3
         JBNupGhbtx7a9LS84ZeLAuYe+TYpNXQCcxlOiBoFqcIYKUJAFXiLHCMNYyc6MPAGII
         vz2mzdjqsqB/A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kbuild: deb-pkg: introduce is_enabled and if_enabled_echo to builddeb
Date:   Fri,  8 Mar 2019 18:56:24 +0900
Message-Id: <1552038985-10473-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552038985-10473-1-git-send-email-yamada.masahiro@socionext.com>
References: <1552038985-10473-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think is_enabled() and if_enable_echo() in scripts/package/mkdebian
are useful.

builddeb also has many repetitive greps over the kernel config, so I
borrowed the idea to clean it up.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/package/builddeb | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 8ac25d1..e2cb438 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -12,6 +12,18 @@
 
 set -e
 
+is_enabled() {
+	grep -q "^$1=y" $KCONFIG_CONFIG
+}
+
+if_enabled_echo() {
+	if is_enabled "$1"; then
+		echo -n "$2"
+	elif [ $# -ge 3 ]; then
+		echo -n "$3"
+	fi
+}
+
 create_package() {
 	local pname="$1" pdir="$2"
 
@@ -62,7 +74,7 @@ parisc|mips|powerpc)
 	installed_image_path="boot/vmlinuz-$version"
 esac
 
-BUILD_DEBUG="$(grep -s '^CONFIG_DEBUG_INFO=y' $KCONFIG_CONFIG || true)"
+BUILD_DEBUG=$(if_enabled_echo CONFIG_DEBUG_INFO Yes)
 
 # Setup the directory structure
 rm -rf "$tmpdir" "$kernel_headers_dir" "$libc_headers_dir" "$dbg_dir" $objtree/debian/files
@@ -83,14 +95,14 @@ else
 fi
 cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
 
-if grep -q "^CONFIG_OF_EARLY_FLATTREE=y" $KCONFIG_CONFIG ; then
+if is_enabled CONFIG_OF_EARLY_FLATTREE; then
 	# Only some architectures with OF support have this target
 	if [ -d "${srctree}/arch/$SRCARCH/boot/dts" ]; then
 		$MAKE -f $srctree/Makefile INSTALL_DTBS_PATH="$tmpdir/usr/lib/$packagename" dtbs_install
 	fi
 fi
 
-if grep -q '^CONFIG_MODULES=y' $KCONFIG_CONFIG ; then
+if is_enabled CONFIG_MODULES; then
 	INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_install
 	rm -f "$tmpdir/lib/modules/$version/build"
 	rm -f "$tmpdir/lib/modules/$version/source"
@@ -111,8 +123,7 @@ if grep -q '^CONFIG_MODULES=y' $KCONFIG_CONFIG ; then
 		done
 
 		# resign stripped modules
-		MODULE_SIG_ALL="$(grep -s '^CONFIG_MODULE_SIG_ALL=y' $KCONFIG_CONFIG || true)"
-		if [ -n "$MODULE_SIG_ALL" ]; then
+		if is_enabled CONFIG_MODULE_SIG_ALL; then
 			INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_sign
 		fi
 	fi
@@ -129,11 +140,6 @@ fi
 # make-kpkg sets $INITRD to indicate whether an initramfs is wanted, and
 # so do we; recent versions of dracut and initramfs-tools will obey this.
 debhookdir=${KDEB_HOOKDIR:-/etc/kernel}
-if grep -q '^CONFIG_BLK_DEV_INITRD=y' $KCONFIG_CONFIG; then
-	want_initrd=Yes
-else
-	want_initrd=No
-fi
 for script in postinst postrm preinst prerm ; do
 	mkdir -p "$tmpdir$debhookdir/$script.d"
 	cat <<EOF > "$tmpdir/DEBIAN/$script"
@@ -145,7 +151,7 @@ set -e
 export DEB_MAINT_PARAMS="\$*"
 
 # Tell initramfs builder whether it's wanted
-export INITRD=$want_initrd
+export INITRD=$(if_enabled_echo CONFIG_BLK_DEV_INITRD Yes No)
 
 test -d $debhookdir/$script.d && run-parts --arg="$version" --arg="/$installed_image_path" $debhookdir/$script.d
 exit 0
@@ -158,11 +164,11 @@ done
 (cd $srctree; find arch/*/include include scripts -type f -o -type l) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
-if grep -q '^CONFIG_STACK_VALIDATION=y' $KCONFIG_CONFIG ; then
+if is_enabled CONFIG_STACK_VALIDATION; then
 	(cd $objtree; find tools/objtool -type f -executable) >> "$objtree/debian/hdrobjfiles"
 fi
 (cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -type f) >> "$objtree/debian/hdrobjfiles"
-if grep -q '^CONFIG_GCC_PLUGINS=y' $KCONFIG_CONFIG ; then
+if is_enabled CONFIG_GCC_PLUGINS; then
 	(cd $objtree; find scripts/gcc-plugins -name \*.so -o -name gcc-common.h) >> "$objtree/debian/hdrobjfiles"
 fi
 destdir=$kernel_headers_dir/usr/src/linux-headers-$version
-- 
2.7.4

