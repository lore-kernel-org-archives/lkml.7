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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50DAC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755B0222BE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5EqRRlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbfIIIQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44053 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389064AbfIIIQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id q21so8652694pfn.11;
        Mon, 09 Sep 2019 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UtLtNTXEdU6C/yU6HS/q4vOOCRlfD3VhKvtyNVUaElQ=;
        b=p5EqRRlJRJIxCcqnSYcClS+b2Agv9cgjWAIYSC4ovPblZ+UMsneKfXyrhqaS6xZprR
         /vgFUmG91ralYNG2gP858XxwLl/5EEhyNXRn8ZgT0vGSWE92Gnc58fsVEki5VW5aYrpp
         tfo9tzxQIiPI4fnVDjv479YpDQBeGzzOqvdgFZdqN6PtK9HtXhwu9AGFlsp6mbHGBmyG
         GJztfKCgKX7VC/a2d7/FcVk4gff2tk5KTibK/IW/aBFRZNzKSPcrojdO4UsTEoLvx/Ue
         DQr66VhkRVqB56/o0Es4xfCGTEBvFmiz9pJ+fZ3oG5mk5t2N7smpjQPn0C4si+2LT2O6
         U7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UtLtNTXEdU6C/yU6HS/q4vOOCRlfD3VhKvtyNVUaElQ=;
        b=O1FJ6r/3HShsnAywUlWJ8NMARLuu7LPb0F4UrvXQcDjt9lxAsqpxwRNndF+q62BJJZ
         sNZYhPSMu6EzVQpT/xKxxLZ2Rz+/2PGvWhxmBFAfcUgRLkgT6TJLP3T2XXOpbivLBBv2
         Uz0KDtLh0VQFBdy8b3p3N/eOTWHIT47iI6ORv8Au5DZOOEEkuPJZxQDgWtMJm2NmsrZF
         796jgd8/wyVGZBXgO2ruP8Gpm2Do/ExQ2EOFslWNsDyngvjzrRcf4aoPVhTatNTpGTft
         h8W/qi7+1BAFAAaZoruxc84RX7jv4yoLVUd2itKtEKosv9eL4ok8PE1YzikudClmlvpG
         PIEw==
X-Gm-Message-State: APjAAAXCEYOEI1BbVPtHdHdBXOimkO+8mmUa5JVB6zc7lvjqy4BGS+xa
        d8zniTxsjjxM46J1b84g6GU=
X-Google-Smtp-Source: APXvYqxwW2cQ3r9xbGMuuXjFn4yVwKa0UiWh32a4KuHhTp5JI7Q/rVYNDtrTcg/ShjeZsKLE8JfOYw==
X-Received: by 2002:a63:394:: with SMTP id 142mr20558333pgd.43.1568016980256;
        Mon, 09 Sep 2019 01:16:20 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:19 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 13/13] software node: remove separate handling of references
Date:   Mon,  9 Sep 2019 01:15:57 -0700
Message-Id: <20190909081557.93766-14-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
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
 drivers/base/swnode.c    | 44 +++++++++++++++-------------------------
 include/linux/property.h | 14 -------------
 2 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 4aaad0c7b1eb..8085b39e23b4 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -452,8 +452,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 				 struct fwnode_reference_args *args)
 {
 	struct swnode *swnode = to_swnode(fwnode);
-	const struct software_node_reference *ref;
-	const struct software_node_ref_args *ref_args;
+	const struct software_node_ref_args *ref;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
 	int i;
@@ -462,36 +461,25 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	prop = property_entry_get(swnode->node->properties, propname);
-	if (prop) {
-		if (prop->type != DEV_PROP_REF)
-			return -EINVAL;
-
-		/*
-		 * We expect that references are never stored inline, even
-		 * single ones, as they are too big.
-		 */
-		if (prop->is_inline)
-			return -EINVAL;
-
-		if (index * sizeof(*ref_args) >= prop->length)
-			return -ENOENT;
+	if (!prop)
+		return -ENOENT;
 
-		ref_args = &prop->pointer.ref[index];
-	} else {
-		if (!swnode->node->references)
-			return -ENOENT;
+	if (prop->type != DEV_PROP_REF)
+		return -EINVAL;
 
-		for (ref = swnode->node->references; ref->name; ref++)
-			if (!strcmp(ref->name, propname))
-				break;
+	/*
+	 * We expect that references are never stored inline, even
+	 * single ones, as they are too big.
+	 */
+	if (prop->is_inline)
+		return -EINVAL;
 
-		if (!ref->name || index > (ref->nrefs - 1))
-			return -ENOENT;
+	if (index * sizeof(*ref) >= prop->length)
+		return -ENOENT;
 
-		ref_args = &ref->refs[index];
-	}
+	ref = &prop->pointer.ref[index];
 
-	refnode = software_node_fwnode(ref_args->node);
+	refnode = software_node_fwnode(ref->node);
 	if (!refnode)
 		return -ENOENT;
 
@@ -510,7 +498,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref_args->args[i];
+		args->args[i] = ref->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index c9234fc43917..67cd38936c1e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -419,30 +419,16 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
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

