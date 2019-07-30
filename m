Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDFBC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66BBA2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WKq782IF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfG3Fwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:52:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbfG3Fw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SLYhAoIvzDqEf4YX6gjEiCAIywOZyrNyWp5yd9O/FEc=; b=WKq782IFsF2U8eCPkvbUWuvcnc
        dGVtnstjVvRw2rYquMXhiZpabUdUodjkHu9e7OfwK5arL0H5z+H39dxtShbtn8hqykGKG03/CEL0F
        NUObuP68VCe2bBewDj64dRY+eMtBG27qhmhh5JOz8nTU3t5Sh/ssdaHtdPal7/Ql9XMNVhT5vTpqd
        tGdz/1eEoUVBDmSFmFqaT5L12zImSvXSXehxchm9l9I6kt/e/hGAQmgn4I+XTxnAGXdmF2OJJSk2R
        xl6eJ0RkTyxEgWzxTAyofzqSRzUa8oFtXKF2RnLpeyeF4NvIBHBO+0N+OyQQ2gti5w0FwunCO7uiv
        aR5KVByA==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsL3i-00016F-Io; Tue, 30 Jul 2019 05:52:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] mm: remove the pgmap field from struct hmm_vma_walk
Date:   Tue, 30 Jul 2019 08:51:54 +0300
Message-Id: <20190730055203.28467-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730055203.28467-1-hch@lst.de>
References: <20190730055203.28467-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single place where the pgmap is passed over a function
call, so replace it with local variables in the places where we deal
with the pgmap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 62 ++++++++++++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 9a908902e4cc..d66fa29b42e0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -278,7 +278,6 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
 
 struct hmm_vma_walk {
 	struct hmm_range	*range;
-	struct dev_pagemap	*pgmap;
 	unsigned long		last;
 	unsigned int		flags;
 };
@@ -475,6 +474,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
+	struct dev_pagemap *pgmap = NULL;
 	unsigned long pfn, npages, i;
 	bool fault, write_fault;
 	uint64_t cpu_flags;
@@ -490,17 +490,14 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 	pfn = pmd_pfn(pmd) + pte_index(addr);
 	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
 		if (pmd_devmap(pmd)) {
-			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
-					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap))
+			pgmap = get_dev_pagemap(pfn, pgmap);
+			if (unlikely(!pgmap))
 				return -EBUSY;
 		}
 		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
 	}
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
+	if (pgmap)
+		put_dev_pagemap(pgmap);
 	hmm_vma_walk->last = end;
 	return 0;
 #else
@@ -520,7 +517,7 @@ static inline uint64_t pte_to_hmm_pfn_flags(struct hmm_range *range, pte_t pte)
 
 static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			      unsigned long end, pmd_t *pmdp, pte_t *ptep,
-			      uint64_t *pfn)
+			      uint64_t *pfn, struct dev_pagemap **pgmap)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
@@ -591,9 +588,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		goto fault;
 
 	if (pte_devmap(pte)) {
-		hmm_vma_walk->pgmap = get_dev_pagemap(pte_pfn(pte),
-					      hmm_vma_walk->pgmap);
-		if (unlikely(!hmm_vma_walk->pgmap))
+		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
+		if (unlikely(!*pgmap))
 			return -EBUSY;
 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
 		*pfn = range->values[HMM_PFN_SPECIAL];
@@ -604,10 +600,10 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	return 0;
 
 fault:
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
+	if (*pgmap)
+		put_dev_pagemap(*pgmap);
+	*pgmap = NULL;
+
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
 	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
@@ -620,6 +616,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
+	struct dev_pagemap *pgmap = NULL;
 	uint64_t *pfns = range->pfns;
 	unsigned long addr = start, i;
 	pte_t *ptep;
@@ -683,23 +680,21 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	for (; addr < end; addr += PAGE_SIZE, ptep++, i++) {
 		int r;
 
-		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, &pfns[i]);
+		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, &pfns[i],
+				&pgmap);
 		if (r) {
 			/* hmm_vma_handle_pte() did unmap pte directory */
 			hmm_vma_walk->last = addr;
 			return r;
 		}
 	}
-	if (hmm_vma_walk->pgmap) {
-		/*
-		 * We do put_dev_pagemap() here and not in hmm_vma_handle_pte()
-		 * so that we can leverage get_dev_pagemap() optimization which
-		 * will not re-take a reference on a pgmap if we already have
-		 * one.
-		 */
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
+	/*
+	 * We do put_dev_pagemap() here and not in hmm_vma_handle_pte() so that
+	 * we can leverage the get_dev_pagemap() optimization which will not
+	 * re-take a reference on a pgmap if we already have one.
+	 */
+	if (pgmap)
+		put_dev_pagemap(pgmap);
 	pte_unmap(ptep - 1);
 
 	hmm_vma_walk->last = addr;
@@ -714,6 +709,7 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long addr = start, next;
+	struct dev_pagemap *pgmap = NULL;
 	pmd_t *pmdp;
 	pud_t pud;
 	int ret;
@@ -744,17 +740,14 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 		for (i = 0; i < npages; ++i, ++pfn) {
-			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
-					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap))
+			pgmap = get_dev_pagemap(pfn, pgmap);
+			if (unlikely(!pgmap))
 				return -EBUSY;
 			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				  cpu_flags;
 		}
-		if (hmm_vma_walk->pgmap) {
-			put_dev_pagemap(hmm_vma_walk->pgmap);
-			hmm_vma_walk->pgmap = NULL;
-		}
+		if (pgmap)
+			put_dev_pagemap(pgmap);
 		hmm_vma_walk->last = end;
 		return 0;
 	}
@@ -1002,7 +995,6 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 			return -EPERM;
 		}
 
-		hmm_vma_walk.pgmap = NULL;
 		hmm_vma_walk.last = start;
 		hmm_vma_walk.flags = flags;
 		hmm_vma_walk.range = range;
-- 
2.20.1

