Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F15C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DAC208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393581AbfIJIrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:47:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:60938 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387824AbfIJIrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:47:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 01:47:14 -0700
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="196470873"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 01:47:12 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id A9A5420B51;
        Tue, 10 Sep 2019 11:47:05 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i7bnn-0004nZ-By; Tue, 10 Sep 2019 11:47:07 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v6 05/12] device property: Add functions for accessing node's parents
Date:   Tue, 10 Sep 2019 11:47:00 +0300
Message-Id: <20190910084707.18380-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two convenience functions for accessing node's parents:

fwnode_count_parents() returns the number of parent nodes a given node
has. fwnode_get_nth_parent() returns node's parent at a given distance
from the node itself.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 46 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 3d9dffbe96378..f2e555e68b56a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -590,6 +590,52 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
 
+/**
+ * fwnode_count_parents - Return the number of parents a node has
+ * @fwnode: The node the parents of which are to be counted
+ *
+ * Returns the number of parents a node has.
+ */
+unsigned int fwnode_count_parents(const struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *__fwnode;
+	unsigned int count;
+
+	__fwnode = fwnode_get_parent(fwnode);
+
+	for (count = 0; __fwnode; count++)
+		__fwnode = fwnode_get_next_parent(__fwnode);
+
+	return count;
+}
+EXPORT_SYMBOL_GPL(fwnode_count_parents);
+
+/**
+ * fwnode_get_nth_parent - Return an nth parent of a node
+ * @fwnode: The node the parent of which is requested
+ * @depth: Distance of the parent from the node
+ *
+ * Returns the nth parent of a node. If there is no parent at the requested
+ * @depth, %NULL is returned. If @depth is 0, the functionality is equivalent to
+ * fwnode_handle_get(). For @depth == 1, it is fwnode_get_parent() and so on.
+ *
+ * The caller is responsible for calling fwnode_handle_put() for the returned
+ * node.
+ */
+struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
+					    unsigned int depth)
+{
+	unsigned int i;
+
+	fwnode_handle_get(fwnode);
+
+	for (i = 0; i < depth && fwnode; i++)
+		fwnode = fwnode_get_next_parent(fwnode);
+
+	return fwnode;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
+
 /**
  * fwnode_get_next_child_node - Return the next child node handle for a node
  * @fwnode: Firmware node to find the next child node for.
diff --git a/include/linux/property.h b/include/linux/property.h
index 421c76e53708d..5450e7ec219ac 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -83,6 +83,9 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
+unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
+struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
+					    unsigned int depth);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.20.1

