Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1455AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54D62190A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfDHX6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:58:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:63285 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfDHX5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:57:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 16:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,327,1549958400"; 
   d="scan'208";a="149169938"
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
Subject: [PATCH 03/18] ioasid: Convert ioasid_idr to XArray
Date:   Mon,  8 Apr 2019 16:59:18 -0700
Message-Id: <1554767973-30125-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDR is to be replaced by XArray, keep up with the changes.
XArray has internal locking for normal APIs used here, also removed
radix tree related preload.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/base/ioasid.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
index 294e856..35bdc680 100644
--- a/drivers/base/ioasid.c
+++ b/drivers/base/ioasid.c
@@ -4,7 +4,7 @@
  * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
  * free IOASIDs with ioasid_alloc and ioasid_free.
  */
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/ioasid.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -16,7 +16,7 @@ struct ioasid_data {
 	struct rcu_head rcu;
 };
 
-static DEFINE_IDR(ioasid_idr);
+static DEFINE_XARRAY_ALLOC(ioasid_xa);
 static DEFINE_MUTEX(ioasid_allocator_lock);
 static const struct ioasid_allocator *ioasid_allocator;
 
@@ -24,9 +24,9 @@ static const struct ioasid_allocator *ioasid_allocator;
 /**
  * ioasid_set_allocator - register a custom allocator
  *
- * Custom allocator take precedence over the default IDR based allocator.
+ * Custom allocator take precedence over the default xarray based allocator.
  * Private data associated with the ASID are managed by ASID common code
- * similar to IDR data.
+ * similar to data stored in xa.
  */
 int ioasid_set_allocator(struct ioasid_allocator *allocator)
 {
@@ -72,13 +72,12 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
 	struct ioasid_data *ioasid_data;
 	int ret = 0;
 
-	idr_lock(&ioasid_idr);
-	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (ioasid_data)
 		ioasid_data->private = data;
 	else
 		ret = -ENOENT;
-	idr_unlock(&ioasid_idr);
+
 	/* getter may use the private data */
 	synchronize_rcu();
 
@@ -110,7 +109,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	data->set = set;
 	data->private = private;
 
-	/* Use custom allocator if available, otherwise default to IDR */
+	/* Use custom allocator if available, otherwise default to xarray */
 	if (ioasid_allocator) {
 		mutex_lock(&ioasid_allocator_lock);
 		id = ioasid_allocator->alloc(min, max, ioasid_allocator->pdata);
@@ -120,17 +119,18 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 			goto exit_free;
 		}
 		/*
-		 * Use IDR to manage private data also sanitiy check custom
+		 * Use XA to manage private data also sanitiy check custom
 		 * allocator for duplicates.
 		 */
 		min = id;
 		max = id + 1;
 	}
-	idr_preload(GFP_KERNEL);
-	idr_lock(&ioasid_idr);
-	data->id = id = idr_alloc(&ioasid_idr, data, min, max, GFP_ATOMIC);
-	idr_unlock(&ioasid_idr);
-	idr_preload_end();
+
+	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
+		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
+		goto exit_free;
+	}
+	data->id = id;
 
 exit_free:
 	if (id < 0 || id == INVALID_IOASID) {
@@ -160,10 +160,7 @@ int ioasid_free(ioasid_t ioasid)
 		return ret;
 	}
 
-	idr_lock(&ioasid_idr);
-	ioasid_data = idr_remove(&ioasid_idr, ioasid);
-	idr_unlock(&ioasid_idr);
-
+	ioasid_data = xa_erase(&ioasid_xa, ioasid);
 	if (ioasid_data)
 		kfree_rcu(ioasid_data, rcu);
 
@@ -192,7 +189,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	struct ioasid_data *ioasid_data;
 
 	rcu_read_lock();
-	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (!ioasid_data) {
 		priv = ERR_PTR(-ENOENT);
 		goto unlock;
-- 
2.7.4

