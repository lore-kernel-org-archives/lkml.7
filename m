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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62F4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7955520678
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMu453yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbfIIIQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:13 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:39217 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbfIIIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:11 -0400
Received: by mail-pl1-f181.google.com with SMTP id bd8so6185411plb.6;
        Mon, 09 Sep 2019 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuGs0hz5CxIzty752gFKYk0HsyobjL4IUQwm2G4SX64=;
        b=YMu453yheSlqaOZcSDBv25kKyEMmOOnXyz7xuaMjSZro6TUTELOyphiG1vdeX7usOD
         kg7SbhTGTBTGzh5Y58/m0JOfhYQzkGz3kNaylO/KAjC2JOcoARZwL2N9uXILXZyhiDx8
         65Y6thXAoNswbzDlpEeLA7I9U1z8123uOwfRldgA0ay3OcPv7BtQ9FQk11L1GH3ASp2/
         A9iWi5xabhq5w77qoPjtrNebPu2SLPy9BqC1TeQgJGxFVS4Bf/qOnYtqADiE0Mvfesao
         GhMemqGDQlHv/aYKc6px+9cFanOHdQCQDnNCchVZ9i61knUfIpbMsybQiSjE+FOXaizb
         z8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuGs0hz5CxIzty752gFKYk0HsyobjL4IUQwm2G4SX64=;
        b=IM/nl00QRhzeyEsY/vz/FaTSvqmyHxqXWq83U2BU3uRv1yaeqbUpPS47OyPNWlxAFQ
         5NT5DlKzfhIJvjp9g7mPUf1KIRm9oqUKJM38rAvOdmAmcEi/LAPUZWMhOUeqMYOSAcT0
         x1WA4YGNqPvY6MMUVRJcRV0oHFxPepPM6LrrdmTOmhkriLfq3vtPUhqKBBDaoNgJVjgC
         g2IO/GPr7tbp7nN3V38eLvbFleRPE+0BkyFngrQZCTBhuV4J6+M5H9L1owFTGN1mdF3b
         J2YFcZIuE3+TkxCmJ6IQCEISIsNAEH9dztRIdko2SIoNv4gHq1RcDJGgeAi1QNC6Qvw4
         FUjg==
X-Gm-Message-State: APjAAAX1UJketaBVgBhcfxVgyxRM+3xFWeRFz0h+aQwJgYWaWzxS2R22
        CcJ6JN2Zr/3khoLNEpHSm6Y=
X-Google-Smtp-Source: APXvYqxUZpku1eu2kZBcGXOGS50scBfF7DPE+BRqiU68g6jFAvCpf52phqxufxvb71erV/+aD1P1Dw==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr22627115pll.179.1568016970236;
        Mon, 09 Sep 2019 01:16:10 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:08 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 06/13] software node: unify PROPERTY_ENTRY_XXX macros
Date:   Mon,  9 Sep 2019 01:15:50 -0700
Message-Id: <20190909081557.93766-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
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
 include/linux/property.h | 70 +++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 4943b40d3536..911ace267247 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -257,57 +257,47 @@ struct property_entry {
  * and structs.
  */
 
-#define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _Type_, _val_)	\
+#define PROPERTY_ENTRY_ELSIZE(_elem_)					\
+	sizeof(*(((struct property_entry *)NULL)->pointer._elem_))
+
+#define PROPERTY_ENTRY_ARRAY(_name_, _elem_, _Type_, _val_)		\
 (struct property_entry) {						\
 	.name = _name_,							\
-	.length = ARRAY_SIZE(_val_) * sizeof(_type_),			\
+	.length = ARRAY_SIZE(_val_) * PROPERTY_ENTRY_ELSIZE(_elem_),	\
 	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
-	{ .pointer = { ._type_##_data = _val_ } },			\
+	.pointer._elem_ = _val_,					\
 }
 
-#define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u8, U8, _val_)
-#define PROPERTY_ENTRY_U16_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u16, U16, _val_)
-#define PROPERTY_ENTRY_U32_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u32, U32, _val_)
-#define PROPERTY_ENTRY_U64_ARRAY(_name_, _val_)			\
-	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, U64, _val_)
-
-#define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
+#define PROPERTY_ENTRY_U8_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_ARRAY(_name_, u8_data, U8, _val_)
+#define PROPERTY_ENTRY_U16_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_ARRAY(_name_, u16_data, U16, _val_)
+#define PROPERTY_ENTRY_U32_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_ARRAY(_name_, u32_data, U32, _val_)
+#define PROPERTY_ENTRY_U64_ARRAY(_name_, _val_)				\
+	PROPERTY_ENTRY_ARRAY(_name_, u64_data, U64, _val_)
+#define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
+	PROPERTY_ENTRY_ARRAY(_name_, str, STRING, _val_)
+
+#define PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)	\
 (struct property_entry) {					\
 	.name = _name_,						\
-	.length = ARRAY_SIZE(_val_) * sizeof(const char *),	\
-	.is_array = true,					\
-	.type = DEV_PROP_STRING,				\
-	{ .pointer = { .str = _val_ } },			\
-}
-
-#define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
-(struct property_entry) {					\
-	.name = _name_,						\
-	.length = sizeof(_type_),				\
+	.length = PROPERTY_ENTRY_ELSIZE(_elem_),		\
 	.type = DEV_PROP_##_Type_,				\
-	{ .value = { ._type_##_data = _val_ } },		\
+	.value._elem_ = _val_,					\
 }
 
-#define PROPERTY_ENTRY_U8(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u8, U8, _val_)
-#define PROPERTY_ENTRY_U16(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u16, U16, _val_)
-#define PROPERTY_ENTRY_U32(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u32, U32, _val_)
-#define PROPERTY_ENTRY_U64(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
-
-#define PROPERTY_ENTRY_STRING(_name_, _val_)		\
-(struct property_entry) {				\
-	.name = _name_,					\
-	.length = sizeof(const char *),			\
-	.type = DEV_PROP_STRING,			\
-	{ .value = { .str = _val_ } },			\
-}
+#define PROPERTY_ENTRY_U8(_name_, _val_)			\
+	PROPERTY_ENTRY_ELEMENT(_name_, u8_data, U8, _val_)
+#define PROPERTY_ENTRY_U16(_name_, _val_)			\
+	PROPERTY_ENTRY_ELEMENT(_name_, u16_data, U16, _val_)
+#define PROPERTY_ENTRY_U32(_name_, _val_)			\
+	PROPERTY_ENTRY_ELEMENT(_name_, u32_data, U32, _val_)
+#define PROPERTY_ENTRY_U64(_name_, _val_)			\
+	PROPERTY_ENTRY_ELEMENT(_name_, u64_data, U64, _val_)
+#define PROPERTY_ENTRY_STRING(_name_, _val_)			\
+	PROPERTY_ENTRY_ELEMENT(_name_, str, STRING, _val_)
 
 #define PROPERTY_ENTRY_BOOL(_name_)		\
 (struct property_entry) {			\
-- 
2.23.0.187.g17f5b7556c-goog

