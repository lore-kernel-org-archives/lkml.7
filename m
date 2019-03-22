Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B2D21841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BEdj+0/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCVTnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:43:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38882 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfCVTnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:43:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so2210687pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYqFr+nokroCQk0GfZJrc/hecYrDnUnpegApq5u6l48=;
        b=BEdj+0/kyZwUnAi9/1kT2d/WMYKs3Law/tm6RkJQGfFFNOTcBVyi3G3Bx6KYmhHrGj
         IoS399l7qbQ55yonn2J/kjLrkEd3VnpwpoDmq96A1atqjsl/Fbzf2dN5KpizgbXOHIb/
         McyfVCAO3wxN4DlFBtD/Rs8W/p0fWXUZpSX10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYqFr+nokroCQk0GfZJrc/hecYrDnUnpegApq5u6l48=;
        b=q4H1WL53b1zChkBjKFIDu7Uv0nQMn3xszjdZVp3D2QK5uvNadoMtHjTRcZOYg2x/qy
         GhFgERmmBc2QCusz370tE2XA9HmulAU7Q8BFSOJPfOrj2a0p+GksyUiG6E2xEzSEw2Dt
         sAh4PdEtbrZwO7HKb/7hBRT9q53S8GcNFUQuoq6Qg2piRgUrOT6yCgLwgUapPv5jYoe6
         i9HM4KXKmZq2HXqX7SHeM9gLR4MBS88bB9I928Mb1AuIfscr6boEv5VtG/nNKyWH7lqf
         Gf9DMSFzQnNNHhOvJ4TFvyJ9l/yETqigvICr9OjpgoUZ1gbWYpnJl9tYV9PwVLgO4fDn
         SPzA==
X-Gm-Message-State: APjAAAVCRDp/y3afzMuiH1+NSWpFiHxpreqoB3K8AaZuVxPabRKFZR1V
        mz16z0zLmesDUcoYuG08p3Dpgw==
X-Google-Smtp-Source: APXvYqxXpTCZSUaZybnhn3kH/rqUyC9SSUsXSslOr40FDp4NQubq5kyqbt2zxvEqyYAVDXYKvBv8Zw==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr10846518pfd.232.1553283818430;
        Fri, 22 Mar 2019 12:43:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o3sm9699274pgv.50.2019.03.22.12.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 12:43:37 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ARM: dts: rockchip: Add device tree for rk3288-veyron-mighty
Date:   Fri, 22 Mar 2019 12:43:10 -0700
Message-Id: <20190322194310.61365-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190322194310.61365-1-dianders@chromium.org>
References: <20190322194310.61365-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mighty is basically the same Chromebook as Jaq but it has a full-sized
SD slot and some different (slightly more rugged) plastics around it.
Like Jaq, Mighty may show up with various different brandings but all
of them have the same board inside.

In the downstream kernel Mighty and Jaq share a "dtsi" and Mighty just
adds the SD write protect (needed for a full-sized SD slot).  It seems
cleaner for upstream just to add a separate dts file, though.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/rk3288-veyron-mighty.dts | 182 +++++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-mighty.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f4f5aeaf3298..48282ebfb3da 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -909,6 +909,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-veyron-jaq.dtb \
 	rk3288-veyron-jerry.dtb \
 	rk3288-veyron-mickey.dtb \
+	rk3288-veyron-mighty.dtb \
 	rk3288-veyron-minnie.dtb \
 	rk3288-veyron-pinky.dtb \
 	rk3288-veyron-speedy.dtb \
diff --git a/arch/arm/boot/dts/rk3288-veyron-mighty.dts b/arch/arm/boot/dts/rk3288-veyron-mighty.dts
new file mode 100644
index 000000000000..59c23be3d46f
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-mighty.dts
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Veyron Mighty Rev 1+ board device tree source
+ *
+ * Copyright 2015 Google, Inc
+ */
+
+/dts-v1/;
+
+#include "rk3288-veyron-chromebook.dtsi"
+#include "cros-ec-sbs.dtsi"
+
+/ {
+	model = "Google Mighty";
+	compatible = "google,veyron-mighty-rev5", "google,veyron-mighty-rev4",
+		     "google,veyron-mighty-rev3", "google,veyron-mighty-rev2",
+		     "google,veyron-mighty-rev1", "google,veyron-mighty",
+		     "google,veyron", "rockchip,rk3288";
+
+	panel_regulator: panel-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio7 RK_PB6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_enable_h>;
+		regulator-name = "panel_regulator";
+		startup-delay-us = <100000>;
+		vin-supply = <&vcc33_sys>;
+	};
+
+	vcc18_lcd: vcc18-lcd {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&avdd_1v8_disp_en>;
+		regulator-name = "vcc18_lcd";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc18_wl>;
+	};
+
+	backlight_regulator: backlight-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_pwr_en>;
+		regulator-name = "backlight_regulator";
+		vin-supply = <&vcc33_sys>;
+		startup-delay-us = <15000>;
+	};
+};
+
+&backlight {
+	/* Mighty panel PWM must be >= 3%, so start non-zero brightness at 8 */
+	brightness-levels = <
+		  0
+		  8   9  10  11  12  13  14  15
+		 16  17  18  19  20  21  22  23
+		 24  25  26  27  28  29  30  31
+		 32  33  34  35  36  37  38  39
+		 40  41  42  43  44  45  46  47
+		 48  49  50  51  52  53  54  55
+		 56  57  58  59  60  61  62  63
+		 64  65  66  67  68  69  70  71
+		 72  73  74  75  76  77  78  79
+		 80  81  82  83  84  85  86  87
+		 88  89  90  91  92  93  94  95
+		 96  97  98  99 100 101 102 103
+		104 105 106 107 108 109 110 111
+		112 113 114 115 116 117 118 119
+		120 121 122 123 124 125 126 127
+		128 129 130 131 132 133 134 135
+		136 137 138 139 140 141 142 143
+		144 145 146 147 148 149 150 151
+		152 153 154 155 156 157 158 159
+		160 161 162 163 164 165 166 167
+		168 169 170 171 172 173 174 175
+		176 177 178 179 180 181 182 183
+		184 185 186 187 188 189 190 191
+		192 193 194 195 196 197 198 199
+		200 201 202 203 204 205 206 207
+		208 209 210 211 212 213 214 215
+		216 217 218 219 220 221 222 223
+		224 225 226 227 228 229 230 231
+		232 233 234 235 236 237 238 239
+		240 241 242 243 244 245 246 247
+		248 249 250 251 252 253 254 255>;
+	power-supply = <&backlight_regulator>;
+};
+
+&panel {
+	power-supply = <&panel_regulator>;
+};
+
+&rk808 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
+	dvs-gpios = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>,
+		    <&gpio7 RK_PB7 GPIO_ACTIVE_HIGH>;
+
+	regulators {
+		mic_vcc: LDO_REG2 {
+			regulator-name = "mic_vcc";
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+	};
+};
+
+&sdmmc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd_disabled &sdmmc_cd_gpio
+			&sdmmc_wp_gpio &sdmmc_bus4>;
+	wp-gpios = <&gpio7 10 GPIO_ACTIVE_HIGH>;
+};
+
+&vcc_5v {
+	enable-active-high;
+	gpio = <&gpio7 RK_PC5 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&drv_5v>;
+};
+
+&vcc50_hdmi {
+	enable-active-high;
+	gpio = <&gpio5 RK_PC3 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc50_hdmi_en>;
+};
+
+&pinctrl {
+	backlight {
+		bl_pwr_en: bl_pwr_en {
+			rockchip,pins = <2 12 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	buck-5v {
+		drv_5v: drv-5v {
+			rockchip,pins = <7 21 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	hdmi {
+		vcc50_hdmi_en: vcc50-hdmi-en {
+			rockchip,pins = <5 19 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	lcd {
+		lcd_enable_h: lcd-en {
+			rockchip,pins = <7 14 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		avdd_1v8_disp_en: avdd-1v8-disp-en {
+			rockchip,pins = <2 13 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		dvs_1: dvs-1 {
+			rockchip,pins = <7 12 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		dvs_2: dvs-2 {
+			rockchip,pins = <7 15 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_wp_gpio: sdmmc-wp-gpio {
+			rockchip,pins = <7 10 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
-- 
2.21.0.392.gf8f6787159e-goog

