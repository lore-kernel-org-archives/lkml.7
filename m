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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40D5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB692075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 04:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyx3Ol/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfIFEiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 00:38:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38295 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfIFEiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 00:38:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so3486046pfe.5;
        Thu, 05 Sep 2019 21:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTbki7gvp1q8jXhcyUyr4Dd730rxRGHBVjVqDJdKMPo=;
        b=Fyx3Ol/lhTm3U3oa6ABBfjOw1Gk4b52t9Nt57eizzIquWlZVGBY+gr0axcdof2sLTG
         gu7GnLyn9ls/lvwtha8/unQHv1+yC8qEVOG6FuiP2vOwWpg4lkqdefRyI+ZjN4tOKurj
         b54btbhW7XuuABXguA5pxs2kBKz9sqR706KfBAQ8q6F6/sWhL0777H+byMFfM0WAdF9S
         kjZGs00Zh+elV8UOLXUp/+F/uWIx3mzpnnX3ORM5aftAUlnWZvFRzYJ09jRcPDOsEwQt
         PhCQtz5HJvpgxFXysQk7tSUgFDoa+qwrqsi0EQCyfrk4+sYD+Fkud5SWlD5neZSGcSUF
         7nhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTbki7gvp1q8jXhcyUyr4Dd730rxRGHBVjVqDJdKMPo=;
        b=fnR2enpIcLGj8lbL6TH5Evq3rvxatIA7ErMjZz8uNg0qTu7wn+NHEmzz7V+3ML40yW
         P8ycg1v424bfh/vuN7kPrIQXnxz4emYwcjEe30FPd1m/B/4L1VGbJDo0muET8/rxlRRO
         w5t+wmP0j01SFwFAzrwW3CFZa9v9kjssGsg+T7/E8FDv6SFZyWgeYtnFIv9jtuSMGdEG
         Y7BMJjXgmollpIt5DzHnVmu+w45koGSTG7rvRdKqPe5k5stBLFZlwmvlZN7CLSg5+yNe
         3LDidzRC/ixpuN2+ZJhhezureZeXQxdo3rz6tuF/vSJzlWpwytYeIx2CvOCHNgVQR8ED
         C0lA==
X-Gm-Message-State: APjAAAWeEA92GFMD7vX1YUlanQ9HAApkgGb7e40Urnivq2ZQGq+aRiVs
        0FcBPfMqiBWh8l8MyRK2V3s=
X-Google-Smtp-Source: APXvYqxlXD1SLWCwLirIyKrZzgQOoQBI/ev8EUl1EUmTRlXWWLkxHgBNcMzOuDkDKyHydHvvb5xhJA==
X-Received: by 2002:a17:90a:9105:: with SMTP id k5mr7910815pjo.9.1567744694307;
        Thu, 05 Sep 2019 21:38:14 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y15sm6085378pfp.111.2019.09.05.21.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 21:38:13 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/3] software node: remove separate handling of references
Date:   Thu,  5 Sep 2019 21:38:09 -0700
Message-Id: <20190906043809.18990-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906043809.18990-1-dmitry.torokhov@gmail.com>
References: <20190906043809.18990-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all users of references have moved to reference properties,
we can remove separate handling of references.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 31 +++++++++----------------------
 include/linux/property.h | 26 ++++++--------------------
 2 files changed, 15 insertions(+), 42 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 01325705b8e4..21771b29b641 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -568,7 +568,6 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 {
 	struct swnode *swnode = to_swnode(fwnode);
 	const struct software_node_reference *ref;
-	const struct software_node_ref_args *ref_args;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
 	int i;
@@ -577,30 +576,18 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	prop = property_entry_get(swnode->node->properties, propname);
-	if (prop) {
-		if (prop->type != DEV_PROP_REF)
-			return -EINVAL;
-
-		if (index * sizeof(*ref_args) >= prop->length)
-			return -ENOENT;
-
-		ref_args = prop->is_array ?
-				&prop->pointer.ref[index] : &prop->value.ref;
-	} else {
-		if (!swnode->node->references)
-			return -ENOENT;
+	if (!prop)
+		return -ENOENT;
 
-		for (ref = swnode->node->references; ref->name; ref++)
-			if (!strcmp(ref->name, propname))
-				break;
+	if (prop->type != DEV_PROP_REF)
+		return -EINVAL;
 
-		if (!ref->name || index > (ref->nrefs - 1))
-			return -ENOENT;
+	if (index * sizeof(*ref) >= prop->length)
+		return -ENOENT;
 
-		ref_args = &ref->refs[index];
-	}
+	ref = prop->is_array ? &prop->pointer.ref[index] : &prop->value.ref;
 
-	refnode = software_node_fwnode(ref_args->node);
+	refnode = software_node_fwnode(ref->node);
 	if (!refnode)
 		return -ENOENT;
 
@@ -619,7 +606,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref_args->args[i];
+		args->args[i] = ref->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index b25440344743..005b90d9e608 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -223,12 +223,12 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
 struct software_node;
 
 /**
- * struct software_node_ref_args - Reference property with additional arguments
+ * struct software_node_reference - Named software node reference property
  * @node: Reference to a software node
  * @nargs: Number of elements in @args array
  * @args: Integer arguments
  */
-struct software_node_ref_args {
+struct software_node_reference {
 	const struct software_node *node;
 	unsigned int nargs;
 	u64 args[NR_FWNODE_REFERENCE_ARGS];
@@ -255,7 +255,7 @@ struct property_entry {
 			const u32 *u32_data;
 			const u64 *u64_data;
 			const char * const *str;
-			const struct software_node_ref_args *ref;
+			const struct software_node_reference *ref;
 		} pointer;
 		union {
 			u8 u8_data;
@@ -263,7 +263,7 @@ struct property_entry {
 			u32 u32_data;
 			u64 u64_data;
 			const char *str;
-			struct software_node_ref_args ref;
+			struct software_node_reference ref;
 		} value;
 	};
 };
@@ -305,7 +305,7 @@ struct property_entry {
 (struct property_entry) {					\
 	.name = _name_,						\
 	.length = ARRAY_SIZE(_val_) *				\
-			sizeof(struct software_node_ref_args),	\
+			sizeof(struct software_node_reference),	\
 	.is_array = true,					\
 	.type = DEV_PROP_REF,					\
 	.pointer.ref = _val_,					\
@@ -344,7 +344,7 @@ struct property_entry {
 #define PROPERTY_ENTRY_REF(_name_, _ref_, ...)			\
 (struct property_entry) {					\
 	.name = _name_,						\
-	.length = sizeof(struct software_node_ref_args),	\
+	.length = sizeof(struct software_node_reference),	\
 	.type = DEV_PROP_REF,					\
 	.value.ref.node = _ref_,				\
 	.value.ref.nargs =					\
@@ -415,30 +415,16 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
-/**
- * struct software_node_reference - Named software node reference property
- * @name: Name of the property
- * @nrefs: Number of elements in @refs array
- * @refs: Array of references with optional arguments
- */
-struct software_node_reference {
-	const char *name;
-	unsigned int nrefs;
-	const struct software_node_ref_args *refs;
-};
-
 /**
  * struct software_node - Software node description
  * @name: Name of the software node
  * @parent: Parent of the software node
  * @properties: Array of device properties
- * @references: Array of software node reference properties
  */
 struct software_node {
 	const char *name;
 	const struct software_node *parent;
 	const struct property_entry *properties;
-	const struct software_node_reference *references;
 };
 
 bool is_software_node(const struct fwnode_handle *fwnode);
-- 
2.23.0.187.g17f5b7556c-goog

