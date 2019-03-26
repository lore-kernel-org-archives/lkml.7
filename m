Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E61AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB98A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfCZMlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:41:31 -0400
Received: from retiisi.org.uk ([95.216.213.190]:42368 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731464AbfCZMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:41:11 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id CA6CD634C80;
        Tue, 26 Mar 2019 14:41:04 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/6] device property: Add a function to obtain a node's prefix
Date:   Tue, 26 Mar 2019 14:41:03 +0200
Message-Id: <20190326124106.27694-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prefix is used for printing purpose before a node, and it also works
as a separator between two nodes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c  | 22 ++++++++++++++++++++++
 drivers/base/property.c  | 12 ++++++++++++
 drivers/of/property.c    | 10 ++++++++++
 include/linux/fwnode.h   |  2 ++
 include/linux/property.h |  1 +
 5 files changed, 47 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8c9a4c02cde2..c167fd748f86 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1314,6 +1314,27 @@ static const char *acpi_fwnode_get_name(const struct fwnode_handle *fwnode)
 	return adev ? acpi_device_bid(adev) : NULL;
 }
 
+static const char *
+acpi_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
+{
+	struct fwnode_handle *parent;
+
+	parent = fwnode_get_parent(fwnode);
+	/* Root node. */
+	if (!parent)
+		return "";
+
+	parent = fwnode_get_next_parent(parent);
+	/* Second node from the root; no prefix here either. */
+	if (!parent)
+		return "";
+
+	fwnode_handle_put(parent);
+
+	/* ACPI device or data node. */
+	return ".";
+}
+
 static struct fwnode_handle *
 acpi_fwnode_get_parent(struct fwnode_handle *fwnode)
 {
@@ -1355,6 +1376,7 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 		.get_next_child_node = acpi_get_next_subnode,		\
 		.get_named_child_node = acpi_fwnode_get_named_child_node, \
 		.get_name = acpi_fwnode_get_name,			\
+		.get_name_prefix = acpi_fwnode_get_name_prefix,		\
 		.get_reference_args = acpi_fwnode_get_reference_args,	\
 		.graph_get_next_endpoint =				\
 			acpi_graph_get_next_endpoint,			\
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 04a8591cd1b0..2e5b826a2376 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -544,6 +544,18 @@ const char *fwnode_get_name(const struct fwnode_handle *fwnode)
 }
 
 /**
+ * fwnode_get_name_prefix - Return the prefix of node for printing purposes
+ * @fwnode: The firmware node
+ *
+ * Returns the prefix of a node, intended to be printed right before the node.
+ * The prefix works also as a separator between the nodes.
+ */
+const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
+{
+	return fwnode_call_ptr_op(fwnode, get_name_prefix);
+}
+
+/**
  * fwnode_get_parent - Return parent firwmare node
  * @fwnode: Firmware whose parent is retrieved
  *
diff --git a/drivers/of/property.c b/drivers/of/property.c
index f0a7b78f2d9f..8fed3b142b41 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -877,6 +877,15 @@ static const char *of_fwnode_get_name(const struct fwnode_handle *fwnode)
 	return kbasename(to_of_node(fwnode)->full_name);
 }
 
+static const char *of_fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
+{
+	/* Root needs no prefix here (its name is "/"). */
+	if (!to_of_node(fwnode)->parent)
+		return "";
+
+	return "/";
+}
+
 static struct fwnode_handle *
 of_fwnode_get_parent(const struct fwnode_handle *fwnode)
 {
@@ -999,6 +1008,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
 	.get_name = of_fwnode_get_name,
+	.get_name_prefix = of_fwnode_get_name_prefix,
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 85b7fa4dc727..592ac6936e14 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -60,6 +60,7 @@ struct fwnode_reference_args {
  * @property_read_string_array: Read an array of string properties. Return zero
  *				on success, a negative error code otherwise.
  * @get_name: Return the name of an fwnode.
+ * @get_name_prefix: Get a prefix for a node (for printing purposes).
  * @get_parent: Return the parent of an fwnode.
  * @get_next_child_node: Return the next child node in an iteration.
  * @get_named_child_node: Return a child node with a given name.
@@ -87,6 +88,7 @@ struct fwnode_operations {
 				      const char *propname, const char **val,
 				      size_t nval);
 	const char *(*get_name)(const struct fwnode_handle *fwnode);
+	const char *(*get_name_prefix)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*get_parent)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *
 	(*get_next_child_node)(const struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index 2f5df900e310..0ea466ee8c3d 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -79,6 +79,7 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       struct fwnode_reference_args *args);
 
 const char *fwnode_get_name(const struct fwnode_handle *fwnode);
+const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
-- 
2.11.0

