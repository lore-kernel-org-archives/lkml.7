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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E5AC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41A6207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPOOmssS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404984AbfIFW0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:26:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40395 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404918AbfIFW0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:26:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so5490463pfb.7;
        Fri, 06 Sep 2019 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwemBU+v3KzP8p62Iwnfn5JccM5nY24p7G/KK/8dCU8=;
        b=TPOOmssSdlRC00scR9zIyH6VvqkQesXn8nQHaHe1yocHyV6llbP75QzlImSqMFL7cT
         ktJBOCI3vrzOuFapqt1nSmnSjBeN25H6fwn0i0281/QdLHBkyZCJLXWieaJjg232vhXu
         8a9F/N6+pM1A+kQDBwjWFeLzfFy+nK9RwPVeobjlDgf9PWlqBFsU/K0k+V51t1i52sRp
         3wzmvwY1Wli4vgOkqaYbULaxd924fsIEILtzGa541lT9MCeFt409ROtdynkebTmMQ0nz
         KKTZTK0YwzOrNdfpeHfikCbryXMLGjMZ2UZgwLogxpf2t8xa5tYBF8TV1sk2gT8Kk17Q
         EiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwemBU+v3KzP8p62Iwnfn5JccM5nY24p7G/KK/8dCU8=;
        b=NZRwzdOjT1Fmy9t11cPQ/NTrNmdRTTpZHI/P6jALDzJKFdwBhoXKVMLy3Bu3W9JBtY
         IbsqWSt/F816OkzNHhjHwX9kgPmby2kAGLe1BZDT8Y2y4is85xLIXGnxkBu771BL8RoO
         kTF5ygsdDUq+OcUzC1DkTDJ/PxWsahQexwX+u5pb59RGNIa3IrMg+aK93AO0QioISAhi
         Bj0+m6TxWkZ2ygrZ82f1YaaNjYJpml/Y9I2c9/MF26SupyJUGu522zsslS8FPy867gLC
         BmFlw9jaM672UFcCJ8cRj+vvXky7b0NIYtycWs6PvXBf0UTzUVWQ7kiOG7WV6tJVRivl
         vbSg==
X-Gm-Message-State: APjAAAUnnuJCncp9CFn7yT7lh8+4/7ckRQYFL5aqhMdySYRKvCMTh6N6
        KCCWy/YpEg2wsvorO2Qy3wU=
X-Google-Smtp-Source: APXvYqx23C6Ba42TXbg+9w9fK12tQbcjz/a+3Fdzh88mbhk94bm9Cod2Rn5AKW7eD+mhdxjbKbSwbg==
X-Received: by 2002:a17:90a:c24e:: with SMTP id d14mr12602456pjx.0.1567808776849;
        Fri, 06 Sep 2019 15:26:16 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o130sm9648902pfg.171.2019.09.06.15.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 15:26:15 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 3/3] software node: remove separate handling of references
Date:   Fri,  6 Sep 2019 15:26:11 -0700
Message-Id: <20190906222611.223532-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
References: <20190906222611.223532-1-dmitry.torokhov@gmail.com>
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

v1->v2:

- dropped rename of struct software_node_ref_args ->
	struct software_node_reference

 drivers/base/swnode.c    | 44 +++++++++++++++-------------------------
 include/linux/property.h | 14 -------------
 2 files changed, 16 insertions(+), 42 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index bd720d995123..5dc113de0cae 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -570,8 +570,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 				 struct fwnode_reference_args *args)
 {
 	struct swnode *swnode = to_swnode(fwnode);
-	const struct software_node_reference *ref;
-	const struct software_node_ref_args *ref_args;
+	const struct software_node_ref_args *ref;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
 	int i;
@@ -580,36 +579,25 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	prop = property_entry_get(swnode->node->properties, propname);
-	if (prop) {
-		if (prop->type != DEV_PROP_REF)
-			return -EINVAL;
-
-		/*
-		 * We expect all references to be stored as arrays via
-		 * a pointer, even single ones.
-		 */
-		if (!prop->is_array)
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
+	 * We expect all references to be stored as arrays via
+	 * a pointer, even single ones.
+	 */
+	if (!prop->is_array)
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
 
@@ -628,7 +616,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)
-		args->args[i] = ref_args->args[i];
+		args->args[i] = ref->args[i];
 
 	return 0;
 }
diff --git a/include/linux/property.h b/include/linux/property.h
index 6658403f6fa9..5e4adccd6404 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
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

