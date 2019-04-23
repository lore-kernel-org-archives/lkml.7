Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E6DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2742F214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="LRiyoxWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfDWOU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:20:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25241 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfDWOUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:20:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44pQbF1SQ6zB09Zk;
        Tue, 23 Apr 2019 16:20:41 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=LRiyoxWh; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FkZUlhVbjkEj; Tue, 23 Apr 2019 16:20:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44pQbF0PzXz9v08G;
        Tue, 23 Apr 2019 16:20:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556029241; bh=XbVZ4oKpQMl9qOlnu8pF9HWZTr2Xn/KB1xhQRObdqb0=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=LRiyoxWhPKDlrkfHp0vFLWs9yst1laispyQX+PXQpaSw/tJFuMoEkpA+69oPcrONy
         74klRHC0b2vx9i5OVjxoHqbjfEMBf1JjPCMW0RHTbYf1EiXD0rWMeODcrCydfHDS8S
         hWqgBR21sYo6YAlrnm6mg4iVYVchQoEM9zf1G36A=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 891658B8E0;
        Tue, 23 Apr 2019 16:20:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 24ViAqodXyYG; Tue, 23 Apr 2019 16:20:42 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 299838B8E5;
        Tue, 23 Apr 2019 16:20:42 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 02EED666CF; Tue, 23 Apr 2019 14:20:41 +0000 (UTC)
Message-Id: <ffc4fb67fa1249490ade367ee112859177d0f2f3.1556028978.git.christophe.leroy@c-s.fr>
In-Reply-To: <2d3a59015307d368d6ac1a62fe7e47f5b39e2fe2.1556028978.git.christophe.leroy@c-s.fr>
References: <2d3a59015307d368d6ac1a62fe7e47f5b39e2fe2.1556028978.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/4] powerpc/boot: Add lzma support for uImage
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 23 Apr 2019 14:20:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows to generate lzma compressed uImage

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 v2: restore alphabetic order in Kconfig
---
 arch/powerpc/Kconfig       | 1 +
 arch/powerpc/boot/Makefile | 2 ++
 arch/powerpc/boot/wrapper  | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2d0be82c3061..dd22988cac0b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -200,6 +200,7 @@ config PPC
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_LZMA			if DEFAULT_UIMAGE
 	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 73d1f3562978..9b7b11a22925 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -22,6 +22,7 @@ all: $(obj)/zImage
 
 compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
 compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
+compress-$(CONFIG_KERNEL_LZMA) := CONFIG_KERNEL_LZMA
 
 ifdef CROSS32_COMPILE
     BOOTCC := $(CROSS32_COMPILE)gcc
@@ -257,6 +258,7 @@ endif
 
 compressor-$(CONFIG_KERNEL_GZIP) := gz
 compressor-$(CONFIG_KERNEL_XZ)   := xz
+compressor-$(CONFIG_KERNEL_LZMA)   := lzma
 
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 4e9beecf2502..51dc42f5acbc 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -137,7 +137,7 @@ while [ "$#" -gt 0 ]; do
     -Z)
 	shift
 	[ "$#" -gt 0 ] || usage
-        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "none" ] || usage
+        [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "lzma" -o "$1" != "none" ] || usage
 
 	compression=".$1"
 	uboot_comp=$1
@@ -374,6 +374,9 @@ if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel
     .gz)
         gzip -n -f -9 "$vmz.$$"
         ;;
+    .lzma)
+        xz --format=lzma -f -6 "$vmz.$$"
+	;;
     *)
         # drop the compression suffix so the stripped vmlinux is used
         compression=
-- 
2.13.3

