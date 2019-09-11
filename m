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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFD7ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972EF222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I81PYlpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfIKFMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43069 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfIKFMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id u72so10881553pgb.10;
        Tue, 10 Sep 2019 22:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sr5fjQTMZVqf+Bacd5g9dQg5Ens8+dgwrpyFPkZSOxI=;
        b=I81PYlpAKX/W2CfW7Na7WdVPXubtkOv2peWrSpwBv00eVnfizb5Io/APJgRPRHQrng
         lxPWcyQn4Vp66OQUbYoC/Z1/g+XbApeE2Xu6klh7eU8er+qpKAfAlqhNMXxo1Sd5ebsw
         XVehMx5mb1BdBVCxFOjWh4guC20sOXK8eBEyWi6mHeERZHLFSsLRFMOGy+tNXDTQC+Cn
         hUZ3AShswkE3hYYOTHKAhSn9uimIMNjysrkAA2wmCB/bdDhyf10wTUiMC4I+J9p7Qkti
         8L+vSbxtidYoG9oKoMMIDJ4J66WuCoo6QDJAd7Tq7zLPDPpc4wZFWrMqgFUeo8SWjsnV
         GShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sr5fjQTMZVqf+Bacd5g9dQg5Ens8+dgwrpyFPkZSOxI=;
        b=d1mfT2/pT8vVRXjFnr0/CO42gzIaNIItpzvq0lvHfKL3XhZkxu9rHOf6pf88xHVZOB
         UGMJCQpO+M5OO2tn0opV34lpWfo8uNfjO5rJYiQqeXOf01oFMUkKjtbpJH9IUSfwjGbs
         AgDKiJ3sjpoH+qVRITFgg58sDwxUWq2EexbjVH1GHXl2eSrnRnqO2hGDr4qAXG2V7sS6
         l5Y2Auu9FAdSHRll7XnyXY17LsNvNP8O1hncasShqqnRqk4vmGbbEVjjEmnfcNaR2l0i
         SS4m1njHDFMTUZg9l2LubWBlbsZ1iPar6bWtH2jpB5HGfy0Rm3y0cl8zARbl+fpvcFfJ
         HN5g==
X-Gm-Message-State: APjAAAVRfTsYPSTG8+utqVsjfFE3IqzbP2tBuWn4s+n/pBOdKbTabJrr
        5IU+6aQRu8dYU04JZV75orU=
X-Google-Smtp-Source: APXvYqxNJTOZbRUEGaipqBNeV3JtfmKsQfW0Y3abDdEsnfzacv6CRpAGh6xhFFjoD6yZOeoi85mhmQ==
X-Received: by 2002:a62:7c47:: with SMTP id x68mr40265301pfc.178.1568178764011;
        Tue, 10 Sep 2019 22:12:44 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:43 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 06/14] software node: get rid of property_set_pointer()
Date:   Tue, 10 Sep 2019 22:12:23 -0700
Message-Id: <20190911051231.148032-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of explicitly setting values of integer types when copying
property entries lets just copy entire value union when processing
non-array values.

When handling array values assign the pointer there using the newly
introduced "raw" pointer union member. This allows us to remove
property_set_pointer().

In property_get_pointer() we do not need to handle each data type
separately, we can simply return either the raw pointer or pointer to
values union.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 90 +++++++++-------------------------------
 include/linux/property.h | 12 ++----
 2 files changed, 22 insertions(+), 80 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 7bad41a8f65d..726195d334e4 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -103,71 +103,15 @@ property_entry_get(const struct property_entry *prop, const char *name)
 	return NULL;
 }
 
-static void
-property_set_pointer(struct property_entry *prop, const void *pointer)
-{
-	switch (prop->type) {
-	case DEV_PROP_U8:
-		if (prop->is_array)
-			prop->pointer.u8_data = pointer;
-		else
-			prop->value.u8_data = *((u8 *)pointer);
-		break;
-	case DEV_PROP_U16:
-		if (prop->is_array)
-			prop->pointer.u16_data = pointer;
-		else
-			prop->value.u16_data = *((u16 *)pointer);
-		break;
-	case DEV_PROP_U32:
-		if (prop->is_array)
-			prop->pointer.u32_data = pointer;
-		else
-			prop->value.u32_data = *((u32 *)pointer);
-		break;
-	case DEV_PROP_U64:
-		if (prop->is_array)
-			prop->pointer.u64_data = pointer;
-		else
-			prop->value.u64_data = *((u64 *)pointer);
-		break;
-	case DEV_PROP_STRING:
-		if (prop->is_array)
-			prop->pointer.str = pointer;
-		else
-			prop->value.str = pointer;
-		break;
-	default:
-		break;
-	}
-}
-
 static const void *property_get_pointer(const struct property_entry *prop)
 {
-	switch (prop->type) {
-	case DEV_PROP_U8:
-		if (prop->is_array)
-			return prop->pointer.u8_data;
-		return &prop->value.u8_data;
-	case DEV_PROP_U16:
-		if (prop->is_array)
-			return prop->pointer.u16_data;
-		return &prop->value.u16_data;
-	case DEV_PROP_U32:
-		if (prop->is_array)
-			return prop->pointer.u32_data;
-		return &prop->value.u32_data;
-	case DEV_PROP_U64:
-		if (prop->is_array)
-			return prop->pointer.u64_data;
-		return &prop->value.u64_data;
-	case DEV_PROP_STRING:
-		if (prop->is_array)
-			return prop->pointer.str;
-		return &prop->value.str;
-	default:
+	if (!prop->length)
 		return NULL;
-	}
+
+	if (prop->is_array)
+		return prop->pointer;
+
+	return &prop->value;
 }
 
 static const void *property_entry_find(const struct property_entry *props,
@@ -322,13 +266,15 @@ static int property_entry_read_string_array(const struct property_entry *props,
 static void property_entry_free_data(const struct property_entry *p)
 {
 	const void *pointer = property_get_pointer(p);
+	const char * const *src_str;
 	size_t i, nval;
 
 	if (p->is_array) {
-		if (p->type == DEV_PROP_STRING && p->pointer.str) {
+		if (p->type == DEV_PROP_STRING && p->pointer) {
+			src_str = p->pointer;
 			nval = p->length / sizeof(const char *);
 			for (i = 0; i < nval; i++)
-				kfree(p->pointer.str[i]);
+				kfree(src_str[i]);
 		}
 		kfree(pointer);
 	} else if (p->type == DEV_PROP_STRING) {
@@ -341,6 +287,7 @@ static const char * const *
 property_copy_string_array(const struct property_entry *src)
 {
 	const char **d;
+	const char * const *src_str = src->pointer;
 	size_t nval = src->length / sizeof(*d);
 	int i;
 
@@ -349,8 +296,8 @@ property_copy_string_array(const struct property_entry *src)
 		return NULL;
 
 	for (i = 0; i < nval; i++) {
-		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
-		if (!d[i] && src->pointer.str[i]) {
+		d[i] = kstrdup(src_str[i], GFP_KERNEL);
+		if (!d[i] && src_str[i]) {
 			while (--i >= 0)
 				kfree(d[i]);
 			kfree(d);
@@ -380,20 +327,21 @@ static int property_entry_copy_data(struct property_entry *dst,
 			if (!new)
 				return -ENOMEM;
 		}
+
+		dst->is_array = true;
+		dst->pointer = new;
 	} else if (src->type == DEV_PROP_STRING) {
 		new = kstrdup(src->value.str, GFP_KERNEL);
 		if (!new && src->value.str)
 			return -ENOMEM;
+
+		dst->value.str = new;
 	} else {
-		new = pointer;
+		dst->value = src->value;
 	}
 
 	dst->length = src->length;
-	dst->is_array = src->is_array;
 	dst->type = src->type;
-
-	property_set_pointer(dst, new);
-
 	dst->name = kstrdup(src->name, GFP_KERNEL);
 	if (!dst->name)
 		goto out_free_data;
diff --git a/include/linux/property.h b/include/linux/property.h
index 2c9d4d209296..ec8f84d564a8 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -233,13 +233,7 @@ struct property_entry {
 	bool is_array;
 	enum dev_prop_type type;
 	union {
-		union {
-			const u8 *u8_data;
-			const u16 *u16_data;
-			const u32 *u32_data;
-			const u64 *u64_data;
-			const char * const *str;
-		} pointer;
+		const void *pointer;
 		union {
 			u8 u8_data;
 			u16 u16_data;
@@ -262,7 +256,7 @@ struct property_entry {
 	.length = (_len_) * sizeof(_type_),				\
 	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
-	{ .pointer = { ._type_##_data = _val_ } },			\
+	{ .pointer = _val_ },						\
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
@@ -280,7 +274,7 @@ struct property_entry {
 	.length = (_len_) * sizeof(const char *),			\
 	.is_array = true,						\
 	.type = DEV_PROP_STRING,					\
-	{ .pointer = { .str = _val_ } },				\
+	{ .pointer = _val_ },						\
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
-- 
2.23.0.162.g0b9fbb3734-goog

