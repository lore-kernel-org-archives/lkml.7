Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67891C3A5A7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D2822CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lgRcL1QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfH2KUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:20:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36703 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2KUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:20:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so1360070pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNZX4eqtl2El6LWT9bac5sFO3bj8HKaIdZCKDqJ8x5s=;
        b=lgRcL1QGXy+z69wlZhv+t9AFDVWDyn+OVcHqrhcKetbMCc6nkkPUzivEa5/dRurtGC
         iWkz//mI8+6v+PvhylBPDiX+auE086H8vv1Rqmto1vJLR0iBXULC7Gdw0DCpGjIQ8Glv
         DJKDNSCoGSTLAEgXuCyoToBXW96D5yHbeEwA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNZX4eqtl2El6LWT9bac5sFO3bj8HKaIdZCKDqJ8x5s=;
        b=Rbt9cAzNCAD5geMoFT7mczFebtzYN+AgLR5ZfCchhwlZEZz9th5D5zMknfAvGnpd/C
         WnDGFHRGPJw9gneQtROVnGideriKmUToUaldmuaoH5Sjlp9dGjpJnJbFxeyEMrpjktAo
         0KfISoyGmpr25VyVrcjbCmFr4YCO4cjnn5TDr/nLd6qRb7dmThrM4E33PQiMbaas4Kgn
         VBOLTB5piKIFT2SDTGv8mfU96k5lUFd9GpkgL6CFuzsqrbq4+Njh46czH5lZO76rgyRg
         jPgxiQ7hO7LU3P2+4/ntykgQ5beT1LJGkKxZlLWPberttSUkOMPBUApTQ6mc0xNcKWGU
         ucMQ==
X-Gm-Message-State: APjAAAV2nbmwWqZTwHq00xDdHjJ4wmhLf04v/ce9b62/Y9skTaBQqiIC
        jBER3GY+zNUCJf9W0k+ol6i6jA==
X-Google-Smtp-Source: APXvYqwsKk8oeaVMwvzWeXaqs+5Qhxt8m9ljjHSFlY1KhRFo36mrlFYpLVkOTHy4kZfWtmBmiVIybg==
X-Received: by 2002:a62:7912:: with SMTP id u18mr10910327pfc.254.1567074011787;
        Thu, 29 Aug 2019 03:20:11 -0700 (PDT)
Received: from hungte-p920.tpe.corp.google.com ([2401:fa00:1:10:76a7:bbc0:2929:253d])
        by smtp.googlemail.com with ESMTPSA id y10sm2156255pjp.27.2019.08.29.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 03:20:11 -0700 (PDT)
From:   Hung-Te Lin <hungte@chromium.org>
Cc:     hungte@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Allison Randal <allison@lohutok.net>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julius Werner <jwerner@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] firmware: google: update vpd_decode from upstream
Date:   Thu, 29 Aug 2019 18:19:45 +0800
Message-Id: <20190829101949.36275-1-hungte@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <525c3cdd-ba15-5898-b9de-daaa42b4b87e@roeck-us.net>
References: <525c3cdd-ba15-5898-b9de-daaa42b4b87e@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VPD implementation from Chromium Vital Product Data project used to
parse data from untrusted input without checking if there is invalid
data (for example the if the size becomes negative, or larger than whole
input buffer), which may cause buffer overflow on corrupted data.

To fix that, the upstream driver 'vpd_decode' has changed size
parameters to unsigned integer (u32), and refactored the parsing of
entry header so the size is always checked properly.

Fixes: ad2ac9d5c5e0 ("firmware: Google VPD: import lib_vpd source files")
Signed-off-by: Hung-Te Lin <hungte@chromium.org>
---
Changes in v2:
- removed renaming of enum
- prevent undoing other patches that have gone upstream.
- dropped cosmetic changes
- changed *consume to local variable

 drivers/firmware/google/vpd.c        |  4 +-
 drivers/firmware/google/vpd_decode.c | 55 ++++++++++++++++------------
 drivers/firmware/google/vpd_decode.h |  9 ++---
 3 files changed, 38 insertions(+), 30 deletions(-)

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
index 92e3258552fc..7a5b0c72db00 100644
--- a/drivers/firmware/google/vpd_decode.c
+++ b/drivers/firmware/google/vpd_decode.c
@@ -9,8 +9,8 @@
 
 #include "vpd_decode.h"
 
-static int vpd_decode_len(const s32 max_len, const u8 *in,
-			  s32 *length, s32 *decoded_len)
+static int vpd_decode_len(const u32 max_len, const u8 *in, u32 *length,
+			  u32 *decoded_len)
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
index cf8c2ace155a..b65d246a6804 100644
--- a/drivers/firmware/google/vpd_decode.h
+++ b/drivers/firmware/google/vpd_decode.h
@@ -25,15 +25,14 @@ enum {
 };
 
 /* Callback for vpd_decode_string to invoke. */
-typedef int vpd_decode_callback(const u8 *key, s32 key_len,
-				const u8 *value, s32 value_len,
-				void *arg);
+typedef int vpd_decode_callback(const u8 *key, u32 key_len, const u8 *value,
+				u32 value_len, void *arg);
 
 /*
  * vpd_decode_string
  *
  * Given the encoded string, this function invokes callback with extracted
- * (key, value). The *consumed will be plused the number of bytes consumed in
+ * (key, value). The *consumed will be plused by the number of bytes consumed in
  * this function.
  *
  * The input_buf points to the first byte of the input buffer.
@@ -44,7 +43,7 @@ typedef int vpd_decode_callback(const u8 *key, s32 key_len,
  * If one entry is successfully decoded, sends it to callback and returns the
  * result.
  */
-int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
+int vpd_decode_string(const u32 max_len, const u8 *input_buf, u32 *consumed,
 		      vpd_decode_callback callback, void *callback_arg);
 
 #endif  /* __VPD_DECODE_H */
-- 
2.23.0.187.g17f5b7556c-goog

