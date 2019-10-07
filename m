Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E2ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373AC21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="qZu3yKxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfJGUcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:32:10 -0400
Received: from vps.xff.cz ([195.181.215.36]:46270 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbfJGUcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1570480327; bh=Zdq7TsrioBhNJ4nRUcC5Dq41WDeZro1CErpIBoxFFlk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qZu3yKxvXIgZ6M9g+fSwLTvYIYJqSTLyWHm91zPfZqj615BCwzyCtg9tka+f9NYhX
         BooT4yvuwH0xZMINkfmPnGxUDmjd26JQROGYcoAegmIRa8HQmyPRvK3bKXcILkbOLQ
         6tOPQkCXqMA1L7R4WTusX+R/+W/YVBtzB4jYzzx8=
From:   megous@megous.com
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>
Subject: [RESEND PATCH 2/2] arm64: dts: allwinner: orange-pi-3: Enable UART1 / Bluetooth
Date:   Mon,  7 Oct 2019 22:31:52 +0200
Message-Id: <20191007203152.3889947-3-megous@megous.com>
In-Reply-To: <20191007203152.3889947-1-megous@megous.com>
References: <20191007203152.3889947-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The board contains AP6256 WiFi/BT module that has its bluetooth part
connected to SoC's UART1 port. Enable this port, and add node for the
bluetooth device.

Bluetooth part is named bcm4345c5.

You'll need a BCM4345C5.hcd firmware file that can be found in the
Xulongs's repository for H6:

https://github.com/orangepi-xunlong/OrangePiH6_external/tree/master/ap6256

The driver expects the firmware at the following path relative to the
firmware directory:

  brcm/BCM4345C5.hcd

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 49d954369087..a9e776446c35 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -15,6 +15,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		serial1 = &uart1;
 	};
 
 	chosen {
@@ -271,6 +272,24 @@
 	status = "okay";
 };
 
+/* There's the BT part of the AP6256 connected to that UART */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&rtc 1>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&r_pio 1 2 GPIO_ACTIVE_HIGH>; /* PM2 */
+		host-wakeup-gpios = <&r_pio 1 1 GPIO_ACTIVE_HIGH>; /* PM1 */
+		shutdown-gpios = <&r_pio 1 4 GPIO_ACTIVE_HIGH>; /* PM4 */
+		max-speed = <1500000>;
+	};
+};
+
 &usb2otg {
 	/*
 	 * This board doesn't have a controllable VBUS even though it
-- 
2.23.0

