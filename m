Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C78C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1251121726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BZGGw9m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfH3CYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:24:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35622 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfH3CYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:24:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so1047291pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 19:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmqdFZq2W5NbVGJIAJOCWKV2YxcrP+ZUk1h61mL1bYU=;
        b=BZGGw9m07Y4KwMqD0JODv17E9TKwpHOIva+1t14VTjYXuYDIl2+5d//+LM0c6q+Cha
         UVO+MdLMQCUjNQp3XWVjkApBt2H4jedD/3ksqelxcg2iC3AE2twsWpVMWvQl35W+vY/l
         +Ntv0rsMRRx+mCVEbzKqW8G7TFVJcjkmt7qjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmqdFZq2W5NbVGJIAJOCWKV2YxcrP+ZUk1h61mL1bYU=;
        b=BGrbvEybXve+4rogHYRgqHlRGkGGSFxkmCnc99N0VisRJYrJZUEAwuZKj78CNYoIsm
         hNMTi9Q8+rPg8RI0sIewHfhA53LxUDWJYPD+Ow2ggwFbvNVASrahyU25fnAR8yuKeGTe
         sKPUvU0Xlyc9QExHZp5HVPQRGzlGa74Z9UQwDTFkZmU6Mks4cZchAYZ09lNeD9A8gAIG
         +px806p8bqM86JWalsDQbP3DCOzca6r8ZeoYTfW8emoK3zO3IwexqXUcQDvuGoD57uQW
         e4zYKDfiXT4GnKRIwT1o46Gf6re3XdQTvyTD2EruZDZ19XPnbEZMbhCqtRFDYV6T28c0
         Lq3A==
X-Gm-Message-State: APjAAAWYOfq0Vdccw3HXRrOO+dcxR4T00duYFwpEetmYWzd43dFIbOeB
        UECIptuQBqzezOvNIF0eEind4w==
X-Google-Smtp-Source: APXvYqz3sFecpEul92stqU55cGfX9T+dihlDF8WozVTPTdc1FIfWSr5pacvWi7dEmeDiFiUigvmhfQ==
X-Received: by 2002:a63:ee04:: with SMTP id e4mr11012732pgi.53.1567131848377;
        Thu, 29 Aug 2019 19:24:08 -0700 (PDT)
Received: from hungte-p920.tpe.corp.google.com ([2401:fa00:1:10:76a7:bbc0:2929:253d])
        by smtp.googlemail.com with ESMTPSA id s125sm4679004pfc.133.2019.08.29.19.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 19:24:07 -0700 (PDT)
From:   Hung-Te Lin <hungte@chromium.org>
Cc:     hungte@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] firmware: google: check if size is valid when decoding VPD data
Date:   Fri, 30 Aug 2019 10:23:58 +0800
Message-Id: <20190830022402.214442-1-hungte@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <5d67e673.1c69fb81.5f13b.62ee@mx.google.com>
References: <5d67e673.1c69fb81.5f13b.62ee@mx.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VPD implementation from Chromium Vital Product Data project used to
parse data from untrusted input without checking if the meta data is
invalid or corrupted. For example, the size from decoded content may
be negative value, or larger than whole input buffer. Such invalid data
may cause buffer overflow.

To fix that, the size parameters passed to vpd_decode functions should
be changed to unsigned integer (u32) type, and the parsing of entry
header should be refactored so every size field is correctly verified
before starting to decode.

Fixes: ad2ac9d5c5e0 ("firmware: Google VPD: import lib_vpd source files")
Signed-off-by: Hung-Te Lin <hungte@chromium.org>
---
Changes in v4:
- Prevent changing indent in function prototype
- Removed changes in function comments

 drivers/firmware/google/vpd.c        |  4 +-
 drivers/firmware/google/vpd_decode.c | 55 ++++++++++++++++------------
 drivers/firmware/google/vpd_decode.h |  6 +--
 3 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index 0739f3b70347..db0812263d46 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -92,8 +92,8 @@ static int vpd_section_check_key_name(const u8 *key, s32 key_len)
 	return VPD_OK;
 }
 
-static int vpd_section_attrib_add(const u8 *key, s32 key_len,
-				  const u8 *value, s32 value_len,
+static int vpd_section_attrib_add(const u8 *key, u32 key_len,
+				  const u8 *value, u32 value_len,
 				  void *arg)
 {
 	int ret;
diff --git a/drivers/firmware/google/vpd_decode.c b/drivers/firmware/google/vpd_decode.c
index 92e3258552fc..dda525c0f968 100644
--- a/drivers/firmware/google/vpd_decode.c
+++ b/drivers/firmware/google/vpd_decode.c
@@ -9,8 +9,8 @@
 
 #include "vpd_decode.h"
 
-static int vpd_decode_len(const s32 max_len, const u8 *in,
-			  s32 *length, s32 *decoded_len)
+static int vpd_decode_len(const u32 max_len, const u8 *in,
+			  u32 *length, u32 *decoded_len)
 {
 	u8 more;
 	int i = 0;
@@ -30,18 +30,39 @@ static int vpd_decode_len(const s32 max_len, const u8 *in,
 	} while (more);
 
 	*decoded_len = i;
+	return VPD_OK;
+}
+
+static int vpd_decode_entry(const u32 max_len, const u8 *input_buf,
+			    u32 *_consumed, const u8 **entry, u32 *entry_len)
+{
+	u32 decoded_len;
+	u32 consumed = *_consumed;
+
+	if (vpd_decode_len(max_len - consumed, &input_buf[consumed],
+			   entry_len, &decoded_len) != VPD_OK)
+		return VPD_FAIL;
+	if (max_len - consumed < decoded_len)
+		return VPD_FAIL;
+
+	consumed += decoded_len;
+	*entry = input_buf + consumed;
+
+	/* entry_len is untrusted data and must be checked again. */
+	if (max_len - consumed < *entry_len)
+		return VPD_FAIL;
 
+	consumed += decoded_len;
+	*_consumed = consumed;
 	return VPD_OK;
 }
 
-int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
+int vpd_decode_string(const u32 max_len, const u8 *input_buf, u32 *consumed,
 		      vpd_decode_callback callback, void *callback_arg)
 {
 	int type;
-	int res;
-	s32 key_len;
-	s32 value_len;
-	s32 decoded_len;
+	u32 key_len;
+	u32 value_len;
 	const u8 *key;
 	const u8 *value;
 
@@ -56,26 +77,14 @@ int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
 	case VPD_TYPE_STRING:
 		(*consumed)++;
 
-		/* key */
-		res = vpd_decode_len(max_len - *consumed, &input_buf[*consumed],
-				     &key_len, &decoded_len);
-		if (res != VPD_OK || *consumed + decoded_len >= max_len)
+		if (vpd_decode_entry(max_len, input_buf, consumed, &key,
+				     &key_len) != VPD_OK)
 			return VPD_FAIL;
 
-		*consumed += decoded_len;
-		key = &input_buf[*consumed];
-		*consumed += key_len;
-
-		/* value */
-		res = vpd_decode_len(max_len - *consumed, &input_buf[*consumed],
-				     &value_len, &decoded_len);
-		if (res != VPD_OK || *consumed + decoded_len > max_len)
+		if (vpd_decode_entry(max_len, input_buf, consumed, &value,
+				     &value_len) != VPD_OK)
 			return VPD_FAIL;
 
-		*consumed += decoded_len;
-		value = &input_buf[*consumed];
-		*consumed += value_len;
-
 		if (type == VPD_TYPE_STRING)
 			return callback(key, key_len, value, value_len,
 					callback_arg);
diff --git a/drivers/firmware/google/vpd_decode.h b/drivers/firmware/google/vpd_decode.h
index cf8c2ace155a..8dbe41cac599 100644
--- a/drivers/firmware/google/vpd_decode.h
+++ b/drivers/firmware/google/vpd_decode.h
@@ -25,8 +25,8 @@ enum {
 };
 
 /* Callback for vpd_decode_string to invoke. */
-typedef int vpd_decode_callback(const u8 *key, s32 key_len,
-				const u8 *value, s32 value_len,
+typedef int vpd_decode_callback(const u8 *key, u32 key_len,
+				const u8 *value, u32 value_len,
 				void *arg);
 
 /*
@@ -44,7 +44,7 @@ typedef int vpd_decode_callback(const u8 *key, s32 key_len,
  * If one entry is successfully decoded, sends it to callback and returns the
  * result.
  */
-int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
+int vpd_decode_string(const u32 max_len, const u8 *input_buf, u32 *consumed,
 		      vpd_decode_callback callback, void *callback_arg);
 
 #endif  /* __VPD_DECODE_H */
-- 
2.23.0.187.g17f5b7556c-goog

