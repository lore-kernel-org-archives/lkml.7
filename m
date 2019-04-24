Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADDEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20E121907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RCR6ddV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfDXXaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:30:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39071 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbfDXXaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:30:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id e92so8289430plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oISqN0lALJiaPoY/5dc7oyf6pp9svxMWzZU6ftW5w18=;
        b=RCR6ddV7+SDClWXmz3GC+8FF5uyZDwHxgyg3+HGZz8wKsDnFBe+nCCtp67x0cdJWj6
         fY6ex5gI80xv/kE99TW3maAFx1OzPzrxF525DSkRWLOv4WJvXjLbfhZLlJlqc7Y6ZnaP
         74rLa25hxcPjvcOm8G1DxGySMtU3tErVW5+1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oISqN0lALJiaPoY/5dc7oyf6pp9svxMWzZU6ftW5w18=;
        b=Qw5KO58gzDoAofhzDbQnYd4shqSQHjs2ylXrCoMMUGRSQfQv4olL+BRsDF0OSbBxtv
         4YCi42GFPvEUU8StJ1Ae3W8ieOlNGVk/ztP9frujAU/5VtFnVaw4yoBFqqmrk1CMv/Do
         EkZ8ojULLt3V3TK8R5ZMt/LRT2fuD7UWI5b110bvlVxN9E2IaT9z/iZyhJjbLqTx/48l
         Gz6QKqtbE+tUcUy9Dvv/+rG8KRYLR5WtO2hFieBY62sJGcMFrrtghDiI2FDKJH4cFluS
         tIkykOGderIOJA5m3GcJCUP4VZBi6GESa4FGUsMabD3XjNBOcoLGHRW04Rb3456KUgop
         YrBw==
X-Gm-Message-State: APjAAAXv14yMdShGeg77RdYpaKZTaA2s8nfxWlDgYKR8J4iGOK5nes5Z
        U0I7uhl5jRA/CG3ojMfrXPdTn+Yd4/w=
X-Google-Smtp-Source: APXvYqy7RNQuMfw/X7xPfK/UodPbCs5nQyT/ea4pnC3BXhVja0MrZjl4fgqp35vzfxyQZIYA7K9XlA==
X-Received: by 2002:a17:902:2827:: with SMTP id e36mr34469610plb.45.1556148607849;
        Wed, 24 Apr 2019 16:30:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id z124sm12543961pfz.116.2019.04.24.16.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 16:30:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 30/30] mfd: cros_ec: Add Management API entry points
Date:   Wed, 24 Apr 2019 16:29:18 -0700
Message-Id: <20190424232918.243308-31-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190424232918.243308-1-gwendal@chromium.org>
References: <20190424232918.243308-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add commands for test and management.
Add command space for future development.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 113 +++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index e7f17c072d39..fa397722f17e 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -5172,6 +5172,119 @@ struct ec_params_set_cbi {
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
2.21.0.593.g511ec345e18-goog

