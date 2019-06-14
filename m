Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDCC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA8120665
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="sX7cDuPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfFNKQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:16:28 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:17591 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbfFNKQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:16:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45QGjM1H2Jz9vDbj;
        Fri, 14 Jun 2019 12:16:23 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=sX7cDuPN; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RsZZFblO1owP; Fri, 14 Jun 2019 12:16:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45QGjL6tmgz9vDbh;
        Fri, 14 Jun 2019 12:16:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560507383; bh=TY2dCqN2e9LwCfIjpEtnXQ6QZOx6P42BO2JkGX44zKo=;
        h=From:Subject:To:Cc:Date:From;
        b=sX7cDuPNCOH3k1NV5WEEAQVIfWziAd8Yttao5/aoEyBT0eSlXHRjPskvTVdPr820M
         GMCllAQp+pwfGchnsGUjQ24zxvechvXUsYdfgm90jqvm2kG6mvV2/nyUMo0fQ1Awme
         5YfAXVzfmyFBYJsQRM+ClutAhF5IvooTaDlCYPGw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C4018B7AD;
        Fri, 14 Jun 2019 12:16:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id b9t6QDuhCvSj; Fri, 14 Jun 2019 12:16:24 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 08F808B7AC;
        Fri, 14 Jun 2019 12:16:24 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id DF66968D78; Fri, 14 Jun 2019 10:16:23 +0000 (UTC)
Message-Id: <1b4946c9e580b51b6ca2ddc5963d66406c013c2d.1560507284.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/3] powerpc/boot: don't force gzipped uImage
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Jun 2019 10:16:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the generation of uImage by handing over
the selected compression type instead of forcing gzip

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 v3: no change
 v2: no change
---
 arch/powerpc/boot/wrapper | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 532d45833396..85d97360b1c9 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -40,6 +40,7 @@ dts=
 cacheit=
 binary=
 compression=.gz
+uboot_comp=gzip
 pie=
 format=
 
@@ -130,6 +131,7 @@ while [ "$#" -gt 0 ]; do
 	;;
     -z)
 	compression=.gz
+	uboot_comp=gzip
 	;;
     -Z)
 	shift
@@ -137,15 +139,21 @@ while [ "$#" -gt 0 ]; do
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
@@ -368,6 +376,7 @@ if [ -z "$cacheit" -o ! -f "$vmz$compression" -o "$vmz$compression" -ot "$kernel
     *)
         # drop the compression suffix so the stripped vmlinux is used
         compression=
+	uboot_comp=none
 	;;
     esac
 
@@ -411,7 +420,7 @@ membase=`${CROSS}objdump -p "$kernel" | grep -m 1 LOAD | awk '{print $7}'`
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

