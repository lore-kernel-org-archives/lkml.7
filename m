Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10115C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D482087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 00:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="pmBv5ZmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfC0A1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 20:27:53 -0400
Received: from vps.xff.cz ([195.181.215.36]:53790 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfC0A1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 20:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553645935; bh=hix23JteI8Gnawnkk7CYam4uCur8J7Owg3iSq2HxzIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmBv5ZmVMA7kiI5p7tz9w4OXo9RlP+/ytJFPEfwQwWXSqJp5ZSI5Xr2aRs1ZPDhl2
         DopIrtI5bv4FhwXhUeFDeqieRH9BjW/Pm2VoAu2qXsp/LtEhgSO/4BleubOIQJg5n6
         GAr4ZVaJm/HdwWLR9fQ3efbyfUREIkpxyGpf56Ag=
From:   megous@megous.com
To:     maxime.ripard@free-electrons.com, wens@csie.org, robh@kernel.org,
        johan@kernel.org, mark.rutland@arm.com
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 1/7] ARM: dts: sun8i: tbs-a711: Enable bluetooth
Date:   Wed, 27 Mar 2019 01:18:37 +0100
Message-Id: <20190327001843.2420-2-megous@megous.com>
In-Reply-To: <20190327001843.2420-1-megous@megous.com>
References: <20190327001843.2420-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

TBS A711 tablet has a bcm20702a1 bluetooth chip (part of AP6210 WiFi/BT
module) connected to UART1. Add node for the blutooth chip.

The driver needs brcm/BCM20702A1.hcd firmware file to run.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 1e840ab5a541..6aae70c89a1e 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -406,7 +406,20 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm20702a1";
+		clocks = <&ac100_rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_vbat>;
+		vddio-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+		host-wakeup-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		shutdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		max-speed = <1500000>;
+	};
 };
 
 &usb_otg {
-- 
2.21.0

