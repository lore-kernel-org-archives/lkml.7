Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC4820883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Co1jldvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDANgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:36:18 -0400
Received: from vps.xff.cz ([195.181.215.36]:58896 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfDANgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554125771; bh=Y1e7lelAV4W15WGtD+ZdmuUOPL1/Br6QOZj+3oHFR/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Co1jldvfWijDV+Fsn69xzrwwk55etKY2zkfMRue+S03AKiScHLi66lfvinocEa2Gw
         QSiwULO0PdgA/6M7eWwf43zjPWvJimtkg/fBszmuHVZIKx3UOJsc65NW33TJhY9qif
         Qlw/aNEh3FPuKJsEQhK+ZcM+qexFvO2pkb+PONzI=
From:   megous@megous.com
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] ARM: dts: sun8i: a83t: Add missing CPU clock references
Date:   Mon,  1 Apr 2019 15:36:10 +0200
Message-Id: <20190401133610.17916-2-megous@megous.com>
In-Reply-To: <20190401133610.17916-1-megous@megous.com>
References: <20190401133610.17916-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

A83T DTSI has cpu clocks defined only on the first CPU in each cluster.
We can bring down any CPU in the cluster, so we need to define clock
for each CPU, so that the system knows what clock to use if the first
CPU is down.

Also move the clocks property below the compatible on cpus where it is
already defined. Property "clock-names" is not needed.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 7a40b7d77ec0..b241058dc6b0 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -61,10 +61,9 @@
 		#size-cells = <0>;
 
 		cpu0: cpu@0 {
-			clocks = <&ccu CLK_C0CPUX>;
-			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&ccu CLK_C0CPUX>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
@@ -75,6 +74,7 @@
 		cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&ccu CLK_C0CPUX>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
@@ -85,6 +85,7 @@
 		cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&ccu CLK_C0CPUX>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
@@ -95,6 +96,7 @@
 		cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&ccu CLK_C0CPUX>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
 			enable-method = "allwinner,sun8i-a83t-smp";
@@ -103,10 +105,9 @@
 		};
 
 		cpu100: cpu@100 {
-			clocks = <&ccu CLK_C1CPUX>;
-			clock-names = "cpu";
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&ccu CLK_C1CPUX>;
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
@@ -117,6 +118,7 @@
 		cpu@101 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&ccu CLK_C1CPUX>;
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
@@ -127,6 +129,7 @@
 		cpu@102 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&ccu CLK_C1CPUX>;
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
@@ -137,6 +140,7 @@
 		cpu@103 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
+			clocks = <&ccu CLK_C1CPUX>;
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
 			enable-method = "allwinner,sun8i-a83t-smp";
-- 
2.21.0

