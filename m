Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6449AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340EE206C1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfECWas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 18:30:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:7006 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfECW3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 18:29:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 15:29:32 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2019 15:29:32 -0700
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
        "Liu, Yi L" <yi.l.liu@linux.intel.com>, Liu@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
Date:   Fri,  3 May 2019 15:32:03 -0700
Message-Id: <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liu, Yi L" <yi.l.liu@linux.intel.com>

In any virtualization use case, when the first translation stage
is "owned" by the guest OS, the host IOMMU driver has no knowledge
of caching structure updates unless the guest invalidation activities
are trapped by the virtualizer and passed down to the host.

Since the invalidation data are obtained from user space and will be
written into physical IOMMU, we must allow security check at various
layers. Therefore, generic invalidation data format are proposed here,
model specific IOMMU drivers need to convert them into their own format.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v6 -> v7:
- detail which fields are used for each invalidation type
- add a comment about multiple cache invalidation

v5 -> v6:
- fix merge issue

v3 -> v4:
- full reshape of the API following Alex' comments

v1 -> v2:
- add arch_id field
- renamed tlb_invalidate into cache_invalidate as this API allows
  to invalidate context caches on top of IOTLBs

v1:
renamed sva_invalidate into tlb_invalidate and add iommu_ prefix in
header. Commit message reworded.
---
 drivers/iommu/iommu.c      | 14 ++++++++
 include/linux/iommu.h      | 15 ++++++++-
 include/uapi/linux/iommu.h | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8df9d34..a2f6f3e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1645,6 +1645,20 @@ void iommu_detach_pasid_table(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
 
+int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
+			   struct iommu_cache_invalidate_info *inv_info)
+{
+	int ret = 0;
+
+	if (unlikely(!domain->ops->cache_invalidate))
+		return -ENODEV;
+
+	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ab4d922..d182525 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -266,6 +266,7 @@ struct page_response_msg {
  * @page_response: handle page request response
  * @attach_pasid_table: attach a pasid table
  * @detach_pasid_table: detach the pasid table
+ * @cache_invalidate: invalidate translation caches
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -328,8 +329,9 @@ struct iommu_ops {
 	int (*attach_pasid_table)(struct iommu_domain *domain,
 				  struct iommu_pasid_table_config *cfg);
 	void (*detach_pasid_table)(struct iommu_domain *domain);
-
 	int (*page_response)(struct device *dev, struct page_response_msg *msg);
+	int (*cache_invalidate)(struct iommu_domain *domain, struct device *dev,
+				struct iommu_cache_invalidate_info *inv_info);
 
 	unsigned long pgsize_bitmap;
 };
@@ -442,6 +444,9 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 extern int iommu_attach_pasid_table(struct iommu_domain *domain,
 				    struct iommu_pasid_table_config *cfg);
 extern void iommu_detach_pasid_table(struct iommu_domain *domain);
+extern int iommu_cache_invalidate(struct iommu_domain *domain,
+				  struct device *dev,
+				  struct iommu_cache_invalidate_info *inv_info);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -982,6 +987,14 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 static inline
 void iommu_detach_pasid_table(struct iommu_domain *domain) {}
 
+static inline int
+iommu_cache_invalidate(struct iommu_domain *domain,
+		       struct device *dev,
+		       struct iommu_cache_invalidate_info *inv_info)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 8848514..fa96ecb 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -162,4 +162,84 @@ struct iommu_pasid_table_config {
 	};
 };
 
+/* defines the granularity of the invalidation */
+enum iommu_inv_granularity {
+	IOMMU_INV_GRANU_DOMAIN,	/* domain-selective invalidation */
+	IOMMU_INV_GRANU_PASID,	/* pasid-selective invalidation */
+	IOMMU_INV_GRANU_ADDR,	/* page-selective invalidation */
+	IOMMU_INVAL_GRANU_NR,   /* number of invalidation granularities */
+};
+
+/**
+ * Address Selective Invalidation Structure
+ *
+ * @flags indicates the granularity of the address-selective invalidation
+ * - if PASID bit is set, @pasid field is populated and the invalidation
+ *   relates to cache entries tagged with this PASID and matching the
+ *   address range.
+ * - if ARCHID bit is set, @archid is populated and the invalidation relates
+ *   to cache entries tagged with this architecture specific id and matching
+ *   the address range.
+ * - Both PASID and ARCHID can be set as they may tag different caches.
+ * - if neither PASID or ARCHID is set, global addr invalidation applies
+ * - LEAF flag indicates whether only the leaf PTE caching needs to be
+ *   invalidated and other paging structure caches can be preserved.
+ * @pasid: process address space id
+ * @archid: architecture-specific id
+ * @addr: first stage/level input address
+ * @granule_size: page/block size of the mapping in bytes
+ * @nb_granules: number of contiguous granules to be invalidated
+ */
+struct iommu_inv_addr_info {
+#define IOMMU_INV_ADDR_FLAGS_PASID	(1 << 0)
+#define IOMMU_INV_ADDR_FLAGS_ARCHID	(1 << 1)
+#define IOMMU_INV_ADDR_FLAGS_LEAF	(1 << 2)
+	__u32	flags;
+	__u32	archid;
+	__u64	pasid;
+	__u64	addr;
+	__u64	granule_size;
+	__u64	nb_granules;
+};
+
+/**
+ * First level/stage invalidation information
+ * @cache: bitfield that allows to select which caches to invalidate
+ * @granularity: defines the lowest granularity used for the invalidation:
+ *     domain > pasid > addr
+ *
+ * Not all the combinations of cache/granularity make sense:
+ *
+ *         type |   DEV_IOTLB   |     IOTLB     |      PASID    |
+ * granularity	|		|		|      cache	|
+ * -------------+---------------+---------------+---------------+
+ * DOMAIN	|	N/A	|       Y	|	Y	|
+ * PASID	|	Y	|       Y	|	Y	|
+ * ADDR		|       Y	|       Y	|	N/A	|
+ *
+ * Invalidations by %IOMMU_INV_GRANU_ADDR use field @addr_info.
+ * Invalidations by %IOMMU_INV_GRANU_PASID use field @pasid.
+ * Invalidations by %IOMMU_INV_GRANU_DOMAIN don't take any argument.
+ *
+ * If multiple cache types are invalidated simultaneously, they all
+ * must support the used granularity.
+ */
+struct iommu_cache_invalidate_info {
+#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
+	__u32	version;
+/* IOMMU paging structure cache */
+#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /* IOMMU IOTLB */
+#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /* Device IOTLB */
+#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /* PASID cache */
+#define IOMMU_CACHE_TYPE_NR		(3)
+	__u8	cache;
+	__u8	granularity;
+	__u8	padding[2];
+	union {
+		__u64	pasid;
+		struct iommu_inv_addr_info addr_info;
+	};
+};
+
+
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

