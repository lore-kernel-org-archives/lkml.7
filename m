Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7524DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CF42171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfCLGGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:06:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:22866 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfCLGGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:06:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 23:06:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,470,1544515200"; 
   d="scan'208";a="141228884"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2019 23:06:10 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1 9/9] iommu/vt-d: Use bounce buffer for untrusted devices
Date:   Tue, 12 Mar 2019 14:00:05 +0800
Message-Id: <20190312060005.12189-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312060005.12189-1-baolu.lu@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
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
 drivers/iommu/intel-iommu.c | 151 +++++++++++++++++++++++++++---------
 1 file changed, 114 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4f2fdd68658c..4bdfc42c06f4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -52,6 +52,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
+#include <trace/events/intel_iommu.h>
 
 #include "irq_remapping.h"
 #include "intel-pasid.h"
@@ -3670,12 +3671,14 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 				     size_t size, int dir, u64 dma_mask)
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
+	struct bounce_param param;
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -3687,9 +3690,10 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 		return DMA_MAPPING_ERROR;
 
 	iommu = domain_get_iommu(domain);
-	size = aligned_nrpages(paddr, size);
+	nrpages = aligned_nrpages(paddr, size);
 
-	iova_pfn = intel_alloc_iova(dev, domain, dma_to_mm_pfn(size), dma_mask);
+	iova_pfn = intel_alloc_iova(dev, domain,
+				    dma_to_mm_pfn(nrpages), dma_mask);
 	if (!iova_pfn)
 		goto error;
 
@@ -3702,24 +3706,36 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 		prot |= DMA_PTE_READ;
 	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
 		prot |= DMA_PTE_WRITE;
+
+	start_dma = (dma_addr_t)iova_pfn << PAGE_SHIFT;
+	start_dma += offset_in_page(paddr);
+
 	/*
 	 * paddr - (paddr + size) might be partial page, we should map the whole
 	 * page.  Note: if two part of one page are separately mapped, we
 	 * might have two guest_addr mapping to the same host paddr, but this
 	 * is not a big problem
 	 */
-	ret = domain_pfn_mapping(domain, mm_to_dma_pfn(iova_pfn),
-				 mm_to_dma_pfn(paddr_pfn), size, prot);
+	memset(&param, 0, sizeof(param));
+	param.prot = prot;
+	param.dir = dir;
+	if (device_needs_bounce(dev)) {
+		ret = domain_bounce_map(domain, start_dma, paddr, size, &param);
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
@@ -3741,36 +3757,81 @@ static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
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
-
-	if (iommu_no_mapping(dev))
-		return;
+	struct bounce_param param;
 
 	if (dev_is_pci(dev))
 		pdev = to_pci_dev(dev);
 
+	if (iommu_no_mapping(dev))
+		return;
+
 	domain = find_domain(dev);
 	BUG_ON(!domain);
 
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
+				memset(&param, 0, sizeof(param));
+				param.freelist = &tmp;
+				param.dir = dir;
+				domain_bounce_unmap(domain, sg_dma_address(sg),
+						    sg_phys(sg), sg->length,
+						    &param);
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
+			memset(&param, 0, sizeof(param));
+			param.freelist = &freelist;
+			param.dir = dir;
+			domain_bounce_unmap(domain, dev_addr, 0, size, &param);
+			trace_bounce_unmap_single(dev, dev_addr, size);
+		} else {
+			freelist = domain_unmap(domain, start_pfn, last_pfn);
+		}
+	}
 
 	if (intel_iommu_strict || (pdev && pdev->untrusted)) {
 		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
@@ -3792,7 +3853,7 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	intel_unmap(dev, dev_addr, size);
+	intel_unmap(dev, dev_addr, size, NULL, 0, dir, attrs);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3852,7 +3913,7 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
-	intel_unmap(dev, dma_handle, size);
+	intel_unmap(dev, dma_handle, size, NULL, 0, 0, attrs);
 	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
 		__free_pages(page, order);
 }
@@ -3861,16 +3922,7 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
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
@@ -3932,7 +3984,32 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 	start_vpfn = mm_to_dma_pfn(iova_pfn);
 
-	ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
+	if (device_needs_bounce(dev)) {
+		for_each_sg(sglist, sg, nelems, i) {
+			unsigned int pgoff = offset_in_page(sg->offset);
+			struct bounce_param param;
+			dma_addr_t addr;
+
+			addr = ((dma_addr_t)iova_pfn << PAGE_SHIFT) + pgoff;
+			memset(&param, 0, sizeof(param));
+			param.prot = prot;
+			param.dir = dir;
+			ret = domain_bounce_map(domain, addr, sg_phys(sg),
+						sg->length, &param);
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

