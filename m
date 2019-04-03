Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05279C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EE120882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="DP+0b9No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfDCUHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:07:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60056 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfDCUGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:06:23 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44ZHCK5YYQz9v3pv;
        Wed,  3 Apr 2019 22:06:21 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=DP+0b9No; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QduSbUW2nhId; Wed,  3 Apr 2019 22:06:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44ZHCK4T2Sz9v3pp;
        Wed,  3 Apr 2019 22:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1554321981; bh=cKVCAWWgxfJHTR62ySrc4ckTvWFi3ivA85IeW7+QV3M=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=DP+0b9NoZhyZdR5HsqFc9ZQxHcMEw27gUE79pKnlxmROxWhKuGiTUMOIKGegdoV5f
         /LVRMbOGTtmb8CNu28S0SdZEk5HnFvwXvkL7pDmWuU+knabalp2V6r+UXtWTK8Rtzm
         kfH5zQmyI4lPZH3bsHwyPj/bMTrqYvuBa1nhAYlY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA5BD8B905;
        Wed,  3 Apr 2019 22:06:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KejXRKhQv8Eg; Wed,  3 Apr 2019 22:06:21 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8EC548B902;
        Wed,  3 Apr 2019 22:06:21 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 747EF655EC; Wed,  3 Apr 2019 20:06:21 +0000 (UTC)
Message-Id: <04200c1d4d6ea143e54db651995933edefd024ac.1554321743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554321743.git.christophe.leroy@c-s.fr>
References: <cover.1554321743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 09/15] powerpc/mm: inline pte_alloc_one_kernel() and
 pte_alloc_one() on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  3 Apr 2019 20:06:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_alloc_one_kernel() and pte_alloc_one() are simple calls to
pte_fragment_alloc(), so they are good candidates for inlining as
already done on PPC64.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 15 ++++++++++++---
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 15 ++++++++++++---
 arch/powerpc/mm/pgtable_32.c                 | 10 ----------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 645af86cd072..0ed856068bb8 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -59,10 +59,19 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm);
-void pte_frag_destroy(void *pte_frag);
 pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	return (pte_t *)pte_fragment_alloc(mm, 1);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
+{
+	return (pgtable_t)pte_fragment_alloc(mm, 0);
+}
+
+void pte_frag_destroy(void *pte_frag);
 void pte_fragment_free(unsigned long *table, int kernel);
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index ea265a578eb0..1d41508f0676 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -77,10 +77,19 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
 #endif
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm);
-void pte_frag_destroy(void *pte_frag);
 pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel);
+
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	return (pte_t *)pte_fragment_alloc(mm, 1);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
+{
+	return (pgtable_t)pte_fragment_alloc(mm, 0);
+}
+
+void pte_frag_destroy(void *pte_frag);
 void pte_fragment_free(unsigned long *table, int kernel);
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a1c3062f0665..d02fe3ce64db 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -43,16 +43,6 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)pte_fragment_alloc(mm, 1);
-}
-
-pgtable_t pte_alloc_one(struct mm_struct *mm)
-{
-	return (pgtable_t)pte_fragment_alloc(mm, 0);
-}
-
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-- 
2.13.3

