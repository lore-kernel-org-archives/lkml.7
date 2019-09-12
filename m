Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECA7C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023DC20856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="AlE91qUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbfILN3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:29:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50467 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731687AbfILN3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:29:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46TfkB4RrNz9txvH;
        Thu, 12 Sep 2019 15:29:06 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AlE91qUL; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CS_Eux0cFFP1; Thu, 12 Sep 2019 15:29:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46TfkB3PHMz9txv9;
        Thu, 12 Sep 2019 15:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1568294946; bh=8YKLm3BM8Fxy2PQQ/azbBDLOKtUwGMrFARZT5pRecvA=;
        h=From:Subject:To:Cc:Date:From;
        b=AlE91qUL1IErytQqrdVZaNb9DzquT4c1DDMHzdBMvDQPPhBo32PH9smETuDiHEmDM
         VhhMwPC/3jHELmOlEDYDvNJcOof5G74/RIP+uh59HYEPZHXxKgIyDK2IFWOnFck8fs
         6YGJfcZvPw8X9qe0HOoAGCsjkgP/t+e84XZFSC0E=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D128C8B933;
        Thu, 12 Sep 2019 15:29:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MahlDDjqoM9y; Thu, 12 Sep 2019 15:29:07 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A0258B934;
        Thu, 12 Sep 2019 15:29:07 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3B00F6B736; Thu, 12 Sep 2019 13:29:07 +0000 (UTC)
Message-Id: <f816ccdbd15b97cf43c5a8c7cc8dfa8db58ff036.1568294935.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/8xx: use the fixmapped IMMR in cpm_reset()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 12 Sep 2019 13:29:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit f86ef74ed919 ("powerpc/8xx: Fix vaddr for IMMR early
remap"), the IMMR area has been mapped at startup with fixmap.

Use that fixmap directly instead of calling ioremap(), this
avoids calling ioremap() early before the slab is available.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/cpm1.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
index 5a47b3ead01a..d4648cc468dc 100644
--- a/arch/powerpc/platforms/8xx/cpm1.c
+++ b/arch/powerpc/platforms/8xx/cpm1.c
@@ -51,7 +51,7 @@
 #define CPM_MAP_SIZE    (0x4000)
 
 cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
-immap_t __iomem *mpc8xx_immr;
+immap_t __iomem *mpc8xx_immr = (void __iomem *)VIRT_IMMR_BASE;
 static cpic8xx_t __iomem *cpic_reg;
 
 static struct irq_domain *cpm_pic_host;
@@ -205,12 +205,6 @@ void __init cpm_reset(void)
 	int len;
 #endif
 
-	mpc8xx_immr = ioremap(get_immrbase(), 0x4000);
-	if (!mpc8xx_immr) {
-		printk(KERN_CRIT "Could not map IMMR\n");
-		return;
-	}
-
 	cpmp = &mpc8xx_immr->im_cpm;
 
 #ifndef CONFIG_PPC_EARLY_DEBUG_CPM
-- 
2.13.3

