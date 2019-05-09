Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9CFC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B70121744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l9AwUPGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfEIVOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:14:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41894 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfEIVOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so1829562pgp.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWgr+AhFO3OhKHAPV2m+8yh16a60wmBfWKOBXA4JWIU=;
        b=l9AwUPGMjJlXTw3q/c4anvpEH7Apr8aszczxsz4koZlEjHGujT/XXlhrz3pf0+sgzP
         dnAvEMxzsMC47BA4uHex5mnJOCBLJtL+VnX8D0Y0cQcuEDamqlpfp+YNaNNY8zeWE69c
         jMjclChUoCUTXBkcR2S0aGhAvt5t3ntNQtaUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWgr+AhFO3OhKHAPV2m+8yh16a60wmBfWKOBXA4JWIU=;
        b=EZrGwJJi5P8+PZddE+HiQ4U5I3YGIrZeLJ/+U8fO+7Jx9fw55fPrbxXlA7knJRJhj+
         4OjZ1JNUkTUEaz1VdxzUJE5pZDIN+VFZpK73j6rwOopfhY1u/67D7deVhjFAcstaHtIh
         i/GKCDJ2MZ8bWhbsYuAAtLGqR8JiLQLpuZd3Gdd2HtJ5mWwJ5k/6qm0cnpoiPI+K15kR
         +KI0Yhuqh++8sGyWaKd9H4oy4JhMpvbAUaXnlVyDSoxp22Yk3mOJv+8F/zXgQPwk3CHX
         iGk5aYQybiZPAqLmJi3pLU5PukKGkZw/E65nclMjIvItIX5bcMkQtRm15W3In05YKqFI
         8zdQ==
X-Gm-Message-State: APjAAAU7M6L/siP/vRgpYD3jBr8Oq7boUPzQzn/GdFpoz4VzOT27+Up/
        R6xnQ0bFDVioZT1MKCGm5vlngcQiPbM=
X-Google-Smtp-Source: APXvYqxbARVqhKLstd3ckJiRL7/+p2xHa3sntQBgb11XMfj7kEkYjGDv7msVASirpXtae93+FNtnGw==
X-Received: by 2002:a63:1460:: with SMTP id 32mr8650708pgu.319.1557436476179;
        Thu, 09 May 2019 14:14:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id a17sm4854335pff.82.2019.05.09.14.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:35 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 22/30] mfd: cros_ec: Add Smart Battery Firmware update API
Date:   Thu,  9 May 2019 14:13:45 -0700
Message-Id: <20190509211353.213194-23-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API to update battery firmware.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 73 ++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 7f98c6e63ad1..49ea905cfd18 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4243,6 +4243,79 @@ struct ec_response_battery_vendor_param {
 	uint32_t value;
 } __ec_align4;
 
+/*****************************************************************************/
+/*
+ * Smart Battery Firmware Update Commands
+ */
+#define EC_CMD_SB_FW_UPDATE 0x00B5
+
+enum ec_sb_fw_update_subcmd {
+	EC_SB_FW_UPDATE_PREPARE  = 0x0,
+	EC_SB_FW_UPDATE_INFO     = 0x1, /*query sb info */
+	EC_SB_FW_UPDATE_BEGIN    = 0x2, /*check if protected */
+	EC_SB_FW_UPDATE_WRITE    = 0x3, /*check if protected */
+	EC_SB_FW_UPDATE_END      = 0x4,
+	EC_SB_FW_UPDATE_STATUS   = 0x5,
+	EC_SB_FW_UPDATE_PROTECT  = 0x6,
+	EC_SB_FW_UPDATE_MAX      = 0x7,
+};
+
+#define SB_FW_UPDATE_CMD_WRITE_BLOCK_SIZE 32
+#define SB_FW_UPDATE_CMD_STATUS_SIZE 2
+#define SB_FW_UPDATE_CMD_INFO_SIZE 8
+
+struct ec_sb_fw_update_header {
+	uint16_t subcmd;  /* enum ec_sb_fw_update_subcmd */
+	uint16_t fw_id;   /* firmware id */
+} __ec_align4;
+
+struct ec_params_sb_fw_update {
+	struct ec_sb_fw_update_header hdr;
+	union {
+		/* EC_SB_FW_UPDATE_PREPARE  = 0x0 */
+		/* EC_SB_FW_UPDATE_INFO     = 0x1 */
+		/* EC_SB_FW_UPDATE_BEGIN    = 0x2 */
+		/* EC_SB_FW_UPDATE_END      = 0x4 */
+		/* EC_SB_FW_UPDATE_STATUS   = 0x5 */
+		/* EC_SB_FW_UPDATE_PROTECT  = 0x6 */
+		/* Those have no args */
+
+		/* EC_SB_FW_UPDATE_WRITE    = 0x3 */
+		struct __ec_align4 {
+			uint8_t  data[SB_FW_UPDATE_CMD_WRITE_BLOCK_SIZE];
+		} write;
+	};
+} __ec_align4;
+
+struct ec_response_sb_fw_update {
+	union {
+		/* EC_SB_FW_UPDATE_INFO     = 0x1 */
+		struct __ec_align1 {
+			uint8_t data[SB_FW_UPDATE_CMD_INFO_SIZE];
+		} info;
+
+		/* EC_SB_FW_UPDATE_STATUS   = 0x5 */
+		struct __ec_align1 {
+			uint8_t data[SB_FW_UPDATE_CMD_STATUS_SIZE];
+		} status;
+	};
+} __ec_align1;
+
+/*
+ * Entering Verified Boot Mode Command
+ * Default mode is VBOOT_MODE_NORMAL if EC did not receive this command.
+ * Valid Modes are: normal, developer, and recovery.
+ */
+#define EC_CMD_ENTERING_MODE 0x00B6
+
+struct ec_params_entering_mode {
+	int vboot_mode;
+} __ec_align4;
+
+#define VBOOT_MODE_NORMAL    0
+#define VBOOT_MODE_DEVELOPER 1
+#define VBOOT_MODE_RECOVERY  2
+
 /*****************************************************************************/
 /*
  * HDMI CEC commands
-- 
2.21.0.1020.gf2820cf01a-goog

