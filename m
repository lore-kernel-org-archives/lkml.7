Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B0DC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BE422459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iF3sTTwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfKMNpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:45:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfKMNpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dbHXvHHO0vExx9pg+QDwRlvBCR8gm4rqbdm4b46pTX8=; b=iF3sTTwcKd+vHRsn5vqbMfUMX
        LMs3j0MwWMiqhx1P88B7CqzUsVMzgxihjAq/fb4Cm/ZVmGJdxG1b07NFu3DkIW7uwDuvKdiBm8jh9
        sBSvLTUBxkAedST/O/gArj7PJd4necaG+lxm7k/Crx/BkyN3gYfzH9sk8eEQnVue2hYWfkOmx6ZgD
        elJgLa2toIFgzhQ70D+w+u60Z4SjbNesnZHmZQyNGxovmCPbMSALyHmOBtwGCJbptuNUL75CNek/w
        H5Hjbwrdsy3u5CLHLVND0CgGZc9wYTmwSU8SKLa6ydJYtZ2LGn0eSpitye5we3cl+pVQK/nn78GKX
        hnRsq5pTQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUsxe-00052U-EJ; Wed, 13 Nov 2019 13:45:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     jgg@ziepe.ca, jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hmm: remove hmm_range_dma_map and hmm_range_dma_unmap
Date:   Wed, 13 Nov 2019 14:45:28 +0100
Message-Id: <20191113134528.21187-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions have never been used since they were added.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/hmm.h |  23 -------
 mm/hmm.c            | 147 --------------------------------------------
 2 files changed, 170 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index b4af51735232..922c8d015cdb 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -230,34 +230,11 @@ static inline uint64_t hmm_device_entry_from_pfn(const struct hmm_range *range,
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
 long hmm_range_fault(struct hmm_range *range, unsigned int flags);
-
-long hmm_range_dma_map(struct hmm_range *range,
-		       struct device *device,
-		       dma_addr_t *daddrs,
-		       unsigned int flags);
-long hmm_range_dma_unmap(struct hmm_range *range,
-			 struct device *device,
-			 dma_addr_t *daddrs,
-			 bool dirty);
 #else
 static inline long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 {
 	return -EOPNOTSUPP;
 }
-
-static inline long hmm_range_dma_map(struct hmm_range *range,
-				     struct device *device, dma_addr_t *daddrs,
-				     unsigned int flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline long hmm_range_dma_unmap(struct hmm_range *range,
-				       struct device *device,
-				       dma_addr_t *daddrs, bool dirty)
-{
-	return -EOPNOTSUPP;
-}
 #endif
 
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 9e9d3f4ea17c..ab883eefe847 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -698,150 +698,3 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
 }
 EXPORT_SYMBOL(hmm_range_fault);
-
-/**
- * hmm_range_dma_map - hmm_range_fault() and dma map page all in one.
- * @range:	range being faulted
- * @device:	device to map page to
- * @daddrs:	array of dma addresses for the mapped pages
- * @flags:	HMM_FAULT_*
- *
- * Return: the number of pages mapped on success (including zero), or any
- * status return from hmm_range_fault() otherwise.
- */
-long hmm_range_dma_map(struct hmm_range *range, struct device *device,
-		dma_addr_t *daddrs, unsigned int flags)
-{
-	unsigned long i, npages, mapped;
-	long ret;
-
-	ret = hmm_range_fault(range, flags);
-	if (ret <= 0)
-		return ret ? ret : -EBUSY;
-
-	npages = (range->end - range->start) >> PAGE_SHIFT;
-	for (i = 0, mapped = 0; i < npages; ++i) {
-		enum dma_data_direction dir = DMA_TO_DEVICE;
-		struct page *page;
-
-		/*
-		 * FIXME need to update DMA API to provide invalid DMA address
-		 * value instead of a function to test dma address value. This
-		 * would remove lot of dumb code duplicated accross many arch.
-		 *
-		 * For now setting it to 0 here is good enough as the pfns[]
-		 * value is what is use to check what is valid and what isn't.
-		 */
-		daddrs[i] = 0;
-
-		page = hmm_device_entry_to_page(range, range->pfns[i]);
-		if (page == NULL)
-			continue;
-
-		/* Check if range is being invalidated */
-		if (mmu_range_check_retry(range->notifier,
-					  range->notifier_seq)) {
-			ret = -EBUSY;
-			goto unmap;
-		}
-
-		/* If it is read and write than map bi-directional. */
-		if (range->pfns[i] & range->flags[HMM_PFN_WRITE])
-			dir = DMA_BIDIRECTIONAL;
-
-		daddrs[i] = dma_map_page(device, page, 0, PAGE_SIZE, dir);
-		if (dma_mapping_error(device, daddrs[i])) {
-			ret = -EFAULT;
-			goto unmap;
-		}
-
-		mapped++;
-	}
-
-	return mapped;
-
-unmap:
-	for (npages = i, i = 0; (i < npages) && mapped; ++i) {
-		enum dma_data_direction dir = DMA_TO_DEVICE;
-		struct page *page;
-
-		page = hmm_device_entry_to_page(range, range->pfns[i]);
-		if (page == NULL)
-			continue;
-
-		if (dma_mapping_error(device, daddrs[i]))
-			continue;
-
-		/* If it is read and write than map bi-directional. */
-		if (range->pfns[i] & range->flags[HMM_PFN_WRITE])
-			dir = DMA_BIDIRECTIONAL;
-
-		dma_unmap_page(device, daddrs[i], PAGE_SIZE, dir);
-		mapped--;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(hmm_range_dma_map);
-
-/**
- * hmm_range_dma_unmap() - unmap range of that was map with hmm_range_dma_map()
- * @range: range being unmapped
- * @device: device against which dma map was done
- * @daddrs: dma address of mapped pages
- * @dirty: dirty page if it had the write flag set
- * Return: number of page unmapped on success, -EINVAL otherwise
- *
- * Note that caller MUST abide by mmu notifier or use HMM mirror and abide
- * to the sync_cpu_device_pagetables() callback so that it is safe here to
- * call set_page_dirty(). Caller must also take appropriate locks to avoid
- * concurrent mmu notifier or sync_cpu_device_pagetables() to make progress.
- */
-long hmm_range_dma_unmap(struct hmm_range *range,
-			 struct device *device,
-			 dma_addr_t *daddrs,
-			 bool dirty)
-{
-	unsigned long i, npages;
-	long cpages = 0;
-
-	/* Sanity check. */
-	if (range->end <= range->start)
-		return -EINVAL;
-	if (!daddrs)
-		return -EINVAL;
-	if (!range->pfns)
-		return -EINVAL;
-
-	npages = (range->end - range->start) >> PAGE_SHIFT;
-	for (i = 0; i < npages; ++i) {
-		enum dma_data_direction dir = DMA_TO_DEVICE;
-		struct page *page;
-
-		page = hmm_device_entry_to_page(range, range->pfns[i]);
-		if (page == NULL)
-			continue;
-
-		/* If it is read and write than map bi-directional. */
-		if (range->pfns[i] & range->flags[HMM_PFN_WRITE]) {
-			dir = DMA_BIDIRECTIONAL;
-
-			/*
-			 * See comments in function description on why it is
-			 * safe here to call set_page_dirty()
-			 */
-			if (dirty)
-				set_page_dirty(page);
-		}
-
-		/* Unmap and clear pfns/dma address */
-		dma_unmap_page(device, daddrs[i], PAGE_SIZE, dir);
-		range->pfns[i] = range->values[HMM_PFN_NONE];
-		/* FIXME see comments in hmm_vma_dma_map() */
-		daddrs[i] = 0;
-		cpages++;
-	}
-
-	return cpages;
-}
-EXPORT_SYMBOL(hmm_range_dma_unmap);
-- 
2.20.1

