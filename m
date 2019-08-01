Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DD5C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53942089E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfHAGC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:02:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:50823 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHAGC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:02:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 23:02:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,333,1559545200"; 
   d="scan'208";a="184119238"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2019 23:02:53 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/3] iommu/vt-d: Refactor find_domain() helper
Date:   Thu,  1 Aug 2019 14:01:54 +0800
Message-Id: <20190801060156.8564-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801060156.8564-1-baolu.lu@linux.intel.com>
References: <20190801060156.8564-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current find_domain() helper checks and does the deferred domain
attachment and return the domain in use. This isn't always the
use case for the callers. Some callers only want to retrieve the
current domain in use.

This refactors find_domain() into two helpers: 1) find_domain()
only returns the domain in use; 2) deferred_attach_domain() does
the deferred domain attachment if required and return the domain
in use.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index aaa641f98590..d2ac89a2026e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2387,14 +2387,24 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-/*
- * find_domain
- * Note: we use struct device->archdata.iommu stores the info
- */
 static struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
 
+	if (unlikely(dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO ||
+		     dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO))
+		return NULL;
+
+	/* No lock here, assumes no domain exit in normal case */
+	info = dev->archdata.iommu;
+	if (likely(info))
+		return info->domain;
+
+	return NULL;
+}
+
+static struct dmar_domain *deferred_attach_domain(struct device *dev)
+{
 	if (unlikely(dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO)) {
 		struct iommu_domain *domain;
 
@@ -2404,12 +2414,7 @@ static struct dmar_domain *find_domain(struct device *dev)
 			intel_iommu_attach_device(domain, dev);
 	}
 
-	/* No lock here, assumes no domain exit in normal case */
-	info = dev->archdata.iommu;
-
-	if (likely(info))
-		return info->domain;
-	return NULL;
+	return find_domain(dev);
 }
 
 static inline struct device_domain_info *
@@ -3478,7 +3483,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	domain = find_domain(dev);
+	domain = deferred_attach_domain(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
 
@@ -3552,7 +3557,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 	struct page *freelist;
 	struct pci_dev *pdev = NULL;
 
-	domain = find_domain(dev);
+	domain = deferred_attach_domain(dev);
 	BUG_ON(!domain);
 
 	iommu = domain_get_iommu(domain);
@@ -3694,7 +3699,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	if (!iommu_need_mapping(dev))
 		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
 
-	domain = find_domain(dev);
+	domain = deferred_attach_domain(dev);
 	if (!domain)
 		return 0;
 
@@ -3757,7 +3762,7 @@ bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
 	unsigned long nrpages;
 	dma_addr_t ret_addr;
 
-	domain = find_domain(dev);
+	domain = deferred_attach_domain(dev);
 	if (WARN_ON(dir == DMA_NONE || !domain))
 		return DMA_MAPPING_ERROR;
 
@@ -3789,7 +3794,7 @@ bounce_unmap_single(struct device *dev, dma_addr_t dev_addr, size_t size,
 	unsigned long iova_pfn;
 	unsigned long nrpages;
 
-	domain = find_domain(dev);
+	domain = deferred_attach_domain(dev);
 	if (WARN_ON(!domain))
 		return;
 
-- 
2.17.1

