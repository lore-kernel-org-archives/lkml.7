Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4E8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF4B20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WxUQZFtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfCDKi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:38:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34937 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfCDKi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:38:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so4956060wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 02:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alOo0f/NLXA+J+lrhBG6i0U2G26hjQrx9D9IoyrBZIg=;
        b=WxUQZFtTnriTzzxpDPE04/Ebi8+i/1cNCtpzm+vH2QJBqDtqma8pxVydVtKUI1Hg35
         Hbgt7vedp7dvO+wfIx+WFvv1zlzF7ZlZB9mgRTpi/iMfaIgdzm2bZXE1S9/W2arlxER4
         scadIGD3h1T4Y97oBg1glfQDu3sXqCCe46sdVvN7VfvWXAGMSL3HVZIMdJpE0miuyk8I
         vGP1ln7UKDuWzMC9YXz1g7HptFB3lvbpgvddoNZam3ltGuI3a+6xu/2wj2Enj1WY+YVr
         2Vc5nRRR616CdoZf4TijmFvt0LgzHgovRWdyXo8dmKfJovgGlWS7pjaMwkdlFvLO0iBM
         tc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alOo0f/NLXA+J+lrhBG6i0U2G26hjQrx9D9IoyrBZIg=;
        b=kIqe3cFV+ytp8woSR4k7xGlTY4yYFEBD2TU7BzqOIiwgjIO1ERObiMP+M3Yarcadaz
         DPHiw95jroGFBPRgqpLt5LDZJkRHUP+ey9bWB8FZ2EbCHbg4lPnaDNjyQ0bv1eEMzzz4
         RunIbH4781eMQatkxmR7qy0mqJP+xUDzf1osVbsfprGFWO6lfKHgp6kduUyDPhNTx43G
         xtSKqfj4tsrhdX8OwVJKXwpxRFCHFZO2dbI/Wf1L7qSrmIUNOrtzs8tI1tmh9YZPYH0h
         enaUsLmAmaLkgFiraT5eLDZXYWPwa71tITRylAUUGUzZhdndhHSrLzBV1inRegZV0Unq
         m8xQ==
X-Gm-Message-State: APjAAAW0rcs8IkjGR1SO5jVoMB2GnT2pZUc+KvWyt7On+F5XkZL30LWw
        goZ46gmdYNn0FU6S6vNi8Fniyg==
X-Google-Smtp-Source: APXvYqx032M1rOT9J89/8zdCgewi5y7oO3uCtK6v0+YEDnsHvpceN8qgk3Mp0w7vew0PITfpOeJ1KA==
X-Received: by 2002:adf:e647:: with SMTP id b7mr12083538wrn.260.1551695933759;
        Mon, 04 Mar 2019 02:38:53 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g24sm5505676wmh.45.2019.03.04.02.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 02:38:52 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
Date:   Mon,  4 Mar 2019 11:38:42 +0100
Message-Id: <20190304103846.2060-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304103846.2060-1-narmstrong@baylibre.com>
References: <20190304103846.2060-1-narmstrong@baylibre.com>
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

