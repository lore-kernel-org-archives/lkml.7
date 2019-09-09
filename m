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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C02C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3044320678
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB0+oaHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbfIIIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36234 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbfIIIQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id y22so8686635pfr.3;
        Mon, 09 Sep 2019 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygERPEYDl5khdxtFV71ZgBn42XfY3vLVBUhlCDUWTi8=;
        b=IB0+oaHAnB2IEqov32d4DaABRray/YsR+DTNfwBp3QyqA9tttJgXZX2rrHHI4x74zr
         UABS7aQN8+/CvZ4Hb5KIIeP0X3J55u82Ea3r0C1QRurXtS55ldXJ0ZMO/r3B24X8V+yz
         A8X8znO1tUCGFyqdQIwDizl9v26KNx+joIr03lLuT8L15RyOnlrAOmCOq8sF5WzTCYu3
         3gjR7q7dTbM1Yq2rRxoeiN/n2MQlqVgc9LcYitcejyjJqVXWtunJUmdWc1DniJuCTGvX
         TYPpJroc5fjJFqtY5mfNm6vbW2yK+VA1q6iP7zXlX5AV6FW5IQEZQCN6e+KC2EdgO5mz
         5KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygERPEYDl5khdxtFV71ZgBn42XfY3vLVBUhlCDUWTi8=;
        b=M+vS39RS+FH7hBIWc6X+ulQkI1RTr+uk5pG/KwGwN4ofpUSMSNqcgC0PS/XRSrBZ28
         D8+aBnfW3FV7gsCpYcYp8CI6rA6a/ZAPo+cKGNO0pHgUrG9hCZAUAcj+o8M6LOd39CmJ
         fiwDuaC2pKMBrMuWWUl4YvuVnp3wc62f4xGopAlYLWN3Gk5WSGfHHZJzXY6oCpXSMlvB
         vifuoLtaiw0hnR2aPwAMbRwUNT9+/dJtl2FSRczptpFR/T2KRaNprFzwTJCjenb37iGT
         c9BnpSJNq8F4WN1xSouYb1JtHj4rcZ6s3HL08+sxKlIxZ/hR4LyXsHzOvABfRA5tw2rF
         JUlA==
X-Gm-Message-State: APjAAAWUafIvLBxk8P/AqGxygIxgajnJ8+PF7LLuM45Ischykh9Ohi9/
        S+LwIvUW0PdyovnQGLMHxkM=
X-Google-Smtp-Source: APXvYqzEXckrT+EdMdUIs1QKgYUg+AgkH3qbZgV+l+UGHnMxIl2f3qG/fqXXL/LZACKoG3JPkuBq/g==
X-Received: by 2002:aa7:8b01:: with SMTP id f1mr26960241pfd.173.1568016965972;
        Mon, 09 Sep 2019 01:16:05 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:04 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 03/13] software node: get rid of property_set_pointer()
Date:   Mon,  9 Sep 2019 01:15:47 -0700
Message-Id: <20190909081557.93766-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of explicitly setting values of integer types when copying property
entries lets just copy entire value union when processing non-array values.

When handling array values assign the pointer there using the newly introduced
"raw" pointer union member. This allows us to remove property_set_pointer().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 50 +++++-----------------------------------
 include/linux/property.h |  1 +
 2 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 7bad41a8f65d..a8d12046105e 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -103,45 +103,6 @@ property_entry_get(const struct property_entry *prop, const char *name)
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
 	switch (prop->type) {
@@ -380,20 +341,21 @@ static int property_entry_copy_data(struct property_entry *dst,
 			if (!new)
 				return -ENOMEM;
 		}
+
+		dst->is_array = true;
+		dst->pointer.raw = new;
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
index 44c1704f7163..4943b40d3536 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -239,6 +239,7 @@ struct property_entry {
 			const u32 *u32_data;
 			const u64 *u64_data;
 			const char * const *str;
+			const void *raw;
 		} pointer;
 		union {
 			u8 u8_data;
-- 
2.23.0.187.g17f5b7556c-goog

