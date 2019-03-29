Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4701C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830D42082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dZVmImQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfC2Ikl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:40:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15047 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbfC2Ik0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:40:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44VwD74mfxz9v0nL;
        Fri, 29 Mar 2019 09:40:23 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=dZVmImQ/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id knD2RpUqNE3p; Fri, 29 Mar 2019 09:40:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44VwD73ZGrz9v0n9;
        Fri, 29 Mar 2019 09:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553848823; bh=BN8YFCnkZyMt7fbqBBq+kQwchPieT1bmK69D5rfkV7o=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=dZVmImQ/+Mrs7jcexlMR8C4NYyrtgNNliyol3HLF7lkiDiQHvjDZe07RmWuGiF6d9
         u6DQXpkYiHosQwOqIWrWd1QgN6M2PlJjShHkHwlbzjoIu9zDye/rI3sUCwtSXLDmz/
         FQltAWFl4ovnU45HeraceWPnvKBRsT5x5gKo18/0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73AA08B825;
        Fri, 29 Mar 2019 09:40:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id daa-pkjtDzun; Fri, 29 Mar 2019 09:40:24 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 58E438B779;
        Fri, 29 Mar 2019 09:40:24 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 490946FC95; Fri, 29 Mar 2019 08:40:24 +0000 (UTC)
Message-Id: <40f0a5645b721eeb6b8d9bc078be9d0155feff33.1553848759.git.christophe.leroy@c-s.fr>
In-Reply-To: <3632dd9c8115965b37fd0b8fc50b3352395933fa.1553848759.git.christophe.leroy@c-s.fr>
References: <3632dd9c8115965b37fd0b8fc50b3352395933fa.1553848759.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 4/4] powerpc/boot: Add lzo support for uImage
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 29 Mar 2019 08:40:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to generate lzo compressed uImage

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig       | 1 +
 arch/powerpc/boot/Makefile | 2 ++
 arch/powerpc/boot/wrapper  | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6f1d49fdae98..df3694b947ce 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -203,6 +203,7 @@ config PPC
 	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
 	select HAVE_KERNEL_LZMA			if DEFAULT_UIMAGE
 	select HAVE_KERNEL_BZIP2		if DEFAULT_UIMAGE
+	select HAVE_KERNEL_LZO			if DEFAULT_UIMAGE
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0a7f8c2dc8af..4675575774d7 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -24,6 +24,7 @@ compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
 compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
 compress-$(CONFIG_KERNEL_LZMA) := CONFIG_KERNEL_LZMA
 compress-$(CONFIG_KERNEL_BZIP2)   := CONFIG_KERNEL_BZIP2
+compress-$(CONFIG_KERNEL_LZO)   := CONFIG_KERNEL_LZO
 
 ifdef CROSS32_COMPILE
     BOOTCC := $(CROSS32_COMPILE)gcc
@@ -261,6 +262,7 @@ compressor-$(CONFIG_KERNEL_GZIP) := gz
 compressor-$(CONFIG_KERNEL_XZ)   := xz
 compressor-$(CONFIG_KERNEL_LZMA)   := lzma
 compressor-$(CONFIG_KERNEL_BZIP2) := bz2
+compressor-$(CONFIG_KERNEL_LZO) := lzo
 
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index d1384e8c0c6f..2fd3483f9d80 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -137,7 +137,7 @@ while [ "$#" -gt 0 ]; do
     -Z)
 	shift
 	[ "$#" -gt 0 ] || usage
-        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "bz2" -o "$1" != "none" ] || usage
+        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "bz2" -o "$1" != "lzo" -o "$1" != "none" ] || usage
 
 	compression=".$1"
 	uboot_comp=$1
@@ -383,6 +383,9 @@ if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel
     .bz2)
         bzip2 -f "$vmz.$$"
 	;;
+    .lzo)
+        lzop -f -9 "$vmz.$$"
+	;;
     *)
         # drop the compression suffix so the stripped vmlinux is used
         compression=
-- 
2.13.3

