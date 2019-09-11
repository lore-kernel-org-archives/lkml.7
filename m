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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30660ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9E4222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFoxoJEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfIKFMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32909 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfIKFMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so10912205pgn.0;
        Tue, 10 Sep 2019 22:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+lAoewH+jhsvt3QeezehbGtMBLTUm9LftrXq9l91DQ0=;
        b=VFoxoJEckEcZIGDTxpPt7UGaWMAQrO3tkzFDjvrIZMfM4bK/YZWAu9wd9ILoV0gVBV
         RmRC2FZKNa2rU/kK/Wl/yoYr/ll+BPWPlT7IiyRtH0y+n1ymHU7ZqsMVz1WZQDwegPki
         JVazvV4FNcz6T7zE6N1MtKrV7KjKzmOdEUGTbEO0RClpqMrviAhEZlW0V7Hkm3qROx4K
         OzmcZdr2x0p8+Y5NIHfCBypAvKN8ViuyqCxjhmunkMYv4wz2/JGA6wcVIgGvsI8eSjhp
         E+483k/AGkQrdjHqIiTBfdtgDWD2dgid34j1eZ9wKkmMwSgsLDD0WFx1Gxr+8GTJ0Evn
         U4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+lAoewH+jhsvt3QeezehbGtMBLTUm9LftrXq9l91DQ0=;
        b=gmxBFZ/wyjmA1at/Ixr+5RtJwOZY3cnNon1NK6y9ll3kssSfcJXeFcjetCCs/WRVN2
         tIQIhJf8rrVd7AuMwtJWSr1hBN7P2a0yKZWreNPEBh8STzRBHErdpSdCMb9jmB/GfsK9
         hKWnVcY62sczQFL9qTMmuXh5JcZAt0foh2WAC7PFhVVyZM3uf+TjQ1SBMb9nem35VMc0
         tHoL7oqC4TQYHLTXNq8+BAKM9OYdfx6i5Xg/0z1E1nvesWeAB41ghWuvPGfCDT3A9SEg
         azL4muDcmajrFpYD8MbQkAkZSErwqMulLmqBQuHv0NDD+XO5Fwe60sWTLK/ZEqV1PWUA
         cPAw==
X-Gm-Message-State: APjAAAUI4S+mYdq3MQrr4HwU3tCfm0M8ojX/ZYEMCrPjLEIv4tmqgrCN
        9eByjs9yIrKnfEZvL7hZFtQ=
X-Google-Smtp-Source: APXvYqxCtF6ozo7kQje77FWoQfLW4x1y4DZ5T4Y2lgvx2KNuRoeZ1DZU6y2TLJbsZM2AkxWOAr502g==
X-Received: by 2002:a17:90b:8d7:: with SMTP id ds23mr3254538pjb.141.1568178768687;
        Tue, 10 Sep 2019 22:12:48 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:47 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 10/14] software node: rename is_array to is_inline
Date:   Tue, 10 Sep 2019 22:12:27 -0700
Message-Id: <20190911051231.148032-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not need a special flag to know if we are dealing with an array,
as we can get that data from ratio between element length and the data
size, however we do need a flag to know whether the data is stored
directly inside property_entry or separately.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    |  9 +++++----
 include/linux/property.h | 12 +++++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 9c3e566c753e..83e2a706a86e 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -108,7 +108,7 @@ static const void *property_get_pointer(const struct property_entry *prop)
 	if (!prop->length)
 		return NULL;
 
-	if (prop->is_array)
+	if (!prop->is_inline)
 		return prop->pointer;
 
 	return &prop->value;
@@ -205,7 +205,7 @@ static void property_entry_free_data(const struct property_entry *p)
 	const char * const *src_str;
 	size_t i, nval;
 
-	if (p->is_array) {
+	if (!p->is_inline) {
 		if (p->type == DEV_PROP_STRING && p->pointer) {
 			src_str = p->pointer;
 			nval = p->length / sizeof(const char *);
@@ -250,7 +250,7 @@ static int property_entry_copy_data(struct property_entry *dst,
 	const void *pointer = property_get_pointer(src);
 	const void *new;
 
-	if (src->is_array) {
+	if (!src->is_inline) {
 		if (!src->length)
 			return -ENODATA;
 
@@ -264,15 +264,16 @@ static int property_entry_copy_data(struct property_entry *dst,
 				return -ENOMEM;
 		}
 
-		dst->is_array = true;
 		dst->pointer = new;
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
index 238e1507925f..ac7823d58cfe 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -222,15 +222,17 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
  * @length: Length of data making up the value.
- * @is_array: True when the property is an array.
+ * @is_inline: True when the property value is stored directly in
+ *     &struct property_entry instance.
  * @type: Type of the data in unions.
- * @pointer: Pointer to the property (an array of items of the given type).
- * @value: Value of the property (when it is a single item of the given type).
+ * @pointer: Pointer to the property when it is stored separately from
+ *     the &struct property_entry instance.
+ * @value: Value of the property when it is stored inline.
  */
 struct property_entry {
 	const char *name;
 	size_t length;
-	bool is_array;
+	bool is_inline;
 	enum dev_prop_type type;
 	union {
 		const void *pointer;
@@ -257,7 +259,6 @@ struct property_entry {
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = (_len_) * __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),	\
-	.is_array = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .pointer = _val_ },						\
 }
@@ -288,6 +289,7 @@ struct property_entry {
 (struct property_entry) {						\
 	.name = _name_,							\
 	.length = __PROPERTY_ENTRY_ELEMENT_SIZE(_elem_),		\
+	.is_inline = true,						\
 	.type = DEV_PROP_##_Type_,					\
 	{ .value = { ._elem_ = _val_ } },				\
 }
-- 
2.23.0.162.g0b9fbb3734-goog

