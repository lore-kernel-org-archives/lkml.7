Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA33C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E262133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="aGiXkX4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFNGlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:41:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20744 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfFNGlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:41:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Q9xj1Rltz9v16w;
        Fri, 14 Jun 2019 08:41:45 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=aGiXkX4n; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0O2602rZybOP; Fri, 14 Jun 2019 08:41:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Q9xj0RWMz9v16l;
        Fri, 14 Jun 2019 08:41:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560494505; bh=mqHvMNCVo1J8F/0+o546XcKtxPNuB5rRLMclAu10TBw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=aGiXkX4nZZbbuyKVNY191oLSgXjsghr6jYgT5Odsab8Q4wuMz8xAzz0Q0pv+z2Hnu
         +HTsq9uiDEYIl6C0P1nj8B83UC2FSi3ChzebKvwD8KKjSGXeT/r+ywfEATxRC72s4U
         ATFKz3ThgJuA7AqTyXbBQkgQ6CaWjZjq2Sn2iyos=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F3E9B8B77C;
        Fri, 14 Jun 2019 08:41:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id V917vI46jsYd; Fri, 14 Jun 2019 08:41:45 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D76D78B77A;
        Fri, 14 Jun 2019 08:41:45 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C8D5768D77; Fri, 14 Jun 2019 06:41:45 +0000 (UTC)
Message-Id: <4537c9b06cec9599ba2c3162ed7fbb6ce085d04b.1560494349.git.christophe.leroy@c-s.fr>
In-Reply-To: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
References: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 08/10] powerpc/8xx: replace #ifdefs by IS_ENABLED() in
 microcode.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Jun 2019 06:41:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce #ifdef mess by using IS_ENABLED() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/micropatch.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
index 02490c54ebac..252db7c90599 100644
--- a/arch/powerpc/platforms/8xx/micropatch.c
+++ b/arch/powerpc/platforms/8xx/micropatch.c
@@ -243,14 +243,9 @@ static void __init cpm_write_patch(cpm8xx_t *cp, int offset, uint *patch, int le
 void __init cpm_load_patch(cpm8xx_t *cp)
 {
 	volatile cpm8xx_t	*commproc;
-#if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
-    defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
 	volatile iic_t		*iip;
 	volatile struct spi_pram *spp;
-#ifdef CONFIG_I2C_SPI_SMC1_UCODE_PATCH
 	volatile smc_uart_t	*smp;
-#endif
-#endif
 	commproc = cp;
 
 	commproc->cp_rccr = 0;
@@ -259,24 +254,22 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 	cpm_write_patch(cp, 0xf00, patch_2f00, sizeof(patch_2f00));
 	cpm_write_patch(cp, 0xe00, patch_2e00, sizeof(patch_2e00));
 
-#if defined(CONFIG_I2C_SPI_UCODE_PATCH) || \
-    defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
-
-	iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
-# define RPBASE 0x0500
-	iip->iic_rpbase = RPBASE;
+	if (IS_ENABLED(CONFIG_I2C_SPI_UCODE_PATCH) ||
+	    IS_ENABLED(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)) {
+		u16 rpbase = 0x500;
 
-	/* Put SPI above the IIC, also 32-byte aligned.
-	*/
-	spp = (struct spi_pram *)&commproc->cp_dparam[PROFF_SPI];
-	spp->rpbase = (RPBASE + sizeof(iic_t) + 31) & ~31;
+		iip = (iic_t *)&commproc->cp_dparam[PROFF_IIC];
+		iip->iic_rpbase = rpbase;
 
-# if defined(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)
-	smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
-	smp->smc_rpbase = 0x1FC0;
-# endif /* CONFIG_I2C_SPI_SMC1_UCODE_PATCH) */
+		/* Put SPI above the IIC, also 32-byte aligned. */
+		spp = (struct spi_pram *)&commproc->cp_dparam[PROFF_SPI];
+		spp->rpbase = (rpbase + sizeof(iic_t) + 31) & ~31;
 
-#endif /* some variation of the I2C/SPI patch was selected */
+		if (IS_ENABLED(CONFIG_I2C_SPI_SMC1_UCODE_PATCH)) {
+			smp = (smc_uart_t *)&commproc->cp_dparam[PROFF_SMC1];
+			smp->smc_rpbase = 0x1FC0;
+		}
+	}
 
 	commproc->cp_cpmcr1 = patch_params.cpmcr1;
 	commproc->cp_cpmcr2 = patch_params.cpmcr2;
-- 
2.13.3

