Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E443DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA5A20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbfDJPZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:25:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:15566 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbfDJPZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:25:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 08:25:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="163102922"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2019 08:25:11 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 02/12] software node: Simplify software_node_release() function
Date:   Wed, 10 Apr 2019 18:24:55 +0300
Message-Id: <20190410152505.87041-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to release the node ID immediately when
fwnode_remove_software_node() is called, no need to wait for
software_node_release() with that. This change has no
functional effect.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 30077454eb68..7b321bf8424c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -557,13 +557,6 @@ static void software_node_release(struct kobject *kobj)
 {
 	struct software_node *swnode = kobj_to_swnode(kobj);
 
-	if (swnode->parent) {
-		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
-		list_del(&swnode->entry);
-	} else {
-		ida_simple_remove(&swnode_root_ids, swnode->id);
-	}
-
 	ida_destroy(&swnode->child_ids);
 	property_entries_free(swnode->properties);
 	kfree(swnode);
@@ -610,9 +603,6 @@ fwnode_create_software_node(const struct property_entry *properties,
 	INIT_LIST_HEAD(&swnode->children);
 	swnode->parent = p;
 
-	if (p)
-		list_add_tail(&swnode->entry, &p->children);
-
 	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
 				   p ? &p->kobj : NULL, "node%d", swnode->id);
 	if (ret) {
@@ -626,6 +616,9 @@ fwnode_create_software_node(const struct property_entry *properties,
 		return ERR_PTR(ret);
 	}
 
+	if (p)
+		list_add_tail(&swnode->entry, &p->children);
+
 	kobject_uevent(&swnode->kobj, KOBJ_ADD);
 	return &swnode->fwnode;
 }
@@ -638,6 +631,13 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 	if (!swnode)
 		return;
 
+	if (swnode->parent) {
+		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
+		list_del(&swnode->entry);
+	} else {
+		ida_simple_remove(&swnode_root_ids, swnode->id);
+	}
+
 	kobject_put(&swnode->kobj);
 }
 EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
-- 
2.20.1

