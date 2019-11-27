Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA08206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TrsX5k8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfK0WjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:39:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45733 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfK0WjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:39:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so11903156pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 14:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwZST5J1ZXXWPFjxfqsSyJPwbkM2mp88nHoR9Gx8qNY=;
        b=TrsX5k8AQ7EVewP4n6MEXNcVprRJ246FtF2lut7Zqtt3KVYXmrfe+76wnYVtLYSyRs
         qCTUTsvzljQQIQY4oxD0HZU6fmpVZ9grIMPgVFQksEDRJs5ObdqWEKwJVEegAvm9TM1/
         dvidJgzpeank7/wVVFzWEdGQvAjPDuvtAqum4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwZST5J1ZXXWPFjxfqsSyJPwbkM2mp88nHoR9Gx8qNY=;
        b=eQKqGJDqn+RypaQ6b3z0K0D2XE3QYUWlExXwHy0RnYAwBO7K7CHTA9Myy4V1c3xsQu
         FLBNyIJiTtrz45rCIq0gAtzhzhZ5WjHNOHzQtaPTzvZUlhKI5PPHi/Pj54zTLwFNjY8q
         RU9cdTSsHOk2avhuqL/aRQ+G3Z8RWVqtWzsP5AU7/b5d1Je2IdBKHQFoq9GYNob7lF+s
         o2IrkRFMyWnAV8/OqveVrKweLoY5wyFoAVrPsqZUCI9LA869W6NCs5LNBT36jqi41eux
         FJJre6qYSQxGvlCs2sS0+gGaqZwjzt49gerLeKXcTVroYCmzpa87II+uu05Kc9fk4s0+
         BFlQ==
X-Gm-Message-State: APjAAAXkv6isjEPgnoB0Z8+/ERteBpVcx9EnMEePbrQQ8AnM8+0z9dMo
        WCpj/NE2qHRgONOc8gb5fzmbtQ==
X-Google-Smtp-Source: APXvYqzbzGsXhO6TNMd3JvRS9MIlyRDrBlBaJod42zrLybNDKVb7fIus5HRTIZ7CExUGwwnEmY2QVg==
X-Received: by 2002:a63:465b:: with SMTP id v27mr7768220pgk.257.1574894359653;
        Wed, 27 Nov 2019 14:39:19 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id d6sm17699992pfn.32.2019.11.27.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 14:39:19 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/1] ARM: dts: rockchip: Add brcm bluetooth for rk3288-veyron
Date:   Wed, 27 Nov 2019 14:39:09 -0800
Message-Id: <20191127223909.253873-2-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
In-Reply-To: <20191127223909.253873-1-abhishekpandit@chromium.org>
References: <20191127223909.253873-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the Broadcom uart bluetooth driver on uart0 and gives it
ownership of its gpios. In order to use this, you must enable the
following kconfig options:
- CONFIG_BT_HCIUART_BCM
- CONFIG_SERIAL_DEV

This is applicable to rk3288-veyron series boards that use the bcm43540
wifi+bt chips.

As part of this change, also refactor the pinctrl across the various
boards. All the boards using broadcom bluetooth shouldn't touch the
bt_dev_wake pin.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
- Changed sco routing params to brcm,bt-pcm-int-params

 arch/arm/boot/dts/rk3288-veyron-brain.dts     |  9 +++
 .../dts/rk3288-veyron-broadcom-bluetooth.dtsi | 22 +++++++
 .../boot/dts/rk3288-veyron-chromebook.dtsi    | 21 -------
 arch/arm/boot/dts/rk3288-veyron-fievel.dts    |  2 -
 arch/arm/boot/dts/rk3288-veyron-jaq.dts       | 22 +++++++
 arch/arm/boot/dts/rk3288-veyron-jerry.dts     | 22 +++++++
 arch/arm/boot/dts/rk3288-veyron-mickey.dts    |  9 +++
 arch/arm/boot/dts/rk3288-veyron-minnie.dts    | 21 +++++++
 arch/arm/boot/dts/rk3288-veyron-pinky.dts     | 22 +++++++
 arch/arm/boot/dts/rk3288-veyron-speedy.dts    | 21 +++++++
 arch/arm/boot/dts/rk3288-veyron.dtsi          | 59 +++----------------
 11 files changed, 155 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi

diff --git a/arch/arm/boot/dts/rk3288-veyron-brain.dts b/arch/arm/boot/dts/rk3288-veyron-brain.dts
index 406146cbff29..aa33d09184ad 100644
--- a/arch/arm/boot/dts/rk3288-veyron-brain.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-brain.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "rk3288-veyron.dtsi"
+#include "rk3288-veyron-broadcom-bluetooth.dtsi"
 
 / {
 	model = "Google Brain";
@@ -40,6 +41,14 @@
 };
 
 &pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+	>;
+
 	hdmi {
 		vcc50_hdmi_en: vcc50-hdmi-en {
 			rockchip,pins = <7 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi b/arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi
new file mode 100644
index 000000000000..a10d25ac8f7b
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Veyron (and derivatives) fragment for the Broadcom 43450 bluetooth
+ * chip.
+ *
+ * Copyright 2019 Google, Inc
+ */
+
+&uart0 {
+	bluetooth {
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_l>, <&bt_enable_l>,
+			    <&bt_dev_wake>;
+
+		compatible = "brcm,bcm43540-bt";
+		host-wakeup-gpios	= <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios		= <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios	= <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+		max-speed		= <3000000>;
+		brcm,bt-pcm-int-params	= [01 02 00 01 01];
+	};
+};
diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index ffb60f880b39..05112c25176d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -136,27 +136,6 @@
 };
 
 &pinctrl {
-	pinctrl-0 = <
-		/* Common for sleep and wake, but no owners */
-		&ddr0_retention
-		&ddrio_pwroff
-		&global_pwroff
-
-		/* Wake only */
-		&suspend_l_wake
-		&bt_dev_wake_awake
-	>;
-	pinctrl-1 = <
-		/* Common for sleep and wake, but no owners */
-		&ddr0_retention
-		&ddrio_pwroff
-		&global_pwroff
-
-		/* Sleep only */
-		&suspend_l_sleep
-		&bt_dev_wake_sleep
-	>;
-
 	buttons {
 		ap_lid_int_l: ap-lid-int-l {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-fievel.dts b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
index 9a0f55085839..7e7ef8e06b8d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-fievel.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
@@ -18,8 +18,6 @@
 		     "google,veyron-fievel-rev0", "google,veyron-fievel",
 		     "google,veyron", "rockchip,rk3288";
 
-	/delete-node/ bt-activity;
-
 	vccsys: vccsys {
 		compatible = "regulator-fixed";
 		regulator-name = "vccsys";
diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index a4966e505a2f..171ba6185b6d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -273,6 +273,28 @@
 };
 
 &pinctrl {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Wake only */
+		&suspend_l_wake
+		&bt_dev_wake_awake
+	>;
+	pinctrl-1 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Sleep only */
+		&suspend_l_sleep
+		&bt_dev_wake_sleep
+	>;
+
 	buck-5v {
 		drv_5v: drv-5v {
 			rockchip,pins = <7 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
index a6ee44f0fe13..66f00d28801a 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
@@ -418,6 +418,28 @@
 };
 
 &pinctrl {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Wake only */
+		&suspend_l_wake
+		&bt_dev_wake_awake
+	>;
+	pinctrl-1 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Sleep only */
+		&suspend_l_sleep
+		&bt_dev_wake_sleep
+	>;
+
 	buck-5v {
 		drv_5v: drv-5v {
 			rockchip,pins = <7 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index 06a6a9554c48..ffd1121d19be 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "rk3288-veyron.dtsi"
+#include "rk3288-veyron-broadcom-bluetooth.dtsi"
 
 / {
 	model = "Google Mickey";
@@ -411,6 +412,14 @@
 };
 
 &pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+	>;
+
 	hdmi {
 		power_hdmi_on: power-hdmi-on {
 			rockchip,pins = <7 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index c833716dbe48..39f76e02875f 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "rk3288-veyron-chromebook.dtsi"
+#include "rk3288-veyron-broadcom-bluetooth.dtsi"
 
 / {
 	model = "Google Minnie";
@@ -344,6 +345,26 @@
 };
 
 &pinctrl {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Wake only */
+		&suspend_l_wake
+	>;
+	pinctrl-1 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Sleep only */
+		&suspend_l_sleep
+	>;
+
 	buck-5v {
 		drv_5v: drv-5v {
 			rockchip,pins = <7 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
index f420499f300a..71e6629cc208 100644
--- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
@@ -64,6 +64,28 @@
 };
 
 &pinctrl {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Wake only */
+		&suspend_l_wake
+		&bt_dev_wake_awake
+	>;
+	pinctrl-1 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Sleep only */
+		&suspend_l_sleep
+		&bt_dev_wake_sleep
+	>;
+
 	/delete-node/ lcd;
 
 	backlight {
diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
index 2f2989bc3f9c..e354c61a45e7 100644
--- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "rk3288-veyron-chromebook.dtsi"
+#include "rk3288-veyron-broadcom-bluetooth.dtsi"
 #include "cros-ec-sbs.dtsi"
 
 / {
@@ -279,6 +280,26 @@
 };
 
 &pinctrl {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Wake only */
+		&suspend_l_wake
+	>;
+	pinctrl-1 = <
+		/* Common for sleep and wake, but no owners */
+		&ddr0_retention
+		&ddrio_pwroff
+		&global_pwroff
+
+		/* Sleep only */
+		&suspend_l_sleep
+	>;
+
 	buck-5v {
 		drv_5v: drv-5v {
 			rockchip,pins = <7 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 7525e3dd1fc1..54a6838d73f5 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -23,30 +23,6 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
-	bt_activity: bt-activity {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_host_wake>;
-
-		/*
-		 * HACK: until we have an LPM driver, we'll use an
-		 * ugly GPIO key to allow Bluetooth to wake from S3.
-		 * This is expected to only be used by BT modules that
-		 * use UART for comms.  For BT modules that talk over
-		 * SDIO we should use a wakeup mechanism related to SDIO.
-		 *
-		 * Use KEY_RESERVED here since that will work as a wakeup but
-		 * doesn't get reported to higher levels (so doesn't confuse
-		 * Chrome).
-		 */
-		bt-wake {
-			label = "BT Wakeup";
-			gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
-			linux,code = <KEY_RESERVED>;
-			wakeup-source;
-		};
-
-	};
 
 	power_button: power-button {
 		compatible = "gpio-keys";
@@ -82,22 +58,17 @@
 		clocks = <&rk808 RK808_CLKOUT1>;
 		clock-names = "ext_clock";
 		pinctrl-names = "default";
-		pinctrl-0 = <&bt_enable_l>, <&wifi_enable_h>;
+		pinctrl-0 = <&wifi_enable_h>;
 
 		/*
-		 * Depending on the actual card populated GPIO4 D4 and D5
+		 * Depending on the actual card populated GPIO4 D4
 		 * correspond to one of these signals on the module:
 		 *
 		 * D4:
 		 * - SDIO_RESET_L_WL_REG_ON
 		 * - PDN (power down when low)
-		 *
-		 * D5:
-		 * - BT_I2S_WS_BT_RFDISABLE_L
-		 * - No connect
 		 */
-		reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>,
-			      <&gpio4 RK_PD5 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
 	};
 
 	vcc_5v: vcc-5v {
@@ -481,26 +452,6 @@
 };
 
 &pinctrl {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <
-		/* Common for sleep and wake, but no owners */
-		&ddr0_retention
-		&ddrio_pwroff
-		&global_pwroff
-
-		/* Wake only */
-		&bt_dev_wake_awake
-	>;
-	pinctrl-1 = <
-		/* Common for sleep and wake, but no owners */
-		&ddr0_retention
-		&ddrio_pwroff
-		&global_pwroff
-
-		/* Sleep only */
-		&bt_dev_wake_sleep
-	>;
-
 	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
 		bias-disable;
 		drive-strength = <8>;
@@ -622,6 +573,10 @@
 		bt_dev_wake_awake: bt-dev-wake-awake {
 			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_output_high>;
 		};
+
+		bt_dev_wake: bt-dev-wake {
+			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 
 	tpm {
-- 
2.24.0.432.g9d3f5f5b63-goog

