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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BB3ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25734222BF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOKhu/Fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfIKFMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36980 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfIKFMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so10141857pfo.4;
        Tue, 10 Sep 2019 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJ3HB3kwHSQpcF0VVVgUC+yVgqtllSPS/hLFVVeWsow=;
        b=aOKhu/FgvlpfzBrVxolGRuDI6OZp2k5AAfFDQXpsl0ENWTv0I9NYoNdeL64+Ta6cll
         1Vw1IO34y08O/Q54xxcJK6KXCclvw+Zbr4DyoROYATUAfYEpPiKPqEwj2WW1yW903V7q
         qEY5IjMEJ5qx9CGaVm9/BlLWugg5HWtW6uA1hstG+lcxyC/B+so2jmVgz49NRyGLkzk2
         H5LrDqmZ6ssSIl64Zza1SVE/mTYs0gROimVZsSSi3wOHVoq+kBD8Xvysn1bWQN2FHAuE
         1rf0ZffWw6cOdwWtXomRy06HL2nRokbyKh+thAoAbW45xXontokD6sw7n++onNj3IjTR
         VqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJ3HB3kwHSQpcF0VVVgUC+yVgqtllSPS/hLFVVeWsow=;
        b=G0ddP+QcazxZiNBlu4m/kD4mGwAsspnZ5R8868ItehzENNfxk/7BKkPDy/PP9+gMHR
         HtVkzB74lD/pqpqnIkdJxoYRWPw7sKHz3SmPT6E0v4WpNvFMk+LD2oLy7plZdWhB2Wjm
         Vu4PbfOSN33SW6mG9kIP12ls8s1ylhbgusvfXOoExFGRIEzsJcVqe/9iYH2CZmk5HhVX
         rQHXzrOcGkZXhF4ieSB7uYx1xkW+jsW3E2SqoIn9R4UE0f36JUUvpxLgf4WL7e67ZfzH
         EGIkYrp4wOk5arfABknaVeasDS1EViQau7XSHcQOi/AezoKeAis5LtEMqWRJxTe8PnSS
         L0fA==
X-Gm-Message-State: APjAAAUZTSFBXmBtgXUkm5Ari6VTIq8/m1U+1se9wjs7dxwQpfrZNby+
        pyXYNnDgOALQu0pwz5WtrYo=
X-Google-Smtp-Source: APXvYqw2QQv8gFiwJYlpURrLEFteUnlxh5e/obq14T/hty9DxLVnVYJYuMFOncT17G3QffPGd29Zdw==
X-Received: by 2002:a65:6294:: with SMTP id f20mr31973683pgv.349.1568178761796;
        Tue, 10 Sep 2019 22:12:41 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:40 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 04/14] software node: mark internal macros with double underscores
Date:   Tue, 10 Sep 2019 22:12:21 -0700
Message-Id: <20190911051231.148032-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's mark PROPERTY_ENTRY_* macros that are internal with double leading
underscores so users are not tempted to use them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index f89b930ca4b7..2c9d4d209296 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -256,7 +256,7 @@ struct property_entry {
  * and structs.
  */
 
-#define PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)	\
+#define __PROPERTY_ENTRY_ARRAY_LEN(_name_, _type_, _Type_, _val_, _len_)\
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = (_len_) * sizeof(_type_),				\
@@ -266,13 +266,13 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
-	PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u8, U8, _val_, _len_)
 #define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
-	PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u16, U16, _val_, _len_)
 #define PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, _len_)		\
-	PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u32, U32, _val_, _len_)
 #define PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, _len_)		\
-	PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
+	__PROPERTY_ENTRY_ARRAY_LEN(_name_, u64, U64, _val_, _len_)
 
 #define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
 (struct property_entry) {						\
@@ -294,7 +294,7 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, ARRAY_SIZE(_val_))
 
-#define PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
+#define __PROPERTY_ENTRY_INTEGER(_name_, _type_, _Type_, _val_)	\
 (struct property_entry) {					\
 	.name = _name_,						\
 	.length = sizeof(_type_),				\
@@ -303,13 +303,13 @@ struct property_entry {
 }
 
 #define PROPERTY_ENTRY_U8(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u8, U8, _val_)
+	__PROPERTY_ENTRY_INTEGER(_name_, u8, U8, _val_)
 #define PROPERTY_ENTRY_U16(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u16, U16, _val_)
+	__PROPERTY_ENTRY_INTEGER(_name_, u16, U16, _val_)
 #define PROPERTY_ENTRY_U32(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u32, U32, _val_)
+	__PROPERTY_ENTRY_INTEGER(_name_, u32, U32, _val_)
 #define PROPERTY_ENTRY_U64(_name_, _val_)		\
-	PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
+	__PROPERTY_ENTRY_INTEGER(_name_, u64, U64, _val_)
 
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
 (struct property_entry) {				\
-- 
2.23.0.162.g0b9fbb3734-goog

