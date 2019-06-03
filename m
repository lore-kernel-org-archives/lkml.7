Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE20C282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7465B27A6F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfFCBYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:24:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:20792 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfFCBYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:24:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 18:24:07 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 18:24:03 -0700
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
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 8/9] iommu/vt-d: Code refactoring for bounce map and unmap
Date:   Mon,  3 Jun 2019 09:16:19 +0800
Message-Id: <20190603011620.31999-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603011620.31999-1-baolu.lu@linux.intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to making it ready for calling iommu_bounce_map() and
iommu_bounce_unmap() in __intel_map_single() and intel_unmap(),
we need to do some code refactoring.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 89 ++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 41439647f75d..2f54734d1c43 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3510,16 +3510,19 @@ static bool iommu_need_mapping(struct device *dev)
 	return true;
 }
 
-static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
-				     size_t size, int dir, u64 dma_mask)
+static dma_addr_t
+__intel_map_single(struct device *dev, phys_addr_t paddr, size_t size,
+		   enum dma_data_direction dir, unsigned long attrs,
+		   u64 dma_mask)
 {
+	unsigned long paddr_pfn = paddr >> PAGE_SHIFT;
 	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
 	phys_addr_t start_paddr;
 	unsigned long iova_pfn;
+	unsigned long nrpages;
 	int prot = 0;
 	int ret;
-	struct intel_iommu *iommu;
-	unsigned long paddr_pfn = paddr >> PAGE_SHIFT;
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -3528,9 +3531,9 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 		return DMA_MAPPING_ERROR;
 
 	iommu = domain_get_iommu(domain);
-	size = aligned_nrpages(paddr, size);
-
-	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
+	nrpages = aligned_nrpages(paddr, size);
+	iova_pfn = intel_alloc_iova(dev, domain,
+				    dma_to_mm_pfn(nrpages), dma_mask);
 	if (!iova_pfn)
 		goto error;
 
@@ -3550,7 +3553,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	 * is not a big problem
 	 */
 	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
-				 mm_to_dma_pfn(paddr_pfn), size, prot);
+				 mm_to_dma_pfn(paddr_pfn), nrpages, prot);
 	if (ret)
 		goto error;
 
@@ -3560,7 +3563,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 error:
 	if (iova_pfn)
-		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
+		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(nrpages));
 	dev_err(dev, "Device request: %zx@%llx dir %d --- failed\n",
 		size, (unsigned long long)paddr, dir);
 	return DMA_MAPPING_ERROR;
@@ -3573,7 +3576,7 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 {
 	if (iommu_need_mapping(dev))
 		return __intel_map_single(dev, page_to_phys(page) + offset,
-				size, dir, *dev->dma_mask);
+					  size, dir, attrs, *dev->dma_mask);
 	return dma_direct_map_page(dev, page, offset, size, dir, attrs);
 }
 
@@ -3582,38 +3585,53 @@ static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     unsigned long attrs)
 {
 	if (iommu_need_mapping(dev))
-		return __intel_map_single(dev, phys_addr, size, dir,
-				*dev->dma_mask);
+		return __intel_map_single(dev, phys_addr,
+					  size, dir, attrs, *dev->dma_mask);
 	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
 }
 
-static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
+static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size,
+			struct scatterlist *sglist, int nelems,
+			enum dma_data_direction dir, unsigned long attrs)
 {
-	struct dmar_domain *domain;
 	unsigned long start_pfn, last_pfn;
-	unsigned long nrpages;
-	unsigned long iova_pfn;
-	struct intel_iommu *iommu;
-	struct page *freelist;
+	struct page *freelist = NULL;
 	struct pci_dev *pdev = NULL;
+	struct dmar_domain *domain;
+	unsigned long nrpages = 0;
+	struct intel_iommu *iommu;
+	unsigned long iova_pfn;
 
 	domain = find_domain(dev);
 	BUG_ON(!domain);
 
 	iommu = domain_get_iommu(domain);
 
-	iova_pfn = IOVA_PFN(dev_addr);
+	if (sglist) {
+		struct scatterlist *sg;
+		int i;
 
-	nrpages = aligned_nrpages(dev_addr, size);
-	start_pfn = mm_to_dma_pfn(iova_pfn);
-	last_pfn = start_pfn + nrpages - 1;
+		dev_addr = sg_dma_address(sglist) & PAGE_MASK;
+		iova_pfn = IOVA_PFN(dev_addr);
+		for_each_sg(sglist, sg, nelems, i) {
+			nrpages += aligned_nrpages(sg_dma_address(sg),
+			sg_dma_len(sg));
+		}
+		start_pfn = mm_to_dma_pfn(iova_pfn);
+		last_pfn = start_pfn + nrpages - 1;
 
-	if (dev_is_pci(dev))
-		pdev = to_pci_dev(dev);
+		freelist = domain_unmap(domain, start_pfn, last_pfn);
+	} else {
+		iova_pfn = IOVA_PFN(dev_addr);
+		nrpages = aligned_nrpages(dev_addr, size);
+		start_pfn = mm_to_dma_pfn(iova_pfn);
+		last_pfn = start_pfn + nrpages - 1;
 
-	dev_dbg(dev, "Device unmapping: pfn %lx-%lx\n", start_pfn, last_pfn);
+		freelist = domain_unmap(domain, start_pfn, last_pfn);
+	}
 
-	freelist = domain_unmap(domain, start_pfn, last_pfn);
+	if (dev_is_pci(dev))
+		pdev = to_pci_dev(dev);
 
 	if (intel_iommu_strict || (pdev && pdev->untrusted)) {
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
@@ -3636,7 +3654,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     unsigned long attrs)
 {
 	if (iommu_need_mapping(dev))
-		intel_unmap(dev, dev_addr, size);
+		intel_unmap(dev, dev_addr, size, NULL, 0, dir, attrs);
 	else
 		dma_direct_unmap_page(dev, dev_addr, size, dir, attrs);
 }
@@ -3645,7 +3663,7 @@ static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	if (iommu_need_mapping(dev))
-		intel_unmap(dev, dev_addr, size);
+		intel_unmap(dev, dev_addr, size, NULL, 0, dir, attrs);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3675,7 +3693,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	memset(page_address(page), 0, size);
 
 	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
-					 DMA_BIDIRECTIONAL,
+					 DMA_BIDIRECTIONAL, attrs,
 					 dev->coherent_dma_mask);
 	if (*dma_handle != DMA_MAPPING_ERROR)
 		return page_address(page);
@@ -3697,7 +3715,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	intel_unmap(dev, dma_handle, size);
+	intel_unmap(dev, dma_handle, size, NULL, 0, 0, attrs);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, order);
 }
@@ -3706,19 +3724,10 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction dir,
 			   unsigned long attrs)
 {
-	dma_addr_t startaddr = sg_dma_address(sglist) & PAGE_MASK;
-	unsigned long nrpages = 0;
-	struct scatterlist *sg;
-	int i;
-
 	if (!iommu_need_mapping(dev))
 		return dma_direct_unmap_sg(dev, sglist, nelems, dir, attrs);
 
-	for_each_sg(sglist, sg, nelems, i) {
-		nrpages += aligned_nrpages(sg_dma_address(sg), sg_dma_len(sg));
-	}
-
-	intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
+	intel_unmap(dev, 0, 0, sglist, nelems, dir, attrs);
 }
 
 static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nelems,
-- 
2.17.1

