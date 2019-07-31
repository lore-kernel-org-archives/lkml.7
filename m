Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1405C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C867F206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="USefCljr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfGaPfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:35:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38632 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfGaPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:35:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so70186197wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C6EJL/51AHNPmVJCC71cSQAo/Uql1LEExYduU9tlj54=;
        b=USefCljrpz1yRsoIXF2w4xg9VXh4QbDSRfoyiXoY6jTBa7FxJT/7Due8LQ+/bxUmFp
         WAnAouc1YOFfmGGlkNGldaFXIxCzuzfN2zJb8T2LWO6y0KSY9g+ThTrcEkjgJRrQypui
         TsALxmEM6dEQtySXllvS/VgeRnzL0tr4TE/tKkqBl2gomPbnpVwkSJM34y8hi4C+tq00
         nUML5hcGDz/hAz/bYVpHD4tw1+z/2tRy2XSrR0p9nOkH2XwzrkSf15x7n1UTHj+JEKVf
         DBXXcERhZyinR8yH4dhsmdtXxIqaSW5Xl367BjgxRe//gosv9vVQECKBtdVspL1td+tS
         BVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C6EJL/51AHNPmVJCC71cSQAo/Uql1LEExYduU9tlj54=;
        b=s5TRgUO+h9JEYfEwdYHxmzi1YEVkTRNKNCYOazvrWNLpfpQ49lHUO7YMBQrc3rjHzS
         G1nwU85fEpULQeL+QmGEJLIP5yJQhLXjMRl6Ay8zPN/Zpw2cwqlcaH0/4cftHhnCcCJi
         Ku6NlIaYPOfvYEo2FWNVytEbhx8otTV/sRrFXGVkmQgkmDiGtyZf2/9vq8j5wOavpdew
         2N/G8AFG5T8jFf3hI5TGMFbFcEG/ZlM9D6OOM5wYHrNTeyCYMbkUnP0GwxmOwxXaCDSP
         hAriopMsBKzDv6Vk7o4RYKkb5WVKjtHdfzi9NdDSs8/6lCJxgouung3IDrPhWTcmiIdR
         93yw==
X-Gm-Message-State: APjAAAUooXX5yKUW74ecnXFN3Xz17Cv+4ydu5Sk4yflsOgN7CrC9ZUW8
        LMtYfdFKKW+IONbawIyUyC7yFA==
X-Google-Smtp-Source: APXvYqxYIBXbtzSuPK9eyz7FC0ILxtSo7AVLrSGfVDmK39RujTf/qMGWu4sryl3IMIl6xvWfe1kg/w==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr44406641wrs.200.1564587336894;
        Wed, 31 Jul 2019 08:35:36 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i13sm62834396wrr.73.2019.07.31.08.35.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:35:36 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/6] arm64: dts: amlogic: odroid-n2: add minimal thermal zone
Date:   Wed, 31 Jul 2019 17:35:28 +0200
Message-Id: <20190731153529.30159-6-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731153529.30159-1-glaroque@baylibre.com>
References: <20190731153529.30159-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minimal thermal zone for DDR and CPU sensor

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 75ff8a7e373d..a7d73c0c8447 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "hardkernel,odroid-n2", "amlogic,g12b";
@@ -20,6 +21,55 @@
 		ethernet0 = &ethmac;
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&cpu_temp>;
+
+			trips {
+				cpu_critical: cpu-critical {
+					temperature = <110000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map {
+					trip = <&cpu_critical>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		ddr-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&ddr_temp>;
+
+			trips {
+				ddr_critical: ddr-critical {
+					temperature = <110000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map {
+					trip = <&ddr_critical>;
+					cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -288,6 +338,7 @@
 	operating-points-v2 = <&cpu_opp_table_0>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu1 {
@@ -295,6 +346,7 @@
 	operating-points-v2 = <&cpu_opp_table_0>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu100 {
@@ -302,6 +354,7 @@
 	operating-points-v2 = <&cpub_opp_table_1>;
 	clocks = <&clkc CLKID_CPUB_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu101 {
@@ -309,6 +362,7 @@
 	operating-points-v2 = <&cpub_opp_table_1>;
 	clocks = <&clkc CLKID_CPUB_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu102 {
@@ -316,6 +370,7 @@
 	operating-points-v2 = <&cpub_opp_table_1>;
 	clocks = <&clkc CLKID_CPUB_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu103 {
@@ -323,6 +378,7 @@
 	operating-points-v2 = <&cpub_opp_table_1>;
 	clocks = <&clkc CLKID_CPUB_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &ext_mdio {
@@ -377,6 +433,10 @@
 	};
 };
 
+&mali {
+	#cooling-cells = <2>;
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
-- 
2.17.1

