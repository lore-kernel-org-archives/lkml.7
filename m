Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E151BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 09:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6942067B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 09:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfJ0JKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 05:10:01 -0400
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:21925 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbfJ0JKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 05:10:01 -0400
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id x9R99gMa087451
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 27 Oct 2019 17:09:42 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.74.79) by BJMBX01.spreadtrum.com (10.0.64.7)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sun, 27 Oct 2019 17:09:48
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 2/2] arm64: dts: Add SC9863A emmc and sd card nodes
Date:   Sun, 27 Oct 2019 17:09:03 +0800
Message-ID: <20191027090904.14349-3-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027090904.14349-1-chunyan.zhang@unisoc.com>
References: <20191027090904.14349-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.79]
X-ClientProxiedBy: shcas04.spreadtrum.com (10.29.35.89) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com x9R99gMa087451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add emmc and sd card devicetree nodes for SC9863A.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/sc9863a.dtsi     | 31 +++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts | 16 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index ceecf551fd01..e3ae64cc214a 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -626,5 +626,36 @@
 				};
 			};
 		};
+
+		ap-ahb {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			sdio0: sdio@20300000 {
+				compatible  = "sprd,sdhci-r11";
+				reg = <0 0x20300000 0 0x1000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+
+				clock-names = "sdio", "enable";
+				clocks = <&aon_clk CLK_SDIO0_2X>,
+					 <&apahb_gate CLK_SDIO0_EB>;
+				assigned-clocks = <&aon_clk CLK_SDIO0_2X>;
+				assigned-clock-parents = <&rpll CLK_RPLL_390M>;
+			};
+
+			sdio3: sdio@20600000 {
+				compatible  = "sprd,sdhci-r11";
+				reg = <0 0x20600000 0 0x1000>;
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+
+				clock-names = "sdio", "enable";
+				clocks = <&aon_clk CLK_EMMC_2X>,
+					 <&apahb_gate CLK_EMMC_EB>;
+				assigned-clocks = <&aon_clk CLK_EMMC_2X>;
+				assigned-clock-parents = <&rpll CLK_RPLL_390M>;
+			};
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
index b6fbb5ca37e1..14673a1e52cb 100644
--- a/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
@@ -38,3 +38,19 @@
 &uart1 {
 	status = "okay";
 };
+
+&sdio0 {
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
+&sdio3 {
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
-- 
2.20.1


