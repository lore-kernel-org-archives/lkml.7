Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52492C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AB42133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfJBMdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:33:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:27022 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfJBMdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:33:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 05:33:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,574,1559545200"; 
   d="scan'208";a="205330033"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2019 05:33:12 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] software node: Add documentation
Date:   Wed,  2 Oct 2019 15:33:05 +0300
Message-Id: <20191002123305.80012-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002123305.80012-1-heikki.krogerus@linux.intel.com>
References: <20191002123305.80012-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

API documentation for the software nodes.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/driver-api/software_node.rst | 197 +++++++++++++++++++++
 1 file changed, 197 insertions(+)
 create mode 100644 Documentation/driver-api/software_node.rst

diff --git a/Documentation/driver-api/software_node.rst b/Documentation/driver-api/software_node.rst
new file mode 100644
index 000000000000..cf8a05c34e9e
--- /dev/null
+++ b/Documentation/driver-api/software_node.rst
@@ -0,0 +1,197 @@
+
+.. _software_node:
+
+==============
+Software nodes
+==============
+
+Introduction
+============
+
+Software node is a :c:type:`struct fwnode_handle <fwnode_handle>` type,
+analogous to the ACPI and DT firmware nodes except that the software nodes are
+created in kernel code (hence the name "software" node). The software nodes can
+be used to complement fwnodes representing real firmware nodes when they are
+incomplete, for example missing device properties, and to supply the primary
+fwnode when the firmware lacks hardware description for a device completely.
+
+NOTE! The primary hardware description should always come from either ACPI
+tables or DT. Describing an entire system with software nodes, though possible,
+is not acceptable! The software nodes should only complement the primary
+hardware description.
+
+Hierarchy
+=========
+
+The software nodes support hierarchy (i.e. the software nodes can have child
+software nodes and a parent software node) just like ACPI and DT firmware nodes,
+but there is no dedicated root software node object. It means that a software
+node at the root level does not have a parent.
+
+Note! Only other software nodes can be children and the parent for a software
+node.
+
+Device properties
+=================
+
+The software node device properties are described with :c:type:`struct
+property_entry <property_entry>`. When a software node is created that has
+device properties, it is supplied with a zero terminated array of property
+entries. Normally the properties are described with helper macros::
+
+	static const u8 u8_array[] = { 0, 1, 2, 3 };
+	static const u16 u16_array[] = { 0, 1, 2, 3 };
+	static const u32 u32_array[] = { 0, 1, 2, 3 };
+	static const u64 u64_array[] = { 0, 1, 2, 3 };
+
+	static const struct property_entry my_props[] = {
+		PROPERTY_ENTRY_U8_ARRAY("u8_array_example", u8_array),
+		PROPERTY_ENTRY_U16_ARRAY("u16_array_example", u16_array),
+		PROPERTY_ENTRY_U32_ARRAY("u32_array_example", u32_array),
+		PROPERTY_ENTRY_U64_ARRAY("u64_array_example", u64_array),
+		PROPERTY_ENTRY_U8("u8_example", 0xff),
+		PROPERTY_ENTRY_U16("u16_example", 0xffff),
+		PROPERTY_ENTRY_U32("u32_example", 0xffffffff),
+		PROPERTY_ENTRY_U64("u64_example", 0xffffffffffffffff),
+		PROPERTY_ENTRY_STRING("string_example", "string"),
+		{ }
+	};
+
+Note! If "build-in" device properties are supplied to already existing device
+entries by using :c:func:`device_add_properties`, a software node is actually
+created for that device. That software node is just assigned to the device
+automatically in the function.
+
+Usage
+=====
+
+Node creation
+-------------
+
+Static nodes
+~~~~~~~~~~~~
+
+In a normal case the software nodes are described statically with
+:c:type:`struct software_node <software_node>`, and then registered with
+:c:func:`software_node_register`. Usually there is more then one software node
+that needs to be registered. A helper :c:func:`software_node_register_nodes`
+registers a zero terminated array of software nodes::
+
+	static const struct property_entry props[] = {
+		PROPERTY_ENTRY_STRING("foo", "bar"),
+		{ }
+	};
+
+	static const struct software_node my_nodes[] = {
+		{ "grandparent" },		/* no parent nor properties */
+		{ "parent", &my_nodes[0] },	/* parent, but no propreties */
+		{ "child", &my_nodes[1], props }, /* parent and properties */
+		{ }
+	};
+
+	static int my_init(void)
+	{
+		return software_node_register_nodes(my_nodes);
+	}
+
+Note! The above example names the nodes "grandparent", "parent" and "child", but
+the software nodes don't actually have to be named. If no name is supplied for a
+software node when it's being registered, the API names the node "node<n>" where
+<n> is index number.
+
+Dynamic nodes
+~~~~~~~~~~~~~
+
+The Quick (and dirty) method. A software node can be created on the fly with
+:c:func:`fwnode_create_software_node`. The nodes create "on-the-fly" don't
+differ from statically described software nodes in any way, but for now the API
+does not support naming of these nodes::
+
+	static const struct property_entry my_props[] = {
+		PROPERTY_ENTRY_STRING("foo", "bar"),
+		{ }
+	};
+
+	static int my_init(void)
+	{
+		struct fwnode_handle *fwnode;
+
+		/* Software node without a parent. */
+		fwnode = fwnode_create_software_node(my_props, NULL);
+		if (IS_ERR(fwnode))
+			return PTR_ERR(fwnode);
+
+		return -1;
+	}
+
+Linking software nodes with the device (struct device) entries
+--------------------------------------------------------------
+
+Ideally the software node should be assigned to the device entry before the
+device is registered (just like any other fwnode).
+
+When the software node is the primary fwnode for the device, the fwnode of the
+device needs to simply point to the software node fwnode. Using a helper
+:c:func:`software_node_fwnode` in the following example::
+
+	static const struct software_node my_node = {
+		.name = "thenode",
+	};
+
+	static int my_init(void)
+	{
+		struct device my_device = { };
+		int ret;
+
+		ret = software_node_register(my_node);
+		if (ret)
+			return ret;
+
+		device_initialize(&my_device);
+		dev_set_name(&my_device, "thedevice")
+
+		my_device.fwnode = software_node_fwnode(swnode);
+
+		return device_add(&my_device);
+	}
+
+When the software node is the secondary fwnode for a device, i.e. the device has
+either ACPI or DT (or something else) firmware node as the primary fwnode, the
+node should be assigned with :c:func:`set_secondary_fwnode`. If the
+``secondary`` member of the primary fwnode needs to be manually made to point
+to the software node, the code needs to make sure that the ``secondary`` member
+of the software node fwnode points to a specific value of ``ERR_PTR(-ENODEV)``::
+
+	struct fwnode_handle *fwnode = software_node_fwnode(swnode);
+
+	fwnode->secondary = ERR_PTR(-ENODEV);
+	dev->fwnode->secondary = fwnode;
+
+Note! There is no requirement to bind a software node with a device entry, i.e.
+having "sub-nodes" that represent for example certain resources the parent
+software node has is not a problem.
+
+Node References
+---------------
+
+TODO
+
+Device graph
+------------
+
+TODO
+
+API
+===
+
+.. kernel-doc:: include/linux/property.h
+   :internal: software_node
+
+.. kernel-doc:: include/linux/fwnode.h
+   :internal: fwnode_handle
+
+.. kernel-doc:: drivers/base/core.c
+   :functions: set_secondary_fwnode
+
+.. kernel-doc:: drivers/base/swnode.c
+   :functions: is_software_node is_software_node software_node_fwnode software_node_find_by_name software_node_register_nodes software_node_unregister_nodes software_node_register software_node_register fwnode_create_software_node fwnode_remove_software_node
-- 
2.23.0

