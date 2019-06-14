Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE46DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A391F20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="er95ejVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfFNGlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:41:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20744 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFNGlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:41:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Q9xf12W5z9v16r;
        Fri, 14 Jun 2019 08:41:42 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=er95ejVG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rP8rI4qRFnww; Fri, 14 Jun 2019 08:41:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Q9xf01r6z9v16l;
        Fri, 14 Jun 2019 08:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560494502; bh=cCE6OdJ24TuDs1xM5LRdP+vefhe2tcaWmq93hyBjEj4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=er95ejVGAn8TAD0aJZSamLrjuZHxGaB47/vaBb1OspdLQVHFLKKYKa0FTlY3UXb3i
         0PI7/WFuv6u5wOjWSLQk2a6yf+CfCoUXtzCGpt32UsYNX9dXxEEDHFb/2g6VmKe06E
         2qvoGybyVQn3mzUmEnqAYmJ775xtC4tCp2wKmw18=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA8168B77A;
        Fri, 14 Jun 2019 08:41:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KrE4FFKMAlr6; Fri, 14 Jun 2019 08:41:42 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C94888B775;
        Fri, 14 Jun 2019 08:41:42 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B593968D77; Fri, 14 Jun 2019 06:41:42 +0000 (UTC)
Message-Id: <093a095faf6d7627acf071cffca530496540c13e.1560494349.git.christophe.leroy@c-s.fr>
In-Reply-To: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
References: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 05/10] powerpc/8xx: Refactor microcode write
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Jun 2019 06:41:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add empty microcode tables so that all tables are defined
all the time. Regroup the writing of the 3 tables regardless
of the selected microcode.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/micropatch.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
index 2abc226d1139..410968a0b177 100644
--- a/arch/powerpc/platforms/8xx/micropatch.c
+++ b/arch/powerpc/platforms/8xx/micropatch.c
@@ -68,6 +68,8 @@ static uint patch_2f00[] __initdata = {
 	0x31497353, 0x76956D69, 0x7B9D9693, 0x13131979,
 	0x79376935
 };
+
+static uint patch_2e00[] __initdata = {};
 #endif
 
 /*
@@ -201,6 +203,8 @@ static uint patch_2000[] __initdata = {
 static uint patch_2f00[] __initdata = {
 	0x3030304c, 0xcab9e441, 0xa1aaf220
 };
+
+static uint patch_2e00[] __initdata = {};
 #endif
 
 static void __init cpm_write_patch(cpm8xx_t *cp, int offset, uint *patch, int len)
@@ -223,12 +227,13 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 #endif
 	commproc = cp;
 
-#ifdef CONFIG_USB_SOF_UCODE_PATCH
 	commproc->cp_rccr = 0;
 
 	cpm_write_patch(cp, 0, patch_2000, sizeof(patch_2000));
 	cpm_write_patch(cp, 0xf00, patch_2f00, sizeof(patch_2f00));
+	cpm_write_patch(cp, 0xe00, patch_2e00, sizeof(patch_2e00));
 
+#ifdef CONFIG_USB_SOF_UCODE_PATCH
 	commproc->cp_rccr = 0x0009;
 
 	printk("USB SOF microcode patch installed\n");
@@ -237,11 +242,6 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 #if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
     defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
 
-	commproc->cp_rccr = 0;
-
-	cpm_write_patch(cp, 0, patch_2000, sizeof(patch_2000));
-	cpm_write_patch(cp, 0xf00, patch_2f00, sizeof(patch_2f00));
-
 	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
 # define RPBASE 0x0500
 	iip->iic_rpbase = RPBASE;
@@ -262,9 +262,6 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 # endif /* CONFIG_I2C_SPI_UCODE_PATCH */
 
 # if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
-
-	cpm_write_patch(cp, 0xe00, patch_2e00, sizeof(patch_2e00));
-
 	commproc->cp_cpmcr1 = 0x8080;
 	commproc->cp_cpmcr2 = 0x808a;
 	commproc->cp_cpmcr3 = 0x8028;
-- 
2.13.3

