Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A08ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86329222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK55kvaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfIKFM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40151 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfIKFMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so12879955pfb.7;
        Tue, 10 Sep 2019 22:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UM/x9OUxWvKu8h5hlzYT3dDasLYFcLlKN6IsiVi+Sck=;
        b=FK55kvazx7m5MCBwdSr2PBkhps1PNkE44SkmtGNua/suozgruYUqEs0hkHSF8y06T3
         jf/+axjFBGFHMmQCTA+sfpm8D4elE5076HnvbvygiOc7Y/8LWgORHAbKYwcJ/tuiRm5m
         0X1nzky7jFSW1P1j5C692CFwtDcxaVnWEk5FDRSrsdbVFONUhUrk15eD531jDiWsDEbp
         R2UQ7eOfsx8zo6OuV/N9nEBhasiGveaFBjf6z0WhizOSZQ+fbJlae84l2uy8fPxhzPow
         4Lcjj0/PCHTa7luy4eKuVL//YuG3x2VLhGhZQymYPpVYUuXPsST7NAq1Lj2jCPTZcSN/
         W1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UM/x9OUxWvKu8h5hlzYT3dDasLYFcLlKN6IsiVi+Sck=;
        b=PzG1aPaO400uL6XtA60oI4Rtq+FbVEDSyyUwn3w3ZrxT1xMRZtgMRPu4ilht4ULKvD
         CEQo9Hxk0OLlVjyxsXaigt9BgzNI1k72TQcgQABQkhEInhJM3vtskOQ2I7JrcW8CzRz+
         u9vge/VRzLFT0SWMFOCfjKXombOa7anWyISY/5KppiLsViWum3ECHlyyO9aCnZCRAeXm
         gKnnd2FnFY1cviWWZ1cMUFp7jxaBkypLKQD/AEOD4Ug2V5/P4Ep0qkYKF0111QNxsYA8
         qvBFarmGa8jSrIAL3SQGvBtm2YswGh8MZ9+VjySquZBpSV/cfOcdsaYNTGtD1taI9LeU
         3lIg==
X-Gm-Message-State: APjAAAUuCtT8UFuFFsHTOngbM34HZfqvm3lfUci34LkH7nO4fcDoS4uk
        Tjyo87vmFYnI+QGifbdze5eNiaR2JxQ=
X-Google-Smtp-Source: APXvYqxfcYyaPW0OLzaJAMVoWfQd5w98bgB2OI1BVlo6NJfzkteuBKrocfw2Q+/C0T6Ya1Nl0iBWzw==
X-Received: by 2002:a17:90a:2206:: with SMTP id c6mr3401556pje.4.1568178772376;
        Tue, 10 Sep 2019 22:12:52 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:50 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 12/14] software node: implement reference properties
Date:   Tue, 10 Sep 2019 22:12:29 -0700
Message-Id: <20190911051231.148032-13-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
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
 drivers/base/swnode.c    | 48 +++++++++++++++++++++++++++------
 include/linux/property.h | 57 +++++++++++++++++++++++++++++-----------
 2 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 1aa6559993ec..07e1325789d2 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -265,6 +265,12 @@ static int property_entry_copy_data(struct property_entry *dst,
 		}
 
 		dst->pointer = new;
+	} else if (src->type == DEV_PROP_REF) {
+		/*
+		 * Reference properties are never stored inline as
+		 * they are too big.
+		 */
+		return -EINVAL;
 	} else if (src->type == DEV_PROP_STRING) {
 		new = kstrdup(src->value.str, GFP_KERNEL);
 		if (!new && src->value.str)
@@ -460,21 +466,47 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 {
 	struct swnode *swnode = to_swnode(fwnode);
 	const struct software_node_reference *ref;
+	const struct software_node_ref_args *ref_array;
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
+		 * We expect that references are never stored inline, even
+		 * single ones, as they are too big.
+		 */
+		if (prop->is_inline)
+			return -EINVAL;
+
+		if (index * sizeof(*ref_args) >= prop->length)
+			return -ENOENT;
+
+		ref_array = prop->pointer;
+		ref_args = &ref_array[index];
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
 
@@ -493,7 +525,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref->refs[index].args[i];
+		args->args[i] = ref_args->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index ac7823d58cfe..08d3e9d126ef 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -22,6 +22,7 @@ enum dev_prop_type {
 	DEV_PROP_U32,
 	DEV_PROP_U64,
 	DEV_PROP_STRING,
+	DEV_PROP_REF,
 };
 
 enum dev_dma_attr {
@@ -218,6 +219,20 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
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
@@ -255,14 +270,20 @@ struct property_entry {
 #define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)				\
 	sizeof(((struct property_entry *)NULL)->value._elem_)
 
-#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
+#define __PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_, _elsize_, _Type_,	\
+					  _val_, _len_)			\
 (struct property_entry) {						\
 	.name = _name_,							\
-	.length = (_len_) * __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
+	.length = (_len_) * (_elsize_),					\
 	.type = DEV_PROP_##_Type_,					\
 	{ .pointer = _val_ },						\
 }
 
+#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
+	__PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,			\
+				__PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
+				_Type_, _val_, _len_)
+
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8_data, U8, _val_, _len_)
 #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
@@ -273,6 +294,10 @@ struct property_entry {
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64_data, U64, _val_, _len_)
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
 	__PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
+#define PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, _len_)		\
+	__PROPERTY_ENTRY_ARRAY_ELSIZE_LEN(_name_,			\
+				sizeof(struct software_node_ref_args),	\
+				REF, _val_, _len_)
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
 	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
@@ -284,6 +309,8 @@ struct property_entry {
 	PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_REF_ARRAY(_name_, _val_)			\
+	PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 
 #define __PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)		\
 (struct property_entry) {						\
@@ -310,6 +337,18 @@ struct property_entry {
 	.name = _name_,				\
 }
 
+#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = sizeof(struct software_node_ref_args),		\
+	.type = DEV_PROP_REF,						\
+	{ .pointer = &(const struct software_node_ref_args) {		\
+		.node = _ref_,						\
+		.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
+		.args = { __VA_ARGS__ },				\
+	} },								\
+}
+
 struct property_entry *
 property_entries_dup(const struct property_entry *properties);
 
@@ -373,20 +412,6 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
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
2.23.0.162.g0b9fbb3734-goog

