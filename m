Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D535C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F6520851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="boWQWqC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbfFMPvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:51:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50072 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731671AbfFMJMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:12:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45PdKT6DDszB09Zl;
        Thu, 13 Jun 2019 11:11:57 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=boWQWqC3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JrueQZJUsD0U; Thu, 13 Jun 2019 11:11:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45PdKT59v1zB09Zg;
        Thu, 13 Jun 2019 11:11:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560417117; bh=nw7s55nSCE5gZsdfCAQCVWUUIXEzDyTDYLqPEVTErBE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=boWQWqC3D/XalcPnhPI/GyNq60NyTwjwLNLBvads62bU5FaTyZVFdwPXezhQuVOT3
         apb9UxvasoerSAoIb92J3K1hpMlzF4xxDJQRpmuycX9o+cjyGMzijrfORaLBwBzRK7
         17hclZKYm8GvtuOUJAXBdwZ71hXlRdZHqetTFYwA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA4F58B8CB;
        Thu, 13 Jun 2019 11:11:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mGt5KfZ8d4MU; Thu, 13 Jun 2019 11:11:58 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 765A68B8B9;
        Thu, 13 Jun 2019 11:11:58 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3730168B1D; Thu, 13 Jun 2019 09:11:58 +0000 (UTC)
Message-Id: <3f5c27c0045fddab9e32d7450d2124e04dcf6205.1560416987.git.christophe.leroy@c-s.fr>
In-Reply-To: <1930b7e67ab361e68f356e7fdeba403e32ce3ad0.1560416986.git.christophe.leroy@c-s.fr>
References: <1930b7e67ab361e68f356e7fdeba403e32ce3ad0.1560416986.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 06/10] powerpc/8xx: refactor printing of microcode patch
 name.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Jun 2019 09:11:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define patch name together with the patch code, and refactor
the associated printk() while replacing it by a pr_info()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/micropatch.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
index 410968a0b177..5e5ac2378d3f 100644
--- a/arch/powerpc/platforms/8xx/micropatch.c
+++ b/arch/powerpc/platforms/8xx/micropatch.c
@@ -26,6 +26,8 @@
 
 #ifdef CONFIG_I2C_SPI_UCODE_PATCH
 
+static char patch_name[] __initdata = "I2C/SPI";
+
 static uint patch_2000[] __initdata = {
 	0x7FFFEFD9, 0x3FFD0000, 0x7FFB49F7, 0x7FF90000,
 	0x5FEFADF7, 0x5F89ADF7, 0x5FEFAFF7, 0x5F89AFF7,
@@ -78,6 +80,8 @@ static uint patch_2e00[] __initdata = {};
 
 #ifdef CONFIG_I2C_SPI_SMC1_UCODE_PATCH
 
+static char patch_name[] __initdata = "I2C/SPI/SMC1";
+
 static uint patch_2000[] __initdata = {
 	0x3fff0000, 0x3ffd0000, 0x3ffb0000, 0x3ff90000,
 	0x5f13eff8, 0x5eb5eff8, 0x5f88adf7, 0x5fefadf7,
@@ -194,6 +198,8 @@ static uint patch_2e00[] __initdata = {
 
 #ifdef CONFIG_USB_SOF_UCODE_PATCH
 
+static char patch_name[] __initdata = "USB SOF";
+
 static uint patch_2000[] __initdata = {
 	0x7fff0000, 0x7ffd0000, 0x7ffb0000, 0x49f7ba5b,
 	0xba383ffb, 0xf9b8b46d, 0xe5ab4e07, 0xaf77bffe,
@@ -235,8 +241,6 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 
 #ifdef CONFIG_USB_SOF_UCODE_PATCH
 	commproc->cp_rccr = 0x0009;
-
-	printk("USB SOF microcode patch installed\n");
 #endif /* CONFIG_USB_SOF_UCODE_PATCH */
 
 #if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
@@ -257,8 +261,6 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 	commproc->cp_cpmcr3 = 0x802e;
 	commproc->cp_cpmcr4 = 0x802c;
 	commproc->cp_rccr = 1;
-
-	printk("I2C/SPI microcode patch installed.\n");
 # endif /* CONFIG_I2C_SPI_UCODE_PATCH */
 
 # if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
@@ -270,9 +272,9 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 
 	smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
 	smp->smc_rpbase = 0x1FC0;
-
-	printk("I2C/SPI/SMC1 microcode patch installed.\n");
 # endif /* CONFIG_I2C_SPI_SMC1_UCODE_PATCH) */
 
 #endif /* some variation of the I2C/SPI patch was selected */
+
+	pr_info("%s microcode patch installed\n", patch_name);
 }
-- 
2.13.3

