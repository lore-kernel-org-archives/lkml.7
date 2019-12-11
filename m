Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D71C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74862464B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfLKNYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:24:05 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:17383 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfLKNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:24:05 -0500
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Wed, 11 Dec 2019
 21:24:35 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: meson: add A1 periphs and PLL clock nodes
Date:   Wed, 11 Dec 2019 21:23:59 +0800
Message-ID: <20191211132359.53647-1-jian.hu@amlogic.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add A1 periphs and PLL clock controller nodes, Some clocks
in periphs controller are the parents of PLL clocks, Meanwhile
some clocks in PLL controller are those of periphs clocks.
They rely on each other.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
Compared with the previous series, the register region
is only for the clock. So syscon is not used in A1.

This patch depends on A1 clock patchset at [0]

Changes since v1 at [1]:
-remove the compared message in commit description,
 And put it after the '---'
-reorder order the includes
-reorder the clock node
-change the clock node name

[0] https://lkml.kernel.org/r/20191206074052.15557-1-jian.hu@amlogic.com
[1] https://lkml.kernel.org/r/20191211070835.83489-1-jian.hu@amlogic.com

---
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index 7210ad049d1d..48ba3eba547d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -3,6 +3,8 @@
  * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/a1-pll-clkc.h>
+#include <dt-bindings/clock/a1-clkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -74,6 +76,21 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
 
+			clkc_periphs: clock-controller@800 {
+				compatible = "amlogic,a1-periphs-clkc";
+				#clock-cells = <1>;
+				reg = <0 0x800 0 0x104>;
+				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
+					 <&clkc_pll CLKID_FCLK_DIV3>,
+					 <&clkc_pll CLKID_FCLK_DIV5>,
+					 <&clkc_pll CLKID_FCLK_DIV7>,
+					 <&clkc_pll CLKID_HIFI_PLL>,
+					 <&xtal>;
+				clock-names = "fclk_div2", "fclk_div3",
+					      "fclk_div5", "fclk_div7",
+					      "hifi_pll", "xtal";
+			};
+
 			uart_AO: serial@1c00 {
 				compatible = "amlogic,meson-gx-uart",
 					     "amlogic,meson-ao-uart";
@@ -93,6 +110,15 @@
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			clkc_pll: clock-controller@7c80 {
+				compatible = "amlogic,a1-pll-clkc";
+				#clock-cells = <1>;
+				reg = <0 0x7c80 0 0x21c>;
+				clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
+					 <&clkc_periphs CLKID_XTAL_HIFIPLL>;
+				clock-names = "xtal_fixpll", "xtal_hifipll";
+			};
 		};
 
 		gic: interrupt-controller@ff901000 {
-- 
2.24.0

