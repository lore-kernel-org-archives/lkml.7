Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BA2ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B39218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 22:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbfJIWkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:40:16 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53175 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbfJIWkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 18:40:14 -0400
X-Originating-IP: 86.202.229.42
Received: from localhost (lfbn-lyo-1-146-42.w86-202.abo.wanadoo.fr [86.202.229.42])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id AAADA40008;
        Wed,  9 Oct 2019 22:40:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/8] ARM: dts: at91: sama5d2: add TCB GCLK
Date:   Thu, 10 Oct 2019 00:40:01 +0200
Message-Id: <20191009224006.5021-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
References: <20191009224006.5021-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sama5d2 tcbs take an extra input clock, their gclk.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2e2c1a7b1d1d..f878d7866970 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -495,23 +495,23 @@
 			};
 
 			tcb0: timer@f800c000 {
-				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xf800c000 0x100>;
 				interrupts = <35 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&clk32k>;
-				clock-names = "t0_clk", "slow_clk";
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_GCK 35>, <&clk32k>;
+				clock-names = "t0_clk", "gclk", "slow_clk";
 			};
 
 			tcb1: timer@f8010000 {
-				compatible = "atmel,at91sam9x5-tcb", "simple-mfd", "syscon";
+				compatible = "atmel,sama5d2-tcb", "simple-mfd", "syscon";
 				#address-cells = <1>;
 				#size-cells = <0>;
 				reg = <0xf8010000 0x100>;
 				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>, <&clk32k>;
-				clock-names = "t0_clk", "slow_clk";
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>, <&pmc PMC_TYPE_GCK 36>, <&clk32k>;
+				clock-names = "t0_clk", "gclk", "slow_clk";
 			};
 
 			hsmc: hsmc@f8014000 {
-- 
2.21.0

