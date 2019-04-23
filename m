Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B01EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29DA20449
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfDWXaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:30:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:8111 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728814AbfDWX2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:28:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 16:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; 
   d="scan'208";a="293981272"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 23 Apr 2019 16:28:38 -0700
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
Subject: [PATCH v2 07/19] ioasid: Convert ioasid_idr to XArray
Date:   Tue, 23 Apr 2019 16:31:07 -0700
Message-Id: <1556062279-64135-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
 drivers/base/ioasid.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
index cf122b2..c4012aa 100644
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
@@ -16,13 +16,12 @@ struct ioasid_data {
 	struct rcu_head rcu;
 };
 
-static DEFINE_IDR(ioasid_idr);
-
+static DEFINE_XARRAY_ALLOC(ioasid_xa);
 /**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
  * @min: the minimum ID (inclusive)
- * @max: the maximum ID (exclusive)
+ * @max: the maximum ID (inclusive)
  * @private: data private to the caller
  *
  * Allocate an ID between @min and @max (or %0 and %INT_MAX). Return the
@@ -41,13 +40,13 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
+	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
+		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
+		goto exit_free;
+	}
 
-	idr_preload(GFP_KERNEL);
-	idr_lock(&ioasid_idr);
-	data->id = id = idr_alloc(&ioasid_idr, data, min, max, GFP_ATOMIC);
-	idr_unlock(&ioasid_idr);
-	idr_preload_end();
-
+	data->id = id;
+exit_free:
 	if (id < 0) {
 		kfree(data);
 		return INVALID_IOASID;
@@ -64,12 +63,8 @@ void ioasid_free(ioasid_t ioasid)
 {
 	struct ioasid_data *ioasid_data;
 
-	idr_lock(&ioasid_idr);
-	ioasid_data = idr_remove(&ioasid_idr, ioasid);
-	idr_unlock(&ioasid_idr);
-
-	if (ioasid_data)
-		kfree_rcu(ioasid_data, rcu);
+	ioasid_data = xa_erase(&ioasid_xa, ioasid);
+	kfree_rcu(ioasid_data, rcu);
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
 
@@ -93,7 +88,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	struct ioasid_data *ioasid_data;
 
 	rcu_read_lock();
-	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (ioasid_data && ioasid_data->set == set) {
 		priv = ioasid_data->private;
 		if (getter && !getter(priv))
-- 
2.7.4

