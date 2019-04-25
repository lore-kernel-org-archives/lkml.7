Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAEDC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712412077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Ci2TY9BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfDYO3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:29:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:34283 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbfDYO3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:29:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44qfhY5Nznz9v07D;
        Thu, 25 Apr 2019 16:29:33 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Ci2TY9BB; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rjLrzFRfISzF; Thu, 25 Apr 2019 16:29:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44qfhY4MKzz9v06V;
        Thu, 25 Apr 2019 16:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556202573; bh=wu3SsXDw9+qyf/gIy8GDSFblH0FQGwqwaG1cAbdHGMU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Ci2TY9BB/gjZ1zvQZ4j8wl6byVxq3HNoJJtzK5u0Nd3bFYEOjA7zOZ4dLC7Uemsah
         /V6m5IW6Jm13otL4Dc2UOoCDo6BN3iAJr988ZkO01Kv+v+pFZi95ZFQmFoIalLytq7
         OZGE/Hg8EtNpBCqOaTyEvVT8ncMPMmBGmxfAJwcM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A6598B931;
        Thu, 25 Apr 2019 16:29:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hquzzkm4QH2P; Thu, 25 Apr 2019 16:29:35 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 00F138B923;
        Thu, 25 Apr 2019 16:29:34 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C274666276; Thu, 25 Apr 2019 14:29:34 +0000 (UTC)
Message-Id: <59cd0a363886c9d77da4b1f8c1439b0371d95811.1556202029.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556202028.git.christophe.leroy@c-s.fr>
References: <cover.1556202028.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 08/11] powerpc/8xx: get rid of #ifdef CONFIG_HUGETLB_PAGE
 for slices
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Apr 2019 14:29:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 8xx only selects CONFIG_PPC_MM_SLICES when CONFIG_HUGETLB_PAGE
is set.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index beded4df1f50..0224fc7633b0 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -216,10 +216,8 @@ typedef struct {
 	unsigned char high_slices_psize[0];
 	unsigned long slb_addr_limit;
 	struct slice_mask mask_base_psize; /* 4k or 16k */
-# ifdef CONFIG_HUGETLB_PAGE
 	struct slice_mask mask_512k;
 	struct slice_mask mask_8m;
-# endif
 #endif
 	void *pte_frag;
 } mm_context_t;
@@ -257,12 +255,10 @@ static inline void mm_ctx_set_slb_addr_limit(mm_context_t *ctx, unsigned long li
 
 static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
 {
-#ifdef CONFIG_HUGETLB_PAGE
 	if (psize == MMU_PAGE_512K)
 		return &ctx->mask_512k;
 	if (psize == MMU_PAGE_8M)
 		return &ctx->mask_8m;
-#endif
 	VM_BUG_ON(psize != mmu_virtual_psize);
 
 	return &ctx->mask_base_psize;
-- 
2.13.3

