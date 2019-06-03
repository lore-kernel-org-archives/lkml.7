Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD0C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E6D26F6F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TWnU/8Br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfFCSff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:35:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36652 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfFCSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:34:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id u22so11103561pfm.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2r2J9eRYoICMAO0Mml5Lob5ih4hOJifhd0ChBanih0=;
        b=TWnU/8Br1NDLkxOhDVFWzxXEVZSNWP35rsSpFZ4kQG77SXjpQ2GPwqZBC93IYQvIhS
         YFHi6RH81TFzmW/5VmqivXikdB7llOCHt6HovdBSpuVlJH8x+z8fR/NWFPmE7TbRN5yH
         Ew033+rofC4o4/ZiVfeIOys56qQ1M9/G4+dXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2r2J9eRYoICMAO0Mml5Lob5ih4hOJifhd0ChBanih0=;
        b=SdYJETWqV4btAvSJHS6knXBciKBrGEE3PZOZKjgPtFpmMdVoBhYe6OhcF1rdu6yOUY
         TICNxAh3Vp46cfTMRxsgovOS3gcvxQ7sE5nKjEnr4dOFXiNq5PZUXkeXmNdyaoscwVfi
         12HS8KZjvoNlUe+ZVrSV8TZpkveNjxrJljjzXa95XJ19ond5/OI5/EZ5o5f7w2VV5adl
         UgVao8tWIokmx2uN9DdrM004Q8n3g3uRA//xjntNRAxSwq+XcHo7I01UZ/ppsNPAkKzf
         32hlKleEfp709ZfCHpzSsap1pj2n8tQcTQ/VPKFDAqyKqeM5TX0ekVGBbiRL17gyy65b
         VD1g==
X-Gm-Message-State: APjAAAUm/oyNE6Yn+J6/rPvpYdxnOSHX1kiqHblwqu/Mq2PVpAqfuaVF
        zvLcREJ9Jj26WUCfpIdFN6tAlw==
X-Google-Smtp-Source: APXvYqxQsBEztjKiu8yRdElQCGG16y6F4IoOxNApWgpp02hor9oJUuCHu9DzJeUBik1rcQ4q9voEdA==
X-Received: by 2002:aa7:8248:: with SMTP id e8mr33267234pfn.155.1559586892465;
        Mon, 03 Jun 2019 11:34:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id o126sm3191419pfb.134.2019.06.03.11.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:51 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 29/30] mfd: cros_ec: Add Management API entry points
Date:   Mon,  3 Jun 2019 11:34:00 -0700
Message-Id: <20190603183401.151408-30-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add commands for test and management.
Add command space for future development.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 113 +++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 860a76274334..fc8babce1576 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5176,6 +5176,119 @@ struct ec_params_set_cbi {
 	uint8_t data[];		/* For string and raw data */
 } __ec_align1;
 
+/*
+ * Information about resets of the AP by the EC and the EC's own uptime.
+ */
+#define EC_CMD_GET_UPTIME_INFO 0x0121
+
+struct ec_response_uptime_info {
+	/*
+	 * Number of milliseconds since the last EC boot. Sysjump resets
+	 * typically do not restart the EC's time_since_boot epoch.
+	 *
+	 * WARNING: The EC's sense of time is much less accurate than the AP's
+	 * sense of time, in both phase and frequency.  This timebase is similar
+	 * to CLOCK_MONOTONIC_RAW, but with 1% or more frequency error.
+	 */
+	uint32_t time_since_ec_boot_ms;
+
+	/*
+	 * Number of times the AP was reset by the EC since the last EC boot.
+	 * Note that the AP may be held in reset by the EC during the initial
+	 * boot sequence, such that the very first AP boot may count as more
+	 * than one here.
+	 */
+	uint32_t ap_resets_since_ec_boot;
+
+	/*
+	 * The set of flags which describe the EC's most recent reset.  See
+	 * include/system.h RESET_FLAG_* for details.
+	 */
+	uint32_t ec_reset_flags;
+
+	/* Empty log entries have both the cause and timestamp set to zero. */
+	struct ap_reset_log_entry {
+		/*
+		 * See include/chipset.h: enum chipset_{reset,shutdown}_reason
+		 * for details.
+		 */
+		uint16_t reset_cause;
+
+		/* Reserved for protocol growth. */
+		uint16_t reserved;
+
+		/*
+		 * The time of the reset's assertion, in milliseconds since the
+		 * last EC boot, in the same epoch as time_since_ec_boot_ms.
+		 * Set to zero if the log entry is empty.
+		 */
+		uint32_t reset_time_ms;
+	} recent_ap_reset[4];
+} __ec_align4;
+
+/*
+ * Add entropy to the device secret (stored in the rollback region).
+ *
+ * Depending on the chip, the operation may take a long time (e.g. to erase
+ * flash), so the commands are asynchronous.
+ */
+#define EC_CMD_ADD_ENTROPY	0x0122
+
+enum add_entropy_action {
+	/* Add entropy to the current secret. */
+	ADD_ENTROPY_ASYNC = 0,
+	/*
+	 * Add entropy, and also make sure that the previous secret is erased.
+	 * (this can be implemented by adding entropy multiple times until
+	 * all rolback blocks have been overwritten).
+	 */
+	ADD_ENTROPY_RESET_ASYNC = 1,
+	/* Read back result from the previous operation. */
+	ADD_ENTROPY_GET_RESULT = 2,
+};
+
+struct ec_params_rollback_add_entropy {
+	uint8_t action;
+} __ec_align1;
+
+/*
+ * Perform a single read of a given ADC channel.
+ */
+#define EC_CMD_ADC_READ		0x0123
+
+struct ec_params_adc_read {
+	uint8_t adc_channel;
+} __ec_align1;
+
+struct ec_response_adc_read {
+	int32_t adc_value;
+} __ec_align4;
+
+/*
+ * Read back rollback info
+ */
+#define EC_CMD_ROLLBACK_INFO		0x0124
+
+struct ec_response_rollback_info {
+	int32_t id; /* Incrementing number to indicate which region to use. */
+	int32_t rollback_min_version;
+	int32_t rw_rollback_version;
+} __ec_align4;
+
+
+/* Issue AP reset */
+#define EC_CMD_AP_RESET 0x0125
+
+/*****************************************************************************/
+/* The command range 0x200-0x2FF is reserved for Rotor. */
+
+/*****************************************************************************/
+/*
+ * Reserve a range of host commands for the CR51 firmware.
+ */
+#define EC_CMD_CR51_BASE 0x0300
+#define EC_CMD_CR51_LAST 0x03FF
+
 /*****************************************************************************/
 /* Fingerprint MCU commands: range 0x0400-0x040x */
 
-- 
2.21.0.1020.gf2820cf01a-goog

