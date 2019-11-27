Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B5EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684432068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DB3fiuS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfK0FAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:00:10 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15280 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfK0E7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:59:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dde02c20002>; Tue, 26 Nov 2019 20:59:46 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Nov 2019 20:59:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Nov 2019 20:59:44 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:59:44 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Nov 2019 04:59:43 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.149]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dde02be0001>; Tue, 26 Nov 2019 20:59:43 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/11] arm64: tegra: Add clock-cells property to Tegra pmc
Date:   Tue, 26 Nov 2019 20:59:30 -0800
Message-ID: <1574830773-14892-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574830786; bh=lo8blzopjAGi5SogoYjGohehp7NJzTCYM1OW+wmKKo4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=DB3fiuS2wWQYTgyw2pLrKzroTDIvpsvV19fbA2igRgyxJeOhcYOGqWh4pYSrtDDZj
         8/ogXFsPtXETmkv+uHWqYsotYiyfrBMCxvBnM3SlMxJnPYzT47J5Q/649gQJaDhfQ/
         NGJXSPbf8fS/CnNWjHG7sGr/765J+6d/Fyl6yVszfdCuwWaQ7AGZgwBGOu7oNXZR6q
         eY+a2atQc3bo5IjtoJEB2MOABMIrHozlpOVpBJxgLg9ZpHI/wUvKE2cEHjgH5D4y7i
         WxccgUODtqpSvG61m6Lu2SqxjWwSz94Bt7xatoGr5QfMF9QJMv2DFvJ1qOhtrdcrn0
         DTcgAXTigCrSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra pmc has 3 clocks clk_out_1, clk_out_2, clk_out_3 with mux and gate
for each of these clocks as part of pmc and Tegra pmc is the clock provider
for these clocks.

These clock ids are part of pmc dt-bindings.

This patch includes pmc dt-bindings and adds #clock-cells propert
 with 1 clock specifier to Tegra pmc node.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 4 +++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 2 ++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 2 ++
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 631a7f77c386..5bdb4a6a6b90 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
+#include <dt-bindings/soc/tegra-pmc.h>
 
 / {
 	compatible = "nvidia,tegra132", "nvidia,tegra124";
@@ -577,11 +578,12 @@
 		clock-names = "rtc";
 	};
 
-	pmc@7000e400 {
+	pmc: pmc@7000e400 {
 		compatible = "nvidia,tegra124-pmc";
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
 	};
 
 	fuse@7000f800 {
diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 7893d78a0fb6..627108ce2f56 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/power/tegra186-powergate.h>
 #include <dt-bindings/reset/tegra186-reset.h>
 #include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
+#include <dt-bindings/soc/tegra-pmc.h>
 
 / {
 	compatible = "nvidia,tegra186";
@@ -670,6 +671,7 @@
 		      <0 0x0c390000 0 0x10000>;
 		reg-names = "pmc", "wake", "aotag", "scratch";
 
+		#clock-cells = <1>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 11220d97adb8..37dc19f49e4f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/power/tegra194-powergate.h>
 #include <dt-bindings/reset/tegra194-reset.h>
 #include <dt-bindings/thermal/tegra194-bpmp-thermal.h>
+#include <dt-bindings/soc/tegra-pmc.h>
 
 / {
 	compatible = "nvidia,tegra194";
@@ -799,6 +800,7 @@
 			      <0x0c3a0000 0x10000>;
 			reg-names = "pmc", "wake", "aotag", "scratch", "misc";
 
+			#clock-cells = <1>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
 		};
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 48c63256ba7f..0d0432d3b37a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/reset/tegra210-car.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
+#include <dt-bindings/soc/tegra-pmc.h>
 
 / {
 	compatible = "nvidia,tegra210";
@@ -780,6 +781,7 @@
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
 		#interrupt-cells = <2>;
 		interrupt-controller;
 
-- 
2.7.4

