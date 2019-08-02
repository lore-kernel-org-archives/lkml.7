Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D16DC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19893218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l33S+i3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390846AbfHBIU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:20:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43201 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728671AbfHBIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:20:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id i189so35645950pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1mPBNPR8sstmGLSbOzpoJL82ap9zoEYvV8ixk1kkH8=;
        b=l33S+i3+EQMnFGzKD+a7Zxz7kNQG7NnbakVIY3OqK5tiVE+wP82XaqLXOZluHro2Vv
         AGQ/DD6G+qcOqmqhxf8NzvXCYPgK9+cJO+eb5RFoREejum2JDKP8yh5mA0RoF1o7190R
         eqadG/CUHtFPtpKKG1sePhWYMMuyeSn1H8Qe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p1mPBNPR8sstmGLSbOzpoJL82ap9zoEYvV8ixk1kkH8=;
        b=l16/XvqJqNrMePuqRvWh3KIM9zoSsshzIs0GsCUfKpRwjQ+rOoxuEJP34o997XOghv
         ZhR4hcL+2iSBV+8koAEEqEWVR/uvhPOUyJknLTXA+NPtNZTLr0g5rEwhWuQ4bmpi4jeO
         5TpA+cztIb7TKX3BX1jwOJ4VqU8lPokAnDlzKkOHIU6sJKcQO4pITAnTEOVegZJ0dZpO
         VKlJrvCPFKpPxLWYakRnt8qVFwV+7tGpFz1ydSbi1C5ZFHuZKIIAbIEyJVMkJoMGq8sl
         3bT1kwKbRzm+udIaJf4bTLn/y70aoNToZsvaBSR0qxbgcOO5tJCkVB5k5tT/7hld1EVm
         02BA==
X-Gm-Message-State: APjAAAVy6A6Y9/xP9Gteuyp/M+ZBVHmEz7p2K6POOBOQPUsiVqrC2G4a
        IzXVElfgfoLA8RwzjonV9fnKhg==
X-Google-Smtp-Source: APXvYqwqfSmbZq0ko2w+EQpu6sW5M/YsW2jWgEua/uNtV3v3QaLldu02Jv6x3G+0CkcMUPsy0Pgqdg==
X-Received: by 2002:a17:90a:3724:: with SMTP id u33mr3133335pjb.19.1564734055258;
        Fri, 02 Aug 2019 01:20:55 -0700 (PDT)
Received: from hungte-p920.tpe.corp.google.com ([2401:fa00:1:10:76a7:bbc0:2929:253d])
        by smtp.googlemail.com with ESMTPSA id b24sm3471376pgw.66.2019.08.02.01.20.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 01:20:54 -0700 (PDT)
From:   Hung-Te Lin <hungte@chromium.org>
Cc:     hungte@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: google: update vpd_decode from upstream
Date:   Fri,  2 Aug 2019 16:20:31 +0800
Message-Id: <20190802082035.79316-1-hungte@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VPD implementation from Chromium Vital Product Data project has been
updated so vpd_decode be easily shared by kernel, firmware and the user
space utility programs. Also improved value range checks to prevent
kernel crash due to bad VPD data.

Signed-off-by: Hung-Te Lin <hungte@chromium.org>
---
 drivers/firmware/google/vpd.c        | 38 +++++++++------
 drivers/firmware/google/vpd_decode.c | 69 +++++++++++++++-------------
 drivers/firmware/google/vpd_decode.h | 17 ++++---
 3 files changed, 71 insertions(+), 53 deletions(-)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index 0739f3b70347..ecf217a7db39 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -73,7 +73,7 @@ static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
  * exporting them as sysfs attributes. These keys present in old firmwares are
  * ignored.
  *
- * Returns VPD_OK for a valid key name, VPD_FAIL otherwise.
+ * Returns VPD_DECODE_OK for a valid key name, VPD_DECODE_FAIL otherwise.
  *
  * @key: The key name to check
  * @key_len: key name length
@@ -86,14 +86,14 @@ static int vpd_section_check_key_name(const u8 *key, s32 key_len)
 		c = *key++;
 
 		if (!isalnum(c) && c != '_')
-			return VPD_FAIL;
+			return VPD_DECODE_FAIL;
 	}
 
-	return VPD_OK;
+	return VPD_DECODE_OK;
 }
 
-static int vpd_section_attrib_add(const u8 *key, s32 key_len,
-				  const u8 *value, s32 value_len,
+static int vpd_section_attrib_add(const u8 *key, u32 key_len,
+				  const u8 *value, u32 value_len,
 				  void *arg)
 {
 	int ret;
@@ -101,11 +101,11 @@ static int vpd_section_attrib_add(const u8 *key, s32 key_len,
 	struct vpd_attrib_info *info;
 
 	/*
-	 * Return VPD_OK immediately to decode next entry if the current key
-	 * name contains invalid characters.
+	 * Return VPD_DECODE_OK immediately to decode next entry if the current
+	 * key name contains invalid characters.
 	 */
-	if (vpd_section_check_key_name(key, key_len) != VPD_OK)
-		return VPD_OK;
+	if (vpd_section_check_key_name(key, key_len) != VPD_DECODE_OK)
+		return VPD_DECODE_OK;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
@@ -174,7 +174,7 @@ static int vpd_section_create_attribs(struct vpd_section *sec)
 	do {
 		ret = vpd_decode_string(sec->bin_attr.size, sec->baseaddr,
 					&consumed, vpd_section_attrib_add, sec);
-	} while (ret == VPD_OK);
+	} while (ret == VPD_DECODE_OK);
 
 	return 0;
 }
@@ -246,7 +246,7 @@ static int vpd_section_destroy(struct vpd_section *sec)
 
 static int vpd_sections_init(phys_addr_t physaddr)
 {
-	struct vpd_cbmem *temp;
+	struct vpd_cbmem __iomem *temp;
 	struct vpd_cbmem header;
 	int ret = 0;
 
@@ -254,7 +254,7 @@ static int vpd_sections_init(phys_addr_t physaddr)
 	if (!temp)
 		return -ENOMEM;
 
-	memcpy(&header, temp, sizeof(struct vpd_cbmem));
+	memcpy_fromio(&header, temp, sizeof(struct vpd_cbmem));
 	memunmap(temp);
 
 	if (header.magic != VPD_CBMEM_MAGIC)
@@ -316,7 +316,19 @@ static struct coreboot_driver vpd_driver = {
 	},
 	.tag = CB_TAG_VPD,
 };
-module_coreboot_driver(vpd_driver);
+
+static int __init coreboot_vpd_init(void)
+{
+	return coreboot_driver_register(&vpd_driver);
+}
+
+static void __exit coreboot_vpd_exit(void)
+{
+	coreboot_driver_unregister(&vpd_driver);
+}
+
+module_init(coreboot_vpd_init);
+module_exit(coreboot_vpd_exit);
 
 MODULE_AUTHOR("Google, Inc.");
 MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/google/vpd_decode.c b/drivers/firmware/google/vpd_decode.c
index 92e3258552fc..5531770e3d58 100644
--- a/drivers/firmware/google/vpd_decode.c
+++ b/drivers/firmware/google/vpd_decode.c
@@ -9,19 +9,19 @@
 
 #include "vpd_decode.h"
 
-static int vpd_decode_len(const s32 max_len, const u8 *in,
-			  s32 *length, s32 *decoded_len)
+static int vpd_decode_len(const u32 max_len, const u8 *in, u32 *length,
+			  u32 *decoded_len)
 {
 	u8 more;
 	int i = 0;
 
 	if (!length || !decoded_len)
-		return VPD_FAIL;
+		return VPD_DECODE_FAIL;
 
 	*length = 0;
 	do {
 		if (i >= max_len)
-			return VPD_FAIL;
+			return VPD_DECODE_FAIL;
 
 		more = in[i] & 0x80;
 		*length <<= 7;
@@ -30,24 +30,43 @@ static int vpd_decode_len(const s32 max_len, const u8 *in,
 	} while (more);
 
 	*decoded_len = i;
+	return VPD_DECODE_OK;
+}
+
+static int vpd_decode_entry(const u32 max_len, const u8 *input_buf,
+			    u32 *consumed, const u8 **entry, u32 *entry_len)
+{
+	u32 decoded_len;
+
+	if (vpd_decode_len(max_len - *consumed, &input_buf[*consumed],
+			   entry_len, &decoded_len) != VPD_DECODE_OK)
+		return VPD_DECODE_FAIL;
+	if (max_len - *consumed < decoded_len)
+		return VPD_DECODE_FAIL;
 
-	return VPD_OK;
+	*consumed += decoded_len;
+	*entry = input_buf + *consumed;
+
+	/* entry_len is untrusted data and must be checked again. */
+	if (max_len - *consumed < *entry_len)
+		return VPD_DECODE_FAIL;
+
+	*consumed += *entry_len;
+	return VPD_DECODE_OK;
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
 
 	/* type */
 	if (*consumed >= max_len)
-		return VPD_FAIL;
+		return VPD_DECODE_FAIL;
 
 	type = input_buf[*consumed];
 
@@ -56,25 +75,13 @@ int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
 	case VPD_TYPE_STRING:
 		(*consumed)++;
 
-		/* key */
-		res = vpd_decode_len(max_len - *consumed, &input_buf[*consumed],
-				     &key_len, &decoded_len);
-		if (res != VPD_OK || *consumed + decoded_len >= max_len)
-			return VPD_FAIL;
-
-		*consumed += decoded_len;
-		key = &input_buf[*consumed];
-		*consumed += key_len;
-
-		/* value */
-		res = vpd_decode_len(max_len - *consumed, &input_buf[*consumed],
-				     &value_len, &decoded_len);
-		if (res != VPD_OK || *consumed + decoded_len > max_len)
-			return VPD_FAIL;
+		if (vpd_decode_entry(max_len, input_buf, consumed, &key,
+				     &key_len) != VPD_DECODE_OK)
+			return VPD_DECODE_FAIL;
 
-		*consumed += decoded_len;
-		value = &input_buf[*consumed];
-		*consumed += value_len;
+		if (vpd_decode_entry(max_len, input_buf, consumed, &value,
+				     &value_len) != VPD_DECODE_OK)
+			return VPD_DECODE_FAIL;
 
 		if (type == VPD_TYPE_STRING)
 			return callback(key, key_len, value, value_len,
@@ -82,8 +89,8 @@ int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
 		break;
 
 	default:
-		return VPD_FAIL;
+		return VPD_DECODE_FAIL;
 	}
 
-	return VPD_OK;
+	return VPD_DECODE_OK;
 }
diff --git a/drivers/firmware/google/vpd_decode.h b/drivers/firmware/google/vpd_decode.h
index cf8c2ace155a..4113ac2f4a70 100644
--- a/drivers/firmware/google/vpd_decode.h
+++ b/drivers/firmware/google/vpd_decode.h
@@ -13,28 +13,27 @@
 #include <linux/types.h>
 
 enum {
-	VPD_OK = 0,
-	VPD_FAIL,
+	VPD_DECODE_OK = 0,
+	VPD_DECODE_FAIL = 1,
 };
 
 enum {
 	VPD_TYPE_TERMINATOR = 0,
 	VPD_TYPE_STRING,
-	VPD_TYPE_INFO                = 0xfe,
+	VPD_TYPE_INFO = 0xfe,
 	VPD_TYPE_IMPLICIT_TERMINATOR = 0xff,
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
- * this function.
+ * (key, value). The *consumed will be incremented by the number of bytes
+ * consumed in this function.
  *
  * The input_buf points to the first byte of the input buffer.
  *
@@ -44,7 +43,7 @@ typedef int vpd_decode_callback(const u8 *key, s32 key_len,
  * If one entry is successfully decoded, sends it to callback and returns the
  * result.
  */
-int vpd_decode_string(const s32 max_len, const u8 *input_buf, s32 *consumed,
+int vpd_decode_string(const u32 max_len, const u8 *input_buf, u32 *consumed,
 		      vpd_decode_callback callback, void *callback_arg);
 
 #endif  /* __VPD_DECODE_H */
-- 
2.22.0.770.g0f2c4a37fd-goog

