Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF56C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680A3218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfCOQ6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:58:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:39359 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbfCOQ6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:58:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 09:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="155397192"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2019 09:58:07 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 03/12] software node: Add support for references
Date:   Fri, 15 Mar 2019 19:57:51 +0300
Message-Id: <20190315165800.5058-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
References: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing functions that can be used for adding and
removing references to other software nodes. The goal is to
support fwnode_property_get_reference_args() also with
software nodes, however, get_reference_args fwnode operation
callback is not yet implemented in this commit for the
software nodes. This commit will only add support for
reference addition/removal.

The next example shows how to add references to GPIOs using the
format described in Documentation/acpi/gpio-properties.txt:

/* Array with two GPIOs */
static struct fwnode_reference_args gpioargs[] __initdata = {
	{
		.nargs = 3,
		.args[0]= 19, /* index */
		.args[1]= 0,  /* pin */
		.args[2]= 0,  /* active_low */
	},
	{
		.nargs = 3,
		.args[0]= 20, /* index */
		.args[1]= 0,  /* pin */
		.args[2]= 0,  /* active_low */
	},
	{ }
};

static int myinit(void)
{
	struct software_node_reference *ref;
	struct fwnode_handle *gpio_node;
	struct fwnode_handle *my_node;

	/* Creating the nodes */
	gpio_node = fwnode_create_software_node(gpio_props, NULL);
	...
	my_node = fwnode_create_software_node(my_props, NULL);
	...

	/* gpio_node is associated with a GPIO/Pin controller in this example */
	...

	/* Assigning the actual node references */
	gpioargs[0].fwnode = gpio_node;
	gpioargs[1].fwnode = gpio_node;

	/* my_node will now have a named ("gpios") reference to the two GPIOs */
	ref = fwnode_create_software_node_reference(my_node, "gpios", gpioargs);
	...
	return 0;
}

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/swnode.c    | 101 +++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |   8 ++++
 2 files changed, 109 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 8d4485d8d0f8..591f290d25be 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -11,10 +11,19 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
+struct software_node_reference {
+	struct list_head list;
+	const char *name;
+	int nrefs;
+	struct fwnode_reference_args *args;
+};
+
 struct software_node {
 	int id;
 	struct kobject kobj;
 	struct fwnode_handle fwnode;
+	struct list_head references;
+	struct mutex lock; /* node lock */
 
 	/* hierarchy */
 	struct ida child_ids;
@@ -606,9 +615,11 @@ fwnode_create_software_node(const struct property_entry *properties,
 	swnode->kobj.kset = swnode_kset;
 	swnode->fwnode.ops = &software_node_ops;
 
+	mutex_init(&swnode->lock);
 	ida_init(&swnode->child_ids);
 	INIT_LIST_HEAD(&swnode->entry);
 	INIT_LIST_HEAD(&swnode->children);
+	INIT_LIST_HEAD(&swnode->references);
 	swnode->parent = p;
 
 	if (p) {
@@ -641,10 +652,100 @@ void fwnode_remove_software_node(struct fwnode_handle *fwnode)
 	if (!swnode)
 		return;
 
+	mutex_lock(&swnode->lock);
+	WARN(!list_empty(&swnode->references),
+	     "\"%s\" has still references", kobject_name(&swnode->kobj));
+	mutex_unlock(&swnode->lock);
+
 	kobject_put(&swnode->kobj);
 }
 EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
 
+/**
+ * fwnode_create_software_node_reference - Create named reference description
+ * @fwnode: The software node to have the references
+ * @name: Name given to reference description
+ * @args: Zero terminated array of software node references with arguments
+ *
+ * Associates software nodes listed in @args with @fwnode. The association is
+ * named @name. The reference count is incremented for the nodes in @args.
+ *
+ * Returns pointer to software node reference description on success, or ERR_PTR
+ * on failure.
+ */
+struct software_node_reference *
+fwnode_create_software_node_reference(const struct fwnode_handle *fwnode,
+				      const char *name,
+				      const struct fwnode_reference_args *args)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+	struct software_node_reference *ref;
+	int n;
+
+	if (!swnode)
+		return ERR_PTR(-EINVAL);
+
+	for (n = 0; args[n].fwnode; n++)
+		if (!is_software_node(args[n].fwnode))
+			return ERR_PTR(-EINVAL);
+
+	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+	if (!ref)
+		return ERR_PTR(-ENOMEM);
+
+	ref->nrefs = n;
+
+	ref->name = kstrdup(name, GFP_KERNEL);
+	if (!ref->name) {
+		kfree(ref);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ref->args = kcalloc(ref->nrefs, sizeof(*ref->args), GFP_KERNEL);
+	if (!ref->args) {
+		kfree(ref->name);
+		kfree(ref);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (n = 0; n < ref->nrefs; n++) {
+		ref->args[n] = args[n];
+		software_node_get(ref->args[n].fwnode);
+	}
+
+	mutex_lock(&swnode->lock);
+	list_add_tail(&ref->list, &swnode->references);
+	mutex_unlock(&swnode->lock);
+
+	return ref;
+}
+EXPORT_SYMBOL_GPL(fwnode_create_software_node_reference);
+
+/**
+ * fwnode_remove_software_node_reference - Remove named reference description
+ * @ref: Software node reference description
+ *
+ * Remove named reference @ref. Decrements the software node reference count of
+ * each node in @ref, and removes the association that was created in
+ * fwnode_create_software_node_reference().
+ */
+void fwnode_remove_software_node_reference(struct software_node_reference *ref)
+{
+	int n;
+
+	if (IS_ERR_OR_NULL(ref))
+		return;
+
+	for (n = 0; n < ref->nrefs; n++)
+		kobject_put(&to_software_node(ref->args[n].fwnode)->kobj);
+
+	list_del(&ref->list);
+	kfree(ref->args);
+	kfree(ref->name);
+	kfree(ref);
+}
+EXPORT_SYMBOL_GPL(fwnode_remove_software_node_reference);
+
 int software_node_notify(struct device *dev, unsigned long action)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
diff --git a/include/linux/property.h b/include/linux/property.h
index 65d3420dd5d1..40e12ca43556 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -314,6 +314,8 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
+struct sofware_node_reference;
+
 bool is_software_node(const struct fwnode_handle *fwnode);
 
 int software_node_notify(struct device *dev, unsigned long action);
@@ -323,4 +325,10 @@ fwnode_create_software_node(const struct property_entry *properties,
 			    const struct fwnode_handle *parent);
 void fwnode_remove_software_node(struct fwnode_handle *fwnode);
 
+struct software_node_reference *
+fwnode_create_software_node_reference(const struct fwnode_handle *fwnode,
+				      const char *name,
+				      const struct fwnode_reference_args *args);
+void fwnode_remove_software_node_reference(struct software_node_reference *ref);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.20.1

