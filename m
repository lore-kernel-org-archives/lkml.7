Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7427DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA0D2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="fYNU1kDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbfC0A1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:27:55 -0400
Received: from vps.xff.cz ([195.181.215.36]:53794 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732433AbfC0A1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553645935; bh=e0nnK3rTomZ/ylsbcx/9arI5/NLZs1j94ZDpFtu3D0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYNU1kDGlQjGU/t9NjO/hEQoxy/v5tKR7aYDUKpUoMcM3lHzZrVXsdu55Ha9WBO9P
         sfSVQZNX0cRFzTPbJI8SALaFZfrLTHrRsVes5rEmhnrZoHS7jTdnRuMd9emUaLeOSH
         9po1tgXfC/tlKwUFBtQoZ9i5J8zHTob5+UFyWde0=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 2/7] ARM: dts: sun8i: tbs-a711: Add node for BMA250 accelerometer
Date:   Wed, 27 Mar 2019 01:18:38 +0100
Message-Id: <20190327001843.2420-3-megous@megous.com>
In-Reply-To: <20190327001843.2420-1-megous@megous.com>
References: <20190327001843.2420-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

A711 tablet has BMA250 accelerometer connected to I2C1 bus. Enable
both the I2C1 bus and add the accelerometer device to it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 6aae70c89a1e..347fc0c31fa4 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -156,6 +156,21 @@
 	status = "okay";
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Accelerometer */
+	bma250@18 {
+		compatible = "bosch,bma250";
+		reg = <0x18>;
+		interrupt-parent = <&pio>;
+		interrupts = <7 10 IRQ_TYPE_EDGE_RISING>; /* PH10 / EINT10 */
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	pinctrl-names = "default";
-- 
2.21.0

