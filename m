Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4440EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FE72133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lEM8zJKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfCWVRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:17:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55541 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfCWVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so5260254wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qoI9o83+l6/4OmQhWX5CLHPttjHB/zhLTa/FSwh9TRo=;
        b=lEM8zJKAqoH6SDid4TQM2o+6YFjBD7IHEcge2H/o2VkG5ri8Tk0uryW0CFNPJEj7Ab
         MG3LczTURDJbjaO3z6RoEoq2mgiw43zeQuBuh8SEXKi/ibm8/rog933vw+ufYUe3TK9/
         8t5qN8yIoOU/rtlgDBv2uEEO5HLzp0DwNrJjQoS6CozGXS/JVCiF2mB795+lwMVzsfsS
         XNaVqzUNlPbFG+Py81pOPz4wqxM87O8rbPUKT0fjbeRQW/rXgNQbwYiJVOmbVg0UI70c
         L4d/6PbfPe82N5vgddnLuv/uJLYj62B5usc7pmjAWfqCiF14RexQJ7L9syPUDOnkgsKd
         Z2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoI9o83+l6/4OmQhWX5CLHPttjHB/zhLTa/FSwh9TRo=;
        b=LMWODbPslUahiuxB9Z9PRiafGpru7KbtTNUfg7QTpBya13Pbd9A+5TgFe6khrz3+y+
         WGm3Xrl71TFTWK6e7nXu23h6g1kCPxhrZaNmFC1YiahKINHW8pmffL9HefNNoEnLWkQg
         gVyXUurLI1mw/KohB1dxjVpXbS0oXSwCxL3YjKAYei8j6VgZR78GzjRxT75FGgE4qBnY
         f6QZDHI8jQ98TiQd10EcHf+xq5VYnccNhyGRxvzGoaTziVI3ilrQ68jAYxasD5Few3Xp
         C3V74PDOyp0v2jJ8Ig7wgWKNUPRbXbwqyUbn5QvR4FuL/g6noSvRP8oYgXS8lO+5WDFp
         3oSw==
X-Gm-Message-State: APjAAAXY03KRPZlOtz5wbnGl9C6TXqrkhrVXjihNE4bc8Qn2vnf0kdqH
        s0SRI2/J+ilkQCNhiW+caWyylA==
X-Google-Smtp-Source: APXvYqz2ZDq9tnHdkY9y8F1nZyaFRvJ8FRIvcbQV0pi+FgNm/3lZqyhfh/wiHcNH+jgV69jBx1Ijsw==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr933327wmb.101.1553375861365;
        Sat, 23 Mar 2019 14:17:41 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:40 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 24/24] arm64: dts: mediatek: add pumpkin board dts
Date:   Sat, 23 Mar 2019 22:16:12 +0100
Message-Id: <20190323211612.860-25-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pumpkin board is  made by Gossamer Engineering and is using
a MediaTek SoC. The board currently comes in two available version:
MT8516 SoC and MT8167 SoC.
The board provides the following IOs: eMMC, NAND, SD card, USB type-A,
Ethernet, Wi-Fi, Bluetooth, Audio (jack out, 2 PDM port, 1 analog in),
serial over USB, and an expansion header.

Additionally there is a HDMI port, DSI port, and camera port only
on the MT8167 version of the board.

The board can be powered by battery and/or via a USB Type-C port and
is using a PMIC MT6392.

The eMMC and NAND are sharing pins and cannot be used together.

This commit is adding the basic boot support for the Pumpkin MT8516
board on the eMMC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../boot/dts/mediatek/mt8516-pumpkin.dts      |  19 ++
 .../boot/dts/mediatek/pumpkin-common.dtsi     | 210 ++++++++++++++++++
 .../dts/mediatek/pumpkin-emmc-common.dtsi     |  75 +++++++
 4 files changed, 305 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index e8f952fb279b..3c4edaec9449 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -7,3 +7,4 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
new file mode 100644
index 000000000000..016f11c6c88c
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include "pumpkin-common.dtsi"
+#include "pumpkin-emmc-common.dtsi"
+
+/ {
+	model = "Pumpkin MT8516";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
new file mode 100644
index 000000000000..79d227f28428
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "mt8516.dtsi"
+#include "mt6392.dtsi"
+
+/ {
+	gpio-keys {
+		compatible = "gpio-keys";
+		input-name = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_default>;
+
+		volume-up {
+			gpios = <&pio 42 GPIO_ACTIVE_LOW>;
+			label = "volume_up";
+			linux,code = <115>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		volume-down {
+			gpios = <&pio 43 GPIO_ACTIVE_LOW>;
+			label = "volume_down";
+			linux,code = <114>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+	};
+};
+
+&cpu0 {
+	proc-supply = <&mt6392_vproc_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6392_vproc_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6392_vproc_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6392_vproc_reg>;
+};
+
+&i2c0 {
+	clock-div = <2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	tca6416: gpio@20 {
+		compatible = "ti,tca6416";
+		reg = <0x20>;
+		rst-gpio = <&pio 65 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tca6416_pins>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		eint20_mux_sel0 {
+			gpio-hog;
+			gpios = <0 0>;
+			input;
+			line-name = "eint20_mux_sel0";
+		};
+
+		expcon_mux_sel1 {
+			gpio-hog;
+			gpios = <1 0>;
+			input;
+			line-name = "expcon_mux_sel1";
+		};
+
+		mrg_di_mux_sel2 {
+			gpio-hog;
+			gpios = <2 0>;
+			input;
+			line-name = "mrg_di_mux_sel2";
+		};
+
+		sd_sdio_mux_sel3 {
+			gpio-hog;
+			gpios = <3 0>;
+			input;
+			line-name = "sd_sdio_mux_sel3";
+		};
+
+		sd_sdio_mux_ctrl7 {
+			gpio-hog;
+			gpios = <7 0>;
+			output-low;
+			line-name = "sd_sdio_mux_ctrl7";
+		};
+
+		hw_id0 {
+			gpio-hog;
+			gpios = <8 0>;
+			input;
+			line-name = "hw_id0";
+		};
+
+		hw_id1 {
+			gpio-hog;
+			gpios = <9 0>;
+			input;
+			line-name = "hw_id1";
+		};
+
+		hw_id2 {
+			gpio-hog;
+			gpios = <10 0>;
+			input;
+			line-name = "hw_id2";
+		};
+
+		fg_int_n {
+			gpio-hog;
+			gpios = <11 0>;
+			input;
+			line-name = "fg_int_n";
+		};
+
+		usba_pwr_en {
+			gpio-hog;
+			gpios = <12 0>;
+			output-high;
+			line-name = "usba_pwr_en";
+		};
+
+		wifi_3v3_pg {
+			gpio-hog;
+			gpios = <13 0>;
+			input;
+			line-name = "wifi_3v3_pg";
+		};
+
+		cam_rst {
+			gpio-hog;
+			gpios = <14 0>;
+			output-low;
+			line-name = "cam_rst";
+		};
+
+		cam_pwdn {
+			gpio-hog;
+			gpios = <15 0>;
+			output-low;
+			line-name = "cam_pwdn";
+		};
+	};
+};
+
+&pmic {
+	interrupt-parent = <&pio>;
+	interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&pio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&state_default>;
+
+	state_default:pinconf_default {
+	};
+
+	gpio_keys_default: gpiodefault {
+		pins_cmd_dat {
+			pinmux = <MT8516_PIN_42_KPCOL0__FUNC_GPIO42>,
+				 <MT8516_PIN_43_KPCOL1__FUNC_GPIO43>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
+	i2c0_pins_a: i2c0@0 {
+		pins1 {
+			pinmux = <MT8516_PIN_58_SDA0__FUNC_SDA0_0>,
+				 <MT8516_PIN_59_SCL0__FUNC_SCL0_0>;
+			bias-disable;
+		};
+	};
+
+
+	tca6416_pins: pinmux_tca6416_pins {
+		gpio_mux_rst_n_pin {
+			pinmux = <MT8516_PIN_65_UTXD1__FUNC_GPIO65>;
+			output-high;
+		};
+
+		gpio_mux_int_n_pin {
+			pinmux = <MT8516_PIN_64_URXD1__FUNC_GPIO64>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi
new file mode 100644
index 000000000000..6044c8c91cb1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+&mmc0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	status = "okay";
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&mt6392_vemc3v3_reg>;
+	vqmmc-supply = <&mt6392_vio18_reg>;
+	non-removable;
+};
+
+&pio {
+	mmc0_pins_default: mmc0default {
+		pins_cmd_dat {
+			pinmux = <MT8516_PIN_120_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8516_PIN_119_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8516_PIN_118_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8516_PIN_117_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8516_PIN_113_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8516_PIN_112_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8516_PIN_111_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8516_PIN_110_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8516_PIN_115_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		pins_clk {
+			pinmux = <MT8516_PIN_116_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+
+		pins_rst {
+			pinmux = <MT8516_PIN_114_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0@0{
+		pins_cmd_dat {
+			pinmux = <MT8516_PIN_120_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				<MT8516_PIN_119_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				<MT8516_PIN_118_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				<MT8516_PIN_117_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				<MT8516_PIN_113_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				<MT8516_PIN_112_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				<MT8516_PIN_111_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				<MT8516_PIN_110_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				<MT8516_PIN_115_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins_clk {
+			pinmux = <MT8516_PIN_116_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins_rst {
+			pinmux = <MT8516_PIN_114_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+};
-- 
2.20.1

