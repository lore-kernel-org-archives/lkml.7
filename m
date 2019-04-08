Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12659C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB1420863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfDHX6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:58:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:9985 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfDHX5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:57:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149169935"
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
Subject: [PATCH 02/18] ioasid: Add custom IOASID allocator
Date:   Mon,  8 Apr 2019 16:59:17 -0700
Message-Id: <1554767973-30125-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, IOASID allocation must be handled by platform specific
code. The use cases are guest vIOMMU and pvIOMMU where IOASIDs need
to be allocated by the host via enlightened or paravirt interfaces.

This patch adds an extension to the IOASID allocator APIs such that
platform drivers can register a custom allocator, possibly at boot
time, to take over the allocation. IDR is still used for tracking
and searching purposes internal to the IOASID code. Private data of
an IOASID can also be set after the allocation.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/base/ioasid.c  | 124 +++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/ioasid.h |  28 ++++++++++-
 2 files changed, 143 insertions(+), 9 deletions(-)

diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
index cf122b2..294e856 100644
--- a/drivers/base/ioasid.c
+++ b/drivers/base/ioasid.c
@@ -17,6 +17,74 @@ struct ioasid_data {
 };
 
 static DEFINE_IDR(ioasid_idr);
+static DEFINE_MUTEX(ioasid_allocator_lock);
+static const struct ioasid_allocator *ioasid_allocator;
+
+
+/**
+ * ioasid_set_allocator - register a custom allocator
+ *
+ * Custom allocator take precedence over the default IDR based allocator.
+ * Private data associated with the ASID are managed by ASID common code
+ * similar to IDR data.
+ */
+int ioasid_set_allocator(struct ioasid_allocator *allocator)
+{
+	int ret = 0;
+
+	if (!allocator)
+		return -EINVAL;
+
+	mutex_lock(&ioasid_allocator_lock);
+	if (ioasid_allocator) {
+		ret = -EBUSY;
+		goto exit_unlock;
+	}
+	ioasid_allocator = allocator;
+
+exit_unlock:
+	mutex_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_set_allocator);
+
+/**
+ * ioasid_clear_allocator - Free the custom IOASID allocator
+ *
+ * REVISIT: So far there is only one custom allocator allowed.
+ */
+void ioasid_clear_allocator(void)
+{
+	mutex_lock(&ioasid_allocator_lock);
+	ioasid_allocator = NULL;
+	mutex_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_clear_allocator);
+
+/**
+ * ioasid_set_data - Set private data for an allocated ioasid
+ *
+ * For IOASID that is already allocated, private data can be set
+ * via this API. Future lookup can be done via ioasid_find.
+ */
+int ioasid_set_data(ioasid_t ioasid, void *data)
+{
+	struct ioasid_data *ioasid_data;
+	int ret = 0;
+
+	idr_lock(&ioasid_idr);
+	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	if (ioasid_data)
+		ioasid_data->private = data;
+	else
+		ret = -ENOENT;
+	idr_unlock(&ioasid_idr);
+	/* getter may use the private data */
+	synchronize_rcu();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_set_data);
 
 /**
  * ioasid_alloc - Allocate an IOASID
@@ -32,7 +100,7 @@ static DEFINE_IDR(ioasid_idr);
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private)
 {
-	int id = -1;
+	int id = INVALID_IOASID;
 	struct ioasid_data *data;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
@@ -42,13 +110,30 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	data->set = set;
 	data->private = private;
 
+	/* Use custom allocator if available, otherwise default to IDR */
+	if (ioasid_allocator) {
+		mutex_lock(&ioasid_allocator_lock);
+		id = ioasid_allocator->alloc(min, max, ioasid_allocator->pdata);
+		mutex_unlock(&ioasid_allocator_lock);
+		if (id == INVALID_IOASID) {
+			pr_err("Failed ASID allocation by custom allocator\n");
+			goto exit_free;
+		}
+		/*
+		 * Use IDR to manage private data also sanitiy check custom
+		 * allocator for duplicates.
+		 */
+		min = id;
+		max = id + 1;
+	}
 	idr_preload(GFP_KERNEL);
 	idr_lock(&ioasid_idr);
 	data->id = id = idr_alloc(&ioasid_idr, data, min, max, GFP_ATOMIC);
 	idr_unlock(&ioasid_idr);
 	idr_preload_end();
 
-	if (id < 0) {
+exit_free:
+	if (id < 0 || id == INVALID_IOASID) {
 		kfree(data);
 		return INVALID_IOASID;
 	}
@@ -60,9 +145,20 @@ EXPORT_SYMBOL_GPL(ioasid_alloc);
  * ioasid_free - Free an IOASID
  * @ioasid: the ID to remove
  */
-void ioasid_free(ioasid_t ioasid)
+int ioasid_free(ioasid_t ioasid)
 {
 	struct ioasid_data *ioasid_data;
+	int ret = 0;
+
+	if (ioasid_allocator) {
+		mutex_lock(&ioasid_allocator_lock);
+		ret = ioasid_allocator->free(ioasid, ioasid_allocator->pdata);
+		mutex_unlock(&ioasid_allocator_lock);
+	}
+	if (ret) {
+		pr_err("ioasid %d custom allocator free failed\n", ioasid);
+		return ret;
+	}
 
 	idr_lock(&ioasid_idr);
 	ioasid_data = idr_remove(&ioasid_idr, ioasid);
@@ -70,6 +166,8 @@ void ioasid_free(ioasid_t ioasid)
 
 	if (ioasid_data)
 		kfree_rcu(ioasid_data, rcu);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
 
@@ -84,7 +182,8 @@ EXPORT_SYMBOL_GPL(ioasid_free);
  * if @getter returns false, then the object is invalid and NULL is returned.
  *
  * If the IOASID has been allocated for this set, return the private pointer
- * passed to ioasid_alloc. Otherwise return NULL.
+ * passed to ioasid_alloc. Private data can be NULL if not set. Return an error
+ * if the IOASID is not found or not belong to the set.
  */
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *))
@@ -94,11 +193,20 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 
 	rcu_read_lock();
 	ioasid_data = idr_find(&ioasid_idr, ioasid);
-	if (ioasid_data && ioasid_data->set == set) {
-		priv = ioasid_data->private;
-		if (getter && !getter(priv))
-			priv = NULL;
+	if (!ioasid_data) {
+		priv = ERR_PTR(-ENOENT);
+		goto unlock;
+	}
+	if (set && ioasid_data->set != set) {
+		/* data found but does not belong to the set */
+		priv = ERR_PTR(-EACCES);
+		goto unlock;
 	}
+	/* Now IOASID and its set is verified, we can return the private data */
+	priv = ioasid_data->private;
+	if (getter && !getter(priv))
+		priv = NULL;
+unlock:
 	rcu_read_unlock();
 
 	return priv;
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 6f3655a..64994e7 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -5,20 +5,31 @@
 #define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
 typedef int (*ioasid_iter_t)(ioasid_t ioasid, void *private, void *data);
+typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
+typedef int (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
 
 struct ioasid_set {
 	int dummy;
 };
 
+struct ioasid_allocator {
+	ioasid_alloc_fn_t alloc;
+	ioasid_free_fn_t free;
+	void *pdata;
+};
+
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #ifdef CONFIG_IOASID
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_free(ioasid_t ioasid);
+int ioasid_free(ioasid_t ioasid);
 
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
+int ioasid_set_allocator(struct ioasid_allocator *allocator);
+void ioasid_clear_allocator(void);
+int ioasid_set_data(ioasid_t ioasid, void *data);
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -36,5 +47,20 @@ static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 {
 	return NULL;
 }
+
+static inline int ioasid_set_allocator(struct ioasid_allocator *allocator)
+{
+	return -EINVAL;
+}
+
+static inline void ioasid_clear_allocator(void)
+{
+}
+
+static inline int ioasid_set_data(ioasid_t ioasid, void *data)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

