Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B207C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E072218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfCOQ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:59:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:39359 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbfCOQ6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:58:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 09:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="155397203"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2019 09:58:09 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 04/12] software node: Implement .get_reference_args fwnode operation
Date:   Fri, 15 Mar 2019 19:57:52 +0300
Message-Id: <20190315165800.5058-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
References: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible to support drivers that use
fwnode_property_get_reference_args() function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 591f290d25be..b1320a55351d 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -534,6 +534,61 @@ software_node_get_named_child_node(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+static int
+software_node_get_reference_args(const struct fwnode_handle *fwnode,
+				 const char *propname, const char *nargs_prop,
+				 unsigned int nargs, unsigned int index,
+				 struct fwnode_reference_args *args)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+	struct software_node_reference *ref;
+	const struct property_entry *prop;
+	int ret = -ENOENT;
+	int i;
+
+	mutex_lock(&swnode->lock);
+
+	if (!swnode || list_empty(&swnode->references))
+		goto err_unlock;
+
+	if (nargs_prop) {
+		prop = property_entry_get(swnode->properties, nargs_prop);
+		if (!prop) {
+			ret = -EINVAL;
+			goto err_unlock;
+		}
+
+		nargs = prop->value.u32_data;
+	}
+
+	if (nargs > NR_FWNODE_REFERENCE_ARGS) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	list_for_each_entry(ref, &swnode->references, list) {
+		if (strcmp(ref->name, propname))
+			continue;
+
+		if (index > (ref->nrefs - 1))
+			break;
+
+		args->nargs = nargs;
+		args->fwnode = software_node_get(ref->args[index].fwnode);
+
+		for (i = 0; i < nargs; i++)
+			args->args[i] = ref->args[index].args[i];
+
+		ret = 0;
+		break;
+	}
+
+err_unlock:
+	mutex_unlock(&swnode->lock);
+
+	return ret;
+}
+
 static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
 	.put = software_node_put,
@@ -543,6 +598,7 @@ static const struct fwnode_operations software_node_ops = {
 	.get_parent = software_node_get_parent,
 	.get_next_child_node = software_node_get_next_child,
 	.get_named_child_node = software_node_get_named_child_node,
+	.get_reference_args = software_node_get_reference_args,
 };
 
 /* -------------------------------------------------------------------------- */
-- 
2.20.1

