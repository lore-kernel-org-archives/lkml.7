Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31459C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0529220866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ZDBCBRhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfFNGly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:41:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4989 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFNGls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:41:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Q9xk2ssxz9v16m;
        Fri, 14 Jun 2019 08:41:46 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ZDBCBRhG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id j8daNfTKHkzb; Fri, 14 Jun 2019 08:41:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Q9xk1sZfz9v16l;
        Fri, 14 Jun 2019 08:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560494506; bh=GCEo/uOPUf7AFi3q5LEhtty7Gw7phT08oQfisQVPP5A=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ZDBCBRhGF6aT5LooxLOUrG7zIgqS7hazisUDMV8I2P3Y6fLN1IswsJIquUiYrRhua
         CNduB76lzBmSzfjGOnFdq4OJUjk9A/2lp8pDaM1qZr4G8pv4fUz1xdYp0GliiOOoMQ
         j9rQgetDnF6S4Kb5JxFVMEpYbkg7N2lgtBfUYXi4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 28EA68B77C;
        Fri, 14 Jun 2019 08:41:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZD2ASZLWO9Bu; Fri, 14 Jun 2019 08:41:47 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 049D58B77A;
        Fri, 14 Jun 2019 08:41:47 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DED6C68D77; Fri, 14 Jun 2019 06:41:46 +0000 (UTC)
Message-Id: <11be0db50617a93af596d5b2f8b2a04d0c60456b.1560494349.git.christophe.leroy@c-s.fr>
In-Reply-To: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
References: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 09/10] powerpc/8xx: Use IO accessors in microcode
 programming.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Jun 2019 06:41:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change microcode functions to use IO accessors and get rid
of volatile attributes.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/micropatch.c | 34 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
index 252db7c90599..986aa6978ab7 100644
--- a/arch/powerpc/platforms/8xx/micropatch.c
+++ b/arch/powerpc/platforms/8xx/micropatch.c
@@ -242,13 +242,7 @@ static void __init cpm_write_patch(cpm8xx_t *cp, int offset, uint *patch, int le
 
 void __init cpm_load_patch(cpm8xx_t *cp)
 {
-	volatile cpm8xx_t	*commproc;
-	volatile iic_t		*iip;
-	volatile struct spi_pram *spp;
-	volatile smc_uart_t	*smp;
-	commproc = cp;
-
-	commproc->cp_rccr = 0;
+	out_be16(&cp->cp_rccr, 0);
 
 	cpm_write_patch(cp, 0, patch_2000, sizeof(patch_2000));
 	cpm_write_patch(cp, 0xf00, patch_2f00, sizeof(patch_2f00));
@@ -257,26 +251,30 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 	if (IS_ENABLED(CONFIG_I2C_SPI_UCODE_PATCH) ||
 	    IS_ENABLED(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)) {
 		u16 rpbase = 0x500;
+		iic_t *iip;
+		struct spi_pram *spp;
 
-		iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
-		iip->iic_rpbase = rpbase;
+		iip = (iic_t *)&cp->cp_dparam[PROFF_IIC];
+		out_be16(&iip->iic_rpbase, rpbase);
 
 		/* Put SPI above the IIC, also 32-byte aligned. */
-		spp = (struct spi_pram *)&commproc->cp_dparam[PROFF_SPI];
-		spp->rpbase = (rpbase + sizeof(iic_t) + 31) & ~31;
+		spp = (struct spi_pram *)&cp->cp_dparam[PROFF_SPI];
+		out_be16(&spp->rpbase, (rpbase + sizeof(iic_t) + 31) & ~31);
 
 		if (IS_ENABLED(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)) {
-			smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
-			smp->smc_rpbase = 0x1FC0;
+			smc_uart_t *smp;
+
+			smp = (smc_uart_t *)&cp->cp_dparam[PROFF_SMC1];
+			out_be16(&smp->smc_rpbase, 0x1FC0);
 		}
 	}
 
-	commproc->cp_cpmcr1 = patch_params.cpmcr1;
-	commproc->cp_cpmcr2 = patch_params.cpmcr2;
-	commproc->cp_cpmcr3 = patch_params.cpmcr3;
-	commproc->cp_cpmcr4 = patch_params.cpmcr4;
+	out_be16(&cp->cp_cpmcr1, patch_params.cpmcr1);
+	out_be16(&cp->cp_cpmcr2, patch_params.cpmcr2);
+	out_be16(&cp->cp_cpmcr3, patch_params.cpmcr3);
+	out_be16(&cp->cp_cpmcr4, patch_params.cpmcr4);
 
-	commproc->cp_rccr = patch_params.rccr;
+	out_be16(&cp->cp_rccr, patch_params.rccr);
 
 	pr_info("%s microcode patch installed\n", patch_name);
 }
-- 
2.13.3

