Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009EEECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B7C21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLTfU1Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfIKFNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:13:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46576 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfIKFMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so12864124pfg.13;
        Tue, 10 Sep 2019 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WnwWtVtC6uezsNkuF5wmz268WUJO4EZ17z2Uk6qqhWs=;
        b=dLTfU1UeiL5ZxW1r8ZEpwjgZ5ViCfEc+q+YYgTYl/Y7iJ1pU/GH8RxfGFzW8ymDy48
         dHt+J2A9fw4ug8LqvBNkNf2gGU+MNKIf28rRNmxVyGrwVaZXAjhcmciUJVDWijvvdoFQ
         GD6IS4AHr/GwSEAjl16rxr3VAOLEUT4W+hfS/nZ022f/71LZQxEy6HqIzpFQGCFzyc1H
         hV+gEqj+y7asSUAOdIR8Kx+nkIlKlk4PIJpF3KA6OnsNi4b5rdz97GEIzoeq3t8ykeKO
         XpXyaiqMeLDIfeXJGlTbAqGlVHR2Okuxn2uzTXxZIXiFRVp5WIoJ+cxiyApfHD/jXUXk
         IWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WnwWtVtC6uezsNkuF5wmz268WUJO4EZ17z2Uk6qqhWs=;
        b=MRUCdC9eCcBsIUSfrSFohl1hKqkzp+RwEYeMbGsQwoKRD9p5VEYNuzMtymU+kCZrUS
         CfBpP6luZVVixnxG1qWxbhxt+flKrsQL9QxLbRrMuui50nmx4V70URVAWKLiBuANTFpU
         LiIT/ztaGsbetnJ/9JjXl8Si5hHalqNNeTsKZA6/vkCQOq+Ib3ubnHx4IVJ698UH8bvl
         FVHan3aF+87GyRlOCYs41Wx5KTibBdtj/4ejeDAbznDcE8icLT3Pd9GWzrqts9QjbQRt
         MYzJBNqIa8k5Clfplm1gboOuNnIdkaUtAHZp0H9UqkGu5KJwwz7KJ4dfrlMWwrhs7oqh
         TcmQ==
X-Gm-Message-State: APjAAAVuRlksVqAU86qt/V8rM/nFU3NzJBL1F9XLkLoUaMv2OU7AtcsX
        zm2WcG+68H8K9D3wmIzYe5M=
X-Google-Smtp-Source: APXvYqwdL0RzFYmbLLzoEArxUZpv4bPMUIKcrTFdLOvuq+s91/MZYaQNKw0JTxmKuQN7Dujs+6mpOQ==
X-Received: by 2002:a62:e717:: with SMTP id s23mr40425298pfh.71.1568178766419;
        Tue, 10 Sep 2019 22:12:46 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:45 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 08/14] software node: unify PROPERTY_ENTRY_XXX macros
Date:   Tue, 10 Sep 2019 22:12:25 -0700
Message-Id: <20190911051231.148032-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can unify string properties initializer macros with integer
initializers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 64 +++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index ec8f84d564a8..238e1507925f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -245,37 +245,33 @@ struct property_entry {
 };
 
 /*
- * Note: the below four initializers for the anonymous union are carefully
+ * Note: the below initializers for the anonymous union are carefully
  * crafted to avoid gcc-4.4.4's problems with initialization of anon unions
  * and structs.
  */
 
-#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)\
+#define __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_)				\
+	sizeof(((struct property_entry *)NULL)->value._elem_)
+
+#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)\
 (struct property_entry) {						\
 	.name = _name_,							\
-	.length = (_len_) * sizeof(_type_),				\
+	.length = (_len_) * __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
 	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .pointer = _val_ },						\
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8_data, U8, _val_, _len_)
 #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u16_data, U16, _val_, _len_)
 #define PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u32_data, U32, _val_, _len_)
 #define PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, _len_)		\
-	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
-
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64_data, U64, _val_, _len_)
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
-(struct property_entry) {						\
-	.name = _name_,							\
-	.length = (_len_) * sizeof(const char *),			\
-	.is_array = true,						\
-	.type = DEV_PROP_STRING,					\
-	{ .pointer = _val_ },						\
-}
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
 
 #define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
 	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
@@ -288,30 +284,24 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 
-#define __PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
-(struct property_entry) {					\
-	.name = _name_,						\
-	.length = sizeof(_type_),				\
-	.type = DEV_PROP_##_Type_,				\
-	{ .value = { ._type_##_data = _val_ } },		\
+#define __PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)		\
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
+	.type = DEV_PROP_##_Type_,					\
+	{ .value = { ._elem_ = _val_ } },				\
 }
 
-#define PROPERTY_ENTRY_U8(_name_, _val_)		\
-	__PROPERTY_ENTRY_INTEGER(_name_, u8, U8, _val_)
-#define PROPERTY_ENTRY_U16(_name_, _val_)		\
-	__PROPERTY_ENTRY_INTEGER(_name_, u16, U16, _val_)
-#define PROPERTY_ENTRY_U32(_name_, _val_)		\
-	__PROPERTY_ENTRY_INTEGER(_name_, u32, U32, _val_)
-#define PROPERTY_ENTRY_U64(_name_, _val_)		\
-	__PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
-
-#define PROPERTY_ENTRY_STRING(_name_, _val_)		\
-(struct property_entry) {				\
-	.name = _name_,					\
-	.length = sizeof(const char *),			\
-	.type = DEV_PROP_STRING,			\
-	{ .value = { .str = _val_ } },			\
-}
+#define PROPERTY_ENTRY_U8(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, u8_data, U8, _val_)
+#define PROPERTY_ENTRY_U16(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, u16_data, U16, _val_)
+#define PROPERTY_ENTRY_U32(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, u32_data, U32, _val_)
+#define PROPERTY_ENTRY_U64(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, u64_data, U64, _val_)
+#define PROPERTY_ENTRY_STRING(_name_, _val_)				\
+	__PROPERTY_ENTRY_ELEMENT(_name_, str, STRING, _val_)
 
 #define PROPERTY_ENTRY_BOOL(_name_)		\
 (struct property_entry) {			\
-- 
2.23.0.162.g0b9fbb3734-goog

