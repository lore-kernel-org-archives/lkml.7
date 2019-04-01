Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F04C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0321120896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="RHr+r7m5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDAL4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:56:22 -0400
Received: from vps.xff.cz ([195.181.215.36]:57740 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDAL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554119779; bh=xsDRRopunoJOnvYG1WzHSSCPeJDvYoOT7KX/78WCQRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHr+r7m5OJVShrRXZn9+dKGcPPG1kUnyr+2nN+1lbdq87p+Wg+gV2g6npRM7nrri9
         TpTHs3f9vSlpBpRheDzJjnib+pg8eZlbNcc+cZCtye9we94w6NAiOr3RkOgkn+HRDm
         CNKoIjaEDkgm94CyEYZ3lmkTQPpKj8lPvp4j0+wM=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 1/5] ARM: dts: sun8i: tbs-a711: Add node for BMA250 accelerometer
Date:   Mon,  1 Apr 2019 13:56:12 +0200
Message-Id: <20190401115616.21337-2-megous@megous.com>
In-Reply-To: <20190401115616.21337-1-megous@megous.com>
References: <20190401115616.21337-1-megous@megous.com>
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
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 1e840ab5a541..d70fe04b66f0 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -156,6 +156,19 @@
 	status = "okay";
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Accelerometer */
+	accelerometer@18 {
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

