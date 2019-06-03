Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB7C282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C73527A34
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfFCBYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:24:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:20792 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfFCBYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:24:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 18:24:10 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 18:24:07 -0700
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
Subject: [PATCH v4 9/9] iommu/vt-d: Use bounce buffer for untrusted devices
Date:   Mon,  3 Jun 2019 09:16:20 +0800
Message-Id: <20190603011620.31999-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603011620.31999-1-baolu.lu@linux.intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
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
buffers which don't fill whole IOMMU pages.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-iommu.c | 128 ++++++++++++++++++++++++++++++++----
 1 file changed, 117 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2f54734d1c43..4bf744a1c239 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -52,6 +52,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
+#include <trace/events/intel_iommu.h>
 
 #include "irq_remapping.h"
 #include "intel-pasid.h"
@@ -3537,6 +3538,19 @@ __intel_map_single(struct device *dev, phys_addr_t paddr, size_t size,
 	if (!iova_pfn)
 		goto error;
 
+	if (device_needs_bounce(dev)) {
+		dma_addr_t ret_addr;
+
+		ret_addr = iommu_bounce_map(dev, iova_pfn << PAGE_SHIFT,
+					    paddr, size, dir, attrs);
+		if (ret_addr == DMA_MAPPING_ERROR)
+			goto error;
+		trace_bounce_map_single(dev, iova_pfn << PAGE_SHIFT,
+					paddr, size);
+
+		return ret_addr;
+	}
+
 	/*
 	 * Check if DMAR supports zero-length reads on write only
 	 * mappings..
@@ -3620,14 +3634,28 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size,
 		start_pfn = mm_to_dma_pfn(iova_pfn);
 		last_pfn = start_pfn + nrpages - 1;
 
-		freelist = domain_unmap(domain, start_pfn, last_pfn);
+		if (device_needs_bounce(dev))
+			for_each_sg(sglist, sg, nelems, i) {
+				iommu_bounce_unmap(dev, sg_dma_address(sg),
+						   sg->length, dir, attrs);
+				trace_bounce_unmap_sg(dev, i, nelems,
+						      sg_dma_address(sg),
+						      sg_phys(sg), sg->length);
+			}
+		else
+			freelist = domain_unmap(domain, start_pfn, last_pfn);
 	} else {
 		iova_pfn = IOVA_PFN(dev_addr);
 		nrpages = aligned_nrpages(dev_addr, size);
 		start_pfn = mm_to_dma_pfn(iova_pfn);
 		last_pfn = start_pfn + nrpages - 1;
 
-		freelist = domain_unmap(domain, start_pfn, last_pfn);
+		if (device_needs_bounce(dev)) {
+			iommu_bounce_unmap(dev, dev_addr, size, dir, attrs);
+			trace_bounce_unmap_single(dev, dev_addr, size);
+		} else {
+			freelist = domain_unmap(domain, start_pfn, last_pfn);
+		}
 	}
 
 	if (dev_is_pci(dev))
@@ -3774,6 +3802,26 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 		prot |= DMA_PTE_WRITE;
 
 	start_vpfn = mm_to_dma_pfn(iova_pfn);
+	if (device_needs_bounce(dev)) {
+		for_each_sg(sglist, sg, nelems, i) {
+			dma_addr_t ret_addr;
+
+			ret_addr = iommu_bounce_map(dev,
+					start_vpfn << VTD_PAGE_SHIFT,
+					sg_phys(sg), sg->length, dir, attrs);
+			if (ret_addr == DMA_MAPPING_ERROR)
+				break;
+
+			trace_bounce_map_sg(dev, i, nelems, ret_addr,
+					    sg_phys(sg), sg->length);
+
+			sg->dma_address = ret_addr;
+			sg->dma_length = sg->length;
+			start_vpfn += aligned_nrpages(sg->offset, sg->length);
+		}
+
+		return i;
+	}
 
 	ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
 	if (unlikely(ret)) {
@@ -3787,16 +3835,74 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	return nelems;
 }
 
+static void
+intel_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+			  size_t size, enum dma_data_direction dir)
+{
+	if (!iommu_need_mapping(dev))
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+
+	if (device_needs_bounce(dev))
+		iommu_bounce_sync(dev, addr, size, dir, SYNC_FOR_CPU);
+}
+
+static void
+intel_sync_single_for_device(struct device *dev, dma_addr_t addr,
+			     size_t size, enum dma_data_direction dir)
+{
+	if (!iommu_need_mapping(dev))
+		dma_direct_sync_single_for_device(dev, addr, size, dir);
+
+	if (device_needs_bounce(dev))
+		iommu_bounce_sync(dev, addr, size, dir, SYNC_FOR_DEVICE);
+}
+
+static void
+intel_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist,
+		      int nelems, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (!iommu_need_mapping(dev))
+		dma_direct_sync_sg_for_cpu(dev, sglist, nelems, dir);
+
+	if (device_needs_bounce(dev))
+		for_each_sg(sglist, sg, nelems, i)
+			iommu_bounce_sync(dev, sg_dma_address(sg),
+					  sg_dma_len(sg), dir, SYNC_FOR_CPU);
+}
+
+static void
+intel_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
+			 int nelems, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (!iommu_need_mapping(dev))
+		dma_direct_sync_sg_for_device(dev, sglist, nelems, dir);
+
+	if (device_needs_bounce(dev))
+		for_each_sg(sglist, sg, nelems, i)
+			iommu_bounce_sync(dev, sg_dma_address(sg),
+					  sg_dma_len(sg), dir, SYNC_FOR_DEVICE);
+}
+
 static const struct dma_map_ops intel_dma_ops = {
-	.alloc = intel_alloc_coherent,
-	.free = intel_free_coherent,
-	.map_sg = intel_map_sg,
-	.unmap_sg = intel_unmap_sg,
-	.map_page = intel_map_page,
-	.unmap_page = intel_unmap_page,
-	.map_resource = intel_map_resource,
-	.unmap_resource = intel_unmap_resource,
-	.dma_supported = dma_direct_supported,
+	.alloc			= intel_alloc_coherent,
+	.free			= intel_free_coherent,
+	.map_sg			= intel_map_sg,
+	.unmap_sg		= intel_unmap_sg,
+	.map_page		= intel_map_page,
+	.unmap_page		= intel_unmap_page,
+	.sync_single_for_cpu	= intel_sync_single_for_cpu,
+	.sync_single_for_device	= intel_sync_single_for_device,
+	.sync_sg_for_cpu	= intel_sync_sg_for_cpu,
+	.sync_sg_for_device	= intel_sync_sg_for_device,
+	.map_resource		= intel_map_resource,
+	.unmap_resource		= intel_unmap_resource,
+	.dma_supported		= dma_direct_supported,
 };
 
 static inline int iommu_domain_cache_init(void)
-- 
2.17.1

