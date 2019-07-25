Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10905C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D467622C7E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RKyMMI/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbfGYQ1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:27:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43793 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390689AbfGYQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:26:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so23286564pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqpcsXZmBNcNCZ+dJ5YsfXapSa3gvNcFkNQXkC4vToI=;
        b=RKyMMI/Kn9+HymtnLVsfU62zok5NKwyMWy080+tuDHrjHg3CQdVIunMlikxImeB+13
         epl7Mz5md669zlsqUunFSV1SBFPTHWkxl1I7XtyjWoDRJBa0m63qwLI4Yt7vCIjEX3Cd
         9ghZBAG9xWMiyEH9kbwGmHsT++TunZU02kHxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqpcsXZmBNcNCZ+dJ5YsfXapSa3gvNcFkNQXkC4vToI=;
        b=sAZUdfiF7et13ijP78WT6KhohfRM9x88D/quJkKJH+E3Mi9JX/sw2oFAsS4SR+iL1H
         pj9wlIp7DFVMsRaF3mxwzkVmbjfnzWYwgPI88gVCm9h9uPwzFmiffy1MoN5uEZPOBBCt
         D45ddwooOfLxmlLfIdq4rlEi+Cy3tu8M1zriR7t/kaj5Y969OrhIObT01udUhWB9NhVB
         ebwqo2i5wTOp8KFP1PU4zIQ1xxXCui0t5Q+6afnGB75363f/lZFlY7v0OURv2JiAov7v
         bAVd/9qvXUPbBbe1Ycwelx8Aoqpi4+M3g3SXGto2gd9Q+vaKxwHrsaEnDGOR6VsoRIwN
         EW/g==
X-Gm-Message-State: APjAAAVHuA27ihIxgLTwoT+u57tnQS8ATcPvvDwglUM9z2uP8kPN5tP1
        2mE9w+CUMsydfY845Xr8ziS4Wg==
X-Google-Smtp-Source: APXvYqyhnLfzaeqlRMgj+1CqP/hxlhYEVfu77cZafSafbH23Lhved39ayAYvsJ5mZyG6HybRfWSf7A==
X-Received: by 2002:a17:90a:20c6:: with SMTP id f64mr94433218pjg.57.1564072015359;
        Thu, 25 Jul 2019 09:26:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y12sm58898004pfn.187.2019.07.25.09.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 09:26:54 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 5/5] ARM: dts: rockchip: add veyron-tiger board
Date:   Thu, 25 Jul 2019 09:26:42 -0700
Message-Id: <20190725162642.250709-6-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190725162642.250709-1-mka@chromium.org>
References: <20190725162642.250709-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also known as the AOpen Chromebase Mini.

tiger and fievel are share the same board, tiger has a display and
touchscreen, fievel not. Use the fievel .dts as base and add the
extra bits.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added to the series
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/rk3288-veyron-tiger.dts | 125 ++++++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-tiger.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9fd1e075c624..64b08922e75d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -927,6 +927,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3288-veyron-minnie.dtb \
 	rk3288-veyron-pinky.dtb \
 	rk3288-veyron-speedy.dtb \
+	rk3288-veyron-tiger.dtb \
 	rk3288-vyasa.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += \
 	s3c2416-smdk2416.dtb
diff --git a/arch/arm/boot/dts/rk3288-veyron-tiger.dts b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
new file mode 100644
index 000000000000..fae26d530841
--- /dev/null
+++ b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Google Veyron Tiger Rev 0+ board device tree source
+ *
+ * Copyright 2016 Google, Inc
+ */
+
+/dts-v1/;
+#include "rk3288-veyron-fievel.dts"
+#include "rk3288-veyron-edp.dtsi"
+
+/ {
+	model = "Google Tiger";
+	compatible = "google,veyron-tiger-rev8", "google,veyron-tiger-rev7",
+		     "google,veyron-tiger-rev6", "google,veyron-tiger-rev5",
+		     "google,veyron-tiger-rev4", "google,veyron-tiger-rev3",
+		     "google,veyron-tiger-rev2", "google,veyron-tiger-rev1",
+		     "google,veyron-tiger-rev0", "google,veyron-tiger",
+		     "google,veyron", "rockchip,rk3288";
+
+	/delete-node/ vcc18-lcd;
+
+	vccsys: vccsys {
+		compatible = "regulator-fixed";
+		regulator-name = "vccsys";
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&backlight {
+	/* Tiger panel PWM must be >= 1%, so start non-zero brightness at 3 */
+	brightness-levels = <
+		  0   3   4   5   6   7
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
+};
+
+&backlight_regulator {
+	vin-supply = <&vccsys>;
+};
+
+&i2c3 {
+	status = "okay";
+
+	clock-frequency = <400000>;
+	i2c-scl-falling-time-ns = <50>;
+	i2c-scl-rising-time-ns = <300>;
+
+	touchscreen@10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <RK_PB6 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_int &touch_rst>;
+		reset-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_LOW>;
+		vcc33-supply = <&vcc33_io>;
+		vccio-supply = <&vcc33_io>;
+		wakeup-source;
+	};
+};
+
+&panel {
+	compatible = "auo,b101ean01", "simple-panel";
+
+	/delete-node/ panel-timing;
+
+	panel-timing {
+		clock-frequency = <66666667>;
+		hactive = <1280>;
+		hfront-porch = <18>;
+		hback-porch = <21>;
+		hsync-len = <32>;
+		vactive = <800>;
+		vfront-porch = <4>;
+		vback-porch = <8>;
+		vsync-len = <18>;
+	};
+};
+
+&pinctrl {
+	lcd {
+		/delete-node/ avdd-1v8-disp-en;
+	};
+
+	touchscreen {
+		touch_int: touch-int {
+			rockchip,pins = <2 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		touch_rst: touch-rst {
+			rockchip,pins = <2 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
-- 
2.22.0.709.g102302147b-goog

