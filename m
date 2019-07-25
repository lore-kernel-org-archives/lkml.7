Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40468C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE8822C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TMqB+vQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390654AbfGYQ0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:26:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36211 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390625AbfGYQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:26:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so23021168pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4AQTgJJZeNuBXuGUyMh1BSSXUeCToCh7ZN29ow5vQY=;
        b=TMqB+vQdeyvBfLbcgOAo05P9XMLwSk6UrCtB0eG0ianPX6VwU+lpblnBtv5g9F/hag
         ui3irRG8uTWcdRMZm5ETk0cwIok6AvJheKFB10AWf8duB7npIXPJhaZgPKbymbmn1/IB
         kS6ZjlfIOsTrdhz73T8ds6cGqRGBfiVVAInik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4AQTgJJZeNuBXuGUyMh1BSSXUeCToCh7ZN29ow5vQY=;
        b=sdEES5xRtCuez/PeCMHoChMZnQeW/ghCFTj6VC27NkKdH1Em4i5/+jG7qRpIMzst3R
         5m9yrGrV/xnAp2rDhoj34AQ3nK04KNAfYaYwxsdmPhz7Z8duT3zWGTGw3GejJjht+sgU
         YP7rg+UM9caZ1hrm5LoetO8m+JoHVVKEZcxSI2BgNta9MrXl2h8lazHaR29yV4EjhGrl
         5ix2ni57sWMwAxnh7/i5kIsIksNeGiLD81tB1gEGTZTqPK9NJrMisRSLApaQfkH2kTv7
         pVOjY8PKcnNIbxncdbZk42/b0TuJEmacngYuEad8kC/z0K/lxPhm31c5hwkLxfgrrFrQ
         QeNw==
X-Gm-Message-State: APjAAAUpBZFimdTsDjyVqjGKpwTQ7/Z/922pXFnzWTCiTmHxSAEGxzQH
        dEy6CvdVVQ+jMFXGEshcLmAisQ==
X-Google-Smtp-Source: APXvYqyUpwgFcZaTLDD1V8NK7I4PYMwCOKfgu5banOLy+DYGZeIlueRf3dhG3QrzwneoyhLUT7gujg==
X-Received: by 2002:a62:3895:: with SMTP id f143mr17286607pfa.116.1564072009719;
        Thu, 25 Jul 2019 09:26:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id p68sm61452992pfb.80.2019.07.25.09.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:26:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/5] ARM: dts: rockchip: move rk3288-veryon display settings into a separate file
Date:   Thu, 25 Jul 2019 09:26:38 -0700
Message-Id: <20190725162642.250709-2-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190725162642.250709-1-mka@chromium.org>
References: <20190725162642.250709-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chromebook .dtsi file contains common settings for veyron
Chromebooks with eDP displays. Some veyron devices with a display
aren't Chromebooks (e.g. 'tiger' aka 'AOpen Chromebase Mini'), move
display related bits from the chromebook .dtsi into a separate file
to avoid redundant DT settings.

The new file is included from the chromebook .dtsi and can be
included by non-Chromebook devices with a display.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- allow MIT license
- move pinctrl section to the bottom

Changes in v2:
- rebased on v5.4-armsoc/dts32 (0d19541e3b45)
---
 .../boot/dts/rk3288-veyron-chromebook.dtsi    | 115 +---------------
 arch/arm/boot/dts/rk3288-veyron-edp.dtsi      | 124 ++++++++++++++++++
 2 files changed, 125 insertions(+), 114 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-edp.dtsi

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index 6a28ce345ba0..ffb60f880b39 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 #include "rk3288-veyron.dtsi"
 #include "rk3288-veyron-analog-audio.dtsi"
+#include "rk3288-veyron-edp.dtsi"
 #include "rk3288-veyron-sdmmc.dtsi"
 
 / {
@@ -18,50 +19,6 @@
 		i2c20 = &i2c_tunnel;
 	};
 
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		brightness-levels = <
-			  0   1   2   3   4   5   6   7
-			  8   9  10  11  12  13  14  15
-			 16  17  18  19  20  21  22  23
-			 24  25  26  27  28  29  30  31
-			 32  33  34  35  36  37  38  39
-			 40  41  42  43  44  45  46  47
-			 48  49  50  51  52  53  54  55
-			 56  57  58  59  60  61  62  63
-			 64  65  66  67  68  69  70  71
-			 72  73  74  75  76  77  78  79
-			 80  81  82  83  84  85  86  87
-			 88  89  90  91  92  93  94  95
-			 96  97  98  99 100 101 102 103
-			104 105 106 107 108 109 110 111
-			112 113 114 115 116 117 118 119
-			120 121 122 123 124 125 126 127
-			128 129 130 131 132 133 134 135
-			136 137 138 139 140 141 142 143
-			144 145 146 147 148 149 150 151
-			152 153 154 155 156 157 158 159
-			160 161 162 163 164 165 166 167
-			168 169 170 171 172 173 174 175
-			176 177 178 179 180 181 182 183
-			184 185 186 187 188 189 190 191
-			192 193 194 195 196 197 198 199
-			200 201 202 203 204 205 206 207
-			208 209 210 211 212 213 214 215
-			216 217 218 219 220 221 222 223
-			224 225 226 227 228 229 230 231
-			232 233 234 235 236 237 238 239
-			240 241 242 243 244 245 246 247
-			248 249 250 251 252 253 254 255>;
-		default-brightness-level = <128>;
-		enable-gpios = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bl_en>;
-		pwms = <&pwm0 0 1000000 0>;
-		post-pwm-on-delay-ms = <10>;
-		pwm-off-delay-ms = <10>;
-	};
-
 	gpio-charger {
 		compatible = "gpio-charger";
 		charger-type = "mains";
@@ -85,35 +42,6 @@
 		};
 	};
 
-	panel: panel {
-		compatible ="innolux,n116bge", "simple-panel";
-		status = "okay";
-		power-supply = <&vcc33_lcd>;
-		backlight = <&backlight>;
-
-		panel-timing {
-			clock-frequency = <74250000>;
-			hactive = <1366>;
-			hfront-porch = <136>;
-			hback-porch = <60>;
-			hsync-len = <30>;
-			hsync-active = <0>;
-			vactive = <768>;
-			vfront-porch = <8>;
-			vback-porch = <12>;
-			vsync-len = <12>;
-			vsync-active = <0>;
-		};
-
-		ports {
-			panel_in: port {
-				panel_in_edp: endpoint {
-					remote-endpoint = <&edp_out_panel>;
-				};
-			};
-		};
-	};
-
 	/* A non-regulated voltage from power supply or battery */
 	vccsys: vccsys {
 		compatible = "regulator-fixed";
@@ -155,33 +83,6 @@
 	};
 };
 
-&edp {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&edp_hpd>;
-
-	ports {
-		edp_out: port@1 {
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			edp_out_panel: endpoint@0 {
-				reg = <0>;
-				remote-endpoint = <&panel_in_edp>;
-			};
-		};
-	};
-};
-
-&edp_phy {
-	status = "okay";
-};
-
-&pwm0 {
-	status = "okay";
-};
-
 &rk808 {
 	vcc11-supply = <&vcc_5v>;
 
@@ -234,14 +135,6 @@
 	};
 };
 
-&vopl {
-	status = "okay";
-};
-
-&vopl_mmu {
-	status = "okay";
-};
-
 &pinctrl {
 	pinctrl-0 = <
 		/* Common for sleep and wake, but no owners */
@@ -264,12 +157,6 @@
 		&bt_dev_wake_sleep
 	>;
 
-	backlight {
-		bl_en: bl-en {
-			rockchip,pins = <7 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	buttons {
 		ap_lid_int_l: ap-lid-int-l {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
diff --git a/arch/arm/boot/dts/rk3288-veyron-edp.dtsi b/arch/arm/boot/dts/rk3288-veyron-edp.dtsi
new file mode 100644
index 000000000000..c36fb0940478
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-edp.dtsi
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Veyron (and derivatives) fragment for the edp displays
+ *
+ * Copyright 2019 Google LLC
+ */
+
+/ {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <
+			  0   1   2   3   4   5   6   7
+			  8   9  10  11  12  13  14  15
+			 16  17  18  19  20  21  22  23
+			 24  25  26  27  28  29  30  31
+			 32  33  34  35  36  37  38  39
+			 40  41  42  43  44  45  46  47
+			 48  49  50  51  52  53  54  55
+			 56  57  58  59  60  61  62  63
+			 64  65  66  67  68  69  70  71
+			 72  73  74  75  76  77  78  79
+			 80  81  82  83  84  85  86  87
+			 88  89  90  91  92  93  94  95
+			 96  97  98  99 100 101 102 103
+			104 105 106 107 108 109 110 111
+			112 113 114 115 116 117 118 119
+			120 121 122 123 124 125 126 127
+			128 129 130 131 132 133 134 135
+			136 137 138 139 140 141 142 143
+			144 145 146 147 148 149 150 151
+			152 153 154 155 156 157 158 159
+			160 161 162 163 164 165 166 167
+			168 169 170 171 172 173 174 175
+			176 177 178 179 180 181 182 183
+			184 185 186 187 188 189 190 191
+			192 193 194 195 196 197 198 199
+			200 201 202 203 204 205 206 207
+			208 209 210 211 212 213 214 215
+			216 217 218 219 220 221 222 223
+			224 225 226 227 228 229 230 231
+			232 233 234 235 236 237 238 239
+			240 241 242 243 244 245 246 247
+			248 249 250 251 252 253 254 255>;
+		default-brightness-level = <128>;
+		enable-gpios = <&gpio7 RK_PA2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bl_en>;
+		pwms = <&pwm0 0 1000000 0>;
+		post-pwm-on-delay-ms = <10>;
+		pwm-off-delay-ms = <10>;
+	};
+
+	panel: panel {
+		compatible ="innolux,n116bge", "simple-panel";
+		status = "okay";
+		power-supply = <&vcc33_lcd>;
+		backlight = <&backlight>;
+
+		panel-timing {
+			clock-frequency = <74250000>;
+			hactive = <1366>;
+			hfront-porch = <136>;
+			hback-porch = <60>;
+			hsync-len = <30>;
+			hsync-active = <0>;
+			vactive = <768>;
+			vfront-porch = <8>;
+			vback-porch = <12>;
+			vsync-len = <12>;
+			vsync-active = <0>;
+		};
+
+		ports {
+			panel_in: port {
+				panel_in_edp: endpoint {
+					remote-endpoint = <&edp_out_panel>;
+				};
+			};
+		};
+	};
+};
+
+&edp {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&edp_hpd>;
+
+	ports {
+		edp_out: port@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			edp_out_panel: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&panel_in_edp>;
+			};
+		};
+	};
+};
+
+&edp_phy {
+	status = "okay";
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&vopl {
+	status = "okay";
+};
+
+&vopl_mmu {
+	status = "okay";
+};
+
+&pinctrl {
+	backlight {
+		bl_en: bl-en {
+			rockchip,pins = <7 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
-- 
2.22.0.709.g102302147b-goog

