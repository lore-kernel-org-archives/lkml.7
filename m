Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A4C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F114B2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfEYFtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:49:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:46780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfEYFtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:49:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 22:49:03 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:49:00 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        jamessewart@arista.com, tmurphy@arista.com, dima@arista.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 08/15] iommu/vt-d: Identify default domains replaced with private
Date:   Sat, 25 May 2019 13:41:29 +0800
Message-Id: <20190525054136.27810-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we put a device into an iommu group, the group's default
domain will be attached to the device. There are some corner
cases where the type (identity or dma) of the default domain
doesn't work for the device and the request of a new default
domain results in failure (e.x. multiple devices have already
existed in the group). In order to be compatible with the past,
we used a private domain. Mark the private domains and disallow
some iommu apis (map/unmap/iova_to_phys) on them.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 64 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d246b4a9ac1d..08da484e01d6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -305,6 +305,14 @@ static int hw_pass_through = 1;
 /* si_domain contains mulitple devices */
 #define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
 
+/*
+ * This is a DMA domain allocated through the iommu domain allocation
+ * interface. But one or more devices belonging to this domain have
+ * been chosen to use a private domain. We should avoid to use the
+ * map/unmap/iova_to_phys APIs on it.
+ */
+#define DOMAIN_FLAG_LOSE_CHILDREN		BIT(1)
+
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
@@ -4978,6 +4986,7 @@ static void domain_context_clear(struct intel_iommu *iommu, struct device *dev)
 
 static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 {
+	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
 	unsigned long flags;
 
@@ -4987,6 +4996,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 		return;
 
 	iommu = info->iommu;
+	domain = info->domain;
 
 	if (info->dev) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
@@ -5001,9 +5011,14 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	unlink_domain_info(info);
 
 	spin_lock_irqsave(&iommu->lock, flags);
-	domain_detach_iommu(info->domain, iommu);
+	domain_detach_iommu(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
+	/* free the private domain */
+	if (domain->flags & DOMAIN_FLAG_LOSE_CHILDREN &&
+	    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY))
+		domain_exit(info->domain);
+
 	free_devinfo_mem(info);
 }
 
@@ -5330,6 +5345,9 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	int prot = 0;
 	int ret;
 
+	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
+		return -EINVAL;
+
 	if (iommu_prot & IOMMU_READ)
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
@@ -5371,6 +5389,8 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
 	BUG_ON(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level));
+	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
+		return 0;
 
 	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
 		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
@@ -5402,6 +5422,9 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	int level = 0;
 	u64 phys = 0;
 
+	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
+		return 0;
+
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
 	if (pte)
 		phys = dma_pte_addr(pte);
@@ -5457,9 +5480,12 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 
 static int intel_iommu_add_device(struct device *dev)
 {
+	struct dmar_domain *dmar_domain;
+	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 	struct iommu_group *group;
 	u8 bus, devfn;
+	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
@@ -5473,6 +5499,42 @@ static int intel_iommu_add_device(struct device *dev)
 		return PTR_ERR(group);
 
 	iommu_group_put(group);
+
+	domain = iommu_get_domain_for_dev(dev);
+	dmar_domain = to_dmar_domain(domain);
+	if (domain->type == IOMMU_DOMAIN_DMA) {
+		if (device_def_domain_type(dev, 1) == IOMMU_DOMAIN_IDENTITY) {
+			ret = iommu_request_dm_for_dev(dev);
+			if (ret) {
+				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
+				domain_add_dev_info(si_domain, dev);
+				dev_info(dev,
+					 "Device uses a private identity domain.\n");
+				return 0;
+			}
+
+			return -ENODEV;
+		}
+	} else {
+		if (device_def_domain_type(dev, 1) == IOMMU_DOMAIN_DMA) {
+			ret = iommu_request_dma_domain_for_dev(dev);
+			if (ret) {
+				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
+				if (!get_valid_domain_for_dev(dev)) {
+					dev_warn(dev,
+						 "Failed to get a private domain.\n");
+					return -ENOMEM;
+				}
+
+				dev_info(dev,
+					 "Device uses a private dma domain.\n");
+				return 0;
+			}
+
+			return -ENODEV;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.17.1

