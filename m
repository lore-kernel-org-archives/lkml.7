Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBFAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A576E2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfCZMlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:41:14 -0400
Received: from retiisi.org.uk ([95.216.213.190]:42360 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731457AbfCZMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:41:11 -0400
Received: from lanttu.localdomain (unknown [IPv6:2a01:4f9:c010:4572::e1:1001])
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTP id 67658634C7F;
        Tue, 26 Mar 2019 14:41:04 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/6] device property: Add fwnode_get_name for returning the name of a node
Date:   Tue, 26 Mar 2019 14:41:02 +0200
Message-Id: <20190326124106.27694-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fwnode framework did not have means to obtain the name of a node. Add
that now, in form of the fwnode_get_name() function and a corresponding
get_name fwnode op. OF and ACPI support is included.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c  | 24 ++++++++++++++++++++++++
 drivers/base/property.c  | 11 +++++++++++
 drivers/of/property.c    |  6 ++++++
 include/linux/fwnode.h   |  2 ++
 include/linux/property.h |  1 +
 5 files changed, 44 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 77abe0ec4043..8c9a4c02cde2 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1291,6 +1291,29 @@ acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
 						  args_count, args);
 }
 
+static const char *acpi_fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	const struct acpi_device *adev;
+	struct fwnode_handle *parent;
+
+	parent = fwnode_get_parent(fwnode);
+	/* Is this the root node? */
+	if (!parent)
+		return "\\";
+
+	fwnode_handle_put(parent);
+
+	if (is_acpi_data_node(fwnode)) {
+		const struct acpi_data_node *dn = to_acpi_data_node(fwnode);
+
+		return dn->name;
+	}
+
+	adev = to_acpi_device_node(fwnode);
+
+	return adev ? acpi_device_bid(adev) : NULL;
+}
+
 static struct fwnode_handle *
 acpi_fwnode_get_parent(struct fwnode_handle *fwnode)
 {
@@ -1331,6 +1354,7 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 		.get_parent = acpi_node_get_parent,			\
 		.get_next_child_node = acpi_get_next_subnode,		\
 		.get_named_child_node = acpi_fwnode_get_named_child_node, \
+		.get_name = acpi_fwnode_get_name,			\
 		.get_reference_args = acpi_fwnode_get_reference_args,	\
 		.graph_get_next_endpoint =				\
 			acpi_graph_get_next_endpoint,			\
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 61eb6ceacc3f..04a8591cd1b0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -533,6 +533,17 @@ int device_add_properties(struct device *dev,
 EXPORT_SYMBOL_GPL(device_add_properties);
 
 /**
+ * fwnode_get_name - Return the name of a node
+ * @fwnode: The firmware node
+ *
+ * Returns a pointer to the node name.
+ */
+const char *fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	return fwnode_call_ptr_op(fwnode, get_name);
+}
+
+/**
  * fwnode_get_parent - Return parent firwmare node
  * @fwnode: Firmware whose parent is retrieved
  *
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 8631efa1daa1..f0a7b78f2d9f 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -872,6 +872,11 @@ of_fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 		of_property_count_strings(node, propname);
 }
 
+static const char *of_fwnode_get_name(const struct fwnode_handle *fwnode)
+{
+	return kbasename(to_of_node(fwnode)->full_name);
+}
+
 static struct fwnode_handle *
 of_fwnode_get_parent(const struct fwnode_handle *fwnode)
 {
@@ -993,6 +998,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.property_present = of_fwnode_property_present,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
+	.get_name = of_fwnode_get_name,
 	.get_parent = of_fwnode_get_parent,
 	.get_next_child_node = of_fwnode_get_next_child_node,
 	.get_named_child_node = of_fwnode_get_named_child_node,
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index faebf0ca0686..85b7fa4dc727 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -59,6 +59,7 @@ struct fwnode_reference_args {
  *				 otherwise.
  * @property_read_string_array: Read an array of string properties. Return zero
  *				on success, a negative error code otherwise.
+ * @get_name: Return the name of an fwnode.
  * @get_parent: Return the parent of an fwnode.
  * @get_next_child_node: Return the next child node in an iteration.
  * @get_named_child_node: Return a child node with a given name.
@@ -85,6 +86,7 @@ struct fwnode_operations {
 	(*property_read_string_array)(const struct fwnode_handle *fwnode_handle,
 				      const char *propname, const char **val,
 				      size_t nval);
+	const char *(*get_name)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *(*get_parent)(const struct fwnode_handle *fwnode);
 	struct fwnode_handle *
 	(*get_next_child_node)(const struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index 1164ac974ee8..2f5df900e310 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -78,6 +78,7 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       unsigned int nargs, unsigned int index,
 				       struct fwnode_reference_args *args);
 
+const char *fwnode_get_name(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(
 	struct fwnode_handle *fwnode);
-- 
2.11.0

