Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D3AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19D720869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389454AbfDRPLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:11:48 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:44972 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:11:45 -0400
Received: from pgsop.sopnet.com.ar (unknown [179.40.38.12])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id C139F7B307D;
        Thu, 18 Apr 2019 12:11:34 -0300 (-03)
From:   Pablo Greco <pgreco@centosproject.org>
To:     linux-sunxi@googlegroups.com
Cc:     Pablo Greco <pgreco@centosproject.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] ARM: dts: sun8i: v40: bananapi-m2-berry: Add Bluetooth device node
Date:   Thu, 18 Apr 2019 12:11:20 -0300
Message-Id: <1555600282-9405-6-git-send-email-pgreco@centosproject.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555600282-9405-1-git-send-email-pgreco@centosproject.org>
References: <1555600282-9405-1-git-send-email-pgreco@centosproject.org>
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: C139F7B307D.A4079
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the bananapi-m2-ultra and the bananapi-m2-berry have the same
WiFi/Bluetooth, add the required nodes to the bananapi-m2-berry.

Signed-off-by: Pablo Greco <pgreco@centosproject.org>
---
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index 78f4a1a..3d0bb7e 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -96,6 +96,8 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
+		clocks = <&ccu CLK_OUTA>;
+		clock-names = "ext_clock";
 	};
 };
 
@@ -171,6 +173,11 @@
 	status = "okay";
 };
 
+&pio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&clk_out_a_pin>;
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <2500000>;
@@ -268,6 +275,25 @@
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pg_pins>, <&uart3_rts_cts_pg_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&ccu CLK_OUTA>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dldo2>;
+		vddio-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
+		/* TODO host wake line connected to PMIC GPIO pins */
+		shutdown-gpios = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
+		max-speed = <1500000>;
+	};
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_vcc5v0>;
 	status = "okay";
-- 
1.8.3.1

