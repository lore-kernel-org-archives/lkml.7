Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EEFC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC402067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H9iXWx2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFEUnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:43:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42991 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:43:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so21237pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kH2tvIwU2ls26BfCFJz74j+s6XjNGAPd9Rh4Z1dVjH4=;
        b=H9iXWx2ocx/JtgZ2RjHGQbIVmSNEa7cxsw6UErWXT0TOBExrTfBF6U72DuqHf09MY9
         n5/x6/Dc8g24zwg+oHwI2shjlytkslSvy1HtXb5Q12OLaUA4zCD7+uD5KnQjEf2q+yVA
         i8w/jYS9u8jc8S0ju/tFv9Dq4Pil8x2v98YNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kH2tvIwU2ls26BfCFJz74j+s6XjNGAPd9Rh4Z1dVjH4=;
        b=culNnIqkqkVQu9W5uTDCDYoN7JZmqYBUd2VV8K2Yc5GFSxFupGp5yiGzaKkiUIB1GD
         mcynesSfsWwb4/+1JeEu1noDfmgDNBLXHuOKGYDRM9FDhZuR/zwGwTt+Rq/tfmUDiQ5k
         ah1+Xv6cWp1fqg2OQhHPvwAn9RAzMr0V4kZaczonkqDTC7dBMQmCtn5ctw/egIQ5U988
         bTcR07NQfk0riPN6j3fTEqphr3D/bn1R6R31X/m202A52NnrwBbOtlJpoACPEP/p+IGd
         ivQwMxBOLHez6nhC74RcGAT+u0BwH4opDrqyi7arF/DIgRkbUo4J1tvOX2UCUJENMVWL
         H7Wg==
X-Gm-Message-State: APjAAAURktlYWFvrWudJzauLikNWdxIL3bsKgpsWeQwmCyc3anpOQbYB
        GqifF3nPCVnH9+K2HtfLRyUePg==
X-Google-Smtp-Source: APXvYqw0RtPjrjAddCvG5oorCNxx7MTwisOIJy/yGXAtys5TX4LlNbhepwgGAhKlQk4LV0+c+hIIRg==
X-Received: by 2002:aa7:8491:: with SMTP id u17mr36195165pfn.93.1559767409871;
        Wed, 05 Jun 2019 13:43:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j20sm22313321pfi.138.2019.06.05.13.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:43:29 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] ARM: dts: rockchip: Split GPIO keys for veyron into multiple devices
Date:   Wed,  5 Jun 2019 13:43:19 -0700
Message-Id: <20190605204320.22343-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a single device DT overrides can become messy, especially when
keys are added or removed. Multiple devices also allow to
enable/disable wakeup per key/group.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../boot/dts/rk3288-veyron-chromebook.dtsi    | 26 +++++++------
 arch/arm/boot/dts/rk3288-veyron-minnie.dts    | 38 ++++++++++---------
 arch/arm/boot/dts/rk3288-veyron-pinky.dts     |  2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi          |  4 +-
 4 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index fbef34578100..c5f71af84a40 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -70,6 +70,20 @@
 		pinctrl-0 = <&ac_present_ap>;
 	};
 
+	lid_switch: lid-switch {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ap_lid_int_l>;
+		lid {
+			label = "Lid";
+			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+			linux,code = <0>; /* SW_LID */
+			linux,input-type = <5>; /* EV_SW */
+			debounce-interval = <1>;
+		};
+	};
+
 	panel: panel {
 		compatible ="innolux,n116bge", "simple-panel";
 		status = "okay";
@@ -149,18 +163,6 @@
 	status = "okay";
 };
 
-&gpio_keys {
-	pinctrl-0 = <&pwr_key_l &ap_lid_int_l>;
-	lid {
-		label = "Lid";
-		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
-		wakeup-source;
-		linux,code = <0>; /* SW_LID */
-		linux,input-type = <5>; /* EV_SW */
-		debounce-interval = <1>;
-	};
-};
-
 &pwm0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index a65099b4aef1..b2cc70a08554 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -48,6 +48,26 @@
 		regulator-boot-on;
 		vin-supply = <&vcc18_wl>;
 	};
+
+	volume_buttons: volume-buttons {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&volum_down_l &volum_up_l>;
+
+		volum_down {
+			label = "Volum_down";
+			gpios = <&gpio5 RK_PB3 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <100>;
+		};
+
+		volum_up {
+			label = "Volum_up";
+			gpios = <&gpio5 RK_PB2 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <100>;
+		};
+	};
 };
 
 &backlight {
@@ -90,24 +110,6 @@
 	pwm-off-delay-ms = <200>;
 };
 
-&gpio_keys {
-	pinctrl-0 = <&pwr_key_l &ap_lid_int_l &volum_down_l &volum_up_l>;
-
-	volum_down {
-		label = "Volum_down";
-		gpios = <&gpio5 RK_PB3 GPIO_ACTIVE_LOW>;
-		linux,code = <KEY_VOLUMEDOWN>;
-		debounce-interval = <100>;
-	};
-
-	volum_up {
-		label = "Volum_up";
-		gpios = <&gpio5 RK_PB2 GPIO_ACTIVE_LOW>;
-		linux,code = <KEY_VOLUMEUP>;
-		debounce-interval = <100>;
-	};
-};
-
 &i2c_tunnel {
 	battery: bq27500@55 {
 		compatible = "ti,bq27500";
diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
index 9645be7b3d8c..9b6f4d9b03b6 100644
--- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
@@ -35,7 +35,7 @@
 	force-hpd;
 };
 
-&gpio_keys {
+&lid_switch {
 	pinctrl-0 = <&pwr_key_h &ap_lid_int_l>;
 
 	power {
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 90c8312d01ff..cc4c3595f145 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -23,11 +23,11 @@
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
-	gpio_keys: gpio-keys {
+	power_button: power-button {
 		compatible = "gpio-keys";
-
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key_l>;
+
 		power {
 			label = "Power";
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

