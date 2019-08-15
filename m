Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70F9C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EE62089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfHOUKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:10:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:43476 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733277AbfHOUJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:09:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 13:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="188596217"
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
Subject: [PATCH v5 07/19] iommu: Add I/O ASID allocator
Date:   Thu, 15 Aug 2019 13:13:13 -0700
Message-Id: <1565900005-62508-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Some devices might support multiple DMA address spaces, in particular
those that have the PCI PASID feature. PASID (Process Address Space ID)
allows to share process address spaces with devices (SVA), partition a
device into VM-assignable entities (VFIO mdev) or simply provide
multiple DMA address space to kernel drivers. Add a global PASID
allocator usable by different drivers at the same time. Name it I/O ASID
to avoid confusion with ASIDs allocated by arch code, which are usually
a separate ID space.

The IOASID space is global. Each device can have its own PASID space,
but by convention the IOMMU ended up having a global PASID space, so
that with SVA, each mm_struct is associated to a single PASID.

The allocator is primarily used by IOMMU subsystem but in rare occasions
drivers would like to allocate PASIDs for devices that aren't managed by
an IOMMU, using the same ID space as IOMMU.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/Kconfig  |   4 ++
 drivers/iommu/Makefile |   1 +
 drivers/iommu/ioasid.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  47 +++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 drivers/iommu/ioasid.c
 create mode 100644 include/linux/ioasid.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e15cdcd..0ade8a0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -3,6 +3,10 @@
 config IOMMU_IOVA
 	tristate
 
+# The IOASID library may also be used by non-IOMMU_API users
+config IOASID
+	tristate
+
 # IOMMU_API always gets selected by whoever wants it.
 config IOMMU_API
 	bool
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index f13f36a..011429e 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
+obj-$(CONFIG_IOASID) += ioasid.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
new file mode 100644
index 0000000..6fbea76
--- /dev/null
+++ b/drivers/iommu/ioasid.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I/O Address Space ID allocator. There is one global IOASID space, split into
+ * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
+ * free IOASIDs with ioasid_alloc and ioasid_free.
+ */
+#include <linux/ioasid.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/xarray.h>
+
+struct ioasid_data {
+	ioasid_t id;
+	struct ioasid_set *set;
+	void *private;
+	struct rcu_head rcu;
+};
+
+static DEFINE_XARRAY_ALLOC(ioasid_xa);
+
+/**
+ * ioasid_set_data - Set private data for an allocated ioasid
+ * @ioasid: the ID to set data
+ * @data:   the private data
+ *
+ * For IOASID that is already allocated, private data can be set
+ * via this API. Future lookup can be done via ioasid_find.
+ */
+int ioasid_set_data(ioasid_t ioasid, void *data)
+{
+	struct ioasid_data *ioasid_data;
+	int ret = 0;
+
+	xa_lock(&ioasid_xa);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
+	if (ioasid_data)
+		rcu_assign_pointer(ioasid_data->private, data);
+	else
+		ret = -ENOENT;
+	xa_unlock(&ioasid_xa);
+
+	/*
+	 * Wait for readers to stop accessing the old private data, so the
+	 * caller can free it.
+	 */
+	if (!ret)
+		synchronize_rcu();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_set_data);
+
+/**
+ * ioasid_alloc - Allocate an IOASID
+ * @set: the IOASID set
+ * @min: the minimum ID (inclusive)
+ * @max: the maximum ID (inclusive)
+ * @private: data private to the caller
+ *
+ * Allocate an ID between @min and @max. The @private pointer is stored
+ * internally and can be retrieved with ioasid_find().
+ *
+ * Return: the allocated ID on success, or %INVALID_IOASID on failure.
+ */
+ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
+		      void *private)
+{
+	ioasid_t id;
+	struct ioasid_data *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return INVALID_IOASID;
+
+	data->set = set;
+	data->private = private;
+
+	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
+		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
+		goto exit_free;
+	}
+	data->id = id;
+
+	return id;
+exit_free:
+	kfree(data);
+	return INVALID_IOASID;
+}
+EXPORT_SYMBOL_GPL(ioasid_alloc);
+
+/**
+ * ioasid_free - Free an IOASID
+ * @ioasid: the ID to remove
+ */
+void ioasid_free(ioasid_t ioasid)
+{
+	struct ioasid_data *ioasid_data;
+
+	ioasid_data = xa_erase(&ioasid_xa, ioasid);
+
+	kfree_rcu(ioasid_data, rcu);
+}
+EXPORT_SYMBOL_GPL(ioasid_free);
+
+/**
+ * ioasid_find - Find IOASID data
+ * @set: the IOASID set
+ * @ioasid: the IOASID to find
+ * @getter: function to call on the found object
+ *
+ * The optional getter function allows to take a reference to the found object
+ * under the rcu lock. The function can also check if the object is still valid:
+ * if @getter returns false, then the object is invalid and NULL is returned.
+ *
+ * If the IOASID exists, return the private pointer passed to ioasid_alloc.
+ * Private data can be NULL if not set. Return an error if the IOASID is not
+ * found, or if @set is not NULL and the IOASID does not belong to the set.
+ */
+void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
+		  bool (*getter)(void *))
+{
+	void *priv;
+	struct ioasid_data *ioasid_data;
+
+	rcu_read_lock();
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
+	if (!ioasid_data) {
+		priv = ERR_PTR(-ENOENT);
+		goto unlock;
+	}
+	if (set && ioasid_data->set != set) {
+		/* data found but does not belong to the set */
+		priv = ERR_PTR(-EACCES);
+		goto unlock;
+	}
+	/* Now IOASID and its set is verified, we can return the private data */
+	priv = rcu_dereference(ioasid_data->private);
+	if (getter && !getter(priv))
+		priv = NULL;
+unlock:
+	rcu_read_unlock();
+
+	return priv;
+}
+EXPORT_SYMBOL_GPL(ioasid_find);
+
+MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
+MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
+MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
new file mode 100644
index 0000000..0c272d9
--- /dev/null
+++ b/include/linux/ioasid.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_IOASID_H
+#define __LINUX_IOASID_H
+
+#include <linux/types.h>
+
+#define INVALID_IOASID ((ioasid_t)-1)
+typedef unsigned int ioasid_t;
+
+struct ioasid_set {
+	int dummy;
+};
+
+#define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
+
+#if IS_ENABLED(CONFIG_IOASID)
+ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
+		      void *private);
+void ioasid_free(ioasid_t ioasid);
+void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
+		  bool (*getter)(void *));
+int ioasid_set_data(ioasid_t ioasid, void *data);
+
+#else /* !CONFIG_IOASID */
+static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
+				    ioasid_t max, void *private)
+{
+	return INVALID_IOASID;
+}
+
+static inline void ioasid_free(ioasid_t ioasid)
+{
+}
+
+static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
+				bool (*getter)(void *))
+{
+	return NULL;
+}
+
+static inline int ioasid_set_data(ioasid_t ioasid, void *data)
+{
+	return -ENODEV;
+}
+
+#endif /* CONFIG_IOASID */
+#endif /* __LINUX_IOASID_H */
-- 
2.7.4

