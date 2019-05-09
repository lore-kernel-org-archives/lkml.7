Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2400C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9391C21744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m2IdU+IH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfEIVOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:14:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37461 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfEIVOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so1835676pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqayeGuddjPe6w5qnR/QdiK5/I13mFiipbNcBcee+Lw=;
        b=m2IdU+IH4JuKFYiT7q1VArEPfMhNxv2Ppoygv7EAYBnma3RgoVWsBBYafZirt8ZoCz
         XAVNc6ZbKCwMESG17GkLsO2yq8KL7vAznd47LzsRyroc+kLXnZJi3lANdmkeGqp0T3+q
         AeW5jhRvKHlzyR2Ib2qqWfAZjFYAGEAtucv9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqayeGuddjPe6w5qnR/QdiK5/I13mFiipbNcBcee+Lw=;
        b=VGGZqF1UAaVcwNysaJaBPuZBJymS5LcQBeEH6yS3PQTkqCkpOnnJjr7/EbFY5iLEwq
         GpnF4MDw8mPsuMKrL6tlVSWNbKh0XDRSohZ8FkJ5mBSdW/7UoAJd2gAUAru8IUysx0ss
         fPaOlBZkagXKSJkC7VsYwUlLFXmieDsvRrelLLTi9F4AiL2w1K8B5rL/0y+sppIPoODZ
         ZicFrB27qL8+g2NAGy1FGZBq1K5oXPJBaPBBi5jy8tDTzyM/OYxT8+zrEIHvu9gZRTeq
         e7cBswtVSxMmTHQZPaCOkZkBy2B2JabgxcOyvR07tFhI10jWdittuLFQcSh0Auhu+XX0
         j1qg==
X-Gm-Message-State: APjAAAXjHGGBJc7+5gYbLLIt6A3UiV8OWFw1aTH/ZKtl+b8hRcV0xoQK
        mr9sgefRVfMJ0YY2i1YajOLg7g==
X-Google-Smtp-Source: APXvYqyhfSfOht5AMuVjNtohzOfoZ0AoGJJnvZ6qhK+3yT4wzigSao1hfmWSVuEthiJ6HLDK/6sN6A==
X-Received: by 2002:a63:2b0d:: with SMTP id r13mr8757947pgr.400.1557436464210;
        Thu, 09 May 2019 14:14:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id l9sm3282655pgq.48.2019.05.09.14.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:23 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 14/30] mfd: cros_ec: Add EC transport protocol v4
Date:   Thu,  9 May 2019 14:13:37 -0700
Message-Id: <20190509211353.213194-15-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new transport procotol between EC and host.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 143 ++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 76943e64998a..40a8069a58e8 100644
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
2.21.0.1020.gf2820cf01a-goog

