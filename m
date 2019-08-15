Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56785C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246342086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbfHOUJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:09:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:43467 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733273AbfHOUJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:09:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 13:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="188596211"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2019 13:09:42 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     Eric Auger <eric.auger@redhat.com>, "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 05/19] iommu: Introduce attach/detach_pasid_table API
Date:   Thu, 15 Aug 2019 13:13:11 -0700
Message-Id: <1565900005-62508-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In virtualization use case, when a guest is assigned
a PCI host device, protected by a virtual IOMMU on the guest,
the physical IOMMU must be programmed to be consistent with
the guest mappings. If the physical IOMMU supports two
translation stages it makes sense to program guest mappings
onto the first stage/level (ARM/Intel terminology) while the host
owns the stage/level 2.

In that case, it is mandated to trap on guest configuration
settings and pass those to the physical iommu driver.

This patch adds a new API to the iommu subsystem that allows
to set/unset the pasid table information.

A generic iommu_pasid_table_config struct is introduced in
a new iommu.h uapi header. This is going to be used by the VFIO
user API.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu.c      | 19 +++++++++++++++++
 include/linux/iommu.h      | 18 ++++++++++++++++
 include/uapi/linux/iommu.h | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index feada31..155ebef 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1700,6 +1700,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+int iommu_attach_pasid_table(struct iommu_domain *domain,
+			     struct iommu_pasid_table_config *cfg)
+{
+	if (unlikely(!domain->ops->attach_pasid_table))
+		return -ENODEV;
+
+	return domain->ops->attach_pasid_table(domain, cfg);
+}
+EXPORT_SYMBOL_GPL(iommu_attach_pasid_table);
+
+void iommu_detach_pasid_table(struct iommu_domain *domain)
+{
+	if (unlikely(!domain->ops->detach_pasid_table))
+		return;
+
+	domain->ops->detach_pasid_table(domain);
+}
+EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
+
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 39d371b..8c64065 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -228,6 +228,8 @@ struct iommu_sva_ops {
  * @sva_unbind: Unbind process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
+ * @attach_pasid_table: attach a pasid table
+ * @detach_pasid_table: detach the pasid table
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
@@ -287,6 +289,9 @@ struct iommu_ops {
 				      void *drvdata);
 	void (*sva_unbind)(struct iommu_sva *handle);
 	int (*sva_get_pasid)(struct iommu_sva *handle);
+	int (*attach_pasid_table)(struct iommu_domain *domain,
+				  struct iommu_pasid_table_config *cfg);
+	void (*detach_pasid_table)(struct iommu_domain *domain);
 
 	int (*page_response)(struct device *dev,
 			     struct iommu_fault_event *evt,
@@ -399,6 +404,9 @@ extern int iommu_attach_device(struct iommu_domain *domain,
 			       struct device *dev);
 extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
+extern int iommu_attach_pasid_table(struct iommu_domain *domain,
+				    struct iommu_pasid_table_config *cfg);
+extern void iommu_detach_pasid_table(struct iommu_domain *domain);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -941,6 +949,16 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return IOMMU_PASID_INVALID;
 }
 
+static inline
+int iommu_attach_pasid_table(struct iommu_domain *domain,
+			     struct iommu_pasid_table_config *cfg)
+{
+	return -ENODEV;
+}
+
+static inline
+void iommu_detach_pasid_table(struct iommu_domain *domain) {}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index fc00c5d..0f9d249 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -152,4 +152,55 @@ struct iommu_page_response {
 	__u32	code;
 };
 
+/**
+ * struct iommu_pasid_smmuv3 - ARM SMMUv3 Stream Table Entry stage 1 related
+ *     information
+ * @version: API version of this structure
+ * @s1fmt: STE s1fmt (format of the CD table: single CD, linear table
+ *         or 2-level table)
+ * @s1dss: STE s1dss (specifies the behavior when @pasid_bits != 0
+ *         and no PASID is passed along with the incoming transaction)
+ * @padding: reserved for future use (should be zero)
+ *
+ * The PASID table is referred to as the Context Descriptor (CD) table on ARM
+ * SMMUv3. Please refer to the ARM SMMU 3.x spec (ARM IHI 0070A) for full
+ * details.
+ */
+struct iommu_pasid_smmuv3 {
+#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
+	__u32	version;
+	__u8	s1fmt;
+	__u8	s1dss;
+	__u8	padding[2];
+};
+
+/**
+ * struct iommu_pasid_table_config - PASID table data used to bind guest PASID
+ *     table to the host IOMMU
+ * @version: API version to prepare for future extensions
+ * @format: format of the PASID table
+ * @base_ptr: guest physical address of the PASID table
+ * @pasid_bits: number of PASID bits used in the PASID table
+ * @config: indicates whether the guest translation stage must
+ *          be translated, bypassed or aborted.
+ * @padding: reserved for future use (should be zero)
+ * @smmuv3: table information when @format is %IOMMU_PASID_FORMAT_SMMUV3
+ */
+struct iommu_pasid_table_config {
+#define PASID_TABLE_CFG_VERSION_1 1
+	__u32	version;
+#define IOMMU_PASID_FORMAT_SMMUV3	1
+	__u32	format;
+	__u64	base_ptr;
+	__u8	pasid_bits;
+#define IOMMU_PASID_CONFIG_TRANSLATE	1
+#define IOMMU_PASID_CONFIG_BYPASS	2
+#define IOMMU_PASID_CONFIG_ABORT	3
+	__u8	config;
+	__u8    padding[6];
+	union {
+		struct iommu_pasid_smmuv3 smmuv3;
+	};
+};
+
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

