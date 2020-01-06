Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99645C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704A1215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578301114;
	bh=PM6tQDY3S9hYgHrxWz2QJsPaSBxxGwz5ukhamBiZ/qU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=w6y0M1/SpauWZ0f+8AbI2Kd5mGlJksCi1pGcxD5qmT9v0O1V84l3b7k0ps7IzlOYJ
	 tLaeIhZMnwEK7RCiNMjWL79s76SR9huYvEaMctrwKou111rL9+hBC9b9ixYbQ+9405
	 dsmaJ7lmQu8s4+kbaYx0Prcs0gPZ05/oEIAVkWx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgAFI6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:58:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFI6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:58:33 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAB020848;
        Mon,  6 Jan 2020 08:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578301112;
        bh=PM6tQDY3S9hYgHrxWz2QJsPaSBxxGwz5ukhamBiZ/qU=;
        h=From:To:Cc:Subject:Date:From;
        b=j1jGC9mWPBlAwTAZNn7b3Wn0Po4MmwWAuEDHA9AF5WkvLC5zXBn6uEq4PO6FUIr3b
         CniQuTpixC861XPSnH2ujOWgpikNCM4PY73a90KCxXGANWqnNfckbsniUt9eeSk8IA
         bI7s670ACfE7GqyW/ghEG/Blj0rkZb8ecI4ajKgY=
Received: by wens.tw (Postfix, from userid 1000)
        id 3712E5FC12; Mon,  6 Jan 2020 16:58:29 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: h5: Add Libre Computer ALL-H5-CC H5 board
Date:   Mon,  6 Jan 2020 16:58:20 +0800
Message-Id: <20200106085820.7082-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Libre Computer ALL-H5-CC board is an upgraded version of the
ALL-H3-CC. Changes include:

  - Gigabit Ethernet via external RTL8211E Ethernet PHY
  - 16 MiB SPI NOR flash memory
  - PoE tap header
  - Line out jack removed

Only H5 variant test samples were made available, and the vendor is not
certain whether other SoC variants would be made or not. Furthermore the
board is a minor upgrade compared to the ALL-H3-CC. Thus the device tree
simply includes the one for the ALL-H3-CC, and adds the changes on top.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../sun50i-h5-libretech-all-h5-cc.dts         | 61 +++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index dc035a06454e..327ce6730823 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -347,6 +347,11 @@ properties:
           - const: libretech,all-h3-it-h5
           - const: allwinner,sun50i-h5
 
+      - description: Libre Computer Board ALL-H5-CC H5
+        items:
+          - const: libretech,all-h5-cc-h5
+          - const: allwinner,sun50i-h5
+
       - description: Lichee Pi One
         items:
           - const: licheepi,licheepi-one
diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index a7fdf04ffca2..cf4f78617c3f 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -16,6 +16,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-bananapi-m2-plus-v1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-emlid-neutis-n5-devboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-cc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h3-it.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-libretech-all-h5-cc.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dts
new file mode 100644
index 000000000000..df1b9263ad0e
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Chen-Yu Tsai <wens@csie.org>
+
+#include "sun50i-h5-libretech-all-h3-cc.dts"
+
+/ {
+	model = "Libre Computer Board ALL-H5-CC H5";
+	compatible = "libretech,all-h5-cc-h5", "allwinner,sun50i-h5";
+
+	aliases {
+		spi0 = &spi0;
+	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <5000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+		vin-supply = <&reg_vcc5v0>;
+	};
+};
+
+&codec {
+	/* No line out; only onboard microphone */
+	allwinner,audio-routing =
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+};
+
+/* This board has external PHY */
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+	/delete-property/ allwinner,leds-active-low;
+	status = "okay";
+};
+
+&external_mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&spi0  {
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+	};
+};
-- 
2.24.1

