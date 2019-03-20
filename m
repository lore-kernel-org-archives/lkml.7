Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8475B21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ByKczCNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfCTKHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:07:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43859 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbfCTKHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:07:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PQZB1Rxzz9vC0L;
        Wed, 20 Mar 2019 11:06:58 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ByKczCNT; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RCsqBtQJF1Rm; Wed, 20 Mar 2019 11:06:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PQZB03bZz9vC0H;
        Wed, 20 Mar 2019 11:06:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553076418; bh=UDPBJ/bo+KCA3JW8eW80h7z6wiS0IGvQjLS2tQ348s8=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=ByKczCNTE3rtroo2o8nHgjh/uc6ZptzFE8tBoE61jNwdPLFLHCRj5UzQxHb6noj8J
         RFhrJ4sCiRKZ478U4fYQAlt69H2JWKj58G7fjt0vGlq3rQsj4esad/dKUH30Yw7U+k
         pShx1ugpqJHZ+HFKTLswMb6jJaA8xndkQutNBN98=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 207798B918;
        Wed, 20 Mar 2019 11:06:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lF6RzLg7niZO; Wed, 20 Mar 2019 11:06:59 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EC96B8B911;
        Wed, 20 Mar 2019 11:06:58 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B4F8663AEF; Wed, 20 Mar 2019 10:06:58 +0000 (UTC)
Message-Id: <631fc88138cf384c94879d70c133b1260b0e0b96.1553076180.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553076180.git.christophe.leroy@c-s.fr>
References: <cover.1553076180.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 22/27] powerpc/mm: move slice_mask_for_size() into mmu.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 10:06:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move slice_mask_for_size() into subarch mmu.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/mmu.h     | 22 +++++++++++++----
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 18 ++++++++++++++
 arch/powerpc/mm/slice.c                      | 36 ----------------------------
 3 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 1ceee000c18d..927e3714b0d8 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -123,7 +123,6 @@ typedef struct {
 	/* NPU NMMU context */
 	struct npu_context *npu_context;
 
-#ifdef CONFIG_PPC_MM_SLICES
 	 /* SLB page size encodings*/
 	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
 	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
@@ -136,9 +135,6 @@ typedef struct {
 	struct slice_mask mask_16m;
 	struct slice_mask mask_16g;
 # endif
-#else
-	u16 sllp;		/* SLB page size encoding */
-#endif
 	unsigned long vdso_base;
 #ifdef CONFIG_PPC_SUBPAGE_PROT
 	struct subpage_prot_table spt;
@@ -172,6 +168,24 @@ extern int mmu_vmalloc_psize;
 extern int mmu_vmemmap_psize;
 extern int mmu_io_psize;
 
+static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
+{
+#ifdef CONFIG_PPC_64K_PAGES
+	if (psize == MMU_PAGE_64K)
+		return &ctx->mask_64k;
+#endif
+	if (psize == MMU_PAGE_4K)
+		return &ctx->mask_4k;
+#ifdef CONFIG_HUGETLB_PAGE
+	if (psize == MMU_PAGE_16M)
+		return &ctx->mask_16m;
+	if (psize == MMU_PAGE_16G)
+		return &ctx->mask_16g;
+#endif
+	WARN_ON(true);
+	return NULL;
+}
+
 /* MMU initialization */
 void mmu_early_init_devtree(void);
 void hash__early_init_devtree(void);
diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 0a1a3fc54e54..4ba92c48b3a5 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -255,4 +255,22 @@ extern s32 patch__itlbmiss_perf, patch__dtlbmiss_perf;
 
 #define mmu_linear_psize	MMU_PAGE_8M
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_PPC_MM_SLICES
+static inline struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
+{
+	if (psize == mmu_virtual_psize)
+		return &ctx->mask_base_psize;
+#ifdef CONFIG_HUGETLB_PAGE
+	if (psize == MMU_PAGE_512K)
+		return &ctx->mask_512k;
+	if (psize == MMU_PAGE_8M)
+		return &ctx->mask_8m;
+#endif
+	WARN_ON(true);
+	return NULL;
+}
+#endif
+#endif /* !__ASSEMBLY__ */
+
 #endif /* _ASM_POWERPC_MMU_8XX_H_ */
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 231fd88d97e2..357d64e14757 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -126,42 +126,6 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret,
 			__set_bit(i, ret->high_slices);
 }
 
-#ifdef CONFIG_PPC_BOOK3S_64
-static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
-{
-#ifdef CONFIG_PPC_64K_PAGES
-	if (psize == MMU_PAGE_64K)
-		return &ctx->mask_64k;
-#endif
-	if (psize == MMU_PAGE_4K)
-		return &ctx->mask_4k;
-#ifdef CONFIG_HUGETLB_PAGE
-	if (psize == MMU_PAGE_16M)
-		return &ctx->mask_16m;
-	if (psize == MMU_PAGE_16G)
-		return &ctx->mask_16g;
-#endif
-	WARN_ON(true);
-	return NULL;
-}
-#elif defined(CONFIG_PPC_8xx)
-static struct slice_mask *slice_mask_for_size(mm_context_t *ctx, int psize)
-{
-	if (psize == mmu_virtual_psize)
-		return &ctx->mask_base_psize;
-#ifdef CONFIG_HUGETLB_PAGE
-	if (psize == MMU_PAGE_512K)
-		return &ctx->mask_512k;
-	if (psize == MMU_PAGE_8M)
-		return &ctx->mask_8m;
-#endif
-	WARN_ON(true);
-	return NULL;
-}
-#else
-#error "Must define the slice masks for page sizes supported by the platform"
-#endif
-
 static bool slice_check_range_fits(struct mm_struct *mm,
 			   const struct slice_mask *available,
 			   unsigned long start, unsigned long len)
-- 
2.13.3

