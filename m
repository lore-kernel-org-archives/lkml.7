Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9E0CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C8C20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WNtwQkYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfJUNX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:23:28 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53351 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfJUNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:23:28 -0400
Received: by mail-wm1-f54.google.com with SMTP id i16so13318906wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CDpQCC3yQaQMDA2jPXME+EFagP8LNoO6pNZidHidAbs=;
        b=WNtwQkYbCYYxfHd5g5Gg7/NxW/2r1vdfDzKQVM1p0GqmijVDR7ay0t8fQd49OhlVH8
         v1xTzmO7RCzs8DIzM+GC1R+O/e9f4IXYhWphWBnRs1g9+uSjZ/UW9LNNQ6R6Xe054ORJ
         rZW1kH/clT1ugXzyFKnFBKBW/sYlqn3lsi+OjTQ52Ws6u5zyNAJmXuHGRrGD/FU/o34N
         6VMaoced7C9knxUN7e5A0DpnK4WQdf+FwmTioMRySDT67OUqbhIt1+3pNerW9RgQp6Rt
         0DUE2wRdqWq04NS2c5o1sne3YLzKdy0wiW05agOS2RdADaTvlKraAjujh/a4cgF4HKUu
         o6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CDpQCC3yQaQMDA2jPXME+EFagP8LNoO6pNZidHidAbs=;
        b=ADzi/hglUhscskdXHo9MNyg/2WATC7yaVX7kvqKlMTMsukO3eG5ZifAyIs6D7+1RbU
         L+qjRaDmUr4biBPuDoxeA7/eLSH4a2tWJdv5xlFqbuSkirlZ0YdM+2jMMGc1hF/QsqDd
         TtINWoGmg12qrJ5S6Gb1IAWe/bUYYKZTk6rFMpVOKWbXccs/aAyT4Hk0ZX244MIbKGcL
         zd9DKF92TELseZ4EQ4EOKHaYwLtfBOA683kPlBnL1n24GR7Pp0RXtZVnkR0JPIb5wLW3
         d7LyGGSEkCTI/jB72ZA9OU3qMMSJYThVKhfKrvKEA1hQ83ewdUML6C3gnGy1Ew9kI/Ci
         cUHw==
X-Gm-Message-State: APjAAAVAgg15vuy8UdypAujnhJo9S0Maexr/o68j0QbWM48jadmZ+xNB
        R3A0F/d8UD0G6HQJilb/7wT/mw==
X-Google-Smtp-Source: APXvYqzMvhIv/kFvCKgvdmqwvVk+AwoAtWuBDkfvwp/J9cbsOyOGAGd2wS++y4H9TfIXc0XMmtYvFg==
X-Received: by 2002:a05:600c:3cb:: with SMTP id z11mr17883575wmd.134.1571664204796;
        Mon, 21 Oct 2019 06:23:24 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k8sm29169887wrg.15.2019.10.21.06.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 06:23:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] dt-bindings: usb: dwc3: Move Amlogic G12A DWC3 Glue Bindings to YAML schemas
Date:   Mon, 21 Oct 2019 15:23:22 +0200
Message-Id: <20191021132322.25256-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the DT validation in place, let's convert the device tree
bindings for the Amlogic G12A DWC3 Glue Bindings over to a YAML schemas,
the AXG and GXL glue bindings will be converted later.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/usb/amlogic,dwc3.txt  |  88 ------------
 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 132 ++++++++++++++++++
 2 files changed, 132 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt b/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
index b9f04e617eb7..9a8b631904fd 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
@@ -40,91 +40,3 @@ Example device nodes:
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};
-
-Amlogic Meson G12A DWC3 USB SoC Controller Glue
-
-The Amlogic G12A embeds a DWC3 USB IP Core configured for USB2 and USB3
-in host-only mode, and a DWC2 IP Core configured for USB2 peripheral mode
-only.
-
-A glue connects the DWC3 core to USB2 PHYs and optionnaly to an USB3 PHY.
-
-One of the USB2 PHY can be re-routed in peripheral mode to a DWC2 USB IP.
-
-The DWC3 Glue controls the PHY routing and power, an interrupt line is
-connected to the Glue to serve as OTG ID change detection.
-
-Required properties:
-- compatible:	Should be "amlogic,meson-g12a-usb-ctrl"
-- clocks:	a handle for the "USB" clock
-- resets:	a handle for the shared "USB" reset line
-- reg:		The base address and length of the registers
-- interrupts:	the interrupt specifier for the OTG detection
-- phys: 	handle to used PHYs on the system
-	- a <0> phandle can be used if a PHY is not used
-- phy-names:	names of the used PHYs on the system :
-	- "usb2-phy0" for USB2 PHY0 if USBHOST_A port is used
-	- "usb2-phy1" for USB2 PHY1 if USBOTG_B port is used
-	- "usb3-phy0" for USB3 PHY if USB3_0 is used
-- dr_mode:	should be "host", "peripheral", or "otg" depending on
-	the usage and configuration of the OTG Capable port.
-	- "host" and "peripheral" means a fixed Host or Device only connection
-	- "otg" means the port can be used as both Host or Device and
-	  be switched automatically using the OTG ID pin.
-
-Optional properties:
-- vbus-supply:	should be a phandle to the regulator controlling the VBUS
-		power supply when used in OTG switchable mode
-
-Required child nodes:
-
-A child node must exist to represent the core DWC3 IP block. The name of
-the node is not important. The content of the node is defined in dwc3.txt.
-
-A child node must exist to represent the core DWC2 IP block. The name of
-the node is not important. The content of the node is defined in dwc2.txt.
-
-PHY documentation is provided in the following places:
-- Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
-- Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
-
-Example device nodes:
-	usb: usb@ffe09000 {
-			compatible = "amlogic,meson-g12a-usb-ctrl";
-			reg = <0x0 0xffe09000 0x0 0xa0>;
-			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-
-			clocks = <&clkc CLKID_USB>;
-			resets = <&reset RESET_USB>;
-
-			dr_mode = "otg";
-
-			phys = <&usb2_phy0>, <&usb2_phy1>,
-			       <&usb3_pcie_phy PHY_TYPE_USB3>;
-			phy-names = "usb2-phy0", "usb2-phy1", "usb3-phy0";
-
-			dwc2: usb@ff400000 {
-				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
-				reg = <0x0 0xff400000 0x0 0x40000>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
-				clock-names = "ddr";
-				phys = <&usb2_phy1>;
-				dr_mode = "peripheral";
-				g-rx-fifo-size = <192>;
-				g-np-tx-fifo-size = <128>;
-				g-tx-fifo-size = <128 128 16 16 16>;
-			};
-
-			dwc3: usb@ff500000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0xff500000 0x0 0x100000>;
-				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-				dr_mode = "host";
-				snps,dis_u2_susphy_quirk;
-				snps,quirk-frame-length-adjustment;
-			};
-	};
diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
new file mode 100644
index 000000000000..45bcc98ee9a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/amlogic,meson-g12a-usb-ctrl.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson G12A DWC3 USB SoC Controller Glue
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |
+  The Amlogic G12A embeds a DWC3 USB IP Core configured for USB2 and USB3
+  in host-only mode, and a DWC2 IP Core configured for USB2 peripheral mode
+  only.
+
+  A glue connects the DWC3 core to USB2 PHYs and optionnaly to an USB3 PHY.
+
+  One of the USB2 PHY can be re-routed in peripheral mode to a DWC2 USB IP.
+
+  The DWC3 Glue controls the PHY routing and power, an interrupt line is
+  connected to the Glue to serve as OTG ID change detection.
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-g12a-usb-ctrl
+
+  ranges: true
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  clocks:
+    minItems: 1
+
+  resets:
+    minItems: 1
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: usb2-phy0 # USB2 PHY0 if USBHOST_A port is used
+      - const: usb2-phy1 # USB2 PHY1 if USBOTG_B port is used
+      - const: usb3-phy0 # USB3 PHY if USB3_0 is used
+
+  phys:
+    minItems: 1
+    maxItems: 3
+
+  dr_mode:
+    enum:
+      - host # fixed Host connection
+      - peripheral # fixed Device connection
+      - otg # Host or Device and switched automatically using the OTG ID pin
+
+  power-domains:
+    maxItems: 1
+
+  vbus-supply:
+    description: VBUS power supply when used in OTG switchable mode
+    maxItems: 1
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    type: object
+
+additionalProperties: false
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - clocks
+  - resets
+  - reg
+  - interrupts
+  - phy-names
+  - phys
+  - dr_mode
+
+examples:
+  - |
+    usb: usb@ffe09000 {
+          compatible = "amlogic,meson-g12a-usb-ctrl";
+          reg = <0x0 0xffe09000 0x0 0xa0>;
+          interrupts = <16>;
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+
+          clocks = <&clkc_usb>;
+          resets = <&reset_usb>;
+
+          dr_mode = "otg";
+
+          phys = <&usb2_phy0>, <&usb2_phy1>, <&usb3_phy0>;
+          phy-names = "usb2-phy0", "usb2-phy1", "usb3-phy0";
+
+          dwc2: usb@ff400000 {
+              compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
+              reg = <0xff400000 0x40000>;
+              interrupts = <31>;
+              clocks = <&clkc_usb1>;
+              clock-names = "ddr";
+              phys = <&usb2_phy1>;
+              dr_mode = "peripheral";
+              g-rx-fifo-size = <192>;
+              g-np-tx-fifo-size = <128>;
+              g-tx-fifo-size = <128 128 16 16 16>;
+          };
+
+          dwc3: usb@ff500000 {
+              compatible = "snps,dwc3";
+              reg = <0xff500000 0x100000>;
+              interrupts = <30>;
+              dr_mode = "host";
+              snps,dis_u2_susphy_quirk;
+              snps,quirk-frame-length-adjustment;
+          };
+    };
+
-- 
2.22.0

