Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97D0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E452073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555396837;
	bh=asHhf97KSDRJRJFDggNFWple/eiLgg3HUxDLzyWEBQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JA5MTeQjzDnl5xsds/Pp1r9qcsSVoaa+EqnCvHAOZTOHrdX5mGpX5XeTonKwcwMeS
	 7pTRJuUBlDTQD0iv+cWCPOWh2C3IE54lw1SEJaL26MGkipF23K0ZFJfKFQDWZXHPBV
	 QNNXfdDXxRo3+bxRUXIE0p477j32qQxGbwVO67Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfDPGkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:40:36 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34028 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfDPGka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:40:30 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id ADEFE602FC; Tue, 16 Apr 2019 14:40:25 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 7/7] ARM: dts: sun8i: a83t: Enable USB OTG controller on some boards
Date:   Tue, 16 Apr 2019 14:40:24 +0800
Message-Id: <20190416064024.20414-8-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416064024.20414-1-wens@kernel.org>
References: <20190416064024.20414-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Bananapi M3 and Cubietruck Plus both have USB OTG ports wired to the
SoC and PMIC in the same way, with the N_VBUSEN pin on the PMIC
controlling VBUS output, the PMIC's VBUS input for sensing VBUS, and
PH11 on the SoC for sensing the ID pin.

Enable OTG on both boards.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts     | 12 ++++++++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 838be7b3715f..9d34eabba121 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -389,7 +389,19 @@
 	};
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
+	usb0_id_det-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index fcbec3d7ccd7..ea299d3d84d0 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -420,7 +420,19 @@
 	};
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
+	usb0_id_det-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
+	usb0_vbus_power-supply = <&usb_power_supply>;
+	usb0_vbus-supply = <&reg_drivevbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
-- 
2.20.1

