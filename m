Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62001213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jIrXrSzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCRN1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:27:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53606 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfCRN1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:27:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id e74so12979728wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUvfuvKdMzBgRt0tGHLl1dfJOwtoisFeSR4beOE+s3s=;
        b=jIrXrSzRfeFT3L5SqZU8VhMdQfnOMqArVN3RUgDdTXzDTm6/nTSU3YkSzNKAK9AsGE
         BCLm2p2J6rwKXosIReB02gTyvVzLr1HKi0TMSyhImLxhbJBaBmP74mqtwzIabI9b+GF3
         2NHTQPZfGvADAQk8cb4R4S5BK3Vj/OhymYjKGYguPkcUyZk9LrdEG61VR2MIz6q0dihq
         vMIHKCDEn5wycwAiO7a9FnsK0XkydguP0KcxuZA47q+2rDMmVEqgOWUA2u+SuI2jtIHx
         77pLxX9asFYrkz1LkV+wQoMGOpnJgGkR4PcfUAq3qFxVpcpp72J5Fu3UPGX5ZRg038XK
         8mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUvfuvKdMzBgRt0tGHLl1dfJOwtoisFeSR4beOE+s3s=;
        b=iOlmXUAtrsCYtCHBjQJt8/3TaE6CEiV8S6lPWrZUMA0E/PXWVuiRm/tg9X2U21BOAB
         Lz06/DazD5EK2q3kU6hz+PzpofCyG3ChELFQU4KO32QopKZ9c4VgiOKTNgqcKft8iAWF
         y7tCgT7IGPoiGvpeQ5eutkYyAbQhmeuTetrfVBJw82I0yNpDRk7+xyslt3QRmE8OxtQx
         6lYytJoaBMVecyFVsdudedK15HVeo9yZ7bbl+RYgIk0JtBp35YCdjd4KbW0ZV5FdywyB
         s9KuwS+AdXfjoC/rJVeihLTRk6aWgubhDkhiKCGBjZ9oILtPWevwMu/Xwwm4LGbVRe+7
         SBFg==
X-Gm-Message-State: APjAAAVLz5DoF913+DPNgb69JJiYoYHiSOzXvoUebLP16XpVWyNF+vjX
        wLmspLXy/eFhrCoEjlwumirG0Q==
X-Google-Smtp-Source: APXvYqxdOds81FxQhEjLmNahUvw0D3mjo6gM3zPsg94GVgShFZpFbwtu0SgpQz4+/WcduNdgNB5okw==
X-Received: by 2002:a1c:f50d:: with SMTP id t13mr11232296wmh.81.1552915622556;
        Mon, 18 Mar 2019 06:27:02 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j128sm10421601wmb.43.2019.03.18.06.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 06:27:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 4/8] dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
Date:   Mon, 18 Mar 2019 14:26:51 +0100
Message-Id: <20190318132655.30040-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318132655.30040-1-narmstrong@baylibre.com>
References: <20190318132655.30040-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the bindings for the Amlogic G12A USB Glue HW.

The Amlogic G12A SoC Family embeds 2 USB Controllers :
- a DWC3 IP configured as Host for USB2 and USB3
- a DWC2 IP configured as Peripheral USB2 Only

A glue connects these both controllers to 2 USB2 PHYs,
and optionnally to an USB3+PCIE Combo PHY shared with the PCIE controller.

The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
routing of the OTG PHY between the DWC3 and DWC2 controllers, and
setups the on-chip OTG mode selection for this PHY.

The PHYs phandles are passed  to the Glue node since the Glue controls the
interface with the PHY, not the DWC3 controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/amlogic,dwc3.txt  | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt b/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
index 9a8b631904fd..b9f04e617eb7 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
@@ -40,3 +40,91 @@ Example device nodes:
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};
+
+Amlogic Meson G12A DWC3 USB SoC Controller Glue
+
+The Amlogic G12A embeds a DWC3 USB IP Core configured for USB2 and USB3
+in host-only mode, and a DWC2 IP Core configured for USB2 peripheral mode
+only.
+
+A glue connects the DWC3 core to USB2 PHYs and optionnaly to an USB3 PHY.
+
+One of the USB2 PHY can be re-routed in peripheral mode to a DWC2 USB IP.
+
+The DWC3 Glue controls the PHY routing and power, an interrupt line is
+connected to the Glue to serve as OTG ID change detection.
+
+Required properties:
+- compatible:	Should be "amlogic,meson-g12a-usb-ctrl"
+- clocks:	a handle for the "USB" clock
+- resets:	a handle for the shared "USB" reset line
+- reg:		The base address and length of the registers
+- interrupts:	the interrupt specifier for the OTG detection
+- phys: 	handle to used PHYs on the system
+	- a <0> phandle can be used if a PHY is not used
+- phy-names:	names of the used PHYs on the system :
+	- "usb2-phy0" for USB2 PHY0 if USBHOST_A port is used
+	- "usb2-phy1" for USB2 PHY1 if USBOTG_B port is used
+	- "usb3-phy0" for USB3 PHY if USB3_0 is used
+- dr_mode:	should be "host", "peripheral", or "otg" depending on
+	the usage and configuration of the OTG Capable port.
+	- "host" and "peripheral" means a fixed Host or Device only connection
+	- "otg" means the port can be used as both Host or Device and
+	  be switched automatically using the OTG ID pin.
+
+Optional properties:
+- vbus-supply:	should be a phandle to the regulator controlling the VBUS
+		power supply when used in OTG switchable mode
+
+Required child nodes:
+
+A child node must exist to represent the core DWC3 IP block. The name of
+the node is not important. The content of the node is defined in dwc3.txt.
+
+A child node must exist to represent the core DWC2 IP block. The name of
+the node is not important. The content of the node is defined in dwc2.txt.
+
+PHY documentation is provided in the following places:
+- Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
+- Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
+
+Example device nodes:
+	usb: usb@ffe09000 {
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
+	};
-- 
2.20.1

