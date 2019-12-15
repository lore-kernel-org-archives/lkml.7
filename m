Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55963C2D0CA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D96822B48
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576429183;
	bh=XJDBfT1MU52M3nXB0FIH5aEUDPdxo5W3utk1GX6ZvZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VyUdBhtUnCs0CtHSCQ7adabCFGmDHMmjXuBO0II1gu5p0aVaagzx4zNhi0m9dPvwp
	 vbTltfep9psXcOsu8d5nnGqS0OIO1JfUfkZ08Mi1d5OuhF9T4MnOCrULS6u0GPItUr
	 PGe7pib0uIh6TcifKcFSloVeKyVs0+mg2SV+XKpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfLOQ7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 11:59:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfLOQ7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 11:59:32 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A99924684;
        Sun, 15 Dec 2019 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576429171;
        bh=XJDBfT1MU52M3nXB0FIH5aEUDPdxo5W3utk1GX6ZvZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2bwAHaRcZ6+BOhTn9UUxARreLZGOTNh7g0sSK1CBJt1a5N1twqKmQOEoEIYdOdmIX
         T+ehJNtBF6OEyeU/hozCAzX5MCYP0K91k0sruHYnMrPOKLJ1qD8OPkVQVUEWtiw9Zt
         yvQfaHHpwLOPsEJBmzK2iKO4LjvLNqrJ1zr2lX7c=
Received: by wens.tw (Postfix, from userid 1000)
        id 732195FF1A; Mon, 16 Dec 2019 00:59:26 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 09/14] ARM: dts: sun8i: r40: Add I2C pinmux options
Date:   Mon, 16 Dec 2019 00:59:19 +0800
Message-Id: <20191215165924.28314-10-wens@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191215165924.28314-1-wens@kernel.org>
References: <20191215165924.28314-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The R40 has five I2C controllers. Currently only I2C0 has its pinmux
option defined.

Add the options for the remaining four, and set them as the default,
since each controller has only one possible pinmux configuration.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 421dfbbfd7ee..82ea0b5b0710 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -373,6 +373,26 @@ i2c0_pins: i2c0-pins {
 				function = "i2c0";
 			};
 
+			i2c1_pins: i2c1-pins {
+				pins = "PB18", "PB19";
+				function = "i2c1";
+			};
+
+			i2c2_pins: i2c2-pins {
+				pins = "PB20", "PB21";
+				function = "i2c2";
+			};
+
+			i2c3_pins: i2c3-pins {
+				pins = "PI0", "PI1";
+				function = "i2c3";
+			};
+
+			i2c4_pins: i2c4-pins {
+				pins = "PI2", "PI3";
+				function = "i2c4";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
@@ -528,6 +548,8 @@ i2c1: i2c@1c2b000 {
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C1>;
 			resets = <&ccu RST_BUS_I2C1>;
+			pinctrl-0 = <&i2c1_pins>;
+			pinctrl-names = "default";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -539,6 +561,8 @@ i2c2: i2c@1c2b400 {
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C2>;
 			resets = <&ccu RST_BUS_I2C2>;
+			pinctrl-0 = <&i2c2_pins>;
+			pinctrl-names = "default";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -550,6 +574,8 @@ i2c3: i2c@1c2b800 {
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C3>;
 			resets = <&ccu RST_BUS_I2C3>;
+			pinctrl-0 = <&i2c3_pins>;
+			pinctrl-names = "default";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -561,6 +587,8 @@ i2c4: i2c@1c2c000 {
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C4>;
 			resets = <&ccu RST_BUS_I2C4>;
+			pinctrl-0 = <&i2c4_pins>;
+			pinctrl-names = "default";
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.24.0

