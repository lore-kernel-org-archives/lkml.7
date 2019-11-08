Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45E4C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBFC2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AT2aypKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfKHEWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 23:22:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45895 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbfKHEWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:22:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so3778649pfn.12;
        Thu, 07 Nov 2019 20:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=po8Rb6LoWgZKfHqWrWPqkF0E9McUNGqymnwIsz+izAA=;
        b=AT2aypKSTuuGJ5p7oMpo5aBUjg6YyLrO3vHEHNC0kXGBhLEXdR5YQ0EXphefAfpJg6
         yQ7cLIpt5+ZlbTS+0qy1J0zN9Xhi2eEO1y/cJ2DzY3VPOEiZsJxej4Ak6gQ776n/Z1iv
         ARl2+dGxxAraZT0B/DV/NMZorYoQSTiNWUir/vGKqaArA/EV92uxKGgsuvME5iiIrJi6
         avdS3wpamKHc0Z0p2uJRed8qiyQ/sBanG3l1juaRQ4xIHDvAlQBojlqRpYxVYXgwSUqz
         5h3lxkXaw9kw3eIqdvfD7m/zZPTKEQ855gJ1mCLGfsmbYPkUQwz8BgBt/TkETIk/Rk0w
         44BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=po8Rb6LoWgZKfHqWrWPqkF0E9McUNGqymnwIsz+izAA=;
        b=fIECz/k4KTajIXajIj1qsnW6IjqwjwFGKguLpZ1UQFqka94nKMc9heYeKUnr3f8khN
         2x5SYdupRCCLVOaVQjbK2HvE2PkkLtLIH1PQtIZKvWl5Y4dASfL4S6bSunjuYyZwq1W/
         ixY+O2AkN14sfeOWyA6RsocRN2AB85UybS29NxQ54emL/S/2lqxjd8lBZJPOtiGGbq/y
         sF/8tStR1cQLUUB7cl7YgdGlHb6WAsiDxA5Do50gNNDYtPIOX7i08UGZR6X396iAdI19
         3Y7koYv8Io/62HxnD0jByczt5iKrK3MZQx/Sd+57HpE3qNsHYDCl6tJKj8/wMgx5Bldw
         ZC8Q==
X-Gm-Message-State: APjAAAUPc06VN5C6gwiImdiBLZa4K+4sm1W06YkxMAne6FbMH0It96NK
        tOXmV7ceMmgTY/FgrbM0UeQ=
X-Google-Smtp-Source: APXvYqyA1UPsOde6sy3mfP56M03C0nnhfiE/Dzpv7jciFSKzKQShWHUqAUynX+BKE4RJvGSFd6i0VA==
X-Received: by 2002:a63:cb0f:: with SMTP id p15mr9065466pgg.81.1573186954433;
        Thu, 07 Nov 2019 20:22:34 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 71sm5004106pfx.107.2019.11.07.20.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 20:22:34 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 5/6] software node: remove separate handling of references
Date:   Thu,  7 Nov 2019 20:22:24 -0800
Message-Id: <20191108042225.45391-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com>
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
 drivers/base/swnode.c    | 48 +++++++++++++++-------------------------
 include/linux/property.h | 14 ------------
 2 files changed, 18 insertions(+), 44 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 604d7327bba79..0b081dee1e95c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -479,9 +479,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 				 struct fwnode_reference_args *args)
 {
 	struct swnode *swnode = to_swnode(fwnode);
-	const struct software_node_reference *ref;
 	const struct software_node_ref_args *ref_array;
-	const struct software_node_ref_args *ref_args;
+	const struct software_node_ref_args *ref;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
 	u32 nargs_prop_val;
@@ -492,37 +491,26 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
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
-
-		ref_array = prop->pointer;
-		ref_args = &ref_array[index];
-	} else {
-		if (!swnode->node->references)
-			return -ENOENT;
+	if (!prop)
+		return -ENOENT;
+
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
 
@@ -543,7 +531,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref_args->args[i];
+		args->args[i] = ref->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 19b9dcc322763..b28c81af7bb68 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -418,30 +418,16 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
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
2.24.0.rc1.363.gb1bccd3e3d-goog

