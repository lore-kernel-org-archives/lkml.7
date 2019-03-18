Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CF3C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4410214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KDA6I3JJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfCRJ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:59:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53967 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbfCRJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:59:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id e74so12262609wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4oym53pblyH4Djmv5JFN5gdbf5/Syr9K8b694MhuuQ=;
        b=KDA6I3JJ0yggd8VeyhJeVkFB6JTH4Fj5XQOxFBIP9G01WbWaT9IAGA29p1kvpkEuK6
         ZZ2xaTyaNAL20TqVqFwq1wJowqH2CajW6T6+xkE8EWjMZkG+eOWdL36Rlh+GKwwsDyxl
         IBS/wbV/ejN4NZJFcNvEnl5WGcynvE7gwBJ2S0rOOEU1k9KCrCufA2CKrsa0TbLtH20i
         z+fbFygMtkjkzEKyMdLRAK3YjbUJ3/PPFkc5o1fLb7yKX/N4dLe6PA8Lkh88FHB7SQJP
         pf1/EsjuOljAGxQJoyajg8HShosDjlGF4lYVrIFVGkF1ahQXlqgoFt+uEBvgJdRRLtJN
         FySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4oym53pblyH4Djmv5JFN5gdbf5/Syr9K8b694MhuuQ=;
        b=oQppcOzUF/Pw43OkGclmkfUyayZ5LVxunCWeyK2dw4aGoiVNxLmCA0rQDORJumPZcq
         yfLsXOm5MgSLNVC4jZ3eJbBRLzYRcDhL1U1GYVLInssnLkbvMmU0vHBg/z2dDgQrdpNN
         kSnmep7eO8rdU3+LV3K/r/Fty2FY3iRDkeRJZsxzZMM1rhciDFyUG27i/8h4FOV4oKMt
         qPUq+pLlqtDs0u5mQzpli6FKeq5BsP4iHZLezJaqsNlhskdQEyxpI2Ye2qZTIzmdXjsH
         EjkASWMMIZuT8wDP7o7rEol0n5NA5QUUjnRIUVkZ93YnZtTEnr5r6nkWk65kKUgntNyq
         EF+w==
X-Gm-Message-State: APjAAAXfUWlcNRS+7oWdU+cGO71NWp9FCEUyTZcT1/6jM9ZO1aPf3pEj
        /0cJ1MwuJKvlhNMCKjfiMkvg9g==
X-Google-Smtp-Source: APXvYqxaWk0/0w17XD/AhJmmutHpp4wR7SWU4kIs3KdaNwnpOFXQx289H2hcogU5/TLtRHcJvIq1wA==
X-Received: by 2002:a1c:7c0c:: with SMTP id x12mr10424150wmc.38.1552903141803;
        Mon, 18 Mar 2019 02:59:01 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g8sm5459034wro.77.2019.03.18.02.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 02:59:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] arm64: dts: meson: g12a: Add G12A USB nodes
Date:   Mon, 18 Mar 2019 10:58:50 +0100
Message-Id: <20190318095851.4062-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318095851.4062-1-narmstrong@baylibre.com>
References: <20190318095851.4062-1-narmstrong@baylibre.com>
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
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index a99c13ee724a..ce681aef8d5b 100644
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
@@ -163,6 +165,26 @@
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
@@ -183,6 +205,18 @@
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
@@ -346,6 +380,47 @@
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
2.20.1

