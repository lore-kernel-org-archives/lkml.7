Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45895C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1DE217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bfd/Ekf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfEIVPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:15:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42277 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfEIVOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id x15so1719175pln.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdBQmcIdU0Rz/x8vcPlOves92mcg6yTCi+x1gfv5Pak=;
        b=Bfd/Ekf2p/8ipmAOdUnSq+3U+hBLAtjV69d+L0A5aiqMeWrRbYXuREhAR3zxvuNnKY
         XW4VfFk8dw/iEMnIEvtF82oVHKPtTcEuwAElg84/cOriyZyt4kGa8XtDzC4v/Y/0v92R
         6kxrU3rQ+Ife1RHQCo35bkUNvd8mbc1xMJxnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LdBQmcIdU0Rz/x8vcPlOves92mcg6yTCi+x1gfv5Pak=;
        b=VdESadbplFrg+f7OBdOid0cvm6udCcezRcuVtpG2Dn/5S1cAwnMZ0q6wLJV0AagVj/
         U7I71C5xrI9q+S8mLaG26n6y+aKQrmBWryc1JlihHjkaYOFetTuI4MVwomc/RI53qcDf
         sQg43iuM+Kud67mCr46fCcsuMw+7/QjWfdn2JTu/JZTwho6liOquuPp5xqAqYLG6Jqi3
         JGlS6gRl5cybsfh925rnGnfAk46lSwY80HPYiL9tszeNE2QG3CbD9ibXHkwxJjjOIQG/
         Lhhu0MMy0/l6dV2qHp1Z1BxnEGMEGEo8rkAlVFQe68nN9GBmQJ93smWq6WmJM8mqSoKy
         /Ifw==
X-Gm-Message-State: APjAAAWrth7X9YLw8dwqat8q9v4Kuf5SSWm+t2JFfLWnHQxo5O8C1BBM
        xVapzsbas26HS6xSfHn0pfTLuw==
X-Google-Smtp-Source: APXvYqxbJXdzA8oxT2Bn+g8DBr4t1WTxDT7A8NncOrsx+sD74nqvfLbZIIXeJW3uwslBJ+FXKtQ/AQ==
X-Received: by 2002:a17:902:7247:: with SMTP id c7mr8290208pll.65.1557436470337;
        Thu, 09 May 2019 14:14:30 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h189sm4414601pfc.125.2019.05.09.14.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:29 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 18/30] mfd: cros_ec: Fix temperature API
Date:   Thu,  9 May 2019 14:13:41 -0700
Message-Id: <20190509211353.213194-19-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve API to retrieve temperature information.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 64 +++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index d5d07a9957ec..9a84aad7475a 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2945,9 +2945,28 @@ enum ec_temp_thresholds {
 /*
  * Thermal configuration for one temperature sensor. Temps are in degrees K.
  * Zero values will be silently ignored by the thermal task.
+ *
+ * Set 'temp_host' value allows thermal task to trigger some event with 1 degree
+ * hysteresis.
+ * For example,
+ *	temp_host[EC_TEMP_THRESH_HIGH] = 300 K
+ *	temp_host_release[EC_TEMP_THRESH_HIGH] = 0 K
+ * EC will throttle ap when temperature >= 301 K, and release throttling when
+ * temperature <= 299 K.
+ *
+ * Set 'temp_host_release' value allows thermal task has a custom hysteresis.
+ * For example,
+ *	temp_host[EC_TEMP_THRESH_HIGH] = 300 K
+ *	temp_host_release[EC_TEMP_THRESH_HIGH] = 295 K
+ * EC will throttle ap when temperature >= 301 K, and release throttling when
+ * temperature <= 294 K.
+ *
+ * Note that this structure is a sub-structure of
+ * ec_params_thermal_set_threshold_v1, but maintains its alignment there.
  */
 struct ec_thermal_config {
 	uint32_t temp_host[EC_TEMP_THRESH_COUNT]; /* levels of hotness */
+	uint32_t temp_host_release[EC_TEMP_THRESH_COUNT]; /* release levels */
 	uint32_t temp_fan_off;		/* no active cooling needed */
 	uint32_t temp_fan_max;		/* max active cooling needed */
 } __ec_align4;
@@ -2973,32 +2992,63 @@ struct ec_params_thermal_set_threshold_v1 {
 /* Toggle automatic fan control */
 #define EC_CMD_THERMAL_AUTO_FAN_CTRL 0x0052
 
-/* Get TMP006 calibration data */
+/* Version 1 of input params */
+struct ec_params_auto_fan_ctrl_v1 {
+	uint8_t fan_idx;
+} __ec_align1;
+
+/* Get/Set TMP006 calibration data */
 #define EC_CMD_TMP006_GET_CALIBRATION 0x0053
+#define EC_CMD_TMP006_SET_CALIBRATION 0x0054
+
+/*
+ * The original TMP006 calibration only needed four params, but now we need
+ * more. Since the algorithm is nothing but magic numbers anyway, we'll leave
+ * the params opaque. The v1 "get" response will include the algorithm number
+ * and how many params it requires. That way we can change the EC code without
+ * needing to update this file. We can also use a different algorithm on each
+ * sensor.
+ */
 
+/* This is the same struct for both v0 and v1. */
 struct ec_params_tmp006_get_calibration {
 	uint8_t index;
 } __ec_align1;
 
-struct ec_response_tmp006_get_calibration {
+/* Version 0 */
+struct ec_response_tmp006_get_calibration_v0 {
 	float s0;
 	float b0;
 	float b1;
 	float b2;
 } __ec_align4;
 
-/* Set TMP006 calibration data */
-#define EC_CMD_TMP006_SET_CALIBRATION 0x0054
-
-struct ec_params_tmp006_set_calibration {
+struct ec_params_tmp006_set_calibration_v0 {
 	uint8_t index;
-	uint8_t reserved[3];  /* Reserved; set 0 */
+	uint8_t reserved[3];
 	float s0;
 	float b0;
 	float b1;
 	float b2;
 } __ec_align4;
 
+/* Version 1 */
+struct ec_response_tmp006_get_calibration_v1 {
+	uint8_t algorithm;
+	uint8_t num_params;
+	uint8_t reserved[2];
+	float val[0];
+} __ec_align4;
+
+struct ec_params_tmp006_set_calibration_v1 {
+	uint8_t index;
+	uint8_t algorithm;
+	uint8_t num_params;
+	uint8_t reserved;
+	float val[0];
+} __ec_align4;
+
+
 /* Read raw TMP006 data */
 #define EC_CMD_TMP006_GET_RAW 0x0055
 
-- 
2.21.0.1020.gf2820cf01a-goog

