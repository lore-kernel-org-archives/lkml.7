Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AD9C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8A0218E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfDHX5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:57:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:63285 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbfDHX5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:57:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149169974"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2019 16:57:07 -0700
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 12/18] iommu: Add guest PASID bind function
Date:   Mon,  8 Apr 2019 16:59:27 -0700
Message-Id: <1554767973-30125-13-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest shared virtual address (SVA) may require host to shadow guest
PASID tables. Guest PASID can also be allocated from the host via
enlightened interfaces. In this case, guest needs to bind the guest
mm, i.e. cr3 in guest phisical address to the actual PASID table in
the host IOMMU. Nesting will be turned on such that guest virtual
address can go through a two level translation:
- 1st level translates GVA to GPA
- 2nd level translates GPA to HPA
This patch introduces APIs to bind guest PASID data to the assigned
device entry in the physical IOMMU. See the diagram below for usage
explaination.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process mm, FL only |
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |
    '-------------'
Guest
------| Shadow |--------------------------|------------
      v        v                          v
Host
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.---------------------.
    |             |   |Set SL to GPA-HPA    |
    |             |   '---------------------'
    '-------------'

Where:
 - FL = First level/stage one page tables
 - SL = Second level/stage two page tables

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c      | 20 ++++++++++++++++++++
 include/linux/iommu.h      | 10 ++++++++++
 include/uapi/linux/iommu.h | 15 ++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 344f402..1127920 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1580,6 +1580,26 @@ int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
 
+int iommu_sva_bind_gpasid(struct iommu_domain *domain,
+			struct device *dev, struct gpasid_bind_data *data)
+{
+	if (unlikely(!domain->ops->sva_bind_gpasid))
+		return -ENODEV;
+
+	return domain->ops->sva_bind_gpasid(domain, dev, data);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
+
+int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			int pasid)
+{
+	if (unlikely(!domain->ops->sva_unbind_gpasid))
+		return -ENODEV;
+
+	return domain->ops->sva_unbind_gpasid(dev, pasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c591ef6..c5f5042 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -193,6 +193,8 @@ struct iommu_resv_region {
  * @attach_pasid_table: attach a pasid table
  * @detach_pasid_table: detach the pasid table
  * @cache_invalidate: invalidate translation caches
+ * @sva_bind_gpasid: bind guest pasid and mm
+ * @sva_unbind_gpasid: unbind guest pasid and mm
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -242,6 +244,10 @@ struct iommu_ops {
 
 	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
 				struct iommu_cache_invalidate_info *inv_info);
+	int (*sva_bind_gpasid)(struct iommu_domain *domain,
+			struct device *dev, struct gpasid_bind_data *data);
+
+	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
 
 	unsigned long pgsize_bitmap;
 };
@@ -359,6 +365,10 @@ extern void iommu_detach_pasid_table(struct iommu_domain *domain);
 extern int iommu_cache_invalidate(struct iommu_domain *domain,
 				  struct device *dev,
 				  struct iommu_cache_invalidate_info *inv_info);
+extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
+		struct device *dev, struct gpasid_bind_data *data);
+extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+				struct device *dev, int pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index ae41385..9344cbb 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -228,6 +228,19 @@ struct iommu_cache_invalidate_info {
 		struct iommu_inv_addr_info addr_info;
 	};
 };
-
+/**
+ * struct gpasid_bind_data - Information about device and guest PASID binding
+ * @gcr3:	Guest CR3 value from guest mm
+ * @pasid:	Process address space ID used for the guest mm
+ * @addr_width:	Guest address width. Paging mode can also be derived.
+ */
+struct gpasid_bind_data {
+	__u64 gcr3;
+	__u32 pasid;
+	__u32 addr_width;
+	__u32 flags;
+#define	IOMMU_SVA_GPASID_SRE	BIT(0) /* supervisor request */
+	__u8 padding[4];
+};
 
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

