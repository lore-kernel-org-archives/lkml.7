Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522C3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17580214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DzWJOh2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfDXXaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:30:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46675 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbfDXXaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:30:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so1035232pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZrj/A3WVpTWYMef2k98iej/rFBHYOv7d4tSmjQ25KQ=;
        b=DzWJOh2QSenmpm52FBOpjA44FuB1KlbUSQbJ6nqyxVsV4lJievvvT7WisJ1HmQmNRR
         dtdxhk9cQGBHXY88nE0iIM3ctGHvqziel5YjPG7ul44770UHDU1gb4w6xqK70zSSOC9i
         uAx7fyz17JalNJkpaB9kUH9tDrlmHbYgEuH+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZrj/A3WVpTWYMef2k98iej/rFBHYOv7d4tSmjQ25KQ=;
        b=dQ2AYAyNM9FNujWXsQaYs7DLn1+yma6Z5/nmdUXo1mnijStgDVshI4ZpvTWDTC4xMn
         AlzHdYvN7Q6CprCme5U0nxa3GSE72xiEU62kcu/HRjWFb/0auRszj6vEiVbhQbkP8UXQ
         6H0b6Yoe/7PsEcae4Gz3GpcjqO04imIzu8uaAKA7WG8/AAs1bcJvqt4C1Krq8Dvwv44y
         DZjqjiBRkJ7PWRH5JzLvAyT99eZcYO1/m0nWd+LMNPOIqvmgEOhbvh1IXWMuBjYKBpNI
         ERQeJ8UkLi/qVmgspA+nhGCaeFbNWEX4IZB0oucAXgxyux6WoyBOkLf+fNCUwwTWxOXE
         eyyA==
X-Gm-Message-State: APjAAAXsgUP/8dPt0vdLvvkusHiYvcxz1cqs8f+3EYHunOu7np35KwEX
        GbFYUHFv4/7ug62NYpiWD0Oztg==
X-Google-Smtp-Source: APXvYqzKzWW70qoAiZtbpd0m6vvE/OoQJaJpOGZ1gd59rREZKlSQtQAztk/26CsdJlnBCYNObfeCIw==
X-Received: by 2002:a65:51c8:: with SMTP id i8mr33134520pgq.175.1556148606537;
        Wed, 24 Apr 2019 16:30:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id l74sm36670566pfi.174.2019.04.24.16.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:30:05 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 29/30] mfd: cros_ec: Add SKU ID and Secure storage API
Date:   Wed, 24 Apr 2019 16:29:17 -0700
Message-Id: <20190424232918.243308-30-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API to store SKU, Cros board information in EC flash memory.
Add API to store security data in EC.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 107 +++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 51f75cab0608..e7f17c072d39 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1292,6 +1292,17 @@ struct ec_response_get_features {
 	uint32_t flags[2];
 } __ec_align4;
 
+/*****************************************************************************/
+/* Get the board's SKU ID from EC */
+#define EC_CMD_GET_SKU_ID 0x000E
+
+/* Set SKU ID from AP */
+#define EC_CMD_SET_SKU_ID 0x000F
+
+struct ec_sku_id_info {
+	uint32_t sku_id;
+} __ec_align4;
+
 /*****************************************************************************/
 /* Flash commands */
 
@@ -2902,6 +2913,49 @@ struct ec_response_port80_last_boot {
 	uint16_t code;
 } __ec_align2;
 
+/*****************************************************************************/
+/* Temporary secure storage for host verified boot use */
+
+/* Number of bytes in a vstore slot */
+#define EC_VSTORE_SLOT_SIZE 64
+
+/* Maximum number of vstore slots */
+#define EC_VSTORE_SLOT_MAX 32
+
+/* Get persistent storage info */
+#define EC_CMD_VSTORE_INFO 0x0049
+struct ec_response_vstore_info {
+	/* Indicates which slots are locked */
+	uint32_t slot_locked;
+	/* Total number of slots available */
+	uint8_t slot_count;
+} __ec_align_size1;
+
+/*
+ * Read temporary secure storage
+ *
+ * Response is EC_VSTORE_SLOT_SIZE bytes of data.
+ */
+#define EC_CMD_VSTORE_READ 0x004A
+
+struct ec_params_vstore_read {
+	uint8_t slot; /* Slot to read from */
+} __ec_align1;
+
+struct ec_response_vstore_read {
+	uint8_t data[EC_VSTORE_SLOT_SIZE];
+} __ec_align1;
+
+/*
+ * Write temporary secure storage and lock it.
+ */
+#define EC_CMD_VSTORE_WRITE 0x004B
+
+struct ec_params_vstore_write {
+	uint8_t slot; /* Slot to write to */
+	uint8_t data[EC_VSTORE_SLOT_SIZE];
+} __ec_align1;
+
 /*****************************************************************************/
 /* Thermal engine commands. Note that there are two implementations. We'll
  * reuse the command number, but the data and behavior is incompatible.
@@ -5065,6 +5119,59 @@ struct ec_params_efs_verify {
 	uint8_t region;		/* enum ec_flash_region */
 } __ec_align1;
 
+/*
+ * Retrieve info from Cros Board Info store. Response is based on the data
+ * type. Integers return a uint32. Strings return a string, using the response
+ * size to determine how big it is.
+ */
+#define EC_CMD_GET_CROS_BOARD_INFO	0x011F
+/*
+ * Write info into Cros Board Info on EEPROM. Write fails if the board has
+ * hardware write-protect enabled.
+ */
+#define EC_CMD_SET_CROS_BOARD_INFO	0x0120
+
+enum cbi_data_tag {
+	CBI_TAG_BOARD_VERSION = 0, /* uint32_t or smaller */
+	CBI_TAG_OEM_ID = 1,        /* uint32_t or smaller */
+	CBI_TAG_SKU_ID = 2,        /* uint32_t or smaller */
+	CBI_TAG_DRAM_PART_NUM = 3, /* variable length ascii, nul terminated. */
+	CBI_TAG_OEM_NAME = 4,      /* variable length ascii, nul terminated. */
+	CBI_TAG_MODEL_ID = 5,      /* uint32_t or smaller */
+	CBI_TAG_COUNT,
+};
+
+/*
+ * Flags to control read operation
+ *
+ * RELOAD:  Invalidate cache and read data from EEPROM. Useful to verify
+ *          write was successful without reboot.
+ */
+#define CBI_GET_RELOAD		BIT(0)
+
+struct ec_params_get_cbi {
+	uint32_t tag;		/* enum cbi_data_tag */
+	uint32_t flag;		/* CBI_GET_* */
+} __ec_align4;
+
+/*
+ * Flags to control write behavior.
+ *
+ * NO_SYNC: Makes EC update data in RAM but skip writing to EEPROM. It's
+ *          useful when writing multiple fields in a row.
+ * INIT:    Need to be set when creating a new CBI from scratch. All fields
+ *          will be initialized to zero first.
+ */
+#define CBI_SET_NO_SYNC		BIT(0)
+#define CBI_SET_INIT		BIT(1)
+
+struct ec_params_set_cbi {
+	uint32_t tag;		/* enum cbi_data_tag */
+	uint32_t flag;		/* CBI_SET_* */
+	uint32_t size;		/* Data size */
+	uint8_t data[];		/* For string and raw data */
+} __ec_align1;
+
 /*****************************************************************************/
 /* Fingerprint MCU commands: range 0x0400-0x040x */
 
-- 
2.21.0.593.g511ec345e18-goog

