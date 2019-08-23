Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7282BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456B5233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 09:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="lxilk2ZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfHWJmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 05:42:35 -0400
Received: from vps.xff.cz ([195.181.215.36]:51812 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387777AbfHWJmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 05:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1566553352; bh=1Cw9Xa/6TDBO8NX8xFz1oE/pjRmfY5YYNJ0SmLr41QE=;
        h=From:To:Cc:Subject:Date:From;
        b=lxilk2ZN5+GuOYV2xnSk5104SvjdE8bG+YgWkZ8SBxJgtHVwvOkY/K9F07H+54vyQ
         2gFdNcSfft/JWqmYqycNFAlC1kYrDzXlDr3oF0ohBAdqOB0sHL9KgFD6lmbFjtLlag
         E6Ym8NYOqd9Ku70XRS/nQCGtSGwwmCELaj9FzcOA=
From:   megous@megous.com
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ondrej Jirman <megous@megous.com>
Subject: [PATCH] arm64: dts: allwinner: orange-pi-3: Enable WiFi
Date:   Fri, 23 Aug 2019 11:42:28 +0200
Message-Id: <20190823094228.6540-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Orange Pi 3 has AP6256 WiFi/BT module. WiFi part of the module is called
bcm43356 and can be used with the brcmfmac driver. The module is powered by
the two always on regulators (not AXP805).

WiFi uses a PG port with 1.8V voltage level signals. SoC needs to be
configured so that it sets up an 1.8V input bias on this port. This is done
by the pio driver by reading the vcc-pg-supply voltage.

You'll need a fw_bcm43456c5_ag.bin firmware file and nvram.txt
configuration that can be found in the Xulongs's repository for H6:

https://github.com/orangepi-xunlong/OrangePiH6_external/tree/master/ap6256

Mainline brcmfmac driver expects the firmware and nvram at the following
paths relative to the firmware directory:

  brcm/brcmfmac43456-sdio.bin
  brcm/brcmfmac43456-sdio.txt

Signed-off-by: Ondrej Jirman <megous@megous.com>
---

Since RTC patches for H6 were merged, this can now go in too, if it looks ok.

Other patches for this WiFi chip support were merged in previous cycles,
so this just needs enabling in DTS now.

Sorry for the links in the commit log, but this information is useful,
even if the link itself goes bad. Any pointer what to google for
(file names, tree name) is great for anyone searching in the future.

Please take a look.

Thank you,
	Ondrej

 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index eda9d5f640b9..49d954369087 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -56,6 +56,34 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 	};
+
+	reg_vcc33_wifi: vcc33-wifi {
+		/* Always on 3.3V regulator for WiFi and BT */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc33-wifi";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc5v>;
+	};
+
+	reg_vcc_wifi_io: vcc-wifi-io {
+		/* Always on 1.8V/300mA regulator for WiFi and BT IO */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-wifi-io";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc33_wifi>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
+		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
+		post-power-on-delay-ms = <200>;
+	};
 };
 
 &cpu0 {
@@ -91,6 +119,25 @@
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_vcc33_wifi>;
+	vqmmc-supply = <&reg_vcc_wifi_io>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcm: sdio-wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <1 0 IRQ_TYPE_LEVEL_LOW>; /* PM0 */
+		interrupt-names = "host-wake";
+	};
+};
+
 &ohci0 {
 	status = "okay";
 };
@@ -102,6 +149,7 @@
 &pio {
 	vcc-pc-supply = <&reg_bldo2>;
 	vcc-pd-supply = <&reg_cldo1>;
+	vcc-pg-supply = <&reg_vcc_wifi_io>;
 };
 
 &r_i2c {
-- 
2.23.0

