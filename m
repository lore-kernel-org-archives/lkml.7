Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC6FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDE020867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 19:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="m0ppr4pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfJZT6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 15:58:09 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:50014 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfJZT6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 15:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Iu1cf5SXM1FPYlPFircUpjs1wAmVabBZQFNPF5WSCyU=; b=m0ppr4pf9iQ5MNxaulQLl6LJt9
        wvDH+AldltsHnW8/EMAjlI2iu6tdlCm3sEB91NzB/tSquPzQwvLP1CAYAMdMW8+GJTmadW9Nx2HmT
        krBU+huVkE+a7T+CSr8Wj6IDBlmnYeG1FOhdL/0oZiN2q66zhyhRxkzkNKHPzMN9BC2I=;
Received: from p5dc580b6.dip0.t-ipconnect.de ([93.197.128.182] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iOSC9-0006sL-Vc; Sat, 26 Oct 2019 21:57:54 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1iOSC9-0003pH-Cs; Sat, 26 Oct 2019 21:57:53 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 2/3] ARM: dts: add Netronix E60K02 board common file
Date:   Sat, 26 Oct 2019 21:57:47 +0200
Message-Id: <20191026195748.14562-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026195748.14562-1-andreas@kemnade.info>
References: <20191026195748.14562-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Netronix board E60K02 can be found some several Ebook-Readers,
at least the Kobo Clara HD and the Tolino Shine 3. The board
is equipped with different SoCs requiring different pinmuxes.

For now the following peripherals are included:
- LED
- Power Key
- Cover (gpio via hall sensor)
- RC5T619 PMIC (the kernel misses support for rtc and charger
  subdevices).
- Backlight via lm3630a
- Wifi sdio chip detection (mmc-powerseq and stuff)

It is based on vendor kernel but heavily reworked due to many
changed bindings.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v4:
- style cleanup, non-legacy wakeup-source
- remove pinmux-* properties

Changes in v3:
- better led name
- correct memory size
- comments about missing devices

Changes in v2:
- reordered, was 1/3
- moved pinmuxes to their actual users, not the parents
  of them
- removed some already-disabled stuff
- minor cleanups

backligt dependencies:
module autoloading:
https://patchwork.kernel.org/patch/11139987/ 
enable-gpios property (accepted and acked):
https://patchwork.kernel.org/patch/11143795/

 arch/arm/boot/dts/e60k02.dtsi | 305 ++++++++++++++++++++++++++++++++++
 1 file changed, 305 insertions(+)
 create mode 100644 arch/arm/boot/dts/e60k02.dtsi

diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
new file mode 100644
index 000000000000..97b861042789
--- /dev/null
+++ b/arch/arm/boot/dts/e60k02.dtsi
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Andreas Kemnade
+ * based on works
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * and
+ * Copyright (C) 2014 Ricoh Electronic Devices Co., Ltd
+ *
+ * Netronix E60K02 board common.
+ * This board is equipped with different SoCs and
+ * found in ebook-readers like the Kobo Clara HD (with i.MX6SLL) and
+ * the Tolino Shine 3 (with i.MX6SL)
+ */
+#include <dt-bindings/input/input.h>
+
+/ {
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+		cover {
+			label = "Cover";
+			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+			wakeup-source;
+		};
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+
+		on {
+			label = "e60k02:white:on";
+			gpios = <&gpio5 7 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+	};
+
+	memory {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reg_wifi: regulator-wifi {
+		compatible = "regulator-fixed";
+		regulator-name = "SD3_SPWR";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		post-power-on-delay-ms = <20>;
+		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	};
+};
+
+
+&i2c1 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	lm3630a: backlight@36 {
+		reg = <0x36>;
+		compatible = "ti,lm3630a";
+		enable-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			led-sources = <0>;
+			label = "backlight_warm";
+			default-brightness = <0>;
+			max-brightness = <255>;
+		};
+
+		led@1 {
+			reg = <1>;
+			led-sources = <1>;
+			label = "backlight_cold";
+			default-brightness = <0>;
+			max-brightness = <255>;
+		};
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	/* TODO: CYTTSP5 touch controller at 0x24 */
+
+	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
+
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	ricoh619: pmic@32 {
+		compatible = "ricoh,rc5t619";
+		reg = <0x32>;
+		system-power-controller;
+
+		regulators {
+			dcdc1_reg: DCDC1 {
+				regulator-name = "DCDC1";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <900000>;
+					regulator-suspend-min-microvolt = <900000>;
+				};
+			};
+
+			/* Core3_3V3 */
+			dcdc2_reg: DCDC2 {
+				regulator-name = "DCDC2";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <3300000>;
+					regulator-suspend-min-microvolt = <3300000>;
+				};
+			};
+
+			dcdc3_reg: DCDC3 {
+				regulator-name = "DCDC3";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <1140000>;
+					regulator-suspend-min-microvolt = <1140000>;
+				};
+			};
+
+			/* Core4_1V2 */
+			dcdc4_reg: DCDC4 {
+				regulator-name = "DCDC4";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <1140000>;
+					regulator-suspend-min-microvolt = <1140000>;
+				};
+			};
+
+			/* Core4_1V8 */
+			dcdc5_reg: DCDC5 {
+				regulator-name = "DCDC5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <1700000>;
+					regulator-suspend-min-microvolt = <1700000>;
+				};
+			};
+
+			/* IR_3V3 */
+			ldo1_reg: LDO1  {
+				regulator-name = "LDO1";
+				regulator-boot-on;
+			};
+
+			/* Core1_3V3 */
+			ldo2_reg: LDO2  {
+				regulator-name = "LDO2";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <3000000>;
+					regulator-suspend-min-microvolt = <3000000>;
+				};
+			};
+
+			/* Core5_1V2 */
+			ldo3_reg: LDO3  {
+				regulator-name = "LDO3";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo4_reg: LDO4 {
+				regulator-name = "LDO4";
+				regulator-boot-on;
+			};
+
+			/* SPD_3V3 */
+			ldo5_reg: LDO5 {
+				regulator-name = "LDO5";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* DDR_0V6 */
+			ldo6_reg: LDO6 {
+				regulator-name = "LDO6";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* VDD_PWM */
+			ldo7_reg: LDO7 {
+				regulator-name = "LDO7";
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			/* ldo_1v8 */
+			ldo8_reg: LDO8 {
+				regulator-name = "LDO8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			ldo9_reg: LDO9 {
+				regulator-name = "LDO9";
+				regulator-boot-on;
+			};
+
+			ldo10_reg: LDO10 {
+				regulator-name = "LDO10";
+				regulator-boot-on;
+			};
+
+			ldortc1_reg: LDORTC1  {
+				regulator-name = "LDORTC1";
+				regulator-boot-on;
+			};
+
+			ldortc2_reg: LDORTC2 {
+				regulator-name = "LDORTC2";
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
+&snvs_rtc {
+	/* we are using the rtc in the pmic, not disabled in imx6sll.dtsi */
+	status = "disabled";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usdhc2 {
+	non-removable;
+	status = "okay";
+};
+
+&usdhc3 {
+	vmmc-supply = <&reg_wifi>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	cap-power-off-card;
+	non-removable;
+	status = "okay";
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	disable-over-current;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	status = "okay";
+};
-- 
2.20.1

