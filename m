Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9A5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFE82148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDHX5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:57:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:9986 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfDHX5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:57:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149169995"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:08 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>, Liu@vger.kernel.org,
        Yi L <yi.l.liu@linux.intel.com>
Subject: [PATCH 18/18] iommu/vt-d: Add svm/sva invalidate function
Date:   Mon,  8 Apr 2019 16:59:33 -0700
Message-Id: <1554767973-30125-19-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Shared Virtual Address (SVA) is enabled for a guest OS via
vIOMMU, we need to provide invalidation support at IOMMU API and driver
level. This patch adds Intel VT-d specific function to implement
iommu passdown invalidate API for shared virtual address.

The use case is for supporting caching structure invalidation
of assigned SVM capable devices. Emulated IOMMU exposes queue
invalidation capability and passes down all descriptors from the guest
to the physical IOMMU.

The assumption is that guest to host device ID mapping should be
resolved prior to calling IOMMU driver. Based on the device handle,
host IOMMU driver can replace certain fields before submit to the
invalidation queue.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 159 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d43b87d..d7f39a6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5179,6 +5179,164 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 	dmar_remove_one_dev_info(dev);
 }
 
+/*
+ * 2D array for converting and sanitizing IOMMU generic TLB granularity to
+ * VT-d granularity. Invalidation is typically included in the unmap operation
+ * as a result of DMA or VFIO unmap. However, for assigned device where guest
+ * could own the first level page tables without being shadowed by QEMU. In
+ * this case there is no pass down unmap to the host IOMMU as a result of unmap
+ * in the guest. Only invalidations are trapped and passed down.
+ * In all cases, only first level TLB invalidation (request with PASID) can be
+ * passed down, therefore we do not include IOTLB granularity for request
+ * without PASID (second level).
+ *
+ * For an example, to find the VT-d granularity encoding for IOTLB
+ * type and page selective granularity within PASID:
+ * X: indexed by iommu cache type
+ * Y: indexed by enum iommu_inv_granularity
+ * [IOMMU_INV_TYPE_TLB][IOMMU_INV_GRANU_PAGE_PASID]
+ *
+ * Granu_map array indicates validity of the table. 1: valid, 0: invalid
+ *
+ */
+const static int inv_type_granu_map[NR_IOMMU_CACHE_TYPE][NR_IOMMU_CACHE_INVAL_GRANU] = {
+	/* PASID based IOTLB, support PASID selective and page selective */
+	{0, 1, 1},
+	/* PASID based dev TLBs, only support all PASIDs or single PASID */
+	{1, 1, 0},
+	/* PASID cache */
+	{1, 1, 0}
+};
+
+const static u64 inv_type_granu_table[NR_IOMMU_CACHE_TYPE][NR_IOMMU_CACHE_INVAL_GRANU] = {
+	/* PASID based IOTLB */
+	{0, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
+	/* PASID based dev TLBs */
+	{QI_DEV_IOTLB_GRAN_ALL, QI_DEV_IOTLB_GRAN_PASID_SEL, 0},
+	/* PASID cache */
+	{QI_PC_ALL_PASIDS, QI_PC_PASID_SEL, 0},
+};
+
+static inline int to_vtd_granularity(int type, int granu, u64 *vtd_granu)
+{
+	if (type >= NR_IOMMU_CACHE_TYPE || granu >= NR_IOMMU_CACHE_INVAL_GRANU ||
+		!inv_type_granu_map[type][granu])
+		return -EINVAL;
+
+	*vtd_granu = inv_type_granu_table[type][granu];
+
+	return 0;
+}
+
+static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
+{
+	u64 nr_pages;
+	/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
+	 * IOMMU cache invalidate API passes granu_size in bytes, and number of
+	 * granu size in contiguous memory.
+	 */
+
+	nr_pages = (granu_size * nr_granules) >> VTD_PAGE_SHIFT;
+	return order_base_2(nr_pages);
+}
+
+static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
+		struct device *dev, struct iommu_cache_invalidate_info *inv_info)
+{
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct device_domain_info *info;
+	struct intel_iommu *iommu;
+	unsigned long flags;
+	int cache_type;
+	u8 bus, devfn;
+	u16 did, sid;
+	int ret = 0;
+	u64 granu;
+	u64 size;
+
+	if (!inv_info || !dmar_domain ||
+		inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		return -EINVAL;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	spin_lock(&iommu->lock);
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
+	if (!info) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	did = dmar_domain->iommu_did[iommu->seq_id];
+	sid = PCI_DEVID(bus, devfn);
+	size = to_vtd_size(inv_info->addr_info.granule_size, inv_info->addr_info.nb_granules);
+
+	for_each_set_bit(cache_type, (unsigned long *)&inv_info->cache, NR_IOMMU_CACHE_TYPE) {
+
+		ret = to_vtd_granularity(cache_type, inv_info->granularity, &granu);
+		if (ret) {
+			pr_err("Invalid range type %d, granu %d\n", cache_type,
+				inv_info->granularity);
+			break;
+		}
+
+		switch (1 << cache_type) {
+		case IOMMU_CACHE_INV_TYPE_IOTLB:
+			if (size && (inv_info->addr_info.addr & ((1 << (VTD_PAGE_SHIFT + size)) - 1))) {
+				pr_err("Address out of range, 0x%llx, size order %llu\n",
+					inv_info->addr_info.addr, size);
+				ret = -ERANGE;
+				goto out_unlock;
+			}
+
+			qi_flush_piotlb(iommu, did, mm_to_dma_pfn(inv_info->addr_info.addr),
+					inv_info->addr_info.pasid,
+					size, granu);
+
+			/*
+			 * Always flush device IOTLB if ATS is enabled since guest
+			 * vIOMMU exposes CM = 1, no device IOTLB flush will be passed
+			 * down. REVISIT: cannot assume Linux guest
+			 */
+			if (info->ats_enabled) {
+				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
+						inv_info->addr_info.pasid, info->ats_qdep,
+						inv_info->addr_info.addr, size,
+						granu);
+			}
+			break;
+		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
+			if (info->ats_enabled) {
+				qi_flush_dev_piotlb(iommu, sid, info->pfsid,
+						inv_info->addr_info.pasid, info->ats_qdep,
+						inv_info->addr_info.addr, size,
+						granu);
+			} else
+				pr_warn("Passdown device IOTLB flush w/o ATS!\n");
+
+			break;
+		case IOMMU_CACHE_INV_TYPE_PASID:
+			qi_flush_pasid_cache(iommu, did, granu, inv_info->pasid);
+
+			break;
+		default:
+			dev_err(dev, "Unsupported IOMMU invalidation type %d\n",
+				cache_type);
+			ret = -EINVAL;
+		}
+	}
+out_unlock:
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return ret;
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -5447,6 +5605,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.device_group		= pci_device_group,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 #ifdef CONFIG_INTEL_IOMMU_SVM
+	.cache_invalidate	= intel_iommu_sva_invalidate,
 	.sva_bind_gpasid	= intel_svm_bind_gpasid,
 	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
 #endif
-- 
2.7.4

