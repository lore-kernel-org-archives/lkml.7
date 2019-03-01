Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6E8C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB144218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfCACOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:14:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41670 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725896AbfCACOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:14:24 -0500
X-UUID: 0318acd61d9b4d9296986d1fdbb00a07-20190301
X-UUID: 0318acd61d9b4d9296986d1fdbb00a07-20190301
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 97358672; Fri, 01 Mar 2019 10:14:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Mar 2019 10:14:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Mar 2019 10:14:10 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: net: bluetooth: add support for MediaTek MT7663U and MT7668U UART devices
Date:   Fri, 1 Mar 2019 10:14:07 +0800
Message-ID: <937e729bab743a5e1c0f74db789064de2d078241.1551405664.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1551405664.git.sean.wang@mediatek.com>
References: <cover.1551405664.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E4A479C784B4D73BCF107209ED08A0004351E035A710CF03884C6DB4DB123B1D2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update binding document with adding support of MT7663U and MT7668U UART
devices to mediatek-bluetooth.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../bindings/net/mediatek-bluetooth.txt       | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
index 14ceb2a5b4e8..41a7dcc80f5b 100644
--- a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
@@ -33,3 +33,67 @@ Example:
 			clock-names = "ref";
 		};
 	};
+
+MediaTek UART based Bluetooth Devices
+==================================
+
+This device is a serial attached device to UART device and thus it must be a
+child node of the serial node with UART.
+
+Please refer to the following documents for generic properties:
+
+	Documentation/devicetree/bindings/serial/slave-device.txt
+
+Required properties:
+
+- compatible:	Must be
+		  "mediatek,mt7663u-bluetooth": for MT7663U device
+		  "mediatek,mt7668u-bluetooth": for MT7668U device
+- vcc-supply:	Main voltage regulator
+- pinctrl-names: Should be "default", "runtime"
+- pinctrl-0: Should contain UART RXD low when the device is powered up to
+	     enter proper bootstrap mode.
+- pinctrl-1: Should contain UART mode pin ctrl
+
+Optional properties:
+
+- reset-gpios:	GPIO used to reset the device whose initial state keeps low,
+		if the GPIO is missing, then board-level design should be
+		guaranteed.
+- current-speed:  Current baud rate of the device whose defaults to 921600
+
+Example:
+
+	uart1_pins_boot: uart1-default {
+		pins-dat {
+			pinmux = <MT7623_PIN_81_URXD1_FUNC_GPIO81>;
+			output-low;
+		};
+	};
+
+	uart1_pins_runtime: uart1-runtime {
+		pins-dat {
+			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
+				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
+		};
+	};
+
+	uart1: serial@11003000 {
+		compatible = "mediatek,mt7623-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11003000 0 0x400>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_UART1_SEL>,
+			 <&pericfg CLK_PERI_UART1>;
+		clock-names = "baud", "bus";
+
+		bluetooth {
+			compatible = "mediatek,mt7663u-bluetooth";
+			vcc-supply = <&reg_5v>;
+			reset-gpios = <&pio 24 GPIO_ACTIVE_LOW>;
+			pinctrl-names = "default", "runtime";
+			pinctrl-0 = <&uart1_pins_boot>;
+			pinctrl-1 = <&uart1_pins_runtime>;
+			current-speed = <921600>;
+		};
+	};
-- 
2.18.0

