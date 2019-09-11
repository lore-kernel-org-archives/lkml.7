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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1151ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A7E222BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyjemSJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfIKFNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:13:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41301 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfIKFMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so9635758pls.8;
        Tue, 10 Sep 2019 22:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6w91CiKWHTialn6fseIE4gTrIyeigf6ggLtTvkFJIKY=;
        b=FyjemSJMxy/U8XOLLnqIZck8AI+Td/HVn+NwGWka0d96bGaEQL0KaDpsmD8/oq1Eys
         hCVHFUQWfahgBYvba86gkLWAmB8wLJMHtlosjSMGS79ifpEwQcIH+yfczrmgByh41AcP
         WKImcXQmGnKwPMQJtk3Q0E4LtTagyAJyi7WMXVpd8Tp2hZKc2pRQQGn/RH0sWYi1FMdK
         MQ50RapkkNAxbiZzwpR85B4M1FlM6KOpaCpj6NzCIPPcB+uZKBYo9mQ+woJx3rFCcqRb
         hpCMiKJFJtNyO2TuWhGqnf2syV8LG4Gkc3CWC2Y2Sv0d6ETozxoVp84EGwHA+LgHFFeZ
         pxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6w91CiKWHTialn6fseIE4gTrIyeigf6ggLtTvkFJIKY=;
        b=EqPPgMo2RQ2vTMQJtmmUR36QhhGL3A3BmWltgU6NjP6pbkEEVpgr28rkbSnBAQ5/jC
         dRUysTWzWLFO8E6MUSDbE2u2d09thakmnoiDvnndI2W2N02OqYcaywW/DKbnGaiNrWrn
         fopr4mPbNe88kTwyNu2tekVJRZeR8y33PQAMz9O+HjIAP8OGsApsqKJaZwD9CGpVBvHJ
         MNyvaH+q7dBvxAMInEkK9us5GqAH0R8IxhfiMNGNdT/8pUB214Sypn9mVo24xPJRDx0Y
         20hD4WPhW612WTgM9nPA5zeVWnwI1Nw4nakRpTQ2Sghu+0vihqQwUw6BsA4X7ATOw5uf
         KTVw==
X-Gm-Message-State: APjAAAUpJPF+HMEwaYgwawTWqt00j7Xi/AZIWOcStQbEjAD0HhIuqYIZ
        QH0Td3hQvUphP/KnUoi/4zw=
X-Google-Smtp-Source: APXvYqxGakxPXGq1e65D6to0gO8Kc4pNMKMuBULrtF40Z0xjNkFjHWqWFtW17+yQ5iOjPXv9E/yPnQ==
X-Received: by 2002:a17:902:7285:: with SMTP id d5mr34438830pll.115.1568178773870;
        Tue, 10 Sep 2019 22:12:53 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:53 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 14/14] software node: remove separate handling of references
Date:   Tue, 10 Sep 2019 22:12:31 -0700
Message-Id: <20190911051231.148032-15-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
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
 drivers/base/swnode.c    | 46 +++++++++++++++-------------------------
 include/linux/property.h | 14 ------------
 2 files changed, 17 insertions(+), 43 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 07e1325789d2..ef38ea9f730b 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -465,9 +465,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 				 struct fwnode_reference_args *args)
 {
 	struct swnode *swnode = to_swnode(fwnode);
-	const struct software_node_reference *ref;
 	const struct software_node_ref_args *ref_array;
-	const struct software_node_ref_args *ref_args;
+	const struct software_node_ref_args *ref;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
 	int i;
@@ -476,37 +475,26 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
 
-		ref_array = prop->pointer;
-		ref_args = &ref_array[index];
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
+	ref_array = prop->pointer;
+	ref = &ref_array[index];
 
-	refnode = software_node_fwnode(ref_args->node);
+	refnode = software_node_fwnode(ref->node);
 	if (!refnode)
 		return -ENOENT;
 
@@ -525,7 +513,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref_args->args[i];
+		args->args[i] = ref->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 08d3e9d126ef..fa5a2ddc0c7b 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -412,30 +412,16 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
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
2.23.0.162.g0b9fbb3734-goog

