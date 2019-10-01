Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB7FC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F3821924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfJAX3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 19:29:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:26351 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbfJAX3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:29:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 16:29:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,572,1559545200"; 
   d="scan'208";a="203402513"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 01 Oct 2019 16:29:18 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v3 3/4] iommu/ioasid: Add custom allocators
Date:   Tue,  1 Oct 2019 16:33:24 -0700
Message-Id: <1569972805-27664-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569972805-27664-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1569972805-27664-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOASID allocation may rely on platform specific methods. One use case is
that when running in the guest, in order to obtain system wide global
IOASIDs, emulated allocation interface is needed to communicate with the
host. Here we call these platform specific allocators custom allocators.

Custom IOASID allocators can be registered at runtime and take precedence
over the default XArray allocator. They have these attributes:

- provides platform specific alloc()/free() functions with private data.
- allocation results lookup are not provided by the allocator, lookup
  request must be done by the IOASID framework by its own XArray.
- allocators can be unregistered at runtime, either fallback to the next
  custom allocator or to the default allocator.
- custom allocators can share the same set of alloc()/free() helpers, in
  this case they also share the same IOASID space, thus the same XArray.
- switching between allocators requires all outstanding IOASIDs to be
  freed unless the two allocators share the same alloc()/free() helpers.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lkml.org/lkml/2019/4/26/462
---
 drivers/iommu/ioasid.c | 301 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/ioasid.h |  28 +++++
 2 files changed, 319 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 6fbea76a47cf..5b6ead4b07d6 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -17,7 +17,254 @@ struct ioasid_data {
 	struct rcu_head rcu;
 };
 
-static DEFINE_XARRAY_ALLOC(ioasid_xa);
+/*
+ * struct ioasid_allocator_data - Internal data structure to hold information
+ * about an allocator. There are two types of allocators:
+ *
+ * - Default allocator always has its own XArray to track the IOASIDs allocated.
+ * - Custom allocators may share allocation helpers with different private data.
+ *   Custom allocators share the same helper functions also share the same
+ *   XArray.
+ * Rules:
+ * 1. Default allocator is always available, not dynamically registered. This is
+ *    to prevent race conditions with early boot code that want to register
+ *    custom allocators or allocate IOASIDs.
+ * 2. Custom allocators take precedence over the default allocator.
+ * 3. When all custom allocators sharing the same helper functions are
+ *    unregistered (e.g. due to hotplug), all outstanding IOASIDs must be
+ *    freed.
+ * 4. When switching between custom allocators sharing the same helper
+ *    functions, outstanding IOASIDs are preserved.
+ * 5. When switching between custom allocator and default allocator, all IOASIDs
+ *    must be freed to ensure unadulterated space for the new allocator.
+ *
+ * @ops:	allocator helper functions and its data
+ * @list:	registered custom allocators
+ * @slist:	allocators share the same ops but different data
+ * @flags:	attributes of the allocator
+ * @xa		xarray holds the IOASID space
+ * @users	number of allocators sharing the same ops and XArray
+ */
+struct ioasid_allocator_data {
+	struct ioasid_allocator_ops *ops;
+	struct list_head list;
+	struct list_head slist;
+#define IOASID_ALLOCATOR_CUSTOM BIT(0) /* Needs framework to track results */
+	unsigned long flags;
+	struct xarray xa;
+	refcount_t users;
+};
+
+static DEFINE_SPINLOCK(ioasid_allocator_lock);
+static LIST_HEAD(allocators_list);
+
+static ioasid_t default_alloc(ioasid_t min, ioasid_t max, void *opaque);
+static void default_free(ioasid_t ioasid, void *opaque);
+
+static struct ioasid_allocator_ops default_ops = {
+	.alloc = default_alloc,
+	.free = default_free,
+};
+
+static struct ioasid_allocator_data default_allocator = {
+	.ops = &default_ops,
+	.flags = 0,
+	.xa = XARRAY_INIT(ioasid_xa, XA_FLAGS_ALLOC),
+};
+
+static struct ioasid_allocator_data *active_allocator = &default_allocator;
+
+static ioasid_t default_alloc(ioasid_t min, ioasid_t max, void *opaque)
+{
+	ioasid_t id;
+
+	if (xa_alloc(&default_allocator.xa, &id, opaque, XA_LIMIT(min, max), GFP_ATOMIC)) {
+		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
+		return INVALID_IOASID;
+	}
+
+	return id;
+}
+
+static void default_free(ioasid_t ioasid, void *opaque)
+{
+	struct ioasid_data *ioasid_data;
+
+	ioasid_data = xa_erase(&default_allocator.xa, ioasid);
+	kfree_rcu(ioasid_data, rcu);
+}
+
+/* Allocate and initialize a new custom allocator with its helper functions */
+static struct ioasid_allocator_data *ioasid_alloc_allocator(struct ioasid_allocator_ops *ops)
+{
+	struct ioasid_allocator_data *ia_data;
+
+	ia_data = kzalloc(sizeof(*ia_data), GFP_ATOMIC);
+	if (!ia_data)
+		return NULL;
+
+	xa_init_flags(&ia_data->xa, XA_FLAGS_ALLOC);
+	INIT_LIST_HEAD(&ia_data->slist);
+	ia_data->flags |= IOASID_ALLOCATOR_CUSTOM;
+	ia_data->ops = ops;
+
+	/* For tracking custom allocators that share the same ops */
+	list_add_tail(&ops->list, &ia_data->slist);
+	refcount_set(&ia_data->users, 1);
+
+	return ia_data;
+}
+
+static bool use_same_ops(struct ioasid_allocator_ops *a, struct ioasid_allocator_ops *b)
+{
+	return (a->free == b->free) && (a->alloc == b->alloc);
+}
+
+/**
+ * ioasid_register_allocator - register a custom allocator
+ * @ops: the custom allocator ops to be registered
+ *
+ * Custom allocators take precedence over the default xarray based allocator.
+ * Private data associated with the IOASID allocated by the custom allocators
+ * are managed by IOASID framework similar to data stored in xa by default
+ * allocator.
+ *
+ * There can be multiple allocators registered but only one is active. In case
+ * of runtime removal of a custom allocator, the next one is activated based
+ * on the registration ordering.
+ *
+ * Multiple allocators can share the same alloc() function, in this case the
+ * IOASID space is shared.
+ */
+int ioasid_register_allocator(struct ioasid_allocator_ops *ops)
+{
+	struct ioasid_allocator_data *ia_data;
+	struct ioasid_allocator_data *pallocator;
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+
+	ia_data = ioasid_alloc_allocator(ops);
+	if (!ia_data) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	/*
+	 * No particular preference, we activate the first one and keep
+	 * the later registered allocators in a list in case the first one gets
+	 * removed due to hotplug.
+	 */
+	if (list_empty(&allocators_list)) {
+		WARN_ON(active_allocator != &default_allocator);
+		/* Use this new allocator if default is not active */
+		if (xa_empty(&active_allocator->xa)) {
+			active_allocator = ia_data;
+			list_add_tail(&ia_data->list, &allocators_list);
+			goto out_unlock;
+		}
+		pr_warn("Default allocator active with outstanding IOASID\n");
+		ret = -EAGAIN;
+		goto out_free;
+	}
+
+	/* Check if the allocator is already registered */
+	list_for_each_entry(pallocator, &allocators_list, list) {
+		if (pallocator->ops == ops) {
+			pr_err("IOASID allocator already registered\n");
+			ret = -EEXIST;
+			goto out_free;
+		} else if (use_same_ops(pallocator->ops, ops)) {
+			/*
+			 * If the new allocator shares the same ops,
+			 * then they will share the same IOASID space.
+			 * We should put them under the same xarray.
+			 */
+			list_add_tail(&ops->list, &pallocator->slist);
+			refcount_inc(&pallocator->users);
+			pr_info("New IOASID allocator ops shared %u times\n",
+				refcount_read(&pallocator->users));
+			goto out_free;
+		}
+	}
+	list_add_tail(&ia_data->list, &allocators_list);
+
+	spin_unlock(&ioasid_allocator_lock);
+	return 0;
+out_free:
+	kfree(ia_data);
+out_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_register_allocator);
+
+static inline bool has_shared_ops(struct ioasid_allocator_data *allocator)
+{
+	return refcount_read(&allocator->users) > 1;
+}
+
+/**
+ * ioasid_unregister_allocator - Remove a custom IOASID allocator ops
+ * @ops: the custom allocator to be removed
+ *
+ * Remove an allocator from the list, activate the next allocator in
+ * the order it was registered. Or revert to default allocator if all
+ * custom allocators are unregistered without outstanding IOASIDs.
+ */
+void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
+{
+	struct ioasid_allocator_data *pallocator;
+	struct ioasid_allocator_ops *sops;
+
+	spin_lock(&ioasid_allocator_lock);
+	if (list_empty(&allocators_list)) {
+		pr_warn("No custom IOASID allocators active!\n");
+		goto exit_unlock;
+	}
+
+	list_for_each_entry(pallocator, &allocators_list, list) {
+		if (!use_same_ops(pallocator->ops, ops))
+			continue;
+
+		if (refcount_read(&pallocator->users) == 1) {
+			/* No shared helper functions */
+			list_del(&pallocator->list);
+			/*
+			 * All IOASIDs should have been freed before
+			 * the last allocator that shares the same ops
+			 * is unregistered.
+			 */
+			WARN_ON(!xa_empty(&pallocator->xa));
+			kfree(pallocator);
+			if (list_empty(&allocators_list)) {
+				pr_info("No custom IOASID allocators, switch to default.\n");
+				active_allocator = &default_allocator;
+			} else if (pallocator == active_allocator) {
+				active_allocator = list_first_entry(&allocators_list, struct ioasid_allocator_data, list);
+				pr_info("IOASID allocator changed");
+			}
+			break;
+		}
+		/*
+		 * Find the matching shared ops to delete,
+		 * but keep outstanding IOASIDs
+		 */
+		list_for_each_entry(sops, &pallocator->slist, list) {
+			if (sops == ops) {
+				list_del(&ops->list);
+				if (refcount_dec_and_test(&pallocator->users))
+					pr_err("no shared ops\n");
+				break;
+			}
+		}
+		break;
+	}
+
+exit_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
 
 /**
  * ioasid_set_data - Set private data for an allocated ioasid
@@ -32,13 +279,13 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
 	struct ioasid_data *ioasid_data;
 	int ret = 0;
 
-	xa_lock(&ioasid_xa);
-	ioasid_data = xa_load(&ioasid_xa, ioasid);
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
 	if (ioasid_data)
 		rcu_assign_pointer(ioasid_data->private, data);
 	else
 		ret = -ENOENT;
-	xa_unlock(&ioasid_xa);
+	spin_unlock(&ioasid_allocator_lock);
 
 	/*
 	 * Wait for readers to stop accessing the old private data, so the
@@ -66,8 +313,9 @@ EXPORT_SYMBOL_GPL(ioasid_set_data);
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private)
 {
-	ioasid_t id;
 	struct ioasid_data *data;
+	void *adata;
+	ioasid_t id;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -76,14 +324,34 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	data->set = set;
 	data->private = private;
 
-	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
-		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
+	/*
+	 * Custom allocator needs allocator data to perform platform specific
+	 * operations.
+	 */
+	spin_lock(&ioasid_allocator_lock);
+	adata = active_allocator->flags & IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
+	id = active_allocator->ops->alloc(min, max, adata);
+	if (id == INVALID_IOASID) {
+		pr_err("Failed ASID allocation %lu\n", active_allocator->flags);
 		goto exit_free;
 	}
+
+	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
+		/* Custom allocator needs framework to store and track allocation results */
+		min = max = id;
+
+		if (xa_alloc(&active_allocator->xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
+			pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
+			active_allocator->ops->free(id, NULL);
+			goto exit_free;
+		}
+	}
 	data->id = id;
 
+	spin_unlock(&ioasid_allocator_lock);
 	return id;
 exit_free:
+	spin_unlock(&ioasid_allocator_lock);
 	kfree(data);
 	return INVALID_IOASID;
 }
@@ -97,9 +365,22 @@ void ioasid_free(ioasid_t ioasid)
 {
 	struct ioasid_data *ioasid_data;
 
-	ioasid_data = xa_erase(&ioasid_xa, ioasid);
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+	if (!ioasid_data) {
+		pr_err("Trying to free unknown IOASID %u\n", ioasid);
+		goto exit_unlock;
+	}
 
-	kfree_rcu(ioasid_data, rcu);
+	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
+	/* Custom allocator needs additional steps to free the xa element */
+	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
+		ioasid_data = xa_erase(&active_allocator->xa, ioasid);
+		kfree_rcu(ioasid_data, rcu);
+	}
+
+exit_unlock:
+	spin_unlock(&ioasid_allocator_lock);
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
 
@@ -124,7 +405,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	struct ioasid_data *ioasid_data;
 
 	rcu_read_lock();
-	ioasid_data = xa_load(&ioasid_xa, ioasid);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
 	if (!ioasid_data) {
 		priv = ERR_PTR(-ENOENT);
 		goto unlock;
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 17337a13f06e..6f000d7a0ddc 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -7,11 +7,28 @@
 
 #define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
+typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
+typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
 
 struct ioasid_set {
 	int dummy;
 };
 
+/**
+ * struct ioasid_allocator_ops - IOASID allocator helper functions and data
+ *
+ * @alloc:	helper function to allocate IOASID
+ * @free:	helper function to free IOASID
+ * @list:	for tracking ops that share helper functions but not data
+ * @pdata:	data belong to the allocator, provided when calling alloc()
+ */
+struct ioasid_allocator_ops {
+	ioasid_alloc_fn_t alloc;
+	ioasid_free_fn_t free;
+	struct list_head list;
+	void *pdata;
+};
+
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #if IS_ENABLED(CONFIG_IOASID)
@@ -20,6 +37,8 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 void ioasid_free(ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
+int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
+void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
 
 #else /* !CONFIG_IOASID */
@@ -39,6 +58,15 @@ static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	return NULL;
 }
 
+static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator)
+{
+}
+
 static inline int ioasid_set_data(ioasid_t ioasid, void *data)
 {
 	return -ENOTSUPP;
-- 
2.7.4

