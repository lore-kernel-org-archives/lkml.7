Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7CFC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E397420693
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="geI4nahi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfCYKD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:03:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33279 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfCYKDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:03:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so9373032wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiYphHszT1boPmgsGMzckEzxrSJiGDBV9O9U53D5dZ0=;
        b=geI4nahiemLBvlYgY6ecMbNBRWOJ//sJ600WY8df4KI+6Qx3CxptZzTJRYUcl8z3qN
         YsegQc0vLr62CEwDK+0bWZNFPWJFuHBqbcmNZranYf9lvlRM+ApujvAxYjbI3RX4SBnQ
         aDsPfNXg/N2qldzMTNXZpLJF2BdtjUHQ6FVBoOnNHTqe4ncMAaOPJ9Vqae9tZAzViS2a
         K+WQoOF2sKMZTUtGWYVQ9pHHL8YrBrVYW0qBy4wfcktbwb18zkLJHggGnnn2CQytzkDs
         uNLn/QpgvA4e2Nn4WKQWLddFnvHVOGldpALsznmnrJYzXnzbxqlyqOwucmRA8zfGDHu0
         0jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiYphHszT1boPmgsGMzckEzxrSJiGDBV9O9U53D5dZ0=;
        b=HBih7H3o5xG41sYvjQVg5S8GE5fi3OGel8MkpkVA5kvK7d5xwxoLpCs3D0jfPCLvXx
         fXU4HxWXFP689CklcMXDLDtxKN7phQzenyQ8zZZ4GGAPQZmHpT8tHOKqpVQzPuBqsWyZ
         8U7lJkpE/SDIqQDTXmwd6Od+5BouXdTW+R6vv59hXgLBoo/Npzas/Yehi/vlt9rNr7xW
         HLjFNGYoIHv/s5h2z/vUlCcdoE2QPTf3baB1lNdawL3RAWetmg+YhgtKbLOrdIsf1LfV
         2StlJiLcJNet1HH6vBCWFa1jYi6LFmD1M4Q2BKA19cczAjUj+mmuGUR1oFzGUCgShyrx
         VH5g==
X-Gm-Message-State: APjAAAWMeS9R0c5OFCGEWnSUm4oOF1wXTYIE9bVosQCtQ7aMDAtBrYyj
        e7wdkoUlZohH/UBa2h8+wgRWCg==
X-Google-Smtp-Source: APXvYqy7CSyp6ENjlTRU7AfpXx927Bz4QGMg9seXy80C6ZW+rZthEBOe+nqe+Ue913Cf1TtSNDiHsg==
X-Received: by 2002:a5d:6246:: with SMTP id m6mr15820702wrv.184.1553508224451;
        Mon, 25 Mar 2019 03:03:44 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g12sm11581215wrw.40.2019.03.25.03.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 03:03:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/3] arm64: dts: meson: g12a: Add G12A USB nodes
Date:   Mon, 25 Mar 2019 11:03:38 +0100
Message-Id: <20190325100339.749-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325100339.749-1-narmstrong@baylibre.com>
References: <20190325100339.749-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the nodes for the USB Complex found in the Amlogic
G12A SoC.

It includes the :
- 2 USB2 PHYs
- 1 USB3 + PCIE Combo PHY
- the USB Glue with it's DWC2 and DWC3 sub-nodes

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 4b3be7e60b4d..a9cd91f033f2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -3,11 +3,13 @@
  * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
  */
 
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/g12a-clkc.h>
 #include <dt-bindings/clock/g12a-aoclkc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
 
 / {
 	compatible = "amlogic,g12a";
@@ -175,6 +177,26 @@
 				};
 			};
 
+			usb2_phy0: phy@36000 {
+				compatible = "amlogic,g12a-usb2-phy";
+				reg = <0x0 0x36000 0x0 0x2000>;
+				clocks = <&xtal>;
+				clock-names = "xtal";
+				resets = <&reset RESET_USB_PHY20>;
+				reset-names = "phy";
+				#phy-cells = <0>;
+			};
+
+			usb2_phy1: phy@3a000 {
+				compatible = "amlogic,g12a-usb2-phy";
+				reg = <0x0 0x3a000 0x0 0x2000>;
+				clocks = <&xtal>;
+				clock-names = "xtal";
+				resets = <&reset RESET_USB_PHY21>;
+				reset-names = "phy";
+				#phy-cells = <0>;
+			};
+
 			hiu: bus@3c000 {
 				compatible = "simple-bus";
 				reg = <0x0 0x3c000 0x0 0x1400>;
@@ -195,6 +217,18 @@
 					};
 				};
 			};
+
+			usb3_pcie_phy: phy@46000 {
+				compatible = "amlogic,g12a-usb3-pcie-phy";
+				reg = <0x0 0x46000 0x0 0x2000>;
+				clocks = <&clkc CLKID_PCIE_PLL>;
+				clock-names = "ref_clk";
+				resets = <&reset RESET_PCIE_PHY>;
+				reset-names = "phy";
+				assigned-clocks = <&clkc CLKID_PCIE_PLL>;
+				assigned-clock-rates = <100000000>;
+				#phy-cells = <1>;
+			};
 		};
 
 		aobus: bus@ff800000 {
@@ -358,6 +392,47 @@
 				status = "disabled";
 			};
 		};
+
+		usb: usb@ffe09000 {
+			status = "disabled";
+			compatible = "amlogic,meson-g12a-usb-ctrl";
+			reg = <0x0 0xffe09000 0x0 0xa0>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&clkc CLKID_USB>;
+			resets = <&reset RESET_USB>;
+
+			dr_mode = "otg";
+
+			phys = <&usb2_phy0>, <&usb2_phy1>,
+			       <&usb3_pcie_phy PHY_TYPE_USB3>;
+			phy-names = "usb2-phy0", "usb2-phy1", "usb3-phy0";
+
+			dwc2: usb@ff400000 {
+				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
+				reg = <0x0 0xff400000 0x0 0x40000>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
+				clock-names = "ddr";
+				phys = <&usb2_phy1>;
+				dr_mode = "peripheral";
+				g-rx-fifo-size = <192>;
+				g-np-tx-fifo-size = <128>;
+				g-tx-fifo-size = <128 128 16 16 16>;
+			};
+
+			dwc3: usb@ff500000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff500000 0x0 0x100000>;
+				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				dr_mode = "host";
+				snps,dis_u2_susphy_quirk;
+				snps,quirk-frame-length-adjustment;
+			};
+		};
 	};
 
 	timer {
-- 
2.21.0

