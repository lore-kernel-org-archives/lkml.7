Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD833C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0C32082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XbUx+6a6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbfC2Ikb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:40:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64436 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbfC2IkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:40:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44VwD64NgFz9v0nH;
        Fri, 29 Mar 2019 09:40:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XbUx+6a6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8wqVf8ib4Jcz; Fri, 29 Mar 2019 09:40:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44VwD633Gbz9v0n9;
        Fri, 29 Mar 2019 09:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553848822; bh=lcrRp8MjxDz2LFrpTPK67UD/95vUL1nfZPBGhp5Eo1Q=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=XbUx+6a6q0PbBjbSAdbA7p/YN68dNlKCMAs04y3Hr05whQWJqengQpPqiEG15/3cI
         AyVjlpuAV1emZTUbZ5iY0rxLZFIZ3lW3oshRor9ytuCNgc8OL0oxdVH/MMLNsI25XX
         rYg90ESOeDE7iZNzy9qMkF2OOcdnU4flfiTmOHSc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 69FB28B825;
        Fri, 29 Mar 2019 09:40:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Mbc6GtcGd6FH; Fri, 29 Mar 2019 09:40:23 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 502828B779;
        Fri, 29 Mar 2019 09:40:23 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 41C436FC95; Fri, 29 Mar 2019 08:40:23 +0000 (UTC)
Message-Id: <ae716c2d05cc7591b3eb2f4512491e93a687e935.1553848759.git.christophe.leroy@c-s.fr>
In-Reply-To: <3632dd9c8115965b37fd0b8fc50b3352395933fa.1553848759.git.christophe.leroy@c-s.fr>
References: <3632dd9c8115965b37fd0b8fc50b3352395933fa.1553848759.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 3/4] powerpc/boot: Add bzip2 support for uImage
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 29 Mar 2019 08:40:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to generate bzip2 compressed uImage

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig       | 1 +
 arch/powerpc/boot/Makefile | 2 ++
 arch/powerpc/boot/wrapper  | 8 +++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 69ff2476490c..6f1d49fdae98 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -202,6 +202,7 @@ config PPC
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
 	select HAVE_KERNEL_LZMA			if DEFAULT_UIMAGE
+	select HAVE_KERNEL_BZIP2		if DEFAULT_UIMAGE
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 9b7b11a22925..0a7f8c2dc8af 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -23,6 +23,7 @@ all: $(obj)/zImage
 compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
 compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
 compress-$(CONFIG_KERNEL_LZMA) := CONFIG_KERNEL_LZMA
+compress-$(CONFIG_KERNEL_BZIP2)   := CONFIG_KERNEL_BZIP2
 
 ifdef CROSS32_COMPILE
     BOOTCC := $(CROSS32_COMPILE)gcc
@@ -259,6 +260,7 @@ endif
 compressor-$(CONFIG_KERNEL_GZIP) := gz
 compressor-$(CONFIG_KERNEL_XZ)   := xz
 compressor-$(CONFIG_KERNEL_LZMA)   := lzma
+compressor-$(CONFIG_KERNEL_BZIP2) := bz2
 
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 51dc42f5acbc..d1384e8c0c6f 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -137,7 +137,7 @@ while [ "$#" -gt 0 ]; do
     -Z)
 	shift
 	[ "$#" -gt 0 ] || usage
-        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "none" ] || usage
+        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "bz2" -o "$1" != "none" ] || usage
 
 	compression=".$1"
 	uboot_comp=$1
@@ -149,6 +149,9 @@ while [ "$#" -gt 0 ]; do
 	if [ $uboot_comp = "gz" ]; then
 		uboot_comp=gzip
 	fi
+	if [ $uboot_comp = "bz2" ]; then
+		uboot_comp=bzip2
+	fi
 	;;
     --no-gzip)
         # a "feature" of the the wrapper script is that it can be used outside
@@ -377,6 +380,9 @@ if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel
     .lzma)
         xz --format=lzma -f -6 "$vmz.$$"
 	;;
+    .bz2)
+        bzip2 -f "$vmz.$$"
+	;;
     *)
         # drop the compression suffix so the stripped vmlinux is used
         compression=
-- 
2.13.3

