Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF44BC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A300A216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YPL3r83l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfENUlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:41:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34965 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfENUk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:40:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id h1so153716pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 13:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9za352hE3ZueleWfuyo9coMAwkfOt9GXkoYlh/EHlI=;
        b=YPL3r83lJDb9POCxfAD0R3L1iJgVZzCq8cQDPGYrM+xL4wiqdO6E0a+NZlWi+nmaZj
         uEkbnErpKUymJYufx3GoEdqcv66yhyjorgmlLhT0C3h7Qky9Z5Srivu0odXj37LnROig
         XD776Jy1V+YNOfYUsQ2gkVFPZZPDcVVDgwmLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9za352hE3ZueleWfuyo9coMAwkfOt9GXkoYlh/EHlI=;
        b=GQtZxV8DUCRujiiTZRRt7eBmVjNKYc3q5uX2Iy9FUaxIEHP9rXmBhK55s5SbCmwgA+
         FerTRMWY2Qg/14nCmfnB4HFomw3dHMgAHo8oJ9jTFJq0LEE/9F7I3Mn//9Xgw3lLe/yK
         zHqdGh1vkBc+CX8fRMvov+cM6lsEQ23TVGUAeC6CbmJE/YbemxfoeWkmEZCY8X1nevTg
         2l0utuzLws07qQWypqvc4sMq1/I831q5dMpJKyccsobiMPufGlYEHW9GZKXedDeC3Uqf
         XO7+3Vqi8inxBLTCwLjFMq4wnJSgg2HlEeUZaNOuzedUNJW7snSNbRo3vVH125mNTSNt
         0//w==
X-Gm-Message-State: APjAAAWme07+y0wlBbUS6H2vmooEe1AijseYUAENzjKTU/qzac/U7CKt
        o9M77p9nj15gozeKkaAo9uUP3A==
X-Google-Smtp-Source: APXvYqyxCNQQitAxoK0bdUz/KVX/Lk/IeO2hikQeSb141VYl1QmP0Fo3zaFarsibbAsyIwBY2xE9hQ==
X-Received: by 2002:a63:d949:: with SMTP id e9mr39677144pgj.437.1557866456510;
        Tue, 14 May 2019 13:40:56 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p2sm2137pfi.73.2019.05.14.13.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 13:40:55 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v2 2/3] of/fdt: Remove dead code and mark functions with __init
Date:   Tue, 14 May 2019 13:40:52 -0700
Message-Id: <20190514204053.124122-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190514204053.124122-1-swboyd@chromium.org>
References: <20190514204053.124122-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions in here are never called, and others are only called
during __init. Remove the dead code and some dead exports for functions
that don't exist (I'm looking at you of_fdt_get_string!). Mark some
functions with __init so we can throw them away after we boot up and
poke at the FDT blob too.

Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/of/fdt.c       | 37 +++++--------------------------------
 include/linux/of_fdt.h | 11 -----------
 2 files changed, 5 insertions(+), 43 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4734223ab702..93414b89735f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -38,7 +38,7 @@
  * memory entries in the /memory node. This function may be called
  * any time after initial_boot_param is set.
  */
-void of_fdt_limit_memory(int limit)
+void __init of_fdt_limit_memory(int limit)
 {
 	int memory;
 	int len;
@@ -110,25 +110,6 @@ static int of_fdt_is_compatible(const void *blob,
 	return 0;
 }
 
-/**
- * of_fdt_is_big_endian - Return true if given node needs BE MMIO accesses
- * @blob: A device tree blob
- * @node: node to test
- *
- * Returns true if the node has a "big-endian" property, or if the kernel
- * was compiled for BE *and* the node has a "native-endian" property.
- * Returns false otherwise.
- */
-bool of_fdt_is_big_endian(const void *blob, unsigned long node)
-{
-	if (fdt_getprop(blob, node, "big-endian", NULL))
-		return true;
-	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
-	    fdt_getprop(blob, node, "native-endian", NULL))
-		return true;
-	return false;
-}
-
 static bool of_fdt_device_is_available(const void *blob, unsigned long node)
 {
 	const char *status = fdt_getprop(blob, node, "status", NULL);
@@ -145,8 +126,8 @@ static bool of_fdt_device_is_available(const void *blob, unsigned long node)
 /**
  * of_fdt_match - Return true if node matches a list of compatible values
  */
-int of_fdt_match(const void *blob, unsigned long node,
-                 const char *const *compat)
+static int __init of_fdt_match(const void *blob, unsigned long node,
+			       const char *const *compat)
 {
 	unsigned int tmp, score = 0;
 
@@ -758,7 +739,7 @@ int __init of_scan_flat_dt_subnodes(unsigned long parent,
  * @return offset of the subnode, or -FDT_ERR_NOTFOUND if there is none
  */
 
-int of_get_flat_dt_subnode_by_name(unsigned long node, const char *uname)
+int __init of_get_flat_dt_subnode_by_name(unsigned long node, const char *uname)
 {
 	return fdt_subnode_offset(initial_boot_params, node, uname);
 }
@@ -771,14 +752,6 @@ unsigned long __init of_get_flat_dt_root(void)
 	return 0;
 }
 
-/**
- * of_get_flat_dt_size - Return the total size of the FDT
- */
-int __init of_get_flat_dt_size(void)
-{
-	return fdt_totalsize(initial_boot_params);
-}
-
 /**
  * of_get_flat_dt_prop - Given a node in the flat blob, return the property ptr
  *
@@ -804,7 +777,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 /**
  * of_flat_dt_match - Return true if node matches a list of compatible values
  */
-int __init of_flat_dt_match(unsigned long node, const char *const *compat)
+static int __init of_flat_dt_match(unsigned long node, const char *const *compat)
 {
 	return of_fdt_match(initial_boot_params, node, compat);
 }
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index a713e5d156d8..acf820e88952 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -23,15 +23,6 @@
 struct device_node;
 
 /* For scanning an arbitrary device-tree at any time */
-extern char *of_fdt_get_string(const void *blob, u32 offset);
-extern void *of_fdt_get_property(const void *blob,
-				 unsigned long node,
-				 const char *name,
-				 int *size);
-extern bool of_fdt_is_big_endian(const void *blob,
-				 unsigned long node);
-extern int of_fdt_match(const void *blob, unsigned long node,
-			const char *const *compat);
 extern void *of_fdt_unflatten_tree(const unsigned long *blob,
 				   struct device_node *dad,
 				   struct device_node **mynodes);
@@ -64,9 +55,7 @@ extern int of_get_flat_dt_subnode_by_name(unsigned long node,
 extern const void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				       int *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
-extern int of_flat_dt_match(unsigned long node, const char *const *matches);
 extern unsigned long of_get_flat_dt_root(void);
-extern int of_get_flat_dt_size(void);
 extern uint32_t of_get_flat_dt_phandle(unsigned long node);
 
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
-- 
Sent by a computer through tubes

