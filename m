Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A023C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6989A20678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbfIQI1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:27:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46932 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbfIQI1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:27:12 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8pJ-0005ZY-KU; Tue, 17 Sep 2019 10:27:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 09/13] arm64: dts: rockchip: document explicit px30 cru dependencies
Date:   Tue, 17 Sep 2019 10:26:55 +0200
Message-Id: <20190917082659.25549-9-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917082659.25549-1-heiko@sntech.de>
References: <20190917082659.25549-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The px30 contains 2 separate clock controllers the regular cru creating
most clocks as well as the pmucru managing the GPLL and some other clocks.

The gpll of course also is needed by the cru, so while we normally do rely
on clock names to associate clocks getting probed later on (for example
xin32k coming from an i2c device in most cases) it is safer to declare the
explicit dependency between the two crus. This makes sure that for example
the clock-framework probes them in the correct order from the start.

The assigned-clocks properties were simply working by chance in the past
so split them accordingly to the 2 crus to honor the loading direction.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/clock/rockchip,px30-cru.txt      |  5 ++++
 arch/arm64/boot/dts/rockchip/px30.dtsi        | 25 +++++++++++--------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
index 39f0c1ac84ee..55e78cddec8c 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
+++ b/Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
@@ -10,6 +10,11 @@ Required Properties:
 - compatible: CRU should be "rockchip,px30-cru"
 - reg: physical base address of the controller and length of memory mapped
   region.
+- clocks: A list of phandle + clock-specifier pairs for the clocks listed
+          in clock-names
+- clock-names: Should contain the following:
+  - "xin24m" for both PMUCRU and CRU
+  - "gpll" for CRU (sourced from PMUCRU)
 - #clock-cells: should be 1.
 - #reset-cells: should be 1.
 
diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 63499d27994c..9ad1c2f04ea9 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -667,33 +667,38 @@
 	cru: clock-controller@ff2b0000 {
 		compatible = "rockchip,px30-cru";
 		reg = <0x0 0xff2b0000 0x0 0x1000>;
+		clocks = <&xin24m>, <&pmucru PLL_GPLL>;
+		clock-names = "xin24m", "gpll";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 
-		assigned-clocks = <&cru PLL_NPLL>;
-		assigned-clock-rates = <1188000000>;
+		assigned-clocks = <&cru PLL_NPLL>,
+			<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
+			<&cru HCLK_BUS_PRE>, <&cru HCLK_PERI_PRE>,
+			<&cru PCLK_BUS_PRE>, <&cru SCLK_GPU>;
+
+		assigned-clock-rates = <1188000000>,
+			<200000000>, <200000000>,
+			<150000000>, <150000000>,
+			<100000000>, <200000000>;
 	};
 
 	pmucru: clock-controller@ff2bc000 {
 		compatible = "rockchip,px30-pmucru";
 		reg = <0x0 0xff2bc000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 
 		assigned-clocks =
 			<&pmucru PLL_GPLL>, <&pmucru PCLK_PMU_PRE>,
-			<&pmucru SCLK_WIFI_PMU>, <&cru ARMCLK>,
-			<&cru ACLK_BUS_PRE>, <&cru ACLK_PERI_PRE>,
-			<&cru HCLK_BUS_PRE>, <&cru HCLK_PERI_PRE>,
-			<&cru PCLK_BUS_PRE>, <&cru SCLK_GPU>;
+			<&pmucru SCLK_WIFI_PMU>;
 		assigned-clock-rates =
 			<1200000000>, <100000000>,
-			<26000000>, <600000000>,
-			<200000000>, <200000000>,
-			<150000000>, <150000000>,
-			<100000000>, <200000000>;
+			<26000000>;
 	};
 
 	usb20_otg: usb@ff300000 {
-- 
2.20.1

