Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C5CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B609120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355377;
	bh=a+SAccTr/Xxf0H/51vmwzgEZzN+2/IacJZ4Cl2sT2Ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D3G6vn4txsz22E40GAoparRYQedkp5cNdgvOe5EaHKayW+K/n/zPBQtsUBd5sC3Cw
	 ADCb5YyfwyVDtTqaIxZLRr6omS1+bsdPUw77e1pWJWb5MvQp5Dnh3WxiBkR3yFIQzG
	 mbsFMsQKbrM1qdxdnwVSuy07VneXitB8lby6vGf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbfDOTJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730750AbfDOTJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECE0218D3;
        Mon, 15 Apr 2019 19:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355371;
        bh=a+SAccTr/Xxf0H/51vmwzgEZzN+2/IacJZ4Cl2sT2Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9O6oizEIDe03iapjgEU5mjqhqWkK9cfee9iKiox+CfpKcK9HnxcHbZEEptrraHJ3
         9YwyM9jGbgB8H7rr/AL2lK3EaWb5djQ0fArkzq6MXpdQVsN7+z2DUweAq99KI+eoMQ
         tRcCC0oy3pLtuHI8urdEYPhOfOsJqfa8q1OfI/mw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 002/117] kbuild: pkg: use -f $(srctree)/Makefile to recurse to top Makefile
Date:   Mon, 15 Apr 2019 20:59:32 +0200
Message-Id: <20190415183745.005800803@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 175209cce23d6b0669ed5366add2517e26cd75cd ]

'$(MAKE) KBUILD_SRC=' changes the working directory back and forth
between objtree and srctree.

It is better to recurse to the top-level Makefile directly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/package/Makefile |  4 ++--
 scripts/package/builddeb | 10 +++++-----
 scripts/package/buildtar |  2 +-
 scripts/package/mkdebian |  6 ++++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 453fecee62f0..aa39c2b5e46a 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -59,7 +59,7 @@ rpm-pkg: FORCE
 # binrpm-pkg
 # ---------------------------------------------------------------------------
 binrpm-pkg: FORCE
-	$(MAKE) KBUILD_SRC=
+	$(MAKE) -f $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/binkernel.spec
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE) -bb $(objtree)/binkernel.spec
@@ -102,7 +102,7 @@ clean-dirs += $(objtree)/snap/
 # tarball targets
 # ---------------------------------------------------------------------------
 tar%pkg: FORCE
-	$(MAKE) KBUILD_SRC=
+	$(MAKE) -f $(srctree)/Makefile
 	$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
 
 clean-dirs += $(objtree)/tar-install/
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index f43a274f4f1d..8ac25d10a6ad 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -86,12 +86,12 @@ cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
 if grep -q "^CONFIG_OF_EARLY_FLATTREE=y" $KCONFIG_CONFIG ; then
 	# Only some architectures with OF support have this target
 	if [ -d "${srctree}/arch/$SRCARCH/boot/dts" ]; then
-		$MAKE KBUILD_SRC= INSTALL_DTBS_PATH="$tmpdir/usr/lib/$packagename" dtbs_install
+		$MAKE -f $srctree/Makefile INSTALL_DTBS_PATH="$tmpdir/usr/lib/$packagename" dtbs_install
 	fi
 fi
 
 if grep -q '^CONFIG_MODULES=y' $KCONFIG_CONFIG ; then
-	INSTALL_MOD_PATH="$tmpdir" $MAKE KBUILD_SRC= modules_install
+	INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_install
 	rm -f "$tmpdir/lib/modules/$version/build"
 	rm -f "$tmpdir/lib/modules/$version/source"
 	if [ "$ARCH" = "um" ] ; then
@@ -113,14 +113,14 @@ if grep -q '^CONFIG_MODULES=y' $KCONFIG_CONFIG ; then
 		# resign stripped modules
 		MODULE_SIG_ALL="$(grep -s '^CONFIG_MODULE_SIG_ALL=y' $KCONFIG_CONFIG || true)"
 		if [ -n "$MODULE_SIG_ALL" ]; then
-			INSTALL_MOD_PATH="$tmpdir" $MAKE KBUILD_SRC= modules_sign
+			INSTALL_MOD_PATH="$tmpdir" $MAKE -f $srctree/Makefile modules_sign
 		fi
 	fi
 fi
 
 if [ "$ARCH" != "um" ]; then
-	$MAKE headers_check KBUILD_SRC=
-	$MAKE headers_install KBUILD_SRC= INSTALL_HDR_PATH="$libc_headers_dir/usr"
+	$MAKE -f $srctree/Makefile headers_check
+	$MAKE -f $srctree/Makefile headers_install INSTALL_HDR_PATH="$libc_headers_dir/usr"
 fi
 
 # Install the maintainer scripts
diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index d624a07a4e77..cfd2a4a3fe42 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -57,7 +57,7 @@ dirs=boot
 # Try to install modules
 #
 if grep -q '^CONFIG_MODULES=y' "${KCONFIG_CONFIG}"; then
-	make ARCH="${ARCH}" O="${objtree}" KBUILD_SRC= INSTALL_MOD_PATH="${tmpdir}" modules_install
+	make ARCH="${ARCH}" -f ${srctree}/Makefile INSTALL_MOD_PATH="${tmpdir}" modules_install
 	dirs="$dirs lib"
 fi
 
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index edcad61fe3cd..f030961c5165 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -205,13 +205,15 @@ EOF
 cat <<EOF > debian/rules
 #!$(command -v $MAKE) -f
 
+srctree ?= .
+
 build:
 	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
-	KBUILD_BUILD_VERSION=${revision} KBUILD_SRC=
+	KBUILD_BUILD_VERSION=${revision} -f \$(srctree)/Makefile
 
 binary-arch:
 	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
-	KBUILD_BUILD_VERSION=${revision} KBUILD_SRC= intdeb-pkg
+	KBUILD_BUILD_VERSION=${revision} -f \$(srctree)/Makefile intdeb-pkg
 
 clean:
 	rm -rf debian/*tmp debian/files
-- 
2.19.1



