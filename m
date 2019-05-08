Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170ACC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68C421479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfEHJUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:20:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42070 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfEHJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:20:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3D0A32804FA
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com
Subject: [PATCH v4 1/3] mfd: cros_ec: Update the EC feature codes
Date:   Wed,  8 May 2019 11:19:54 +0200
Message-Id: <20190508091956.5261-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508091956.5261-1-enric.balletbo@collabora.com>
References: <20190508091956.5261-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the feature enum for the Chromebook Embedded Controller to the
latest version. Some of these enums are still not used in the kernel but
we might be also interested on have these enums up to date. Userspace
can use them to query the features to the EC via the cros-ec character
device.

While here, also fix a typo in one comment in the enum.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v4:
- Removed the patch to instantiate the ISH device as was already applied.
- Rebased on top of for-mfd-next branch.

Changes in v3:
- Fix Andy Shevchenko email.

Changes in v2:
- Add a patch to introduce the required enums to build.

 include/linux/mfd/cros_ec_commands.h | 32 +++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 43bee4f7d137..d5bf909af661 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -840,7 +840,7 @@ enum ec_feature_code {
 	 * (Common Smart Battery System Interface Specification)
 	 */
 	EC_FEATURE_SMART_BATTERY = 18,
-	/* EC can dectect when the host hangs. */
+	/* EC can detect when the host hangs. */
 	EC_FEATURE_HANG_DETECT = 19,
 	/* Report power information, for pit only */
 	EC_FEATURE_PMU = 20,
@@ -852,10 +852,40 @@ enum ec_feature_code {
 	EC_FEATURE_USB_MUX = 23,
 	/* Motion Sensor code has an internal software FIFO */
 	EC_FEATURE_MOTION_SENSE_FIFO = 24,
+	/* Support temporary secure vstore */
+	EC_FEATURE_VSTORE = 25,
+	/* EC decides on USB-C SS mux state, muxes configured by host */
+	EC_FEATURE_USBC_SS_MUX_VIRTUAL = 26,
 	/* EC has RTC feature that can be controlled by host commands */
 	EC_FEATURE_RTC = 27,
+	/* The MCU exposes a Fingerprint sensor */
+	EC_FEATURE_FINGERPRINT = 28,
+	/* The MCU exposes a Touchpad */
+	EC_FEATURE_TOUCHPAD = 29,
+	/* The MCU has RWSIG task enabled */
+	EC_FEATURE_RWSIG = 30,
+	/* EC has device events support */
+	EC_FEATURE_DEVICE_EVENT = 31,
+	/* EC supports the unified wake masks for LPC/eSPI systems */
+	EC_FEATURE_UNIFIED_WAKE_MASKS = 32,
+	/* EC supports 64-bit host events */
+	EC_FEATURE_HOST_EVENT64 = 33,
+	/* EC runs code in RAM (not in place, a.k.a. XIP) */
+	EC_FEATURE_EXEC_IN_RAM = 34,
 	/* EC supports CEC commands */
 	EC_FEATURE_CEC = 35,
+	/* EC supports tight sensor timestamping. */
+	EC_FEATURE_MOTION_SENSE_TIGHT_TIMESTAMPS = 36,
+	/*
+	 * EC supports tablet mode detection aligned to Chrome and allows
+	 * setting of threshold by host command using
+	 * MOTIONSENSE_CMD_TABLET_MODE_LID_ANGLE.
+	 */
+	EC_FEATURE_REFINED_TABLET_MODE_HYSTERESIS = 37,
+	/* EC supports audio codec. */
+	EC_FEATURE_AUDIO_CODEC = 38,
+	/* EC Supports SCP. */
+	EC_FEATURE_SCP = 39,
 	/* The MCU is an Integrated Sensor Hub */
 	EC_FEATURE_ISH = 40,
 };
-- 
2.20.1

