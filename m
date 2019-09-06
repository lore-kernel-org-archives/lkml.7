Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87781C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487F6207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PctYsTZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404917AbfIFW0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:26:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41150 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404877AbfIFW0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:26:16 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so5477329pfo.8;
        Fri, 06 Sep 2019 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jy3R1WgQyiaWIhke8T/CbEBcNrYri/Fjw7+3lksM92U=;
        b=PctYsTZeb2Tg0O+MuAW/jpzBA4neZ2631KdjkzQvXekcuC7aBJAI8cQzxB/0Vrp4qo
         g5LvVH+O8SKhO+05O/7itdvULF5wpxVkvoPPw3/EYlMQ/Ji6WeorJtHSo2EEpC5LuHnH
         60jhxYbp8RvcG74y+uMukzB2MGH+Hsaob+dM2tvY8SDSuNKbEUmH3AqQx7xqJ/WjQafo
         1axr3AoQ9lpi0/9QoW2rD/TiBXvYbR1FZn0FY0Z+cH2E8uAmUP52hwp+qM7pGwi2l707
         9+l25aJcCCQgpSf7+H4zOnifyQr0ffIFZVCN/d6kdEmdWjq6ADoii6OpDxa5XZvAxPp1
         em5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jy3R1WgQyiaWIhke8T/CbEBcNrYri/Fjw7+3lksM92U=;
        b=e5s6Ukyl5vYV2Y04OXr1l3bqU8THtVIsMwKVPx2InSIeooSmYRINdwD7iZGuuQq7CN
         3cR2KQmCdG4ldnipgZrG3mTMwE3FB44Lg28w0AbXyU+gD043B2wv+xaadyCLDPhiL425
         1OTqL3J+In/60h63awLUD6MlmSJoUES8Cyo3m5AwJ7wIR40jZXdmVwopf7yc2p/D76OL
         nJ5bruqUxqQedfyGkUNQV27IK2qccZ8kgozLo7S+rZ+jAFrfUx/rr6MX/Z7lt6mtujp8
         rIGxW4+FyeCvSYB5D4KWR/nDrZ7ahS9529e7qmLyu+/nCzHUc0G664yccwlmcqyNiI8a
         Gk4w==
X-Gm-Message-State: APjAAAVGnJ+R6ora0D3ICbrlBSoHLa1Ujrei/JlQ1WG+KvQLgEFuD3Yw
        Qw+BU16z2Z4nIglNXFM01PQ=
X-Google-Smtp-Source: APXvYqwuEdDmNq6/ecMQjecZeu02BUQgc2gDK8ZpS6z+mMch/Kd40lBWVjqdEcquz0hVKbbX8La+9Q==
X-Received: by 2002:a17:90a:33a9:: with SMTP id n38mr12048155pjb.18.1567808774786;
        Fri, 06 Sep 2019 15:26:14 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o130sm9648902pfg.171.2019.09.06.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 15:26:13 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 1/3] software node: implement reference properties
Date:   Fri,  6 Sep 2019 15:26:09 -0700
Message-Id: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to store references to software nodes in the same fashion as
other static properties, so that users do not need to define separate
structures:

static const struct software_node gpio_bank_b_node = {
	.name = "B",
};

static const struct property_entry simone_key_enter_props[] = {
	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
	PROPERTY_ENTRY_STRING("label", "enter"),
	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
	{ }
};

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v1->v2:

- reworked code so that even single-entry reference properties are
  stored as arrays (i.e. the software_node_ref_args instances are
  not part of property_entry structure) to avoid size increase.
  From user's POV nothing is changed, one can still use PROPERTY_ENTRY_REF
  macro to define reference "inline".

- dropped unused DEV_PROP_MAX


 drivers/base/swnode.c    | 43 ++++++++++++++++++++++++++------
 include/linux/property.h | 54 +++++++++++++++++++++++++++++-----------
 2 files changed, 74 insertions(+), 23 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index ee2a405cca9a..bd720d995123 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -387,6 +387,9 @@ static int property_entry_copy_data(struct property_entry *dst,
 		new = kstrdup(src->value.str, GFP_KERNEL);
 		if (!new && src->value.str)
 			return -ENOMEM;
+	} else if (src->type == DEV_PROP_REF) {
+		/* All reference properties must be arrays */
+		return -EINVAL;
 	} else {
 		new = pointer;
 	}
@@ -568,21 +571,45 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 {
 	struct swnode *swnode = to_swnode(fwnode);
 	const struct software_node_reference *ref;
+	const struct software_node_ref_args *ref_args;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
 	int i;
 
-	if (!swnode || !swnode->node->references)
+	if (!swnode)
 		return -ENOENT;
 
-	for (ref = swnode->node->references; ref->name; ref++)
-		if (!strcmp(ref->name, propname))
-			break;
+	prop = property_entry_get(swnode->node->properties, propname);
+	if (prop) {
+		if (prop->type != DEV_PROP_REF)
+			return -EINVAL;
 
-	if (!ref->name || index > (ref->nrefs - 1))
-		return -ENOENT;
+		/*
+		 * We expect all references to be stored as arrays via
+		 * a pointer, even single ones.
+		 */
+		if (!prop->is_array)
+			return -EINVAL;
+
+		if (index * sizeof(*ref_args) >= prop->length)
+			return -ENOENT;
+
+		ref_args = &prop->pointer.ref[index];
+	} else {
+		if (!swnode->node->references)
+			return -ENOENT;
+
+		for (ref = swnode->node->references; ref->name; ref++)
+			if (!strcmp(ref->name, propname))
+				break;
+
+		if (!ref->name || index > (ref->nrefs - 1))
+			return -ENOENT;
+
+		ref_args = &ref->refs[index];
+	}
 
-	refnode = software_node_fwnode(ref->refs[index].node);
+	refnode = software_node_fwnode(ref_args->node);
 	if (!refnode)
 		return -ENOENT;
 
@@ -601,7 +628,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref->refs[index].args[i];
+		args->args[i] = ref_args->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 9b3d4ca3a73a..6658403f6fa9 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -22,7 +22,7 @@ enum dev_prop_type {
 	DEV_PROP_U32,
 	DEV_PROP_U64,
 	DEV_PROP_STRING,
-	DEV_PROP_MAX,
+	DEV_PROP_REF,
 };
 
 enum dev_dma_attr {
@@ -219,6 +219,20 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
 	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
 }
 
+struct software_node;
+
+/**
+ * struct software_node_ref_args - Reference property with additional arguments
+ * @node: Reference to a software node
+ * @nargs: Number of elements in @args array
+ * @args: Integer arguments
+ */
+struct software_node_ref_args {
+	const struct software_node *node;
+	unsigned int nargs;
+	u64 args[NR_FWNODE_REFERENCE_ARGS];
+};
+
 /**
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
@@ -240,6 +254,7 @@ struct property_entry {
 			const u32 *u32_data;
 			const u64 *u64_data;
 			const char * const *str;
+			const struct software_node_ref_args *ref;
 		} pointer;
 		union {
 			u8 u8_data;
@@ -284,6 +299,15 @@ struct property_entry {
 	{ .pointer = { .str = _val_ } },			\
 }
 
+#define PROPERTY_ENTRY_REF_ARRAY(_name_, _val_)				     \
+(struct property_entry) {						     \
+	.name = _name_,							     \
+	.length = ARRAY_SIZE(_val_) * sizeof(struct software_node_ref_args), \
+	.is_array = true,						     \
+	.type = DEV_PROP_REF,						     \
+	.pointer.ref = _val_,						     \
+}
+
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
 (struct property_entry) {					\
 	.name = _name_,						\
@@ -314,6 +338,20 @@ struct property_entry {
 	.name = _name_,				\
 }
 
+#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = sizeof(struct software_node_ref_args),		\
+	.type = DEV_PROP_REF,						\
+	.is_array = true,						\
+	.type = DEV_PROP_REF,						\
+	.pointer.ref = &(const struct software_node_ref_args) {		\
+		.node = _ref_,						\
+		.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
+		.args = { __VA_ARGS__ },				\
+	},								\
+}
+
 struct property_entry *
 property_entries_dup(const struct property_entry *properties);
 
@@ -377,20 +415,6 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
-struct software_node;
-
-/**
- * struct software_node_ref_args - Reference with additional arguments
- * @node: Reference to a software node
- * @nargs: Number of elements in @args array
- * @args: Integer arguments
- */
-struct software_node_ref_args {
-	const struct software_node *node;
-	unsigned int nargs;
-	u64 args[NR_FWNODE_REFERENCE_ARGS];
-};
-
 /**
  * struct software_node_reference - Named software node reference property
  * @name: Name of the property
-- 
2.23.0.187.g17f5b7556c-goog

