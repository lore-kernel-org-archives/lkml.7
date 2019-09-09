Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68651C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257DB21A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG9+ry8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbfIIIQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44050 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389034AbfIIIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so8652629pfn.11;
        Mon, 09 Sep 2019 01:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35xWhpJ4vTqiPEZAd1geSNcC3lLUdXhtiktpOpeubVg=;
        b=MG9+ry8LnfW9Y3XafCz3zWJMbYVNQEiPuYu6AdXywpBr02Lufe4yXXCVKoFHMLHDNT
         Cwr0NsqKItwHDM10nPYx/iXgHeXxldBI9AKgTF4Jy+VVM9bDWAxcmjnnPJ7Zpvn2RWF3
         r/2UHbzrmH1BTkn3Im8+vFs2iLMFmCzli/XUxdL0hW4l8I7a2TmFCC/eMjw52ESE40yb
         BY3qUxG5raJIEy1txIQQ24rcOEoU6NtANUegGcgaBuByRB6+S1ywDibx1ob6u4zgTk2w
         Kef3e72KOkau1dKhvhPT57Rx1Rxm902pF2pSyjyyJ9wybhXbBwR8shQeXLrZD5/yF8jq
         JASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35xWhpJ4vTqiPEZAd1geSNcC3lLUdXhtiktpOpeubVg=;
        b=RMMOesSpyDntXsOaoHlIpZMiNFI90kikxmG2OUicx0+coByQxJ+mzstU/rWhzsKIs7
         VNBFU7Ae2w62OuEvbu64Q3lKj1G4F5dH8PzdeB9O4CUlSt2zytXF4BinldMVciQSdY4t
         ShPHsLC8HHBf/Up/PVqDW+2bJz6FBAoZ44bKRhY4xTQrIWUE7U4yDD1lHkh1jBjlcbV3
         Bf1gIaKTkJg+txsuAg/5UQXqrvcL3gpVxSLFEdMexnj+rzUwJGLDt08lVYfjC7NJ6Xqv
         9l9j8z5Lz963x4LAu6auTO1nnI+O3KQKpJWLVWOX8DSzUlvIeE0bsy6mgZAXW6TZ78dB
         P+8Q==
X-Gm-Message-State: APjAAAUSekIOkC0Cul8iFsBZBoGz5QiTE5eJDL4MqFxn7DQCFfHFlbtN
        UYhlaYOvOLFM+PoRvYrteY8=
X-Google-Smtp-Source: APXvYqwtupkBTffWbYGpU9M0BA/lKlLKqd0/M+QnfYAxlR+QifpbGV80xoL2iTqBuVkLPJAR3LwOSw==
X-Received: by 2002:a62:e708:: with SMTP id s8mr26245440pfh.114.1568016978102;
        Mon, 09 Sep 2019 01:16:18 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:16 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 11/13] software node: implement reference properties
Date:   Mon,  9 Sep 2019 01:15:55 -0700
Message-Id: <20190909081557.93766-12-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
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
 drivers/base/swnode.c    | 46 +++++++++++++++++++++++++++++++++-------
 include/linux/property.h | 46 ++++++++++++++++++++++++++++------------
 2 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 03643f55e5b5..4aaad0c7b1eb 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -262,6 +262,12 @@ static int property_entry_copy_data(struct property_entry *dst,
 		}
 
 		dst->pointer.raw = new;
+	} else if (src->type == DEV_PROP_REF) {
+		/*
+		 * Reference properties are never stored inline as
+		 * they are too big.
+		 */
+		return -EINVAL;
 	} else if (src->type == DEV_PROP_STRING) {
 		new = kstrdup(src->value.str, GFP_KERNEL);
 		if (!new && src->value.str)
@@ -447,21 +453,45 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
+		 * We expect that references are never stored inline, even
+		 * single ones, as they are too big.
+		 */
+		if (prop->is_inline)
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
 
@@ -480,7 +510,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref->refs[index].args[i];
+		args->args[i] = ref_args->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 5180e23348d2..c9234fc43917 100644
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
@@ -240,6 +255,7 @@ struct property_entry {
 			const u32 *u32_data;
 			const u64 *u64_data;
 			const char * const *str;
+			const struct software_node_ref_args *ref;
 			const void *raw;
 		} pointer;
 		union {
@@ -279,6 +295,8 @@ struct property_entry {
 	PROPERTY_ENTRY_ARRAY(_name_, u64_data, U64, _val_)
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_ARRAY(_name_, str, STRING, _val_)
+#define PROPERTY_ENTRY_REF_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_ARRAY(_name_, ref, REF, _val_)
 
 #define PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)	\
 (struct property_entry) {						\
@@ -298,6 +316,8 @@ struct property_entry {
 	PROPERTY_ENTRY_ARRAY_LEN(_name_, u64_data, U64, _val_, _len_)
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
 	PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
+#define PROPERTY_ENTRY_REF_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, ref, REF, _val_, _len)
 
 #define PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)	\
 (struct property_entry) {					\
@@ -324,6 +344,18 @@ struct property_entry {
 	.name = _name_,				\
 }
 
+#define PROPERTY_ENTRY_REF(_name_, _ref_, ...)				\
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = sizeof(struct software_node_ref_args),		\
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
 
@@ -387,20 +419,6 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
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

