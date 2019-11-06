Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0B1C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F16A217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0Djt5Com"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbfKFKpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:45:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35858 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfKFKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:45:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id w18so25160327wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ho0IuXnlLSu0S9dl4tyqWJ4wOPukxzFH+rPw8w9IP3U=;
        b=0Djt5Com4Nw6nawSJY2BCWzsF4s4Xk8wxOoGPh18FDbcUJ4GQQiII9UXR5UWrhl9Ho
         1+hy5If3cGGw6wPamrAt2Ck9f3cdm537ILzhsx/nhU40El7Bti+8EM3DtzCwD0lcdJVq
         FsOzwh1Lcgt8dIoSZ2KacYGB0OmM198fRKZq1pTGk9mqNz1pKhSmpGx/4skJR6qKeQH/
         q6yJAgMA1lNxdvJ5c3cg8pzFOPAs5SAPbUukBlMw5+trLF5gSTdqtRrRu8ROe22nAZXh
         8yF6WN0msw88arX4YfEa+tQBnzkjmrmiQ2cIKVPbH6zBTa2Sz+d5UUDMWbYvrs4kVPHw
         y1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ho0IuXnlLSu0S9dl4tyqWJ4wOPukxzFH+rPw8w9IP3U=;
        b=nH9aQbMNc3k88QBqZWG6IrCjnFNshxCUXZ1xlONbQM+Zw4tzW9Kxx4wmrJMJ9xObB8
         w3e7Y7Akqtls3HF01O9dw9+KMkDjEsxsK1aPhyh0oxSdRF/EwLl2xleiFeXskgGy5Cec
         uB8JYqfH0vW1X/2pr3dCR8vuxhcypqWUtxNTes7734xLSSCdagz6japBMvd8cxnvPKF9
         tPZ//7qPFSXpDqt6nHa30Z7XRKijBa0ISY8PzknYGid5MtJcw2PIsUmW6E8E8J6dptWa
         /53y+ipZc+cRMQXJPIm3YDbEPTjLVsz0BeDwer23OxkQU4U3ufPab7zyh4FZc322gpJC
         kygA==
X-Gm-Message-State: APjAAAU5o4vfzm0MWXGRLzTHxZ23RoYFYaCuRrMsdsH29yesNuZZKN7O
        lsUyng4MASpzYgpVXUPIF65r3A==
X-Google-Smtp-Source: APXvYqxmFcDntelzvf5oc2kIZGTaA8RcxUIN9ppLG7GpMdMZTeYZT5cyAcYce2korwDEVDossgvHyA==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr1948950wrr.81.1573037100615;
        Wed, 06 Nov 2019 02:45:00 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u187sm2483023wme.15.2019.11.06.02.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 02:45:00 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2] dt-bindings: usb: dwc3: Move Amlogic G12A DWC3 Glue Bindings to YAML schemas
Date:   Wed,  6 Nov 2019 11:44:58 +0100
Message-Id: <20191106104458.23698-1-narmstrong@baylibre.com>
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
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- fixed typo in description
- removed dr-mode definition in favor of "true"

 .../devicetree/bindings/usb/amlogic,dwc3.txt  |  88 ------------
 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 128 ++++++++++++++++++
 2 files changed, 128 insertions(+), 88 deletions(-)
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
index 000000000000..2b2dae2e6b7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -0,0 +1,128 @@
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
+  A glue connects the DWC3 core to USB2 PHYs and optionally to an USB3 PHY.
+
+  One of the USB2 PHYs can be re-routed in peripheral mode to a DWC2 USB IP.
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
+  dr_mode: true
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

