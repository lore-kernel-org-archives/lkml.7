Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BFCC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47932087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfHSKHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:07:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:8477 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfHSKH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:07:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 03:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="195506068"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2019 03:07:27 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] software node: Add software_node_find_by_name()
Date:   Mon, 19 Aug 2019 13:07:22 +0300
Message-Id: <20190819100724.30051-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
References: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function that searches software nodes by node name.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/base/swnode.c    | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index e7b3aa3bd55a..ee2a405cca9a 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -620,6 +620,43 @@ static const struct fwnode_operations software_node_ops = {
 
 /* -------------------------------------------------------------------------- */
 
+/**
+ * software_node_find_by_name - Find software node by name
+ * @parent: Parent of the software node
+ * @name: Name of the software node
+ *
+ * The function will find a node that is child of @parent and that is named
+ * @name. If no node is found, the function returns NULL.
+ *
+ * NOTE: you will need to drop the reference with fwnode_handle_put() after use.
+ */
+const struct software_node *
+software_node_find_by_name(const struct software_node *parent, const char *name)
+{
+	struct swnode *swnode;
+	struct kobject *k;
+
+	if (!name)
+		return NULL;
+
+	spin_lock(&swnode_kset->list_lock);
+
+	list_for_each_entry(k, &swnode_kset->list, entry) {
+		swnode = kobj_to_swnode(k);
+		if (parent == swnode->node->parent && swnode->node->name &&
+		    !strcmp(name, swnode->node->name)) {
+			kobject_get(&swnode->kobj);
+			break;
+		}
+		swnode = NULL;
+	}
+
+	spin_unlock(&swnode_kset->list_lock);
+
+	return swnode ? swnode->node : NULL;
+}
+EXPORT_SYMBOL_GPL(software_node_find_by_name);
+
 static int
 software_node_register_properties(struct software_node *node,
 				  const struct property_entry *properties)
diff --git a/include/linux/property.h b/include/linux/property.h
index 5a910ad79591..9b3d4ca3a73a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -421,6 +421,10 @@ bool is_software_node(const struct fwnode_handle *fwnode);
 const struct software_node *to_software_node(struct fwnode_handle *fwnode);
 struct fwnode_handle *software_node_fwnode(const struct software_node *node);
 
+const struct software_node *
+software_node_find_by_name(const struct software_node *parent,
+			   const char *name);
+
 int software_node_register_nodes(const struct software_node *nodes);
 void software_node_unregister_nodes(const struct software_node *nodes);
 
-- 
2.23.0.rc1

