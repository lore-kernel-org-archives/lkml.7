Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F343C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E812082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TsRRUTjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfC2Ik2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:40:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57258 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbfC2IkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:40:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44VwD501Wdz9v0nB;
        Fri, 29 Mar 2019 09:40:21 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TsRRUTjI; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id gDxM64uhAlSn; Fri, 29 Mar 2019 09:40:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44VwD45KQrz9v0n9;
        Fri, 29 Mar 2019 09:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553848820; bh=koHETluniav0+RASqkAnJs+Qi2Jh0mqL4hpr+62Nz60=;
        h=From:Subject:To:Cc:Date:From;
        b=TsRRUTjI/XEK8aWcyej7Qw4Pj/3qfpsUWMAHftoOQzOvrEXJJ1bTSugnEbfH+68oX
         Y0XN32xOoEDM6/meSlOdxzfM9nYJWhC9kHARA6nxYotZ2LvLxu9qvlcxisl0RRP4PN
         96+kinLFgTsGqMFw2uMt801MPr0Yt4m18+VDddhY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DDC38B82D;
        Fri, 29 Mar 2019 09:40:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0ZCAG_Ac1OeI; Fri, 29 Mar 2019 09:40:21 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 606B18B779;
        Fri, 29 Mar 2019 09:40:21 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2786B6FC95; Fri, 29 Mar 2019 08:40:21 +0000 (UTC)
Message-Id: <3632dd9c8115965b37fd0b8fc50b3352395933fa.1553848759.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 1/4] powerpc/boot: don't force gzipped uImage
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 29 Mar 2019 08:40:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the generation of uImage by handing over
the selected compression type instead of forcing gzip

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/boot/wrapper | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index f9141eaec6ff..4e9beecf2502 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -41,6 +41,7 @@ dts=
 cacheit=
 binary=
 compression=.gz
+uboot_comp=gzip
 pie=
 format=
 
@@ -131,6 +132,7 @@ while [ "$#" -gt 0 ]; do
 	;;
     -z)
 	compression=.gz
+	uboot_comp=gzip
 	;;
     -Z)
 	shift
@@ -138,15 +140,21 @@ while [ "$#" -gt 0 ]; do
         [ "$1" != "gz" -o "$1" != "xz" -o "$1" != "none" ] || usage
 
 	compression=".$1"
+	uboot_comp=$1
 
         if [ $compression = ".none" ]; then
                 compression=
+		uboot_comp=none
         fi
+	if [ $uboot_comp = "gz" ]; then
+		uboot_comp=gzip
+	fi
 	;;
     --no-gzip)
         # a "feature" of the the wrapper script is that it can be used outside
         # the kernel tree. So keeping this around for backwards compatibility.
         compression=
+	uboot_comp=none
         ;;
     -?)
 	usage
@@ -369,6 +377,7 @@ if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel
     *)
         # drop the compression suffix so the stripped vmlinux is used
         compression=
+	uboot_comp=none
 	;;
     esac
 
@@ -412,7 +421,7 @@ membase=`${CROSS}objdump -p "$kernel" | grep -m 1 LOAD | awk '{print $7}'`
 case "$platform" in
 uboot)
     rm -f "$ofile"
-    ${MKIMAGE} -A ppc -O linux -T kernel -C gzip -a $membase -e $membase \
+    ${MKIMAGE} -A ppc -O linux -T kernel -C $uboot_comp -a $membase -e $membase \
 	$uboot_version -d "$vmz" "$ofile"
     if [ -z "$cacheit" ]; then
 	rm -f "$vmz"
-- 
2.13.3

