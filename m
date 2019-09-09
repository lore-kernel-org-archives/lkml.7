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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26798C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC16A20678
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljypQiWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389047AbfIIIQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32895 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388998AbfIIIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so8686671pfl.0;
        Mon, 09 Sep 2019 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4ns4T+1S1k8Yfl1+HirB82I68GDEC4NojYLSrKF6Xw=;
        b=ljypQiWmSVbFGUdgPbE7ELOy8YC5qnqWtXRTwrX723h6dzoBJkGz2500h0eYh1R39Y
         B7nY1X+ngHRNo0xs6PoOs/b14vKgVICelCXXZD+AKehjoiS7AfacZGjZqD2wgV6Vb8Mo
         nrZYMrI3F15kZvUAwgB06ZEY21UlC3e8VRDVxaAIRX3/GGchXDE/UEp+s6269ptZNZ8f
         oauOCPgO/OQp3y0kCrB8MlHnts7wCAwhaA3M/GCnYfSvVZjZbMbBzzxmJjPkI5biCRu7
         hLTHlPHxYOXwh1lAFqWAyYUTCLaXazV9d6Vb9QL0uMYMJKWsJ4F5gQuIigkbcHnHYAaF
         3QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4ns4T+1S1k8Yfl1+HirB82I68GDEC4NojYLSrKF6Xw=;
        b=olXDJLiaR9Mlx660vXGAwr0iBmIWq7xZYKWjkETVTBDQKzFGN/3K14dytRXzUAshHr
         3evGbZW4FdoaLYCGT8SHC3QTWeIikfdCcxVIi1hru20K4klemXbl+XMfj5nQndBspONT
         JyEFUVKRxhiBfZd6EF2qQQa7+D2PMS/v82WKwlJIrT5OsF67XS+L9FMbsuWhyEGLW67w
         Y68hELBob9EOZQtCTESERXkzBTLzo6o/fTktC8zA1HCRId297eHlk3yCBufgfdm2N+p2
         dck8Ne0u54Vrd3iDAfIZFPFNotdhPxZ16bVbf3/RaB4Qf8QxRVvJaPiYFI3sDtLmDvC+
         bKrg==
X-Gm-Message-State: APjAAAUtwp1kQkLIfrCmUURstclUZchyd6jBnbNU6AnMP6NHryeqjKTW
        M3QG+Asfvs/rPcqzTLI5tE4=
X-Google-Smtp-Source: APXvYqykxCrSULkcnO/x04UMEYPX2uZ9AF8TxGlGwo+g0Cjy0bPFLa/3wqEBa0XE44qKKvwiE+q4lg==
X-Received: by 2002:a63:eb56:: with SMTP id b22mr20836436pgk.355.1568016976588;
        Mon, 09 Sep 2019 01:16:16 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:15 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 10/13] software node: rename is_array to is_inline
Date:   Mon,  9 Sep 2019 01:15:54 -0700
Message-Id: <20190909081557.93766-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not need a special flag to know if we are dealing with an array, as we can
get that data from ration between element length and the data size, however we
do need a flag to know whether the data is stored directly inside property_entry
or separately.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 9 +++++----
 include/linux/property.h | 7 ++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 2dfeeab919d4..03643f55e5b5 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -108,7 +108,7 @@ static const void *property_get_pointer(const struct property_entry *prop)
 	if (!prop->length)
 		return NULL;
 
-	if (prop->is_array)
+	if (!prop->is_inline)
 		return prop->pointer.raw;
 
 	return &prop->value;
@@ -204,7 +204,7 @@ static void property_entry_free_data(const struct property_entry *p)
 	const void *pointer = property_get_pointer(p);
 	size_t i, nval;
 
-	if (p->is_array) {
+	if (!p->is_inline) {
 		if (p->type == DEV_PROP_STRING && p->pointer.str) {
 			nval = p->length / sizeof(const char *);
 			for (i = 0; i < nval; i++)
@@ -247,7 +247,7 @@ static int property_entry_copy_data(struct property_entry *dst,
 	const void *pointer = property_get_pointer(src);
 	const void *new;
 
-	if (src->is_array) {
+	if (!src->is_inline) {
 		if (!src->length)
 			return -ENODATA;
 
@@ -261,15 +261,16 @@ static int property_entry_copy_data(struct property_entry *dst,
 				return -ENOMEM;
 		}
 
-		dst->is_array = true;
 		dst->pointer.raw = new;
 	} else if (src->type == DEV_PROP_STRING) {
 		new = kstrdup(src->value.str, GFP_KERNEL);
 		if (!new && src->value.str)
 			return -ENOMEM;
 
+		dst->is_inline = true;
 		dst->value.str = new;
 	} else {
+		dst->is_inline = true;
 		dst->value = src->value;
 	}
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 793d05cbc3b2..5180e23348d2 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -222,7 +222,8 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
  * @length: Length of data making up the value.
- * @is_array: True when the property is an array.
+ * @is_inline: True when the property value is stored directly in
+ *	&struct property_entry instance.
  * @type: Type of the data in unions.
  * @pointer: Pointer to the property (an array of items of the given type).
  * @value: Value of the property (when it is a single item of the given type).
@@ -230,7 +231,7 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
 struct property_entry {
 	const char *name;
 	size_t length;
-	bool is_array;
+	bool is_inline;
 	enum dev_prop_type type;
 	union {
 		union {
@@ -264,7 +265,6 @@ struct property_entry {
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = ARRAY_SIZE(_val_) * PROPERTY_ENTRY_ELSIZE(_elem_),	\
-	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	.pointer._elem_ = _val_,					\
 }
@@ -304,6 +304,7 @@ struct property_entry {
 	.name = _name_,						\
 	.length = PROPERTY_ENTRY_ELSIZE(_elem_),		\
 	.type = DEV_PROP_##_Type_,				\
+	.is_inline = true,					\
 	.value._elem_ = _val_,					\
 }
 
-- 
2.23.0.187.g17f5b7556c-goog

