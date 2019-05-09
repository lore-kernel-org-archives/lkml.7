Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84479C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5735B217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zfpt5xg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEIVPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:15:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38595 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfEIVOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so1836436pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lcz1eqcuD73T/NcdIkbFXLwMtkZSGY486wHQZ5MgZj0=;
        b=Zfpt5xg3AxUyQfo8Abyg4ogJXok/St2aZrREtayCmA7BJtNKUrMRpzYLgQhVp8epax
         8X6De6AkM85K2V9mwGPumIuJ4JxnQtMTvXU5RGjInwp3/9deUJM/NvREnuT/LzCF1y91
         GofwX0UiSkq5Vx/fbHbbIFKCYEWUZ7+VXPRyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lcz1eqcuD73T/NcdIkbFXLwMtkZSGY486wHQZ5MgZj0=;
        b=POZcndEbEi0aJd/kU2hD21V3uZSe1xD5yoPBa11SlZTtAuj7lbS3IcYvnFJO9z92N+
         br9FVQ9oa0kzSZTG3SpeAsd/u0VVGgOCwLz1yCPq3POAngTDIPBd88R5rtD2FAxrjZcT
         j6yR6kSCnCXydtA1/d5SboJ3XChwBCzX5xp8Z4m7nMIcp8XNkGeoqdYGm4dGdNmHB8c5
         UOWT3x+6PoJX3rxuxfqJnT3GuqD2Q/ZDBIy1hrnhX4IVACCsNGo8kytEtc8tKWPYaiPD
         Np/BTIt385p33Xt071xMifftBU8ZXIDB4NMRavCv+/1nellb4OAvoSM/X4dFdxewgylx
         dRJw==
X-Gm-Message-State: APjAAAXlbPqkPRQxRCo2o0EUBm2FbOgmSB6dt158uiWOkDZrjcipkhCa
        tFjhVUu/LbruleDuke+TxNpqCg==
X-Google-Smtp-Source: APXvYqz042zmYNJ4m/qpAeFzE/1gR0DwW34FrcjHP7YYL9ft7HjvOA7U92isJkKJvsl71wPm4dexyQ==
X-Received: by 2002:a65:5941:: with SMTP id g1mr8699957pgu.51.1557436474785;
        Thu, 09 May 2019 14:14:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id e8sm5128546pfc.47.2019.05.09.14.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:34 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 21/30] mfd: cros_ec: Add Hibernate API
Date:   Thu,  9 May 2019 14:13:44 -0700
Message-Id: <20190509211353.213194-22-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for controlling hibernation of the Embedded Controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 72 +++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index cc054a0a4c4c..7f98c6e63ad1 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4045,6 +4045,40 @@ struct ec_params_dedicated_charger_limit {
 	uint16_t voltage_lim; /* in mV */
 } __ec_align2;
 
+/*****************************************************************************/
+/* Hibernate/Deep Sleep Commands */
+
+/* Set the delay before going into hibernation. */
+#define EC_CMD_HIBERNATION_DELAY 0x00A8
+
+struct ec_params_hibernation_delay {
+	/*
+	 * Seconds to wait in G3 before hibernate.  Pass in 0 to read the
+	 * current settings without changing them.
+	 */
+	uint32_t seconds;
+} __ec_align4;
+
+struct ec_response_hibernation_delay {
+	/*
+	 * The current time in seconds in which the system has been in the G3
+	 * state.  This value is reset if the EC transitions out of G3.
+	 */
+	uint32_t time_g3;
+
+	/*
+	 * The current time remaining in seconds until the EC should hibernate.
+	 * This value is also reset if the EC transitions out of G3.
+	 */
+	uint32_t time_remaining;
+
+	/*
+	 * The current time in seconds that the EC should wait in G3 before
+	 * hibernating.
+	 */
+	uint32_t hibernate_delay;
+} __ec_align4;
+
 /* Inform the EC when entering a sleep state */
 #define EC_CMD_HOST_SLEEP_EVENT 0x00A9
 
@@ -4052,7 +4086,9 @@ enum host_sleep_event {
 	HOST_SLEEP_EVENT_S3_SUSPEND   = 1,
 	HOST_SLEEP_EVENT_S3_RESUME    = 2,
 	HOST_SLEEP_EVENT_S0IX_SUSPEND = 3,
-	HOST_SLEEP_EVENT_S0IX_RESUME  = 4
+	HOST_SLEEP_EVENT_S0IX_RESUME  = 4,
+	/* S3 suspend with additional enabled wake sources */
+	HOST_SLEEP_EVENT_S3_WAKEABLE_SUSPEND = 5,
 };
 
 struct ec_params_host_sleep_event {
@@ -4116,6 +4152,36 @@ struct ec_response_host_sleep_event_v1 {
 	};
 } __ec_align4;
 
+/*****************************************************************************/
+/* Device events */
+#define EC_CMD_DEVICE_EVENT 0x00AA
+
+enum ec_device_event {
+	EC_DEVICE_EVENT_TRACKPAD,
+	EC_DEVICE_EVENT_DSP,
+	EC_DEVICE_EVENT_WIFI,
+};
+
+enum ec_device_event_param {
+	/* Get and clear pending device events */
+	EC_DEVICE_EVENT_PARAM_GET_CURRENT_EVENTS,
+	/* Get device event mask */
+	EC_DEVICE_EVENT_PARAM_GET_ENABLED_EVENTS,
+	/* Set device event mask */
+	EC_DEVICE_EVENT_PARAM_SET_ENABLED_EVENTS,
+};
+
+#define EC_DEVICE_EVENT_MASK(event_code) BIT(event_code % 32)
+
+struct ec_params_device_event {
+	uint32_t event_mask;
+	uint8_t param;
+} __ec_align_size1;
+
+struct ec_response_device_event {
+	uint32_t event_mask;
+} __ec_align4;
+
 /*****************************************************************************/
 /* Smart battery pass-through */
 
@@ -4361,12 +4427,14 @@ enum ec_reboot_cmd {
 	/* (command 3 was jump to RW-B) */
 	EC_REBOOT_COLD = 4,          /* Cold-reboot */
 	EC_REBOOT_DISABLE_JUMP = 5,  /* Disable jump until next reboot */
-	EC_REBOOT_HIBERNATE = 6      /* Hibernate EC */
+	EC_REBOOT_HIBERNATE = 6,     /* Hibernate EC */
+	EC_REBOOT_HIBERNATE_CLEAR_AP_OFF = 7, /* and clears AP_OFF flag */
 };
 
 /* Flags for ec_params_reboot_ec.reboot_flags */
 #define EC_REBOOT_FLAG_RESERVED0      BIT(0)  /* Was recovery request */
 #define EC_REBOOT_FLAG_ON_AP_SHUTDOWN BIT(1)  /* Reboot after AP shutdown */
+#define EC_REBOOT_FLAG_SWITCH_RW_SLOT BIT(2)  /* Switch RW slot */
 
 struct ec_params_reboot_ec {
 	uint8_t cmd;           /* enum ec_reboot_cmd */
-- 
2.21.0.1020.gf2820cf01a-goog

