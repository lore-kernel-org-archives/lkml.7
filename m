Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2C9C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F45A208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561140152;
	bh=eunsB9axngpbwgAv86zG8SLCyKeyRPBGXGEeasE/nUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YJ1FelsVX6zzT4ptI5+UtJdIRKq3ccaiWCHDGvUknTzx4KFijfdCFFKLdcRggd/ho
	 WnPd/52SFHcvk69Mmol3JnUp7XAl8vbWNcl7LG3Dswr0bZwB/fCNJtPERqa3VJ+CTG
	 dHUuz6zjNVRdmdvlPJXXPviXnVrPNxcTguIesMlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFUSCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUSCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:02:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1D35215EA;
        Fri, 21 Jun 2019 18:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561140149;
        bh=eunsB9axngpbwgAv86zG8SLCyKeyRPBGXGEeasE/nUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHfe2I8Cm0NV/f7gFxOe/r7qIN14zaIFQTSa6q/OrsrrF2OzeKUiW8yCOlgUbdFQ2
         XEQlXF6pa7tHIB7QhaROX9OyaW8X4ydmLtIWwGlvzpSss+EYWSCGtUsOL7ZHl/prD6
         rSA1ak3c6SSMQJ8O3i0u2fGbiCI2NaWbibOwHuqI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joseph Kogut <joseph.kogut@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH v2 2/7] ARM: dts: exynos: Add GPU/Mali 400 node to Exynos4
Date:   Fri, 21 Jun 2019 20:02:03 +0200
Message-Id: <20190621180208.25361-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621180208.25361-1-krzk@kernel.org>
References: <20190621180208.25361-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for GPU (Mali 400) to Exynos4210 and Exynos4412.  Describe the
GPU as much as possible however still few elements are missing:
1. Exynos4210 bus clock is not described in hardware manual therefore
   the IP gate clock was provided,
2. Exynos4412: Not sure what to do with CLK_G3D clock responsible for
   gating entire IP block (it is now being disabled as unused),
3. Regulator supplies on Trats board.

Limited testing on Odroid U3 (Exynos4412).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Use samsung,exynos4210-mali compatible
2. Use CLK_G3D as bus clock (clock for entire IP block)
3. Remove some of operating points to match Mali in Tizen kernel.
   Previously they were taken from datasheet but this information is too
   generic.
4. Add 533 MHz opp to Exynos4412-prime.
---
 arch/arm/boot/dts/exynos4.dtsi                | 36 +++++++++++++++++++
 arch/arm/boot/dts/exynos4210-origen.dts       |  5 +++
 arch/arm/boot/dts/exynos4210-trats.dts        |  4 +++
 .../boot/dts/exynos4210-universal_c210.dts    |  5 +++
 arch/arm/boot/dts/exynos4210.dtsi             | 17 +++++++++
 .../boot/dts/exynos4412-itop-scp-core.dtsi    |  5 +++
 arch/arm/boot/dts/exynos4412-midas.dtsi       |  5 +++
 .../boot/dts/exynos4412-odroid-common.dtsi    |  5 +++
 arch/arm/boot/dts/exynos4412-prime.dtsi       |  7 ++++
 arch/arm/boot/dts/exynos4412.dtsi             | 25 +++++++++++++
 10 files changed, 114 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 36ccf227434d..ceaa169032c8 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -51,6 +51,42 @@
 		serial3 = &serial_3;
 	};
 
+	gpu: gpu@13000000 {
+		compatible = "samsung,exynos4210-mali", "arm,mali-400";
+		reg = <0x13000000 0x10000>;
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "gp",
+				  "gpmmu",
+				  "pp0",
+				  "ppmmu0",
+				  "pp1",
+				  "ppmmu1",
+				  "pp2",
+				  "ppmmu2",
+				  "pp3",
+				  "ppmmu3",
+				  "pmu";
+		/*
+		 * CLK_G3D is not actually bus clock but a IP-level clock.
+		 * The bus clock is not described in hardware manual.
+		 */
+		clocks = <&clock CLK_G3D>,
+			 <&clock CLK_SCLK_G3D>;
+		clock-names = "bus", "core";
+		power-domains = <&pd_g3d>;
+		status = "disabled";
+	};
+
 	pmu: pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupt-parent = <&combiner>;
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 36b1edea254a..0d1e1a9c2f6e 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -132,6 +132,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&buck3_reg>;
+	status = "okay";
+};
+
 &hsotg {
 	vusb_d-supply = <&ldo3_reg>;
 	vusb_a-supply = <&ldo8_reg>;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 6882480dbaf7..7c39dd1c4d3a 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -239,6 +239,10 @@
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
 &hsotg {
 	vusb_d-supply = <&vusb_reg>;
 	vusb_a-supply = <&vusbdac_reg>;
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index bf092e97e14f..82a8b5449978 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -262,6 +262,11 @@
 	};
 };
 
+&gpu {
+	mali-supply = <&buck2_reg>;
+	status = "okay";
+};
+
 &hdmi {
 	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index ea0e043cd2b4..bf312ebed01f 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -449,6 +449,23 @@
 	samsung,lcd-wb;
 };
 
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+
+	gpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+
+		opp-160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <950000>;
+		};
+		opp-267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <1050000>;
+		};
+	};
+};
+
 &mdma1 {
 	power-domains = <&pd_lcd0>;
 };
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index 0038465f38f1..462a5409b1de 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -115,6 +115,11 @@
 	cpu0-supply = <&buck2_reg>;
 };
 
+&gpu {
+	mali-supply = <&buck4_reg>;
+	status = "okay";
+};
+
 &hsotg {
 	vusb_d-supply = <&ldo15_reg>;
 	vusb_a-supply = <&ldo12_reg>;
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 4c15cb616cdf..83be3a797411 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -453,6 +453,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&buck4_reg>;
+	status = "okay";
+};
+
 &hdmi {
 	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 08d3a0a7b4eb..ea55f377d17c 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -229,6 +229,11 @@
 	assigned-clock-rates = <0>, <176000000>;
 };
 
+&gpu {
+	mali-supply = <&buck4_reg>;
+	status = "okay";
+};
+
 &hdmi {
 	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/exynos4412-prime.dtsi b/arch/arm/boot/dts/exynos4412-prime.dtsi
index d83fbd4e434c..3731a225f779 100644
--- a/arch/arm/boot/dts/exynos4412-prime.dtsi
+++ b/arch/arm/boot/dts/exynos4412-prime.dtsi
@@ -38,3 +38,10 @@
 	cooling-device = <&cpu0 15 15>, <&cpu1 15 15>,
 			 <&cpu2 15 15>, <&cpu3 15 15>;
 };
+
+&gpu_opp_table {
+	opp-533000000 {
+		opp-hz = /bits/ 64 <533000000>;
+		opp-microvolt = <1075000>;
+	};
+};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index e5c041ec0756..fb53d96934cc 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -716,6 +716,31 @@
 	cpu-offset = <0x4000>;
 };
 
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+
+	gpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+
+		opp-160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <875000>;
+		};
+		opp-267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <900000>;
+		};
+		opp-350000000 {
+			opp-hz = /bits/ 64 <350000000>;
+			opp-microvolt = <950000>;
+		};
+		opp-440000000 {
+			opp-hz = /bits/ 64 <440000000>;
+			opp-microvolt = <1025000>;
+		};
+	};
+};
+
 &hdmi {
 	compatible = "samsung,exynos4212-hdmi";
 };
-- 
2.17.1

