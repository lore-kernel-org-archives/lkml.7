Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2E1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03964214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jc2oZG8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfCLQHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:07:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41522 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbfCLQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:07:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so2160110pgb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jg4iVSKj+OmqvxvVG9IJ9Ht4fZugKIcI91jm1WRMHBk=;
        b=Jc2oZG8pY6zwvsvEAKcSzNhQfOe7vDcU5Zc5AKi57+T/LyxAND65y6LIBoFfPyEzx5
         Wxk/RZcAjOEn0s0vAqkPYlOipRCrz4/BohAX+rHeTOysO6mJnNbUTzT/hf184LybD1ZJ
         qZQoorw4CPRQ8I+sY8CRO235lyyEdC7xNC3/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jg4iVSKj+OmqvxvVG9IJ9Ht4fZugKIcI91jm1WRMHBk=;
        b=dEzlIODxbmiAHsv+SD96kR3rNL28djBUchyV4ZlkXjHRbQGTGxltk6Tg1LQIcFUGFL
         OjvU/b8bzO+3uNnOX3207gRNX6gI97t7s9hhsY4SOtNWAIeFeqe2Vax5mei8k8U7DWFR
         b809nVRL60M8exfJufVcytKWcKn5gk/4nwCvli0A6EYar3LOYSnu1vAYOqmGaztYjSSp
         WPSz2lpvcZxbg6dk54Q6bAgS2HOBeJlEqiD5V5ait5UQ9nsgYy/kLpd8uMo70vXRLaij
         ohhxgwUnzBbW2VJj6GevwEcB/zHasvA712R8B3xtI7H1W1rFLwn9W3YnwJwZAEn8iFAR
         RUUQ==
X-Gm-Message-State: APjAAAX5KqKVCBlAI2985rIrnD8fnEjdVmuLreQWjWywh/TXdEESiOv4
        c7z7Cf5jA3ggDyT7FHNUIgSlqJUGJ/U=
X-Google-Smtp-Source: APXvYqzchNDQDTulE09FtTDZGWtDO+qfoOeT1Wh4wWZJ87i/mwCxpqva/SjfJgbO1d92SXsvmvNaJQ==
X-Received: by 2002:a63:780e:: with SMTP id t14mr18196331pgc.276.1552406847141;
        Tue, 12 Mar 2019 09:07:27 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z12sm12875854pgv.0.2019.03.12.09.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Mar 2019 09:07:26 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v5 3/3] arm64: dts: Add USB DT nodes for Stingray SoC
Date:   Tue, 12 Mar 2019 21:36:21 +0530
Message-Id: <1552406781-5180-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552406781-5180-1-git-send-email-srinath.mannam@broadcom.com>
References: <1552406781-5180-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for
  - Two xHCI host controllers
  - Two BDC Broadcom USB device controller
  - Five USB PHY controllers

[xHCI0]      [BDC0]            [xHCI1]            [BDC1]
   |           |                  |                 |
  ---------------               -----------------------
   |           |                 |         |         |
[SS-PHY0]   [HS-PHY0]        [SS-PHY1] [HS-PHY2] [HS-PHY1]

[SS-PHY0/HS-PHY0] and [SS-PHY1/HS-PHY1] are combo PHYs has one SS and
one HS PHYs. [HS-PHY2] is a single HS PHY.

xHCI use SS-PHY to detect SS devices and HS-PHY to detect HS/FS/LS
devices. BDC use SS-PHY in SS mode and HS-PHY in HS mode.

xHCI0 port1 is SS-PHY0, port2 is HS-PHY0.
xHCI1 port1 is SS-PHY1, port2 is HS-PHY2 and port3 is HS-PHY1.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 .../boot/dts/broadcom/stingray/stingray-usb.dtsi   | 78 ++++++++++++++++++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  1 +
 2 files changed, 79 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
new file mode 100644
index 0000000..a5d3354
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-usb.dtsi
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause)
+/*
+ *Copyright(c) 2018 Broadcom
+ */
+	usb {
+		compatible = "simple-bus";
+		dma-ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x68500000 0x00400000>;
+
+		usbphy0: usb-phy@0 {
+			compatible = "brcm,sr-usb-combo-phy";
+			reg = <0x00000000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		xhci0: usb@1000 {
+			compatible = "generic-xhci";
+			reg = <0x00001000 0x1000>;
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy0 1>, <&usbphy0 0>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc0: usb@2000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00002000 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy0 0>, <&usbphy0 1>;
+			phy-names = "phy0", "phy1";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		usbphy1: usb-phy@10000 {
+			compatible = "brcm,sr-usb-combo-phy";
+			reg = <0x00010000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		usbphy2: usb-phy@20000 {
+			compatible = "brcm,sr-usb-hs-phy";
+			reg = <0x00020000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		xhci1: usb@11000 {
+			compatible = "generic-xhci";
+			reg = <0x00011000 0x1000>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy1 1>, <&usbphy2>, <&usbphy1 0>;
+			phy-names = "phy0", "phy1", "phy2";
+			dma-coherent;
+			status = "disabled";
+		};
+
+		bdc1: usb@21000 {
+			compatible = "brcm,bdc-v0.16";
+			reg = <0x00021000 0x1000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usbphy2>;
+			phy-names = "phy0";
+			dma-coherent;
+			status = "disabled";
+		};
+	};
diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index cfeaa85..21dbb12 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -287,6 +287,7 @@
 	#include "stingray-fs4.dtsi"
 	#include "stingray-sata.dtsi"
 	#include "stingray-pcie.dtsi"
+	#include "stingray-usb.dtsi"
 
 	hsls {
 		compatible = "simple-bus";
-- 
2.7.4

