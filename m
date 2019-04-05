Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12A7C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC2C21855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDEU6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:58:00 -0400
Received: from hermes.aosc.io ([199.195.250.187]:36963 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEU57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:57:59 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 789C06CDF8;
        Fri,  5 Apr 2019 20:57:56 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v5 2/5] dt-bindings: phy: add binding for Allwinner USB3 PHY
Date:   Sat,  6 Apr 2019 04:57:33 +0800
Message-Id: <20190405205736.55177-3-icenowy@aosc.io>
In-Reply-To: <20190405205736.55177-1-icenowy@aosc.io>
References: <20190405205736.55177-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
external USB3 pins of the SoC.

Add a device tree binding for the PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v5:
- Dropped Vbus regulator and added connector subnode.

Changes in v4:
- Changed Vbus regulator property to vbus-supply.

Changes in v3:
- Added Chen-Yu's Review tag.

No changes in v2, v1.

 .../bindings/phy/sun50i-usb3-phy.txt          | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
new file mode 100644
index 000000000000..eeedc53e6360
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
@@ -0,0 +1,28 @@
+Allwinner sun50i USB3 PHY
+-----------------------
+
+Required properties:
+- compatible : should be one of
+  * allwinner,sun60i-h6-usb3-phy
+- reg : a list of offset + length pairs
+- #phy-cells : from the generic phy bindings, must be 0
+- clocks : phandle + clock specifier for the phy clock
+- resets : phandle + reset specifier for the phy reset
+
+Optional nodes:
+- connector : A sub-node required for representing the connector connected
+	      to the USB PHY. See ../connector/usb-connector.txt for details.
+
+Example:
+	usb3phy: phy@5210000 {
+		compatible = "allwinner,sun50i-h6-usb3-phy";
+		reg = <0x5210000 0x10000>;
+		clocks = <&ccu CLK_USB_PHY1>;
+		resets = <&ccu RST_USB_PHY1>;
+		#phy-cells = <0>;
+
+		connector {
+			compatible = "usb-a-connector";
+			label = "USB3";
+		};
+	};
-- 
2.18.1

