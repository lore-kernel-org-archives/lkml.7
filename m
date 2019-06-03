Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B761C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D87126F6F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NiY0l2sN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfFCSfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:35:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36632 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfFCSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:34:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id u22so11103269pfm.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLEHNLCnTtzmzzGN4Pzj9seKYNRaE4D6DNjUDNIU5Wo=;
        b=NiY0l2sNILSkASpJ3CDQBzbgouPeMl6e0lwQyDqpXCw5ihcfDtcN9uoR3IhKbosE5u
         Z6ybo0TTAvH/EJlY0hoyBcppk3nbon2GI56ukeqBNt9nXlXReES6ZzxbCopLJDV08Agx
         cUz2hgX8gwVAdmrYYHkJII5JiwpioZ1/dfoM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLEHNLCnTtzmzzGN4Pzj9seKYNRaE4D6DNjUDNIU5Wo=;
        b=FPdIEESikFjX+DCkIPOORfhd2UmFLNcK8EkJEju/CurT2A3splWfNCT+I9I109M0MN
         ohwxriZdSWL04dwOwqxhnGSUludV/m7vYlRudyHCHB4kRE/e+NlSzkjff9MxjcUpFacs
         rl3dG5xeEfTTXNGkmjlqX3No+Q4nV633f9Od70jA0ZXOUihoHfpocaf2Q3S/VRSRbaFV
         hAZ6bAn2nGppGKha2uvgtdqY6wrUVqQmV+htGFHGLTo+H6ugxWyfGp9Wmv8PA5FEKdQ4
         LyBv3c8E+7LsKy+HCRXWiOOynbLJE2ApdmKF0Hi4WmaAxAinVL6PJ2AwdT9F6BLpE4F6
         0OtQ==
X-Gm-Message-State: APjAAAXYgaXIqWyh57E9rWLD5noKy6HmfF/EKG/CV3FJ+Pb6E3or/AZa
        24Rh26g95F5dCZp5F149JWNuQx8MBwGOXw==
X-Google-Smtp-Source: APXvYqy9MOabyuLZ/D/AclMugSWoymgjcazoF+OWKjBDuKPOFPXSzhJ1ycz7tEKGrkz9EqKya+6Otg==
X-Received: by 2002:a65:42cd:: with SMTP id l13mr456650pgp.72.1559586880009;
        Mon, 03 Jun 2019 11:34:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id u4sm15185493pfu.26.2019.06.03.11.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:39 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 21/30] mfd: cros_ec: Add Hibernate API
Date:   Mon,  3 Jun 2019 11:33:52 -0700
Message-Id: <20190603183401.151408-22-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for controlling hibernation of the Embedded Controller.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
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

