Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7580FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFBD20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="e1bn3PvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbfFMPvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:51:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9799 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731672AbfFMJMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:12:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45PdKV5qnrzB09Zm;
        Thu, 13 Jun 2019 11:11:58 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=e1bn3PvQ; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oKSzeTlVE5qS; Thu, 13 Jun 2019 11:11:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45PdKV4p9zzB09Zg;
        Thu, 13 Jun 2019 11:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560417118; bh=c1fjFHYo4plvZKawyOgV7g7CcRgoXZx1Z5piZT8xc9k=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=e1bn3PvQ4jDCLMgEDDsy0r6IZIpIgssx/fWUDnTLGS0BSQnk22aml6Nvi0qdPc5TK
         unNv8Dg7DUZVLaU+iC5mvKsiOIewY7BTa0waTRGSAs8HcpAdA9EB41aAvsP0N4ot44
         VzO7kfnnR9faQNWdiCnGkHNWQoOEcFvVerP2MgKM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C2A7F8B8C0;
        Thu, 13 Jun 2019 11:11:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VhPf72UpRPU1; Thu, 13 Jun 2019 11:11:59 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A5A88B8B9;
        Thu, 13 Jun 2019 11:11:59 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3E0BA68B1D; Thu, 13 Jun 2019 09:11:59 +0000 (UTC)
Message-Id: <fda6265bdf4415c12851e31deda337967f3e9b8f.1560416987.git.christophe.leroy@c-s.fr>
In-Reply-To: <1930b7e67ab361e68f356e7fdeba403e32ce3ad0.1560416986.git.christophe.leroy@c-s.fr>
References: <1930b7e67ab361e68f356e7fdeba403e32ce3ad0.1560416986.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 07/10] powerpc/8xx: refactor programming of microcode CPM
 params.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Jun 2019 09:11:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPM registers RCCR and CPMCR1..4 registers has to be set in
accordance with the microcode patch beeing programmed. Lets
define them as part of the patch set and refactor their
programming from that definition.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/micropatch.c | 45 ++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
index 5e5ac2378d3f..02490c54ebac 100644
--- a/arch/powerpc/platforms/8xx/micropatch.c
+++ b/arch/powerpc/platforms/8xx/micropatch.c
@@ -20,6 +20,14 @@
 #include <asm/cpm.h>
 #include <asm/cpm1.h>
 
+struct patch_params {
+	ushort rccr;
+	ushort cpmcr1;
+	ushort cpmcr2;
+	ushort cpmcr3;
+	ushort cpmcr4;
+};
+
 /*
  * I2C/SPI relocation patch arrays.
  */
@@ -28,6 +36,10 @@
 
 static char patch_name[] __initdata = "I2C/SPI";
 
+static struct patch_params patch_params __initdata = {
+	1, 0x802a, 0x8028, 0x802e, 0x802c,
+};
+
 static uint patch_2000[] __initdata = {
 	0x7FFFEFD9, 0x3FFD0000, 0x7FFB49F7, 0x7FF90000,
 	0x5FEFADF7, 0x5F89ADF7, 0x5FEFAFF7, 0x5F89AFF7,
@@ -82,6 +94,10 @@ static uint patch_2e00[] __initdata = {};
 
 static char patch_name[] __initdata = "I2C/SPI/SMC1";
 
+static struct patch_params patch_params __initdata = {
+	3, 0x8080, 0x808a, 0x8028, 0x802a,
+};
+
 static uint patch_2000[] __initdata = {
 	0x3fff0000, 0x3ffd0000, 0x3ffb0000, 0x3ff90000,
 	0x5f13eff8, 0x5eb5eff8, 0x5f88adf7, 0x5fefadf7,
@@ -200,6 +216,10 @@ static uint patch_2e00[] __initdata = {
 
 static char patch_name[] __initdata = "USB SOF";
 
+static struct patch_params patch_params __initdata = {
+	9,
+};
+
 static uint patch_2000[] __initdata = {
 	0x7fff0000, 0x7ffd0000, 0x7ffb0000, 0x49f7ba5b,
 	0xba383ffb, 0xf9b8b46d, 0xe5ab4e07, 0xaf77bffe,
@@ -239,10 +259,6 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 	cpm_write_patch(cp, 0xf00, patch_2f00, sizeof(patch_2f00));
 	cpm_write_patch(cp, 0xe00, patch_2e00, sizeof(patch_2e00));
 
-#ifdef CONFIG_USB_SOF_UCODE_PATCH
-	commproc->cp_rccr = 0x0009;
-#endif /* CONFIG_USB_SOF_UCODE_PATCH */
-
 #if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
     defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
 
@@ -255,26 +271,19 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 	spp = (struct spi_pram *)&commproc->cp_dparam[PROFF_SPI];
 	spp->rpbase = (RPBASE + sizeof(iic_t) + 31) & ~31;
 
-# if defined(CONFIG_I2C_SPI_UCODE_PATCH)
-	commproc->cp_cpmcr1 = 0x802a;
-	commproc->cp_cpmcr2 = 0x8028;
-	commproc->cp_cpmcr3 = 0x802e;
-	commproc->cp_cpmcr4 = 0x802c;
-	commproc->cp_rccr = 1;
-# endif /* CONFIG_I2C_SPI_UCODE_PATCH */
-
 # if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
-	commproc->cp_cpmcr1 = 0x8080;
-	commproc->cp_cpmcr2 = 0x808a;
-	commproc->cp_cpmcr3 = 0x8028;
-	commproc->cp_cpmcr4 = 0x802a;
-	commproc->cp_rccr = 3;
-
 	smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
 	smp->smc_rpbase = 0x1FC0;
 # endif /* CONFIG_I2C_SPI_SMC1_UCODE_PATCH) */
 
 #endif /* some variation of the I2C/SPI patch was selected */
 
+	commproc->cp_cpmcr1 = patch_params.cpmcr1;
+	commproc->cp_cpmcr2 = patch_params.cpmcr2;
+	commproc->cp_cpmcr3 = patch_params.cpmcr3;
+	commproc->cp_cpmcr4 = patch_params.cpmcr4;
+
+	commproc->cp_rccr = patch_params.rccr;
+
 	pr_info("%s microcode patch installed\n", patch_name);
 }
-- 
2.13.3

