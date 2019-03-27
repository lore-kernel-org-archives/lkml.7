Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAF7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C632C20811
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbfC0GlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:41:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:6573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387542AbfC0GlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:41:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 23:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="129006826"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 23:41:01 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 04/10] iommu/vt-d: Add dir_to_prot() helper
Date:   Wed, 27 Mar 2019 14:35:00 +0800
Message-Id: <20190327063506.32564-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This consolidates the code with a helper.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 21 +++------------------
 include/linux/intel-iommu.h | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 19b1ff02025a..6e4e72cd16ca 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3676,15 +3676,8 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	if (!iova_pfn)
 		goto error;
 
-	/*
-	 * Check if DMAR supports zero-length reads on write only
-	 * mappings..
-	 */
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL || \
-			!cap_zlr(iommu->cap))
-		prot |= DMA_PTE_READ;
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		prot |= DMA_PTE_WRITE;
+	prot = dir_to_prot(iommu, dir);
+
 	/*
 	 * paddr - (paddr + size) might be partial page, we should map the whole
 	 * page.  Note: if two part of one page are separately mapped, we
@@ -3899,15 +3892,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 		return 0;
 	}
 
-	/*
-	 * Check if DMAR supports zero-length reads on write only
-	 * mappings..
-	 */
-	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL || \
-			!cap_zlr(iommu->cap))
-		prot |= DMA_PTE_READ;
-	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
-		prot |= DMA_PTE_WRITE;
+	prot = dir_to_prot(iommu, dir);
 
 	start_vpfn = mm_to_dma_pfn(iova_pfn);
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 74afedfe193b..0fbefdf645a5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -593,6 +593,26 @@ static inline void __iommu_flush_cache(
 		clflush_cache_range(addr, size);
 }
 
+static inline int dir_to_prot(struct intel_iommu *iommu,
+			      enum dma_data_direction dir)
+{
+	int prot = 0;
+
+	/*
+	 * Check if DMAR supports zero-length reads on write only
+	 * mappings..
+	 */
+	if (dir == DMA_TO_DEVICE ||
+	    dir == DMA_BIDIRECTIONAL ||
+	    !cap_zlr(iommu->cap))
+		prot |= DMA_PTE_READ;
+
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		prot |= DMA_PTE_WRITE;
+
+	return prot;
+}
+
 /*
  * 0: readable
  * 1: writable
-- 
2.17.1

