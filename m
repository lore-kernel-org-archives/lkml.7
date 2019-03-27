Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1125EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA742075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbfC0GlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:41:11 -0400
Received: from mga02.intel.com ([134.134.136.20]:6573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387602AbfC0GlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:41:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 23:41:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="129006839"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 23:41:05 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 06/10] iommu/vt-d: Add bounce buffer API for dma sync
Date:   Wed, 27 Mar 2019 14:35:02 +0800
Message-Id: <20190327063506.32564-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the APIs for bounce buffer specified dma sync
ops.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-pgtable.c | 44 +++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h   |  4 ++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iommu/intel-pgtable.c b/drivers/iommu/intel-pgtable.c
index 1e56ea07f755..fbe1d0e073fd 100644
--- a/drivers/iommu/intel-pgtable.c
+++ b/drivers/iommu/intel-pgtable.c
@@ -242,6 +242,35 @@ bounce_sync(phys_addr_t orig_addr, phys_addr_t bounce_addr,
 	return 0;
 }
 
+static int
+bounce_sync_single(struct device *dev, struct dmar_domain *domain,
+		   dma_addr_t addr, phys_addr_t paddr, size_t size,
+		   enum dma_data_direction dir, unsigned long attrs,
+		   void *data)
+{
+	enum dma_sync_target *target = data;
+	struct bounce_cookie *cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bounce_lock, flags);
+	cookie = idr_find(&domain->bounce_idr, addr >> PAGE_SHIFT);
+	spin_unlock_irqrestore(&bounce_lock, flags);
+	if (!cookie)
+		return 0;
+
+	if (*target == SYNC_FOR_DEVICE) {
+		if (dir == DMA_BIDIRECTIONAL || dir == DMA_TO_DEVICE)
+			bounce_sync(cookie->original_phys, cookie->bounce_phys,
+				    size, DMA_TO_DEVICE);
+	} else {
+		if (dir == DMA_BIDIRECTIONAL || dir == DMA_FROM_DEVICE)
+			bounce_sync(cookie->original_phys, cookie->bounce_phys,
+				    size, DMA_FROM_DEVICE);
+	}
+
+	return 0;
+}
+
 static int bounce_map(struct device *dev, struct dmar_domain *domain,
 		      dma_addr_t addr, phys_addr_t paddr, size_t size,
 		      enum dma_data_direction dir, unsigned long attrs,
@@ -315,6 +344,11 @@ static const struct addr_walk walk_bounce_unmap = {
 	.high = bounce_unmap,
 };
 
+static const struct addr_walk walk_bounce_sync_single = {
+	.low = bounce_sync_single,
+	.high = bounce_sync_single,
+};
+
 static int
 domain_walk_addr_range(const struct addr_walk *walk, struct device *dev,
 		       struct dmar_domain *domain, dma_addr_t addr,
@@ -401,3 +435,13 @@ int domain_bounce_unmap(struct device *dev, dma_addr_t addr,
 	return domain_walk_addr_range(&walk_bounce_unmap, dev, domain,
 				      addr, 0, size, dir, attrs, data);
 }
+
+int domain_bounce_sync_single(struct device *dev, dma_addr_t addr,
+			      size_t size, enum dma_data_direction dir,
+			      void *data)
+{
+	struct dmar_domain *domain = get_valid_domain_for_dev(dev);
+
+	return domain_walk_addr_range(&walk_bounce_sync_single, dev,
+				      domain, addr, 0, size, dir, 0, data);
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8fd1768f8729..58f192c1f26f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -31,6 +31,7 @@
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
+#include <linux/swiotlb.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -695,6 +696,9 @@ int domain_bounce_map(struct device *dev, dma_addr_t addr, phys_addr_t paddr,
 int domain_bounce_unmap(struct device *dev, dma_addr_t addr,
 			size_t size, enum dma_data_direction dir,
 			unsigned long attrs, void *data);
+int domain_bounce_sync_single(struct device *dev, dma_addr_t addr,
+			      size_t size, enum dma_data_direction dir,
+			      void *data);
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
-- 
2.17.1

