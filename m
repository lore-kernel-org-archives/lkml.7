Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8563C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2AB218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xBns3Jrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLROZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:25:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41232 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727035AbfLROZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:25:08 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIEOC0R003764;
        Wed, 18 Dec 2019 15:25:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=KTCzOHykC73RWxKWR21ZpT9NrGcSEJvdlnUUNGMFyOE=;
 b=xBns3JrxeXz14AfH/zTb0Y6TN/WHQPCOcscUcYjLqS7J6NQQI25CHIMzRUdXm13YwLOI
 ho9cYFI8xqqP1eh7FJfBe64CSI0Lo68StyUGluIkAuLqlUNzYbvtLnipdjo2OYiRFRFU
 mSZMQIbQW+KFg2SLL2tpBSz7AuctCtl1dbCNY7dJTVnETte9APPcDDU5KtqnN6l3J9lb
 YiXN8bb4Mm2+v2VH+RG12o4DrJolxYNTSjzHz00wb588kHyn4vnVxk56kQyPD4dwcjPm
 CX3lKvC27skDAsRWjFCilCef+9jD9vH2wF75iwIgJ3fntPCb9IZ1vtXSNGJjEicQZBeS gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wvqgpvj0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Dec 2019 15:25:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96E7F100038;
        Wed, 18 Dec 2019 15:24:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 86A962BE242;
        Wed, 18 Dec 2019 15:24:57 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 18 Dec 2019 15:24:56
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] dt-bindings: usb: Convert DWC2 bindings to json-schema
Date:   Wed, 18 Dec 2019 15:24:55 +0100
Message-ID: <20191218142455.13542-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert DWC2 bindings to DT schema format using json-schema.
DWC2 is widely use but a couple of compatibles and properties
(vusb_d-supply,vusb_a-supply) were missing in dwc2.txt, the
patch add them.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
Notes:
 I have put Greg Kroah-Hartman has maintainer of this file
 because it was the first entry when calling get_maintainers.pl
 on dwc2.txt. All my apologies if that is an incorrect guess,
 raise your hands if you know who should be the maintainer(s)
 for this file.

 Documentation/devicetree/bindings/usb/dwc2.txt  |  64 ---------
 Documentation/devicetree/bindings/usb/dwc2.yaml | 178 ++++++++++++++++++++++++
 2 files changed, 178 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/dwc2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/dwc2.yaml

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
deleted file mode 100644
index aafff3a6904d..000000000000
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-Platform DesignWare HS OTG USB 2.0 controller
------------------------------------------------------
-
-Required properties:
-- compatible : One of:
-  - brcm,bcm2835-usb: The DWC2 USB controller instance in the BCM2835 SoC.
-  - hisilicon,hi6220-usb: The DWC2 USB controller instance in the hi6220 SoC.
-  - rockchip,rk3066-usb: The DWC2 USB controller instance in the rk3066 Soc;
-  - "rockchip,px30-usb", "rockchip,rk3066-usb", "snps,dwc2": for px30 Soc;
-  - "rockchip,rk3188-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3188 Soc;
-  - "rockchip,rk3288-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3288 Soc;
-  - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
-  - "lantiq,xrx200-usb": The DWC2 USB controller instance in Lantiq XRX SoCs;
-  - "amlogic,meson8-usb": The DWC2 USB controller instance in Amlogic Meson8 SoCs;
-  - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
-  - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
-  - "amlogic,meson-g12a-usb": The DWC2 USB controller instance in Amlogic G12A SoCs;
-  - "amcc,dwc-otg": The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs;
-  - snps,dwc2: A generic DWC2 USB controller with default parameters.
-  - "st,stm32f4x9-fsotg": The DWC2 USB FS/HS controller instance in STM32F4x9 SoCs
-  configured in FS mode;
-  - "st,stm32f4x9-hsotg": The DWC2 USB HS controller instance in STM32F4x9 SoCs
-  configured in HS mode;
-  - "st,stm32f7-hsotg": The DWC2 USB HS controller instance in STM32F7 SoCs
-    configured in HS mode;
-- reg : Should contain 1 register range (address and length)
-- interrupts : Should contain 1 interrupt
-- clocks: clock provider specifier
-- clock-names: shall be "otg"
-Refer to clk/clock-bindings.txt for generic clock consumer properties
-
-Optional properties:
-- phys: phy provider specifier
-- phy-names: shall be "usb2-phy"
-- vbus-supply: reference to the VBUS regulator. Depending on the current mode
-  this is enabled (in "host" mode") or disabled (in "peripheral" mode). The
-  regulator is updated if the controller is configured in "otg" mode and the
-  status changes between "host" and "peripheral".
-Refer to phy/phy-bindings.txt for generic phy consumer properties
-- dr_mode: shall be one of "host", "peripheral" and "otg"
-  Refer to usb/generic.txt
-- g-rx-fifo-size: size of rx fifo size in gadget mode.
-- g-np-tx-fifo-size: size of non-periodic tx fifo size in gadget mode.
-- g-tx-fifo-size: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
-- snps,need-phy-for-wake: If present indicates that the phy needs to be left
-                          on for remote wakeup during suspend.
-- snps,reset-phy-on-wake: If present indicates that we need to reset the PHY when
-                          we detect a wakeup.  This is due to a hardware errata.
-
-Deprecated properties:
-- g-use-dma: gadget DMA mode is automatically detected
-
-Example:
-
-        usb@101c0000 {
-                compatible = "ralink,rt3050-usb, snps,dwc2";
-                reg = <0x101c0000 40000>;
-                interrupts = <18>;
-		clocks = <&usb_otg_ahb_clk>;
-		clock-names = "otg";
-		phys = <&usbphy>;
-		phy-names = "usb2-phy";
-		snps,need-phy-for-wake;
-        };
diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
new file mode 100644
index 000000000000..2c11626e3bc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/dwc2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DesignWare HS OTG USB 2.0 controller Bindings
+
+maintainers:
+  - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: brcm,bcm2835-usb
+        description: The DWC2 USB controller instance in the BCM2835 SoC
+      - const: hisilicon,hi6220-usb
+        description: The DWC2 USB controller instance in the hi6220 SoC
+      - items:
+          - const: rockchip,rk3066-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in the rk3066 Soc
+      - items:
+          - const: rockchip,px30-usb
+          - const: rockchip,rk3066-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in the px30 Soc
+      - items:
+          - const: rockchip,rk3036-usb
+          - const: rockchip,rk3066-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in the rk3036 Soc
+      - items:
+          - const: rockchip,rv1108-usb
+          - const: rockchip,rk3066-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in the rv1108 Soc
+      - items:
+          - const: rockchip,rk3188-usb
+          - const: rockchip,rk3066-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in the rk3188 Soc
+      - items:
+          - const: rockchip,rk3228-usb
+          - const: rockchip,rk3066-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in the rk3228 Soc
+      - items:
+          - const: rockchip,rk3288-usb
+          - const: rockchip,rk3066-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in the rk3288 Soc
+      - const: lantiq,arx100-usb
+        description: The DWC2 USB controller instance in Lantiq ARX SoCs
+      - const: lantiq,xrx200-usb
+        description: The DWC2 USB controller instance in Lantiq XRX SoCs
+      - items:
+          - const: amlogic,meson8-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in Amlogic Meson8 SoCs
+      - items:
+          - const: amlogic,meson8b-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in Amlogic Meson8b SoCs
+      - const: amlogic,meson-gxbb-usb
+        description: The DWC2 USB controller instance in Amlogic S905 SoCs
+      - items:
+          - const: amlogic,meson-g12a-usb
+          - const: snps,dwc2
+        description: The DWC2 USB controller instance in Amlogic G12A SoCs
+      - const: amcc,dwc-otg
+        description: The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs
+      - const: snps,dwc2
+        description: generic DWC2 USB controller with default parameters
+      - const: st,stm32f4x9-fsotg
+        description: The DWC2 USB FS/HS controller instance in STM32F4x9 SoCs configured in FS mode
+      - const: st,stm32f4x9-hsotg
+        description: The DWC2 USB HS controller instance in STM32F4x9 SoCs configured in HS mode
+      - const: st,stm32f7-hsotg
+        description: The DWC2 USB HS controller instance in STM32F7 SoCs configured in HS mode
+      - items:
+          - const: samsung,s3c6400-hsotg
+          - const: snps,dwc2
+        minItems: 1
+        description: The DWC2 USB controller instance in the exynos3250 Soc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: otg
+
+  resets:
+    items:
+     - description: common reset
+     - description: ecc reset
+    minItems: 1
+
+  reset-names:
+    items:
+     - const: dwc2
+     - const: dwc2-ecc
+    minItems: 1
+
+  phys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phy provider specifier
+    maxItems: 1
+
+  phy-names:
+    const: usb2-phy
+
+  vbus-supply:
+    description: reference to the VBUS regulator. Depending on the current mode
+      this is enabled (in "host" mode") or disabled (in "peripheral" mode). The
+      regulator is updated if the controller is configured in "otg" mode and the
+      status changes between "host" and "peripheral".
+
+  vusb_d-supply:
+    description: phandle to voltage regulator of digital section,
+
+  vusb_a-supply:
+    description: phandle to voltage regulator of analog section.
+
+  dr_mode:
+    enum: [host, peripheral, otg]
+
+  g-rx-fifo-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size of rx fifo size in gadget mode.
+
+  g-np-tx-fifo-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: size of non-periodic tx fifo size in gadget mode.
+
+  g-tx-fifo-size:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
+
+  snps,need-phy-for-wake:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If present indicates that the phy needs to be left on for remote wakeup during suspend.
+
+  snps,reset-phy-on-wake:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: If present indicates that we need to reset the PHY when we detect a wakeup.
+                 This is due to a hardware errata.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+      usb@101c0000 {
+        compatible = "ralink,rt3050-usb, snps,dwc2";
+        reg = <0x101c0000 40000>;
+        interrupts = <18>;
+        clocks = <&usb_otg_ahb_clk>;
+        clock-names = "otg";
+        phys = <&usbphy>;
+        phy-names = "usb2-phy";
+        snps,need-phy-for-wake;
+      };
+
+...
-- 
2.15.0

