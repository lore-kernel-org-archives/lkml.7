Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C97C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A992075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfECW3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 18:29:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:7006 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbfECW3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:29:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 15:29:33 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2019 15:29:33 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Auger <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 09/16] iommu: Introduce guest PASID bind function
Date:   Fri,  3 May 2019 15:32:10 -0700
Message-Id: <1556922737-76313-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest shared virtual address (SVA) may require host to shadow guest
PASID tables. Guest PASID can also be allocated from the host via
enlightened interfaces. In this case, guest needs to bind the guest
mm, i.e. cr3 in guest physical address to the actual PASID table in
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
index a2f6f3e..f8572d2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1659,6 +1659,26 @@ int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
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
index d182525..9a69b59 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -268,6 +268,8 @@ struct page_response_msg {
  * @detach_pasid_table: detach the pasid table
  * @cache_invalidate: invalidate translation caches
  * @pgsize_bitmap: bitmap of all possible supported page sizes
+ * @sva_bind_gpasid: bind guest pasid and mm
+ * @sva_unbind_gpasid: unbind guest pasid and mm
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
@@ -332,6 +334,10 @@ struct iommu_ops {
 	int (*page_response)(struct device *dev, struct page_response_msg *msg);
 	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
 				struct iommu_cache_invalidate_info *inv_info);
+	int (*sva_bind_gpasid)(struct iommu_domain *domain,
+			struct device *dev, struct gpasid_bind_data *data);
+
+	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
 
 	unsigned long pgsize_bitmap;
 };
@@ -447,6 +453,10 @@ extern void iommu_detach_pasid_table(struct iommu_domain *domain);
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
index fa96ecb..3a781df 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -240,6 +240,19 @@ struct iommu_cache_invalidate_info {
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

