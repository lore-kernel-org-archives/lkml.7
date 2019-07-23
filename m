Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374C6C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1782520693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbfGWL2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:28:32 -0400
Received: from muru.com ([72.249.23.125]:55646 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389408AbfGWL23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:28:29 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 5078B81A0;
        Tue, 23 Jul 2019 11:28:53 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/8] ARM: dts: Drop bogus ahclkr clocks for dra7 mcasp 3 to 8
Date:   Tue, 23 Jul 2019 04:28:08 -0700
Message-Id: <20190723112811.44381-6-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723112811.44381-1-tony@atomide.com>
References: <20190723112811.44381-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ahclkr clkctrl clock bit 28 only exists for mcasp 1 and 2 on dra7.
Otherwise we get the following warning on beagle-x15:

ti-sysc 48468000.target-module: could not add child clock ahclkr: -19

Fixes: 5241ccbf2819 ("ARM: dts: Add missing ranges for dra7 mcasp l3 ports")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -2818,9 +2818,8 @@
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
 			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 0>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 24>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 28>;
-			clock-names = "fck", "ahclkx", "ahclkr";
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP3_CLKCTRL 24>;
+			clock-names = "fck", "ahclkx";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x68000 0x2000>,
@@ -2854,9 +2853,8 @@
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
 			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 0>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 24>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 28>;
-			clock-names = "fck", "ahclkx", "ahclkr";
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP4_CLKCTRL 24>;
+			clock-names = "fck", "ahclkx";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x6c000 0x2000>,
@@ -2890,9 +2888,8 @@
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
 			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 0>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 24>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 28>;
-			clock-names = "fck", "ahclkx", "ahclkr";
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP5_CLKCTRL 24>;
+			clock-names = "fck", "ahclkx";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x70000 0x2000>,
@@ -2926,9 +2923,8 @@
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
 			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 0>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 24>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 28>;
-			clock-names = "fck", "ahclkx", "ahclkr";
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP6_CLKCTRL 24>;
+			clock-names = "fck", "ahclkx";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x74000 0x2000>,
@@ -2962,9 +2958,8 @@
 					<SYSC_IDLE_SMART>;
 			/* Domains (P, C): l4per_pwrdm, l4per2_clkdm */
 			clocks = <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 0>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 24>,
-				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 28>;
-			clock-names = "fck", "ahclkx", "ahclkr";
+				 <&l4per2_clkctrl DRA7_L4PER2_MCASP7_CLKCTRL 24>;
+			clock-names = "fck", "ahclkx";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x78000 0x2000>,
-- 
2.21.0
