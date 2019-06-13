Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B55AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711532147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="fNUhpvrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbfFMPvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:51:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52242 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731668AbfFMJL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:11:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45PdKS65YJzB09Zj;
        Thu, 13 Jun 2019 11:11:56 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=fNUhpvrL; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MZkL6zE0fl5F; Thu, 13 Jun 2019 11:11:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45PdKS53DMzB09Zg;
        Thu, 13 Jun 2019 11:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560417116; bh=cCE6OdJ24TuDs1xM5LRdP+vefhe2tcaWmq93hyBjEj4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=fNUhpvrLU1vn7B0RFi0A6nS4ZgIJuWc0TANslpflobWHnokN/VPvd0oK0aHYSWFoo
         KjEEKqIgh3jbPsPVc3/ZpEHCctWa0BZRqN+bExUzwoGWQ0pCRJS9rUGhf7ZaWCRR1I
         EJT36eoB41RMYtPXlQo+7dtMN5kgIdtBWD9inxFM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA4C58B8C3;
        Thu, 13 Jun 2019 11:11:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pus5NTiVYV_F; Thu, 13 Jun 2019 11:11:57 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F7858B8C0;
        Thu, 13 Jun 2019 11:11:57 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3138E68B1D; Thu, 13 Jun 2019 09:11:57 +0000 (UTC)
Message-Id: <9834d52c9e7d27b62d972d3cad459701d7650713.1560416987.git.christophe.leroy@c-s.fr>
In-Reply-To: <1930b7e67ab361e68f356e7fdeba403e32ce3ad0.1560416986.git.christophe.leroy@c-s.fr>
References: <1930b7e67ab361e68f356e7fdeba403e32ce3ad0.1560416986.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 05/10] powerpc/8xx: Refactor microcode write
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Jun 2019 09:11:57 +0000 (UTC)
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

