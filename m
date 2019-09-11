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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD27FECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846FA21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyMQSRtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfIKFMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37632 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIKFMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id c17so3137810pgg.4;
        Tue, 10 Sep 2019 22:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k6hYIyf0TaML+Z8b0g2cj+cgGBKeyruhIX+oPtdlFL8=;
        b=ZyMQSRtknL+tHgBeAJoAg3mktJtuAT2iufxcJL4qzNvWAjkM0/+Bc0Y9Pxb6ui4IZ9
         Z465u96VnwdgUb/0oCoLDEEajc+MpxVq8e6mTlNMa39bA+pcFzw6or43UCn/IJVijAcC
         HLR+Eo4VpUbL1d8fWj7Ieoqda9zZE1jXZB/F+8/AMyhlZULZBCfGUwmgwcdcQGncXqUX
         rudKuRCT/Xzw1X5I0neah1v/W5qImprsmJpK3bVCkzafYXfq4wgWSiWXmwK5YkhbGbqy
         /0Y3te3Yy29BbuW8HcebDG0x/03geR3/EBuhbZBTTH1OsZTRqyS+ca+ObQC0dzbhVJTO
         tIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k6hYIyf0TaML+Z8b0g2cj+cgGBKeyruhIX+oPtdlFL8=;
        b=XhfzkT2vkaFXujx++s8fS0IHYRafgjIDFN2lOZTE7UAqNcOq9cGaaVlTr9rSE5tS9w
         jLz4lHKkbLs+kfqnk26MyMUOXsWN2Cu/VnToZGsTgf0y1ijnz7p9Q7tOF9xao8Q5a241
         9vltD+/ByuSsc+JVQ14fNuO1XbluWALjpLrDcYsP4y5arDD2/oJgk8rhVcJgS6aSD2Im
         DVstktloyjNW+AwgszFzfySPS09V26lbAoTbSAiWahCaCNbS3+Gb/eAOmspTMOwFlbM0
         4PQ+RQ0JkdD/JnsBD7pNX1IIwWZu85in+ILzuOO2kOniJsoWO1gj7//cSUS1OjHGiwoD
         egjQ==
X-Gm-Message-State: APjAAAWZiP/D/6g8xeaCuLRKJ790gQrO2XOoWLHoDwWHYSdJQweXup1h
        WdyvLh8nPQRGtAaWAzc3vvY=
X-Google-Smtp-Source: APXvYqw8bDHul8hkgRPv/MMqG5L79aV9OtKiMy2OHKxeJUp0dpSdljt5We2xF8PyHxWd+PIbxtGsLA==
X-Received: by 2002:a63:494d:: with SMTP id y13mr31814884pgk.109.1568178758030;
        Tue, 10 Sep 2019 22:12:38 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:36 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 02/14] software node: introduce PROPERTY_ENTRY_ARRAY_XXX_LEN()
Date:   Tue, 10 Sep 2019 22:12:19 -0700
Message-Id: <20190911051231.148032-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want to initialize property entry array from a regular
pointer, when we can't determine length automatically via ARRAY_SIZE.
Let's introduce PROPERTY_ENTRY_ARRAY_XXX_LEN macros that take explicit
"len" argument.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 45 +++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 44c1704f7163..f89b930ca4b7 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -256,33 +256,44 @@ struct property_entry {
  * and structs.
  */
 
-#define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _Type_, _val_)	\
+#define PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)	\
 (struct property_entry) {						\
 	.name = _name_,							\
-	.length = ARRAY_SIZE(_val_) * sizeof(_type_),			\
+	.length = (_len_) * sizeof(_type_),				\
 	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .pointer = { ._type_##_data = _val_ } },			\
 }
 
-#define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u8, U8, _val_)
-#define PROPERTY_ENTRY_U16_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u16, U16, _val_)
-#define PROPERTY_ENTRY_U32_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u32, U32, _val_)
-#define PROPERTY_ENTRY_U64_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, U64, _val_)
+#define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
+#define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
+#define PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
+#define PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
 
-#define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
-(struct property_entry) {					\
-	.name = _name_,						\
-	.length = ARRAY_SIZE(_val_) * sizeof(const char *),	\
-	.is_array = true,					\
-	.type = DEV_PROP_STRING,				\
-	{ .pointer = { .str = _val_ } },			\
+#define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = (_len_) * sizeof(const char *),			\
+	.is_array = true,						\
+	.type = DEV_PROP_STRING,					\
+	{ .pointer = { .str = _val_ } },				\
 }
 
+#define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_U16_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_U32_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_U64_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+#define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
+	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
+
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
 (struct property_entry) {					\
 	.name = _name_,						\
-- 
2.23.0.162.g0b9fbb3734-goog

