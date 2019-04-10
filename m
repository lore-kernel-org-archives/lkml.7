Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAC4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BA22083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbfDJPQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:16:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56502 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733018AbfDJPQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:16:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43DAEA78;
        Wed, 10 Apr 2019 08:16:11 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B1383F59C;
        Wed, 10 Apr 2019 08:16:09 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        baolu.lu@linux.intel.com, zhangfei.gao@foxmail.com
Subject: [PATCH v3 1/1] iommu: Bind process address spaces to devices
Date:   Wed, 10 Apr 2019 16:15:16 +0100
Message-Id: <20190410151516.47754-2-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bind() and unbind() operations to the IOMMU API.
iommu_sva_bind_device() binds a device to an mm, and returns a handle to
the bond, which is released by calling iommu_sva_unbind_device().

Each mm bound to devices gets a PASID (by convention, a 20-bit system-wide
ID representing the address space), which can be retrieved with
iommu_sva_get_pasid(). When programming DMA addresses, device drivers
include this PASID in a device-specific manner, to let the device access
the given address space. Since the process memory may be paged out, device
and IOMMU must support I/O page faults (e.g. PCI PRI).

Using iommu_sva_set_ops(), device drivers provide an mm_exit() callback
that is called by the IOMMU driver if the process exits before the device
driver called unbind(). In mm_exit(), device driver should disable DMA
from the given context, so that the core IOMMU can reallocate the PASID.
Whether the process exited or nor, the device driver should always release
the handle with unbind().

To use these functions, device driver must first enable the
IOMMU_DEV_FEAT_SVA device feature with iommu_dev_enable_feature().

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  70 ++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d3403d84b20c..65e3b2f06e22 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2357,3 +2357,107 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
+
+/**
+ * iommu_sva_bind_device() - Bind a process address space to a device
+ * @dev: the device
+ * @mm: the mm to bind, caller must hold a reference to it
+ *
+ * Create a bond between device and address space, allowing the device to access
+ * the mm using the returned PASID. If a bond already exists between @device and
+ * @mm, it is returned and an additional reference is taken. Caller must call
+ * iommu_sva_unbind_device() to release each reference.
+ *
+ * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
+ * initialize the required SVA features.
+ *
+ * On error, returns an ERR_PTR value.
+ */
+struct iommu_sva *
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+{
+	struct iommu_group *group;
+	struct iommu_sva *handle = ERR_PTR(-EINVAL);
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (!ops || !ops->sva_bind)
+		return ERR_PTR(-ENODEV);
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return ERR_PTR(-ENODEV);
+
+	/* Ensure device count and domain don't change while we're binding */
+	mutex_lock(&group->mutex);
+
+	/*
+	 * To keep things simple, SVA currently doesn't support IOMMU groups
+	 * with more than one device. Existing SVA-capable systems are not
+	 * affected by the problems that required IOMMU groups (lack of ACS
+	 * isolation, device ID aliasing and other hardware issues).
+	 */
+	if (iommu_group_device_count(group) != 1)
+		goto out_unlock;
+
+	handle = ops->sva_bind(dev, mm, drvdata);
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return handle;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
+
+/**
+ * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
+ * @handle: the handle returned by iommu_sva_bind_device()
+ *
+ * Put reference to a bond between device and address space. The device should
+ * not be issuing any more transaction for this PASID. All outstanding page
+ * requests for this PASID must have been flushed to the IOMMU.
+ *
+ * Returns 0 on success, or an error value
+ */
+void iommu_sva_unbind_device(struct iommu_sva *handle)
+{
+	struct iommu_group *group;
+	struct device *dev = handle->dev;
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+	if (!ops || !ops->sva_unbind)
+		return;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return;
+
+	mutex_lock(&group->mutex);
+	ops->sva_unbind(handle);
+	mutex_unlock(&group->mutex);
+
+	iommu_group_put(group);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
+
+int iommu_sva_set_ops(struct iommu_sva *handle,
+		      const struct iommu_sva_ops *sva_ops)
+{
+	if (handle->ops && handle->ops != sva_ops)
+		return -EEXIST;
+
+	handle->ops = sva_ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_set_ops);
+
+int iommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
+
+	if (!ops || !ops->sva_get_pasid)
+		return IOMMU_PASID_INVALID;
+
+	return ops->sva_get_pasid(handle);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ed6738c358ca..87fe1cddd817 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -51,10 +51,13 @@ struct device;
 struct iommu_domain;
 struct notifier_block;
 struct iommu_fault_event;
+struct iommu_sva;
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault_event *, void *);
+typedef int (*iommu_mm_exit_handler_t)(struct device *dev, struct iommu_sva *,
+				       void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -159,6 +162,28 @@ struct iommu_resv_region {
 /* Per device IOMMU features */
 enum iommu_dev_features {
 	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
+	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
+};
+
+#define IOMMU_PASID_INVALID	(-1U)
+
+/**
+ * struct iommu_sva_ops - device driver callbacks for an SVA context
+ *
+ * @mm_exit: called when the mm is about to be torn down by exit_mmap. After
+ *           @mm_exit returns, the device must not issue any more transaction
+ *           with the PASID given as argument.
+ *
+ *           The @mm_exit handler is allowed to sleep. Be careful about the
+ *           locks taken in @mm_exit, because they might lead to deadlocks if
+ *           they are also held when dropping references to the mm. Consider the
+ *           following call chain:
+ *           mutex_lock(A); mmput(mm) -> exit_mm() -> @mm_exit() -> mutex_lock(A)
+ *           Using mmput_async() prevents this scenario.
+ *
+ */
+struct iommu_sva_ops {
+	iommu_mm_exit_handler_t mm_exit;
 };
 
 #ifdef CONFIG_IOMMU_API
@@ -231,6 +256,10 @@ struct page_response_msg {
  * @dev_feat_enabled: check enabled feature
  * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
  * @aux_get_pasid: get the pasid given an aux-domain
+ * @sva_bind: Bind process address space to device
+ * @sva_unbind: Unbind process address space from device
+ * @sva_set_ops: Set ops for a SVA handle
+ * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
@@ -287,6 +316,10 @@ struct iommu_ops {
 	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
 
+	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
+				      void *drvdata);
+	void (*sva_unbind)(struct iommu_sva *handle);
+	int (*sva_get_pasid)(struct iommu_sva *handle);
 	int (*page_response)(struct device *dev, struct page_response_msg *msg);
 
 	unsigned long pgsize_bitmap;
@@ -514,6 +547,14 @@ struct iommu_fwspec {
 	u32			ids[1];
 };
 
+/**
+ * struct iommu_sva - handle to a device-mm bond
+ */
+struct iommu_sva {
+	struct device			*dev;
+	const struct iommu_sva_ops	*ops;
+};
+
 /* Firmware disabled ATS in the root complex */
 #define IOMMU_FWSPEC_PCI_NO_ATS			(1 << 0)
 
@@ -545,6 +586,14 @@ int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev);
 void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
 int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
+struct iommu_sva *iommu_sva_bind_device(struct device *dev,
+					struct mm_struct *mm,
+					void *drvdata);
+void iommu_sva_unbind_device(struct iommu_sva *handle);
+int iommu_sva_set_ops(struct iommu_sva *handle,
+		      const struct iommu_sva_ops *ops);
+int iommu_sva_get_pasid(struct iommu_sva *handle);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -893,6 +942,27 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 	return -ENODEV;
 }
 
+static inline struct iommu_sva *
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+{
+	return NULL;
+}
+
+static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
+{
+}
+
+static inline int iommu_sva_set_ops(struct iommu_sva *handle,
+				    const struct iommu_sva_ops *ops)
+{
+	return -EINVAL;
+}
+
+static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	return IOMMU_PASID_INVALID;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_DEBUGFS
-- 
2.21.0

