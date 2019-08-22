Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C294521655
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="17+eiC8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbfHVOZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:25:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36998 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388123AbfHVOZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:25:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id d16so6003314wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o5UIEYHuXv3oFeWmm3iKO4/XGty1oJpmX1E+e78Kpt0=;
        b=17+eiC8vU21igxyN6NTyYYi4MBRmA1xYgiGi4R/kgNYC5Xz8xnjxkl7hcvBsJ2yOFv
         Y43Gasp2ibVy9fjdInAkIc5Z0nMr+npEtxAF5y4CWldVyTI7idbNR6OBHsiWDzsagVTF
         P+fAC3zSPGOTNLCSOVFRmSEtw043ditCItbRCxGg7UW4s7poC5NR5qHbSvEAZSUzECH5
         gpZTwNIuGQCEKWEAerrhbja4Uahm6t52uY2SRL7NA733Xd6wwI2B5x/yz/Mhg1fyxiKy
         ytD19Nz58khhHrehK03Tr/mpmZNKuH9Nx83b/71nSOq73nMImYKuasgqYRXt8yF3ImlH
         uRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o5UIEYHuXv3oFeWmm3iKO4/XGty1oJpmX1E+e78Kpt0=;
        b=B8OVtnli4AJvNqClKdEDcXOBl4vSA+FwfBOxsvQC4NdEn6g6bleUIoWetZllKYzNd/
         VCR1NeDHErH7GBbRDAq3cizvLjoU5Qmzv83dlD/lAqJWraZTD84WkSxVgGdNza4Q1+Pn
         FiiDOsD+tYfgpHpvYtp+spkS5vqigTI9TBopGQ4+pFmZ8liQ9XxypXMHm42NWTkeJGzw
         F0jbl0X63J+uPYo8UaCjdXKnwoz48fK5QWFdX98UuSRKyFAaY544vT+mCzuIqxs1zVgV
         EPpjl0iJ9+ZIRvWlhOuwv2inrUWU7HUEITgBXsIk5DsN/mBP0RE4Qk7rZxFPQmg86zay
         ZI0A==
X-Gm-Message-State: APjAAAXgweT2TB2h8Wpzg9nMRO0Z6P88MQx3Dokrdm7Fq/8mGUUOteP5
        EdGTcA3ZEazuNdcV3VGNW7/Ufg==
X-Google-Smtp-Source: APXvYqwEeyUas1lHynl0q9x2yw0ciE7WfB+pHqNmZ62GcAmPjx7sSYeMa63XIc0wj2vmrchGIW6XBw==
X-Received: by 2002:a1c:760b:: with SMTP id r11mr6961947wmc.41.1566483905453;
        Thu, 22 Aug 2019 07:25:05 -0700 (PDT)
Received: from bender.baylibre.local (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d17sm25806547wrm.52.2019.08.22.07.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:25:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: meson-sm1-sei610: enable DVFS
Date:   Thu, 22 Aug 2019 16:24:55 +0200
Message-Id: <20190822142455.12506-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190822142455.12506-1-narmstrong@baylibre.com>
References: <20190822142455.12506-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables DVFS for the Amlogic SM1 based SEI610 board by:
- Adding the SM1 SoC OPPs taken from the vendor tree
- Selecting the SM1 Clock controller instead of the G12A one
- Adding the CPU rail regulator, PWM and OPPs for each CPU nodes.

Each power supply can achieve 0.69V to 1.05V using a single PWM
output clocked at 666KHz with an inverse duty-cycle.

DVFS has been tested by running the arm64 cpuburn at [1] and cycling
between all the possible cpufreq translations of each cluster and
checking the final frequency using the clock-measurer, script at [2].

[1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
[2] https://gist.github.com/superna9999/d4de964dbc0f84b7d527e1df2ddea25f

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-sm1-sei610.dts     | 59 ++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    | 69 +++++++++++++++++++
 2 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 36ac2e4b970d..69966e2e0611 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -19,10 +19,6 @@
 		ethernet0 = &ethmac;
 	};
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_12 GPIO_ACTIVE_LOW>;
@@ -136,6 +132,25 @@
 		regulator-always-on;
 	};
 
+	vddcpu: regulator-vddcpu {
+		/*
+		 * SY8120B1ABC DC/DC Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU";
+		regulator-min-microvolt = <690000>;
+		regulator-max-microvolt = <1050000>;
+
+		vin-supply = <&dc_in>;
+
+		pwms = <&pwm_AO_cd 1 1500 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	vddio_ao1v8: regulator-vddio_ao1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_AO1V8";
@@ -182,6 +197,34 @@
 	hdmi-phandle = <&hdmi_tx>;
 };
 
+&cpu0 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU1_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu2 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU2_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu3 {
+	cpu-supply = <&vddcpu>;
+	operating-points-v2 = <&cpu_opp_table>;
+	clocks = <&clkc CLKID_CPU3_CLK>;
+	clock-latency = <50000>;
+};
+
 &ethmac {
 	status = "okay";
 	phy-handle = <&internal_ephy>;
@@ -220,6 +263,14 @@
 	clock-names = "clkin0";
 };
 
+&pwm_AO_cd {
+	pinctrl-0 = <&pwm_ao_d_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin1";
+	status = "okay";
+};
+
 &pwm_ef {
 	status = "okay";
 	pinctrl-0 = <&pwm_e_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 37064d7f66c1..2b61406b0610 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -50,6 +50,71 @@
 			compatible = "cache";
 		};
 	};
+
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <730000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <730000>;
+		};
+
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <730000>;
+		};
+
+		opp-667000000 {
+			opp-hz = /bits/ 64 <666666666>;
+			opp-microvolt = <750000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <770000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <780000>;
+		};
+
+		opp-1404000000 {
+			opp-hz = /bits/ 64 <1404000000>;
+			opp-microvolt = <790000>;
+		};
+
+		opp-1512000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <800000>;
+		};
+
+		opp-1608000000 {
+			opp-hz = /bits/ 64 <1608000000>;
+			opp-microvolt = <810000>;
+		};
+
+		opp-1704000000 {
+			opp-hz = /bits/ 64 <1704000000>;
+			opp-microvolt = <850000>;
+		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <900000>;
+		};
+
+		opp-1908000000 {
+			opp-hz = /bits/ 64 <1908000000>;
+			opp-microvolt = <950000>;
+		};
+	};
 };
 
 &cecb_AO {
@@ -60,6 +125,10 @@
 	compatible = "amlogic,meson-sm1-clk-measure";
 };
 
+&clkc {
+	compatible = "amlogic,sm1-clkc";
+};
+
 &ethmac {
 	power-domains = <&pwrc PWRC_SM1_ETH_ID>;
 };
-- 
2.22.0

