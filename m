Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F72DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB95214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENdZT0Lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbfDXXb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:31:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33682 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfDXX3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:29:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so10095039plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5ycYyBxsZ3VhB1S5q3MtmZFAo1/jBBWaEOMMre2Mes=;
        b=ENdZT0LgJqQrdgdF7OhmqD25SEYdkPhYhrc5ZXLyJOwE45px9CETcOSJ1I2T8fwIp4
         zuFi7Sbk3OCR66/sWR/llUz9D14+l7VDcrpO7HeYq+PJ4/UhJWCo5xI3xiBxXmDReKNQ
         sJ8vg1+N7BctPzsoNy9FQa4M4/20UZNoj4wp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5ycYyBxsZ3VhB1S5q3MtmZFAo1/jBBWaEOMMre2Mes=;
        b=DpklyTZd0QZm2ljC5Yj5hz9xhWQcNo0jkJjju28SU12R9id0XtA6bgE9UuYn67C4oJ
         Wvi6+1PgACjqLO+dgImAWrB0cuKfm0XyZftTdAsPWG+qRyfbiAvDC+4nl1mUzySkcAcu
         hduMloiFRvBmvAH5NqtXEBRR3TPtXBn/rtpq2ZPwJaIDKluWlpq+NX98iHD9weXSlaUs
         xkusfpN+3VlAQErSuy6H8qJ7EBhCtbS8BNkdm70BFKsxBSFqFqeUKBrIW8t3cW6ITln1
         Hm6Qg6PMI6Ul2Beiwm8xySD7PdM93lhB9bVpptajNTsYvo8bVMJzzWNLBDxGFRl4MtIm
         /jbA==
X-Gm-Message-State: APjAAAWW9Nod2xCqC5H05UeAe37s4Y/TB4k7C4t0ijsQCdBxSZCd7xgN
        sawZJJxVR+Rz40l0jMLrXL3s6Q==
X-Google-Smtp-Source: APXvYqxuZDAV/QP7Bgua3LeQH1Xc8Q4RTPwjdFpfpvlxG+8Z3VkojO1RSau6+nbwoPbF4EnSXRO1Sg==
X-Received: by 2002:a17:902:e208:: with SMTP id ce8mr21470609plb.99.1556148586659;
        Wed, 24 Apr 2019 16:29:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id q5sm29575597pff.97.2019.04.24.16.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:29:46 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 14/30] mfd: cros_ec: Add EC transport protocol v4
Date:   Wed, 24 Apr 2019 16:29:02 -0700
Message-Id: <20190424232918.243308-15-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new transport procotol between EC and host.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 143 ++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 29a996832af0..48e753df7e2d 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -455,7 +455,10 @@
 #define EC_LPC_STATUS_BUSY_MASK \
 	(EC_LPC_STATUS_FROM_HOST | EC_LPC_STATUS_PROCESSING)
 
-/* Host command response codes */
+/*
+ * Host command response codes (16-bit).  Note that response codes should be
+ * stored in a uint16_t rather than directly in a value of this type.
+ */
 enum ec_status {
 	EC_RES_SUCCESS = 0,
 	EC_RES_INVALID_COMMAND = 1,
@@ -471,7 +474,13 @@ enum ec_status {
 	EC_RES_OVERFLOW = 11,		/* Table / data overflow */
 	EC_RES_INVALID_HEADER = 12,     /* Header contains invalid data */
 	EC_RES_REQUEST_TRUNCATED = 13,  /* Didn't get the entire request */
-	EC_RES_RESPONSE_TOO_BIG = 14    /* Response was too big to handle */
+	EC_RES_RESPONSE_TOO_BIG = 14,   /* Response was too big to handle */
+	EC_RES_BUS_ERROR = 15,		/* Communications bus error */
+	EC_RES_BUSY = 16,		/* Up but too busy.  Should retry */
+	EC_RES_INVALID_HEADER_VERSION = 17,  /* Header version invalid */
+	EC_RES_INVALID_HEADER_CRC = 18,      /* Header CRC invalid */
+	EC_RES_INVALID_DATA_CRC = 19,        /* Data CRC invalid */
+	EC_RES_DUP_UNAVAILABLE = 20,         /* Can't resend response */
 };
 
 /*
@@ -744,6 +753,136 @@ struct ec_host_response {
 	uint16_t reserved;
 } __ec_align4;
 
+/*****************************************************************************/
+
+/*
+ * Host command protocol V4.
+ *
+ * Packets always start with a request or response header.  They are followed
+ * by data_len bytes of data.  If the data_crc_present flag is set, the data
+ * bytes are followed by a CRC-8 of that data, using using x^8 + x^2 + x + 1
+ * polynomial.
+ *
+ * Host algorithm when sending a request q:
+ *
+ * 101) tries_left=(some value, e.g. 3);
+ * 102) q.seq_num++
+ * 103) q.seq_dup=0
+ * 104) Calculate q.header_crc.
+ * 105) Send request q to EC.
+ * 106) Wait for response r.  Go to 201 if received or 301 if timeout.
+ *
+ * 201) If r.struct_version != 4, go to 301.
+ * 202) If r.header_crc mismatches calculated CRC for r header, go to 301.
+ * 203) If r.data_crc_present and r.data_crc mismatches, go to 301.
+ * 204) If r.seq_num != q.seq_num, go to 301.
+ * 205) If r.seq_dup == q.seq_dup, return success.
+ * 207) If r.seq_dup == 1, go to 301.
+ * 208) Return error.
+ *
+ * 301) If --tries_left <= 0, return error.
+ * 302) If q.seq_dup == 1, go to 105.
+ * 303) q.seq_dup = 1
+ * 304) Go to 104.
+ *
+ * EC algorithm when receiving a request q.
+ * EC has response buffer r, error buffer e.
+ *
+ * 101) If q.struct_version != 4, set e.result = EC_RES_INVALID_HEADER_VERSION
+ *      and go to 301
+ * 102) If q.header_crc mismatches calculated CRC, set e.result =
+ *      EC_RES_INVALID_HEADER_CRC and go to 301
+ * 103) If q.data_crc_present, calculate data CRC.  If that mismatches the CRC
+ *      byte at the end of the packet, set e.result = EC_RES_INVALID_DATA_CRC
+ *      and go to 301.
+ * 104) If q.seq_dup == 0, go to 201.
+ * 105) If q.seq_num != r.seq_num, go to 201.
+ * 106) If q.seq_dup == r.seq_dup, go to 205, else go to 203.
+ *
+ * 201) Process request q into response r.
+ * 202) r.seq_num = q.seq_num
+ * 203) r.seq_dup = q.seq_dup
+ * 204) Calculate r.header_crc
+ * 205) If r.data_len > 0 and data is no longer available, set e.result =
+ *      EC_RES_DUP_UNAVAILABLE and go to 301.
+ * 206) Send response r.
+ *
+ * 301) e.seq_num = q.seq_num
+ * 302) e.seq_dup = q.seq_dup
+ * 303) Calculate e.header_crc.
+ * 304) Send error response e.
+ */
+
+/* Version 4 request from host */
+struct ec_host_request4 {
+	/*
+	 * bits 0-3: struct_version: Structure version (=4)
+	 * bit    4: is_response: Is response (=0)
+	 * bits 5-6: seq_num: Sequence number
+	 * bit    7: seq_dup: Sequence duplicate flag
+	 */
+	uint8_t fields0;
+
+	/*
+	 * bits 0-4: command_version: Command version
+	 * bits 5-6: Reserved (set 0, ignore on read)
+	 * bit    7: data_crc_present: Is data CRC present after data
+	 */
+	uint8_t fields1;
+
+	/* Command code (EC_CMD_*) */
+	uint16_t command;
+
+	/* Length of data which follows this header (not including data CRC) */
+	uint16_t data_len;
+
+	/* Reserved (set 0, ignore on read) */
+	uint8_t reserved;
+
+	/* CRC-8 of above fields, using x^8 + x^2 + x + 1 polynomial */
+	uint8_t header_crc;
+} __ec_align4;
+
+/* Version 4 response from EC */
+struct ec_host_response4 {
+	/*
+	 * bits 0-3: struct_version: Structure version (=4)
+	 * bit    4: is_response: Is response (=1)
+	 * bits 5-6: seq_num: Sequence number
+	 * bit    7: seq_dup: Sequence duplicate flag
+	 */
+	uint8_t fields0;
+
+	/*
+	 * bits 0-6: Reserved (set 0, ignore on read)
+	 * bit    7: data_crc_present: Is data CRC present after data
+	 */
+	uint8_t fields1;
+
+	/* Result code (EC_RES_*) */
+	uint16_t result;
+
+	/* Length of data which follows this header (not including data CRC) */
+	uint16_t data_len;
+
+	/* Reserved (set 0, ignore on read) */
+	uint8_t reserved;
+
+	/* CRC-8 of above fields, using x^8 + x^2 + x + 1 polynomial */
+	uint8_t header_crc;
+} __ec_align4;
+
+/* Fields in fields0 byte */
+#define EC_PACKET4_0_STRUCT_VERSION_MASK	0x0f
+#define EC_PACKET4_0_IS_RESPONSE_MASK		0x10
+#define EC_PACKET4_0_SEQ_NUM_SHIFT		5
+#define EC_PACKET4_0_SEQ_NUM_MASK		0x60
+#define EC_PACKET4_0_SEQ_DUP_MASK		0x80
+
+/* Fields in fields1 byte */
+#define EC_PACKET4_1_COMMAND_VERSION_MASK	0x1f  /* (request only) */
+#define EC_PACKET4_1_DATA_CRC_PRESENT_MASK	0x80
+
 /*****************************************************************************/
 /*
  * Notes on commands:
-- 
2.21.0.593.g511ec345e18-goog

