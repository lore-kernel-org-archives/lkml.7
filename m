Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DB8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D405E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfC0GlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:41:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:6573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387482AbfC0Gk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:40:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 23:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="129006804"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga008.jf.intel.com with ESMTP; 26 Mar 2019 23:40:56 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 02/10] iommu/vt-d: Add helpers for domain mapping/unmapping
Date:   Wed, 27 Mar 2019 14:34:58 +0800
Message-Id: <20190327063506.32564-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190327063506.32564-1-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two helpers to map or unmap a physically
contiguous memory region in the page table of an
iommu domain.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Xu Pengfei <pengfei.xu@intel.com>
Tested-by: Mika Westerberg <mika.westerberg@intel.com>
---
 drivers/iommu/intel-iommu.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  5 +++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c137f0f2cf49..19b1ff02025a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5851,3 +5851,38 @@ static void __init check_tylersburg_isoch(void)
 	pr_warn("Recommended TLB entries for ISOCH unit is 16; your BIOS set %d\n",
 	       vtisochctrl);
 }
+
+/*
+ * Map a physically contiguous memory region in the dma page table
+ * of an iommu domain.
+ */
+int
+domain_iomap_range(struct dmar_domain *domain, unsigned long addr,
+		   phys_addr_t paddr, size_t size, int prot)
+{
+	return domain_mapping(domain,
+			      mm_to_dma_pfn(IOVA_PFN(addr)),
+			      NULL,
+			      mm_to_dma_pfn(IOVA_PFN(paddr)),
+			      aligned_nrpages(addr, size),
+			      prot);
+}
+
+/*
+ * Unmap a physically contiguous memory region in the dma page table
+ * of an iommu domain. Return the free page list that should be freed
+ * after iotlb flush. We can't free these pages here since it possibly
+ * is still used by iotlb cache for a DMA translation.
+ */
+struct page *
+domain_iounmap_range(struct dmar_domain *domain, unsigned long addr,
+		     size_t size)
+{
+	unsigned long nrpages, start_pfn, last_pfn;
+
+	nrpages = aligned_nrpages(addr, size);
+	start_pfn = mm_to_dma_pfn(IOVA_PFN(addr));
+	last_pfn = start_pfn + nrpages - 1;
+
+	return domain_unmap(domain, start_pfn, last_pfn);
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 6925a18a5ca3..74afedfe193b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -663,6 +663,11 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 
+int domain_iomap_range(struct dmar_domain *domain, unsigned long addr,
+		       phys_addr_t paddr, size_t size, int prot);
+struct page *domain_iounmap_range(struct dmar_domain *domain,
+				  unsigned long addr, size_t size);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
-- 
2.17.1

