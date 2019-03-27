Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1760CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0A620811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbfC0GlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:41:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:6573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387671AbfC0GlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:41:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 23:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="129006877"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 23:41:15 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 10/10] iommu/vt-d: Use bounce buffer for untrusted devices
Date:   Wed, 27 Mar 2019 14:35:06 +0800
Message-Id: <20190327063506.32564-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel VT-d hardware uses paging for DMA remapping.
The minimum mapped window is a page size. The device
drivers may map buffers not filling the whole IOMMU
window. This allows the device to access to possibly
unrelated memory and a malicious device could exploit
this to perform DMA attacks. To address this, the
Intel IOMMU driver will use bounce pages for those
buffers which don't fill a whole IOMMU page.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-iommu.c | 140 ++++++++++++++++++++++++++----------
 1 file changed, 102 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4ad8ac7f791e..c3f4e711e96e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -52,6 +52,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
+#include <trace/events/intel_iommu.h>
 
 #include "irq_remapping.h"
 #include "intel-pasid.h"
@@ -3670,15 +3671,17 @@ static int iommu_no_mapping(struct device *dev)
 }
 
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
-				     size_t size, int dir, u64 dma_mask)
+				     size_t size, enum dma_data_direction dir,
+				     unsigned long attrs, u64 dma_mask)
 {
 	struct dmar_domain *domain;
-	phys_addr_t start_paddr;
+	dma_addr_t start_dma;
 	unsigned long iova_pfn;
 	int prot = 0;
 	int ret;
 	struct intel_iommu *iommu;
 	unsigned long paddr_pfn = paddr >> PAGE_SHIFT;
+	unsigned long nrpages;
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -3690,13 +3693,16 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 		return DMA_MAPPING_ERROR;
 
 	iommu = domain_get_iommu(domain);
-	size = aligned_nrpages(paddr, size);
+	nrpages = aligned_nrpages(paddr, size);
 
-	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
+	iova_pfn = intel_alloc_iova(dev, domain,
+				    dma_to_mm_pfn(nrpages), dma_mask);
 	if (!iova_pfn)
 		goto error;
 
 	prot = dir_to_prot(iommu, dir);
+	start_dma = (dma_addr_t)iova_pfn << PAGE_SHIFT;
+	start_dma += offset_in_page(paddr);
 
 	/*
 	 * paddr - (paddr + size) might be partial page, we should map the whole
@@ -3704,18 +3710,24 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	 * might have two guest_addr mapping to the same host paddr, but this
 	 * is not a big problem
 	 */
-	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
-				 mm_to_dma_pfn(paddr_pfn), size, prot);
+	if (device_needs_bounce(dev)) {
+		ret = domain_bounce_map(dev, start_dma, paddr,
+					size, dir, attrs, NULL);
+		if (!ret)
+			trace_bounce_map_single(dev, start_dma, paddr, size);
+	} else {
+		ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
+					 mm_to_dma_pfn(paddr_pfn),
+					 nrpages, prot);
+	}
 	if (ret)
 		goto error;
 
-	start_paddr = (phys_addr_t)iova_pfn << PAGE_SHIFT;
-	start_paddr += paddr & ~PAGE_MASK;
-	return start_paddr;
-
+	return start_dma;
 error:
 	if (iova_pfn)
-		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
+		free_iova_fast(&domain->iovad, iova_pfn,
+			       dma_to_mm_pfn(nrpages));
 	dev_err(dev, "Device request: %zx@%llx dir %d --- failed\n",
 		size, (unsigned long long)paddr, dir);
 	return DMA_MAPPING_ERROR;
@@ -3727,24 +3739,28 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 unsigned long attrs)
 {
 	return __intel_map_single(dev, page_to_phys(page) + offset, size,
-				  dir, *dev->dma_mask);
+				  dir, attrs, *dev->dma_mask);
 }
 
 static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     size_t size, enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
+	return __intel_map_single(dev, phys_addr, size,
+				  dir, attrs, *dev->dma_mask);
 }
 
-static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
+static void
+intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size,
+	    struct scatterlist *sglist, int nelems,
+	    enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dmar_domain *domain;
 	unsigned long start_pfn, last_pfn;
-	unsigned long nrpages;
+	unsigned long nrpages = 0;
 	unsigned long iova_pfn;
 	struct intel_iommu *iommu;
-	struct page *freelist;
+	struct page *freelist = NULL;
 	struct pci_dev *pdev = NULL;
 
 	if (iommu_no_mapping(dev))
@@ -3758,15 +3774,51 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 
 	iommu = domain_get_iommu(domain);
 
-	iova_pfn = IOVA_PFN(dev_addr);
-
-	nrpages = aligned_nrpages(dev_addr, size);
-	start_pfn = mm_to_dma_pfn(iova_pfn);
-	last_pfn = start_pfn + nrpages - 1;
-
-	dev_dbg(dev, "Device unmapping: pfn %lx-%lx\n", start_pfn, last_pfn);
+	if (sglist) {
+		struct scatterlist *sg;
+		int i;
 
-	freelist = domain_unmap(domain, start_pfn, last_pfn);
+		dev_addr = sg_dma_address(sglist) & PAGE_MASK;
+		iova_pfn = IOVA_PFN(dev_addr);
+		for_each_sg(sglist, sg, nelems, i) {
+			nrpages += aligned_nrpages(sg_dma_address(sg),
+						   sg_dma_len(sg));
+		}
+		start_pfn = mm_to_dma_pfn(iova_pfn);
+		last_pfn = start_pfn + nrpages - 1;
+
+		if (device_needs_bounce(dev))
+			for_each_sg(sglist, sg, nelems, i) {
+				struct page *tmp;
+
+				tmp = NULL;
+				domain_bounce_unmap(dev, sg_dma_address(sg),
+						    sg->length, dir,
+						    attrs, &tmp);
+				if (tmp) {
+					tmp->freelist = freelist;
+					freelist = tmp;
+				}
+				trace_bounce_unmap_sg(dev, i, nelems,
+						      sg_dma_address(sg),
+						      sg_phys(sg), sg->length);
+			}
+		else
+			freelist = domain_unmap(domain, start_pfn, last_pfn);
+	} else {
+		iova_pfn = IOVA_PFN(dev_addr);
+		nrpages = aligned_nrpages(dev_addr, size);
+		start_pfn = mm_to_dma_pfn(iova_pfn);
+		last_pfn = start_pfn + nrpages - 1;
+
+		if (device_needs_bounce(dev)) {
+			domain_bounce_unmap(dev, dev_addr, size,
+					    dir, attrs, &freelist);
+			trace_bounce_unmap_single(dev, dev_addr, size);
+		} else {
+			freelist = domain_unmap(domain, start_pfn, last_pfn);
+		}
+	}
 
 	if (intel_iommu_strict || (pdev && pdev->untrusted)) {
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
@@ -3788,7 +3840,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	intel_unmap(dev, dev_addr, size);
+	intel_unmap(dev, dev_addr, size, NULL, 0, dir, attrs);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3829,7 +3881,7 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	memset(page_address(page), 0, size);
 
 	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
-					 DMA_BIDIRECTIONAL,
+					 DMA_BIDIRECTIONAL, attrs,
 					 dev->coherent_dma_mask);
 	if (*dma_handle != DMA_MAPPING_ERROR)
 		return page_address(page);
@@ -3848,7 +3900,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	intel_unmap(dev, dma_handle, size);
+	intel_unmap(dev, dma_handle, size, NULL, 0, 0, attrs);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, order);
 }
@@ -3857,16 +3909,7 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			   int nelems, enum dma_data_direction dir,
 			   unsigned long attrs)
 {
-	dma_addr_t startaddr = sg_dma_address(sglist) & PAGE_MASK;
-	unsigned long nrpages = 0;
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sglist, sg, nelems, i) {
-		nrpages += aligned_nrpages(sg_dma_address(sg), sg_dma_len(sg));
-	}
-
-	intel_unmap(dev, startaddr, nrpages << VTD_PAGE_SHIFT);
+	intel_unmap(dev, 0, 0, sglist, nelems, dir, attrs);
 }
 
 static int intel_nontranslate_map_sg(struct device *hddev,
@@ -3920,7 +3963,28 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 	start_vpfn = mm_to_dma_pfn(iova_pfn);
 
-	ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
+	if (device_needs_bounce(dev)) {
+		for_each_sg(sglist, sg, nelems, i) {
+			unsigned int pgoff = offset_in_page(sg->offset);
+			dma_addr_t addr;
+
+			addr = ((dma_addr_t)iova_pfn << PAGE_SHIFT) + pgoff;
+			ret = domain_bounce_map(dev, addr, sg_phys(sg),
+						sg->length, dir, attrs, NULL);
+			if (ret)
+				break;
+
+			trace_bounce_map_sg(dev, i, nelems, addr,
+					    sg_phys(sg), sg->length);
+
+			sg->dma_address = addr;
+			sg->dma_length = sg->length;
+			iova_pfn += aligned_nrpages(sg->offset, sg->length);
+		}
+	} else {
+		ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
+	}
+
 	if (unlikely(ret)) {
 		dma_pte_free_pagetable(domain, start_vpfn,
 				       start_vpfn + size - 1,
-- 
2.17.1

