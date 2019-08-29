Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0438EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F10205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EiIQFg2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfH2Lpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:45:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44428 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfH2Lpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:45:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so1446536pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 04:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUKBHjS4FWPo8D7EhI5iVHSW80bFuXbZt+g42ud8NUY=;
        b=EiIQFg2+m3onaVQ9k66bhtgENzA5qWU4uoY03f3zwXP+1uixNRUMDCMGMWfDFz5k4q
         k1MdXUslK07dASOFCYEgm5fEyzYPmLFCdQj2lv/6xeMjoYB2Q8+De9AukaFq6CDcfmAf
         UWcqqvuyT+B6rcd3hQ/8Bo8XcXdd2ga9Qd44E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUKBHjS4FWPo8D7EhI5iVHSW80bFuXbZt+g42ud8NUY=;
        b=LFEsrOAzWAzL+6Y7AUGX8j7u+gXaqnILX75VcXQ1WkFHRGtDF5RoAkDIQm2myt66aS
         Qloa78lEsb36ClGqDoWtg/aY3B5a+t2Zz7Bg1AuKCC3Uw85iVEca84j98F7i1XOhfapt
         yhHAYJiuXdzJ6n0tUGRmtAibG9swyolp4+AkuHDeTS/HC6t42p5E4AMo20Byd3jJcnBK
         U6Y8qd5p5lgmBGDkd5mAsTrImcd7YdiH6A/sulUnllKlskKrvlWI3p28vmbUIfXOB06K
         OYDBRlRMc711M7x/Htt06YbBB6D6NV/gYT1sV3FaPro/nHLKaHKcScJXku/X0TKyPkXI
         q9LQ==
X-Gm-Message-State: APjAAAUnQCsfd+sVBc856PtBWl+cTCwhYdUVrq0ym3xAxtR6AnaF/6mJ
        W6VDiGrKiKV1s8BOU4m+Zfuoqg==
X-Google-Smtp-Source: APXvYqzuhpTw98kd7KTyNTVZkdfKJQwuDX+Ei/d42OhKF11R+Oj7DyGXbahDWSAKs3T17hm+x+ByfQ==
X-Received: by 2002:a17:90a:b884:: with SMTP id o4mr9316136pjr.52.1567079153871;
        Thu, 29 Aug 2019 04:45:53 -0700 (PDT)
Received: from hungte-p920.tpe.corp.google.com ([2401:fa00:1:10:76a7:bbc0:2929:253d])
        by smtp.googlemail.com with ESMTPSA id m4sm2076887pgs.71.2019.08.29.04.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:45:53 -0700 (PDT)
From:   Hung-Te Lin <hungte@chromium.org>
Cc:     hungte@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] firmware: google: check if size is valid when decoding VPD data
Date:   Thu, 29 Aug 2019 19:45:43 +0800
Message-Id: <20190829114547.9957-1-hungte@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190829112407.GB23823@kroah.com>
References: <20190829112407.GB23823@kroah.com>
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
Changes in v3:
- Revise commit message

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

