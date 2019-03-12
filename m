Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9045AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1D321773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfCLGGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:06:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:22866 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbfCLGGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:06:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 23:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,470,1544515200"; 
   d="scan'208";a="141228537"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2019 23:06:06 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1 7/9] iommu/vt-d: Add dma sync ops for untrusted devices
Date:   Tue, 12 Mar 2019 14:00:03 +0800
Message-Id: <20190312060005.12189-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312060005.12189-1-baolu.lu@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the dma sync ops for dma buffers used by any
untrusted device. We need to sync such buffers because
they might have been mapped with bounce pages.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-iommu.c | 154 +++++++++++++++++++++++++++++++++---
 1 file changed, 145 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index cc7609a17d6a..36909f8e7788 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3940,16 +3940,152 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	return nelems;
 }
 
+static void
+sync_dma_for_device(struct device *dev, dma_addr_t dev_addr, size_t size,
+		    enum dma_data_direction dir)
+{
+	struct dmar_domain *domain;
+	struct bounce_param param;
+
+	domain = find_domain(dev);
+	if (WARN_ON(!domain))
+		return;
+
+	memset(&param, 0, sizeof(param));
+	param.dir = dir;
+	if (dir == DMA_BIDIRECTIONAL || dir == DMA_TO_DEVICE)
+		domain_bounce_sync_for_device(domain, dev_addr,
+					      0, size, &param);
+}
+
+static void
+sync_dma_for_cpu(struct device *dev, dma_addr_t dev_addr, size_t size,
+		 enum dma_data_direction dir)
+{
+	struct dmar_domain *domain;
+	struct bounce_param param;
+
+	domain = find_domain(dev);
+	if (WARN_ON(!domain))
+		return;
+
+	memset(&param, 0, sizeof(param));
+	param.dir = dir;
+	if (dir == DMA_BIDIRECTIONAL || dir == DMA_FROM_DEVICE)
+		domain_bounce_sync_for_cpu(domain, dev_addr,
+					   0, size, &param);
+}
+
+static void
+intel_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
+			  size_t size, enum dma_data_direction dir)
+{
+	struct dmar_domain *domain;
+
+	if (WARN_ON(dir == DMA_NONE))
+		return;
+
+	if (!device_needs_bounce(dev))
+		return;
+
+	if (iommu_no_mapping(dev))
+		return;
+
+	domain = get_valid_domain_for_dev(dev);
+	if (!domain)
+		return;
+
+	sync_dma_for_cpu(dev, addr, size, dir);
+}
+
+static void
+intel_sync_single_for_device(struct device *dev, dma_addr_t addr,
+			     size_t size, enum dma_data_direction dir)
+{
+	struct dmar_domain *domain;
+
+	if (WARN_ON(dir == DMA_NONE))
+		return;
+
+	if (!device_needs_bounce(dev))
+		return;
+
+	if (iommu_no_mapping(dev))
+		return;
+
+	domain = get_valid_domain_for_dev(dev);
+	if (!domain)
+		return;
+
+	sync_dma_for_device(dev, addr, size, dir);
+}
+
+static void
+intel_sync_sg_for_cpu(struct device *dev, struct scatterlist *sglist,
+		      int nelems, enum dma_data_direction dir)
+{
+	struct dmar_domain *domain;
+	struct scatterlist *sg;
+	int i;
+
+	if (WARN_ON(dir == DMA_NONE))
+		return;
+
+	if (!device_needs_bounce(dev))
+		return;
+
+	if (iommu_no_mapping(dev))
+		return;
+
+	domain = get_valid_domain_for_dev(dev);
+	if (!domain)
+		return;
+
+	for_each_sg(sglist, sg, nelems, i)
+		sync_dma_for_cpu(dev, sg_dma_address(sg),
+				 sg_dma_len(sg), dir);
+}
+
+static void
+intel_sync_sg_for_device(struct device *dev, struct scatterlist *sglist,
+			 int nelems, enum dma_data_direction dir)
+{
+	struct dmar_domain *domain;
+	struct scatterlist *sg;
+	int i;
+
+	if (WARN_ON(dir == DMA_NONE))
+		return;
+
+	if (!device_needs_bounce(dev))
+		return;
+
+	if (iommu_no_mapping(dev))
+		return;
+
+	domain = get_valid_domain_for_dev(dev);
+	if (!domain)
+		return;
+
+	for_each_sg(sglist, sg, nelems, i)
+		sync_dma_for_device(dev, sg_dma_address(sg),
+				    sg_dma_len(sg), dir);
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
-	.unmap_resource = intel_unmap_page,
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
+	.unmap_resource		= intel_unmap_page,
+	.dma_supported		= dma_direct_supported,
 };
 
 static inline int iommu_domain_cache_init(void)
-- 
2.17.1

