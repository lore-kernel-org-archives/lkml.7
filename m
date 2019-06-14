Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7560C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888EC20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TGQMgCeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbfFNGll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:41:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11042 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfFNGll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:41:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Q9xb0JbMz9v16n;
        Fri, 14 Jun 2019 08:41:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TGQMgCeE; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6GDuRjF6niS5; Fri, 14 Jun 2019 08:41:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Q9xZ6N62z9v16l;
        Fri, 14 Jun 2019 08:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560494498; bh=FrwEFL562hO53reJv49dWHRcAR33QjLuPY2auIynv5Y=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=TGQMgCeEwwOTTZU0KTBbDhxpFsu9REbBfhngWWIv/I3/9Sghonv7Db6kG4vgQnZj/
         PK4NrL+MC5ulLXTmEtXw5jKslzKAOg7vZzlSp2OJX/lAIJkyroXq4v8ig6XmJC7qRz
         LXAZt4NqqJ2qqNeh2lWMo34jS0n4FN2RVUvh19lk=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C1EBC8B77A;
        Fri, 14 Jun 2019 08:41:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JZIzUdbAlMWf; Fri, 14 Jun 2019 08:41:39 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A4A468B775;
        Fri, 14 Jun 2019 08:41:39 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9FE7A68D77; Fri, 14 Jun 2019 06:41:39 +0000 (UTC)
Message-Id: <d66fe12d1dbe29ceba26b7208664f277c7fbf3a9.1560494348.git.christophe.leroy@c-s.fr>
In-Reply-To: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
References: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 02/10] powerpc/8xx: drop verify_patch()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Jun 2019 06:41:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

verify_patch() has been opted out since many years, and
the comment suggests it doesn't work. So drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/micropatch.c | 40 ---------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
index 33a9042fca80..7bbaf9914f32 100644
--- a/arch/powerpc/platforms/8xx/micropatch.c
+++ b/arch/powerpc/platforms/8xx/micropatch.c
@@ -707,43 +707,3 @@ void __init cpm_load_patch(cpm8xx_t *cp)
 
 #endif /* some variation of the I2C/SPI patch was selected */
 }
-
-/*
- *  Take this entire routine out, since no one calls it and its
- * logic is suspect.
- */
-
-#if 0
-void
-verify_patch(volatile immap_t *immr)
-{
-	volatile uint		*dp;
-	volatile cpm8xx_t	*commproc;
-	int i;
-
-	commproc = (cpm8xx_t *)&immr->im_cpm;
-
-	printk("cp_rccr %x\n", commproc->cp_rccr);
-	commproc->cp_rccr = 0;
-
-	dp = (uint *)(commproc->cp_dpmem);
-	for (i=0; i<(sizeof(patch_2000)/4); i++)
-		if (*dp++ != patch_2000[i]) {
-			printk("patch_2000 bad at %d\n", i);
-			dp--;
-			printk("found 0x%X, wanted 0x%X\n", *dp, patch_2000[i]);
-			break;
-		}
-
-	dp = (uint *)&(commproc->cp_dpmem[0x0f00]);
-	for (i=0; i<(sizeof(patch_2f00)/4); i++)
-		if (*dp++ != patch_2f00[i]) {
-			printk("patch_2f00 bad at %d\n", i);
-			dp--;
-			printk("found 0x%X, wanted 0x%X\n", *dp, patch_2f00[i]);
-			break;
-		}
-
-	commproc->cp_rccr = 0x0009;
-}
-#endif
-- 
2.13.3

