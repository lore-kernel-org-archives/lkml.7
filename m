Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB17CC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8140F20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfDWIen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:34:43 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50141 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfDWIel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:34:41 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D78CEFF824;
        Tue, 23 Apr 2019 08:34:35 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v5 6/6] arm64: dts: marvell: Add cpu clock node on Armada 7K/8K
Date:   Tue, 23 Apr 2019 10:33:54 +0200
Message-Id: <20190423083354.17785-7-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423083354.17785-1-gregory.clement@bootlin.com>
References: <20190423083354.17785-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpu clock node on AP

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi | 4 ++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
index 2baafe12ebd4..472211159979 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
@@ -20,24 +20,28 @@
 			compatible = "arm,cortex-a72";
 			reg = <0x000>;
 			enable-method = "psci";
+			clocks = <&cpu_clk 0>;
 		};
 		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x001>;
 			enable-method = "psci";
+			clocks = <&cpu_clk 0>;
 		};
 		cpu2: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x100>;
 			enable-method = "psci";
+			clocks = <&cpu_clk 1>;
 		};
 		cpu3: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x101>;
 			enable-method = "psci";
+			clocks = <&cpu_clk 1>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 91dad7e4ee59..2db27c89427b 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -280,6 +280,13 @@
 				#address-cells = <1>;
 				#size-cells = <1>;
 
+				cpu_clk: clock-cpu@0 {
+					compatible = "marvell,ap806-cpu-clock";
+					clocks = <&ap_clk 0>, <&ap_clk 1>;
+					#clock-cells = <1>;
+					reg = <0x0 0x1000>;
+				};
+
 				ap_thermal: thermal-sensor@80 {
 					compatible = "marvell,armada-ap806-thermal";
 					reg = <0x80 0x10>;
-- 
2.20.1

