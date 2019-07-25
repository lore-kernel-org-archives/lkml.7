Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7547EC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB3A22BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389982AbfGYDSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:18:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:3613 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388449AbfGYDSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:18:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 20:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,305,1559545200"; 
   d="scan'208";a="189228305"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2019 20:18:08 -0700
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
Subject: [PATCH v5 03/10] iommu/vt-d: Cleanup after use per-device dma ops
Date:   Thu, 25 Jul 2019 11:17:10 +0800
Message-Id: <20190725031717.32317-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725031717.32317-1-baolu.lu@linux.intel.com>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After using per-device dma ops, we don't need to check whether
a dvice needs mapping, hence all checks of iommu_need_mapping()
are unnecessary now. Cleanup them.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 50 ++++---------------------------------
 1 file changed, 5 insertions(+), 45 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 11474bd2e348..a458df975c55 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2749,17 +2749,6 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static int identity_mapping(struct device *dev)
-{
-	struct device_domain_info *info;
-
-	info = dev->archdata.iommu;
-	if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
-		return (info->domain == si_domain);
-
-	return 0;
-}
-
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
 	struct dmar_domain *ndomain;
@@ -3416,15 +3405,6 @@ static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 	return domain;
 }
 
-/* Check if the dev needs to go through non-identity map and unmap process.*/
-static bool iommu_need_mapping(struct device *dev)
-{
-	if (iommu_dummy(dev))
-		return false;
-
-	return !identity_mapping(dev);
-}
-
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 				     size_t size, int dir, u64 dma_mask)
 {
@@ -3486,20 +3466,15 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		return __intel_map_single(dev, page_to_phys(page) + offset,
-				size, dir, *dev->dma_mask);
-	return dma_direct_map_page(dev, page, offset, size, dir, attrs);
+	return __intel_map_single(dev, page_to_phys(page) + offset,
+				  size, dir, *dev->dma_mask);
 }
 
 static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     size_t size, enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		return __intel_map_single(dev, phys_addr, size, dir,
-				*dev->dma_mask);
-	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
+	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
@@ -3551,17 +3526,13 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		intel_unmap(dev, dev_addr, size);
-	else
-		dma_direct_unmap_page(dev, dev_addr, size, dir, attrs);
+	intel_unmap(dev, dev_addr, size);
 }
 
 static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		intel_unmap(dev, dev_addr, size);
+	intel_unmap(dev, dev_addr, size);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3571,9 +3542,6 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	struct page *page = NULL;
 	int order;
 
-	if (!iommu_need_mapping(dev))
-		return dma_direct_alloc(dev, size, dma_handle, flags, attrs);
-
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
@@ -3607,9 +3575,6 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order;
 	struct page *page = virt_to_page(vaddr);
 
-	if (!iommu_need_mapping(dev))
-		return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
-
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
@@ -3627,9 +3592,6 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *sg;
 	int i;
 
-	if (!iommu_need_mapping(dev))
-		return dma_direct_unmap_sg(dev, sglist, nelems, dir, attrs);
-
 	for_each_sg(sglist, sg, nelems, i) {
 		nrpages += aligned_nrpages(sg_dma_address(sg), sg_dma_len(sg));
 	}
@@ -3651,8 +3613,6 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct intel_iommu *iommu;
 
 	BUG_ON(dir == DMA_NONE);
-	if (!iommu_need_mapping(dev))
-		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
 
 	domain = find_domain(dev);
 	if (!domain)
-- 
2.17.1

