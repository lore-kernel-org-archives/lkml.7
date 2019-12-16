Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD611C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D3D2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfLPULm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:11:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:10614 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfLPULh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:11:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 11:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,322,1571727600"; 
   d="scan'208";a="209411664"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 16 Dec 2019 11:19:23 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 09/10] iommu/ioasid: Add notifier for status change
Date:   Mon, 16 Dec 2019 11:24:11 -0800
Message-Id: <1576524252-79116-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOASIDs are system resources that can be shared by multiple drivers or
subsystems. When status of an IOASID changes at runtime, there is need
to notify all current users such that proper actions can be taken.

For example, an IOASID can be used by IOMMU subsystem for guest SVM as
well as KVM. When the guest is terminating unexpectedly, both KVM and
IOMMU need to perform clean up action before the IOASID is reclaimed.

This patch adds a per IOASID notifier that can be registered by
interesting parties.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h | 20 ++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 0f8dd377aada..53a2ab287f7d 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -15,6 +15,7 @@ struct ioasid_data {
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
+	struct atomic_notifier_head notifications;
 };
 
 /*
@@ -314,6 +315,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
+	ATOMIC_INIT_NOTIFIER_HEAD(&data->notifications);
 
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
@@ -360,6 +362,9 @@ void ioasid_free(ioasid_t ioasid)
 		goto exit_unlock;
 	}
 
+	/* Notify all users that this IOASID is being freed */
+	atomic_notifier_call_chain(&ioasid_data->notifications, IOASID_FREE,
+				     &ioasid);
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
@@ -416,6 +421,44 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 }
 EXPORT_SYMBOL_GPL(ioasid_find);
 
+int ioasid_add_notifier(ioasid_t ioasid, struct notifier_block *nb)
+{
+	struct ioasid_allocator_data *idata;
+	struct ioasid_data *data;
+	int ret = 0;
+
+	rcu_read_lock();
+	idata = rcu_dereference(active_allocator);
+	data = xa_load(&idata->xa, ioasid);
+	if (!data) {
+		ret = -ENOENT;
+		goto unlock;
+	}
+	ret = atomic_notifier_chain_register(&data->notifications, nb);
+unlock:
+	rcu_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_add_notifier);
+
+void ioasid_remove_notifier(ioasid_t ioasid, struct notifier_block *nb)
+{
+	struct ioasid_allocator_data *idata;
+	struct ioasid_data *data;
+
+	rcu_read_lock();
+	idata = rcu_dereference(active_allocator);
+	data = xa_load(&idata->xa, ioasid);
+	rcu_read_unlock();
+	if (!data) {
+		pr_err("IOASID %d not found\n", ioasid);
+		return;
+	}
+	/* Unregister can sleep, called outside RCU critical section. */
+	atomic_notifier_chain_unregister(&data->notifications, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_remove_notifier);
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 6f000d7a0ddc..4517c4be4088 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
 
 #define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
@@ -29,6 +30,12 @@ struct ioasid_allocator_ops {
 	void *pdata;
 };
 
+/* Notification data when IOASID status changed */
+enum ioasid_notify_val {
+	IOASID_FREE = 1,
+	IOASID_SUSPEND,
+};
+
 #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
 
 #if IS_ENABLED(CONFIG_IOASID)
@@ -40,6 +47,8 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
+int ioasid_add_notifier(ioasid_t ioasid, struct notifier_block *nb);
+void ioasid_remove_notifier(ioasid_t ioasid, struct notifier_block *nb);
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -58,6 +67,17 @@ static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	return NULL;
 }
 
+static inline int ioasid_add_notifier(ioasid_t ioasid,
+				      struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_remove_notifier(ioasid_t ioasid,
+				       struct notifier_block *nb)
+{
+}
+
 static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
 {
 	return -ENOTSUPP;
-- 
2.7.4

