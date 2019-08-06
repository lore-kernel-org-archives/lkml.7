Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4495C32754
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA68B217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="lnXlBBf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbfHFP5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:57:53 -0400
Received: from vps.xff.cz ([195.181.215.36]:55380 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387490AbfHFP5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1565107071; bh=eZIRAtXh9rUuple04Feis2vfaVq0NzLnMtCBPANF3QE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lnXlBBf+jstPnp1QJOMMwnWUm+zMG/CvoIbPiF0pcKmpju+6fTy+aqPWZsyCfb0Kl
         6DYBcxnb7hWnMQ9VzTD5UwWJCdmMB9abijaiWUxEkoB+ErusmwSQQhNoNv4PRlS+Ze
         9ehCkcxu/x7HwNQWJbIgwd9yVUY0aLXyDN5JdHcU=
From:   megous@megous.com
To:     linux-sunxi@googlegroups.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Ondrej Jirman <megous@megous.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/4] arm64: dts: allwinner: orange-pi-3: Enable ethernet
Date:   Tue,  6 Aug 2019 17:57:40 +0200
Message-Id: <20190806155744.10263-2-megous@megous.com>
In-Reply-To: <20190806155744.10263-1-megous@megous.com>
References: <20190806155744.10263-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Orange Pi 3 has two regulators that power the Realtek RTL8211E. According
to the phy datasheet, both regulators need to be enabled at the same time,
but we can only specify a single phy-supply in the DT.

This can be achieved by making one regulator depedning on the other via
vin-supply. While it's not a technically correct description of the
hardware, it achieves the purpose.

All values of RX/TX delay were tested exhaustively and a middle one of the
working values was chosen.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 17d496990108..2c6807b74ff6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -15,6 +15,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &emac;
 	};
 
 	chosen {
@@ -44,6 +45,27 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 	};
+
+	/*
+	 * The board uses 2.5V RGMII signalling. Power sequence to enable
+	 * the phy is to enable GMAC-2V5 and GMAC-3V (aldo2) power rails
+	 * at the same time and to wait 100ms.
+	 */
+	reg_gmac_2v5: gmac-2v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+
+		/* The real parent of gmac-2v5 is reg_vcc5v, but we need to
+		 * enable two regulators to power the phy. This is one way
+		 * to achieve that.
+		 */
+		vin-supply = <&reg_aldo2>; /* GMAC-3V */
+	};
 };
 
 &cpu0 {
@@ -58,6 +80,28 @@
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_gmac_2v5>;
+	allwinner,rx-delay-ps = <1500>;
+	allwinner,tx-delay-ps = <700>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+
+		reset-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
+		reset-assert-us = <15000>;
+		reset-deassert-us = <40000>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-- 
2.22.0

