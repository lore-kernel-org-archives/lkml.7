Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F99C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A22205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390062AbfFKOOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:14:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:12583 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfFKOOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:14:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 07:14:06 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2019 07:14:05 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     jani.nikula@intel.com
Subject: [PATCH] module: add enum module parameter type to map names to values
Date:   Tue, 11 Jun 2019 17:17:01 +0300
Message-Id: <20190611141701.7432-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enum module parameter type that's internally an int and externally
maps names to values. This makes the userspace interface more intuitive
to use and somewhat easier to document, while also limiting the allowed
values set by userspace to the defined set.

For example, given this code to define a "mode" in a fictional module
"foobar":

	struct keyval modes[] = {
		{ "foo", 0 },
		{ "bar", 1 },
		{ "baz", -1 },
	};

	int mode;

	module_param_enum(mode, modes, 0600);

You can probe foobar with "foobar.mode=bar" in the kernel or modprobe
command line to set the mode to 1.

Similarly, you can use the sysfs with the names:

	# echo baz > /sys/module/foobar/parameters/mode
	# cat /sys/module/foobar/parameters/mode
	baz

With checks:

	# echo nope > /sys/module/foobar/parameters/mode
	echo: write error: Invalid argument

Of course, the kernel can still internally set the mode variable
directly to a value that is not defined in the enumerations (obviously
to be avoided), which will result in unknown key:

	# cat /sys/module/foobar/parameters/mode
	(unknown)

Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

I've had this lying around in a branch for a long time, but never really
got around to contributing upstream. Don't have a user for it
either. But here goes, might be useful for someone.

BR,
Jani.
---
 include/linux/moduleparam.h | 60 +++++++++++++++++++++++++++++++++++++
 kernel/params.c             | 42 ++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 5ba250d9172a..0fa341c201d6 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -77,6 +77,7 @@ struct kernel_param {
 		void *arg;
 		const struct kparam_string *str;
 		const struct kparam_array *arr;
+		const struct kparam_enum *enumeration;
 	};
 };
 
@@ -98,6 +99,19 @@ struct kparam_array
 	void *elem;
 };
 
+/* Special ones for enums */
+struct keyval {
+	const char *key;
+	int val;
+};
+
+struct kparam_enum
+{
+	const struct keyval *enumerations;
+	unsigned int size;
+	int *value;
+};
+
 /**
  * module_param - typesafe helper for a module/cmdline parameter
  * @value: the variable to alter, and exposed parameter name.
@@ -405,6 +419,11 @@ extern int param_set_bint(const char *val, const struct kernel_param *kp);
 #define param_get_bint param_get_int
 #define param_check_bint param_check_int
 
+/* An enumeration */
+extern const struct kernel_param_ops param_ops_enum;
+extern int param_set_enum(const char *val, const struct kernel_param *kp);
+extern int param_get_enum(char *buffer, const struct kernel_param *kp);
+
 /**
  * module_param_array - a parameter which is an array of some type
  * @name: the name of the array variable
@@ -444,6 +463,47 @@ extern int param_set_bint(const char *val, const struct kernel_param *kp);
 			    perm, -1, 0);				\
 	__MODULE_PARM_TYPE(name, "array of " #type)
 
+/**
+ * module_param_enum - a parameter which is an enumeration
+ * @name: the variable to alter, and exposed parameter name
+ * @enumerations: pointer to array of struct keyval defining the enums
+ * @perm: visibility in sysfs
+ *
+ * The userspace input and output are based on the names defined in the
+ * @enumerations array, which maps the names to values stored in the int
+ * variable defined by @name.
+ *
+ * When initializing or changing the variable @name, ensure the value is defined
+ * in @enumerations. Otherwise, reading the parameter value via sysfs will
+ * output "(unknown)".
+ *
+ * ARRAY_SIZE(@enumerations) is used to determine the number of elements in the
+ * enumerations array, so the definition must be visible.
+ */
+
+#define module_param_enum(name, enumerations, perm)			\
+	module_param_enum_named(name, name, enumerations, perm)
+
+/**
+ * module_param_enum_named - a renamed parameter which is an enumeration
+ * @name: a valid C identifier which is the parameter name
+ * @value: the actual lvalue int variable to alter
+ * @enumerations: pointer to array of struct keyval defining the enums
+ * @perm: visibility in sysfs
+ *
+ * This exposes a different name than the actual variable name.  See
+ * module_param_named() for why this might be necessary.
+ */
+#define module_param_enum_named(name, value, enumerations, perm)	\
+	param_check_int(name, &(value));				\
+	static const struct kparam_enum __param_arr_##name		\
+	= { enumerations, ARRAY_SIZE(enumerations), &value };		\
+	__module_param_call(MODULE_PARAM_PREFIX, name,			\
+			    &param_ops_enum,				\
+			    .enumeration = &__param_arr_##name,		\
+			    perm, -1, 0);				\
+	__MODULE_PARM_TYPE(name, "enumeration")
+
 enum hwparam_type {
 	hwparam_ioport,		/* Module parameter configures an I/O port */
 	hwparam_iomem,		/* Module parameter configures an I/O mem address */
diff --git a/kernel/params.c b/kernel/params.c
index cf448785d058..d6dc8bc38e43 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -506,6 +506,48 @@ const struct kernel_param_ops param_ops_string = {
 };
 EXPORT_SYMBOL(param_ops_string);
 
+int param_set_enum(const char *val, const struct kernel_param *kp)
+{
+	const struct kparam_enum *e = kp->enumeration;
+	unsigned int i;
+
+	for (i = 0; i < e->size; i++) {
+		if (sysfs_streq(val, e->enumerations[i].key)) {
+			*(e->value) = e->enumerations[i].val;
+			return 0;
+		}
+	}
+
+	pr_err("%s: unknown key %s to enum parameter\n", kp->name, val);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(param_set_enum);
+
+int param_get_enum(char *buffer, const struct kernel_param *kp)
+{
+	const struct kparam_enum *e = kp->enumeration;
+	unsigned int i;
+
+	for (i = 0; i < e->size; i++) {
+		if (*(e->value) == e->enumerations[i].val)
+			return scnprintf(buffer, PAGE_SIZE, "%s\n",
+					 e->enumerations[i].key);
+	}
+
+	pr_err("%s: enum parameter set to unknown value %d\n",
+	       kp->name, *(e->value));
+
+	return scnprintf(buffer, PAGE_SIZE, "(unknown)\n");
+}
+EXPORT_SYMBOL(param_get_enum);
+
+const struct kernel_param_ops param_ops_enum = {
+	.set = param_set_enum,
+	.get = param_get_enum,
+};
+EXPORT_SYMBOL(param_ops_enum);
+
 /* sysfs output in /sys/modules/XYZ/parameters/ */
 #define to_module_attr(n) container_of(n, struct module_attribute, attr)
 #define to_module_kobject(n) container_of(n, struct module_kobject, kobj)
-- 
2.20.1

