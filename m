Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56671C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2930523407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfH3HS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:18:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:62229 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfH3HS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:18:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 00:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,446,1559545200"; 
   d="scan'208";a="182576882"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2019 00:18:52 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com,
        kevin.tian@intel.com, mika.westerberg@linux.intel.com,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v8 2/7] swiotlb: Split size parameter to map/unmap APIs
Date:   Fri, 30 Aug 2019 15:17:13 +0800
Message-Id: <20190830071718.16613-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830071718.16613-1-baolu.lu@linux.intel.com>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This splits the size parameter to swiotlb_tbl_map_single() and
swiotlb_tbl_unmap_single() into an alloc_size and a mapping_size
parameter, where the latter one is rounded up to the iommu page
size.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/xen/swiotlb-xen.c |  8 ++++----
 include/linux/swiotlb.h   |  8 ++++++--
 kernel/dma/direct.c       |  2 +-
 kernel/dma/swiotlb.c      | 30 +++++++++++++++++++-----------
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ae1df496bf38..adcabd9473eb 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -386,8 +386,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
 
-	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
-				     attrs);
+	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys,
+				     size, size, dir, attrs);
 	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
@@ -397,7 +397,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 * Ensure that the address returned is DMA'ble
 	 */
 	if (unlikely(!dma_capable(dev, dev_addr, size))) {
-		swiotlb_tbl_unmap_single(dev, map, size, dir,
+		swiotlb_tbl_unmap_single(dev, map, size, size, dir,
 				attrs | DMA_ATTR_SKIP_CPU_SYNC);
 		return DMA_MAPPING_ERROR;
 	}
@@ -433,7 +433,7 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 
 	/* NOTE: We use dev_addr here, not paddr! */
 	if (is_xen_swiotlb_buffer(dev_addr))
-		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
+		swiotlb_tbl_unmap_single(hwdev, paddr, size, size, dir, attrs);
 }
 
 static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 361f62bb4a8e..cde3dc18e21a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -46,13 +46,17 @@ enum dma_sync_target {
 
 extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 					  dma_addr_t tbl_dma_addr,
-					  phys_addr_t phys, size_t size,
+					  phys_addr_t phys,
+					  size_t mapping_size,
+					  size_t alloc_size,
 					  enum dma_data_direction dir,
 					  unsigned long attrs);
 
 extern void swiotlb_tbl_unmap_single(struct device *hwdev,
 				     phys_addr_t tlb_addr,
-				     size_t size, enum dma_data_direction dir,
+				     size_t mapping_size,
+				     size_t alloc_size,
+				     enum dma_data_direction dir,
 				     unsigned long attrs);
 
 extern void swiotlb_tbl_sync_single(struct device *hwdev,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 706113c6bebc..8402b29c280f 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -305,7 +305,7 @@ void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
 }
 EXPORT_SYMBOL(dma_direct_unmap_page);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9de232229063..89066efa3840 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -444,7 +444,9 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 				   dma_addr_t tbl_dma_addr,
-				   phys_addr_t orig_addr, size_t size,
+				   phys_addr_t orig_addr,
+				   size_t mapping_size,
+				   size_t alloc_size,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
@@ -464,6 +466,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		pr_warn_once("%s is active and system is using DMA bounce buffers\n",
 			     sme_active() ? "SME" : "SEV");
 
+	if (WARN_ON(mapping_size > alloc_size))
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+
 	mask = dma_get_seg_boundary(hwdev);
 
 	tbl_dma_addr &= mask;
@@ -481,8 +486,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
-	nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	if (size >= PAGE_SIZE)
+	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	if (alloc_size >= PAGE_SIZE)
 		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
 	else
 		stride = 1;
@@ -547,7 +552,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-			 size, io_tlb_nslabs, tmp_io_tlb_used);
+			 alloc_size, io_tlb_nslabs, tmp_io_tlb_used);
 	return (phys_addr_t)DMA_MAPPING_ERROR;
 found:
 	io_tlb_used += nslots;
@@ -562,7 +567,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
+		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
 
 	return tlb_addr;
 }
@@ -571,21 +576,24 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
  * tlb_addr is the physical address of the bounce buffer to unmap.
  */
 void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
-			      size_t size, enum dma_data_direction dir,
-			      unsigned long attrs)
+			      size_t mapping_size, size_t alloc_size,
+			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
+	if (WARN_ON(mapping_size > alloc_size))
+		return;
+
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
 	if (orig_addr != INVALID_PHYS_ADDR &&
 	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_FROM_DEVICE);
+		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -665,14 +673,14 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 
 	/* Oh well, have to allocate and map a bounce buffer. */
 	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
-			*phys, size, dir, attrs);
+			*phys, size, size, dir, attrs);
 	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
 		return false;
 
 	/* Ensure that the address returned is DMA'ble */
 	*dma_addr = __phys_to_dma(dev, *phys);
 	if (unlikely(!dma_capable(dev, *dma_addr, size))) {
-		swiotlb_tbl_unmap_single(dev, *phys, size, dir,
+		swiotlb_tbl_unmap_single(dev, *phys, size, size, dir,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC);
 		return false;
 	}
-- 
2.17.1

