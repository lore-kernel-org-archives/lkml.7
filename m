Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B711720989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfCRM4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:56:19 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60321 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCRM4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:56:19 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0E332FF805;
        Mon, 18 Mar 2019 12:56:16 +0000 (UTC)
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i: a23/a33: Add R_I2C Controller
Date:   Mon, 18 Mar 2019 13:56:13 +0100
Message-Id: <20190318125613.25268-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A23 and A33 both have an I2C controller in the ARISC domain, that share
the same pins with the RSB bus.

Even if it's an unusual configuration, that device can be used to drive the
PMIC, so let's use it.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 43fe215e83ea..2eed7a2d7d7e 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -799,6 +799,20 @@
 			status = "disabled";
 		};
 
+		r_i2c: i2c@1f02400 {
+			compatible = "allwinner,sun8i-a23-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x01f02400 0x400>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c_pins>;
+			clocks = <&apb0_gates 6>;
+			resets = <&apb0_rst 6>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-a23-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
@@ -811,6 +825,12 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
+			r_i2c_pins: r-i2c-pins {
+				pins = "PL0", "PL1";
+				function = "s_i2c";
+				bias-pull-up;
+			};
+
 			r_rsb_pins: r-rsb-pins {
 				pins = "PL0", "PL1";
 				function = "s_rsb";
-- 
2.20.1

