Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3555C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A997324672
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MVzJ3Ttj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfLQUE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:04:28 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1827 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbfLQUEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:04:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df934bd0000>; Tue, 17 Dec 2019 12:04:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 17 Dec 2019 12:04:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Dec 2019 12:04:22 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 20:04:21 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Dec 2019 20:04:21 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.101]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df934c50000>; Tue, 17 Dec 2019 12:04:21 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 15/19] ARM: dts: tegra: Add clock-cells property to pmc
Date:   Tue, 17 Dec 2019 12:04:02 -0800
Message-ID: <1576613046-17159-16-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576613053; bh=8wMMkvOn0ws85wYk6fAXIZH+bdboJOtd6GAyLcqUa2Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=MVzJ3Ttjf+5rvCxdiJCj/To37/Cayj5OsUTOYYLU+qnrS5R2EySxrzgCP5CA9f30l
         mrRcEW2zeHDR2p7+LrJFfkR5ci1iUI5e9UdzTIHT+rxgsXgtaBT6Fspoo6rUUMS80U
         VHpUto2areCtxDb4cDftLfMC+UrEjCq1FCErwFHY7DHrJuxzI26pLSUo/ssERQxyaO
         h6Q4oBiNyCeUdpejRxihYOA58vAbZ9DQ7dfGq2GhWaSy/rVrVcLW1jNxVlUXHM3RBy
         bckQXB8vWlRfh9+4TLsHzHzymC5PETa0foF/B9+whQ47WDFRF9VJ+v/U6zzyxejJT8
         ph89AUiQb1UBw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has clk_out_1, clk_out_2, clk_out_3, and blink clock.

These clocks are moved from clock driver to pmc driver with pmc
as the clock provider for these clocks.

This patch adds #clock-cells property with 1 clock specifier to
the Tegra PMC node in device tree.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 4 +++-
 arch/arm/boot/dts/tegra124.dtsi | 4 +++-
 arch/arm/boot/dts/tegra20.dtsi  | 4 +++-
 arch/arm/boot/dts/tegra30.dtsi  | 4 +++-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 0d7a6327e404..b8f12f24f314 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/memory/tegra114-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/tegra-pmc.h>
 
 / {
 	compatible = "nvidia,tegra114";
@@ -514,11 +515,12 @@
 		status = "disabled";
 	};
 
-	pmc@7000e400 {
+	pmc: pmc@7000e400 {
 		compatible = "nvidia,tegra114-pmc";
 		reg = <0x7000e400 0x400>;
 		clocks = <&tegra_car TEGRA114_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
 	};
 
 	fuse@7000f800 {
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 413bfb981de8..d0802c4ae3bf 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/tegra124-car.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
+#include <dt-bindings/soc/tegra-pmc.h>
 
 / {
 	compatible = "nvidia,tegra124";
@@ -595,11 +596,12 @@
 		clocks = <&tegra_car TEGRA124_CLK_RTC>;
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
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 9c58e7fcf5c0..85a64747bec6 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/memory/tegra20-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/tegra-pmc.h>
 
 / {
 	compatible = "nvidia,tegra20";
@@ -608,11 +609,12 @@
 		status = "disabled";
 	};
 
-	pmc@7000e400 {
+	pmc: pmc@7000e400 {
 		compatible = "nvidia,tegra20-pmc";
 		reg = <0x7000e400 0x400>;
 		clocks = <&tegra_car TEGRA20_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
 	};
 
 	mc: memory-controller@7000f000 {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 55ae050042ce..4d5e9d0001d3 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/memory/tegra30-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/tegra-pmc.h>
 
 / {
 	compatible = "nvidia,tegra30";
@@ -714,11 +715,12 @@
 		status = "disabled";
 	};
 
-	pmc@7000e400 {
+	pmc: pmc@7000e400 {
 		compatible = "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
 		clocks = <&tegra_car TEGRA30_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
 	};
 
 	mc: memory-controller@7000f000 {
-- 
2.7.4

