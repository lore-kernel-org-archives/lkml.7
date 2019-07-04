Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EBAC46497
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5D121852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfGDUuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:50:55 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:63211 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfGDUux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:50:53 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-02.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hj8gs-0006Im-Ui from Cedric_Hombourger@mentor.com ; Thu, 04 Jul 2019 13:50:50 -0700
Received: from FRG-W10-HOMBOUR.world.mentorg.com (137.202.0.90) by
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 4 Jul 2019 21:50:46 +0100
From:   Cedric Hombourger <Cedric_Hombourger@mentor.com>
To:     <ben@decadent.org.uk>
CC:     <yamada.masahiro@socionext.com>, <isar-users@googlegroups.com>,
        <michal.lkml@markovi.net>, <linux-kbuild@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <riku.voipio@linaro.org>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>
Subject: [PATCH v3 1/1] builddeb: generate multi-arch friendly linux-libc-dev package
Date:   Thu, 4 Jul 2019 22:50:27 +0200
Message-ID: <1562273427-204-2-git-send-email-Cedric_Hombourger@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562273427-204-1-git-send-email-Cedric_Hombourger@mentor.com>
References: <432e997617a0669886cd9ea5ceac7c1a2173044b.camel@decadent.org.uk>
 <1562273427-204-1-git-send-email-Cedric_Hombourger@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debian-based distributions place libc header files in a machine
specific directory (/usr/include/<libc-machine>) instead of
/usr/include/asm to support installation of the linux-libc-dev
package from multiple architectures. Move headers installed by
"make headers_install" accordingly using Debian's tuple from
dpkg-architecture.

Signed-off-by: Cedric Hombourger <Cedric_Hombourger@mentor.com>
---
 scripts/package/builddeb | 8 ++++++++
 scripts/package/mkdebian | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index b03dd56a4782..15a034e18c37 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -132,6 +132,14 @@ fi
 if [ "$ARCH" != "um" ]; then
 	$MAKE -f $srctree/Makefile headers_check
 	$MAKE -f $srctree/Makefile headers_install INSTALL_HDR_PATH="$libc_headers_dir/usr"
+	if [ -n "$debarch" ]; then
+		# move asm headers to /usr/include/<libc-machine>/asm to match the structure
+		# used by Debian-based distros (to support multi-arch) but only if ARCH was
+		# translated to Debian's (debarch) - this is done by mkdebian
+		host_arch=$(dpkg-architecture -a$debarch -qDEB_HOST_MULTIARCH)
+		mkdir $libc_headers_dir/usr/include/$host_arch
+		mv $libc_headers_dir/usr/include/asm $libc_headers_dir/usr/include/$host_arch/
+	fi
 fi
 
 # Install the maintainer scripts
diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index 8351584cb24e..2d670ae2cabc 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -197,6 +197,7 @@ Architecture: $debarch
 Description: Linux support headers for userspace development
  This package provides userspaces headers from the Linux kernel.  These headers
  are used by the installed headers for GNU glibc and other system libraries.
+Multi-Arch: same
 
 Package: $dbg_packagename
 Section: debug
@@ -212,11 +213,11 @@ cat <<EOF > debian/rules
 srctree ?= .
 
 build:
-	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
+	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} debarch=${debarch} \
 	KBUILD_BUILD_VERSION=${revision} -f \$(srctree)/Makefile
 
 binary-arch:
-	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} \
+	\$(MAKE) KERNELRELEASE=${version} ARCH=${ARCH} debarch=${debarch} \
 	KBUILD_BUILD_VERSION=${revision} -f \$(srctree)/Makefile intdeb-pkg
 
 clean:
-- 
2.11.0

