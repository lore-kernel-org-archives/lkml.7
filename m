Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CDEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1D220883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="skIN/b1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfCLMSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:18:52 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58740 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLMSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:18:51 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2CCIgtB023479;
        Tue, 12 Mar 2019 07:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552393122;
        bh=dLQ2/AC66EeNN7usy5Dj9eEC3wpg6B4yv6T6InGKBeg=;
        h=From:To:CC:Subject:Date;
        b=skIN/b1mztm5PXdEtHqvb66M/15N8vl0RvZBrmE9+24nGUOuSvR4szpxHxIFFK21m
         SM3cZDszSEklFvDO0yXOVft78tWb2W7ghvV6469K+JLGwYbTd8lgqMJAkeBR05ZWjX
         S4G9qnq/hzPZUl7M1uZgDt1RtRmp0mDSZ4XqplqA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2CCIgKi010422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 07:18:42 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 07:18:41 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 07:18:41 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2CCIf2T005310;
        Tue, 12 Mar 2019 07:18:41 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.79.221])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2CCIfU10786;
        Tue, 12 Mar 2019 07:18:41 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <tony@atomide.com>, <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 1/4] dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
Date:   Tue, 12 Mar 2019 07:18:19 -0500
Message-ID: <20190312121822.8315-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the lm3532 device tree documentation.
Remove lm3532 device tree reference from the ti_lmu devicetree
documentation.

With the addition of the dedicated lm3532 documentation the device
can be removed from the ti_lmu.txt.

The reason for this is that the lm3532 dt documentation now defines
the ability to control LED output strings against different control
banks or groups multiple strings to be controlled by a single control
bank.

Another addition was for ALS lighting control and configuration.  The
LM3532 has a feature that can take in the ALS reading from 2 separate
ALS devices and adjust the brightness on the strings that are configured
to support this feature.

Finally the device specific properties were moved to the parent node as these
properties are not control bank configurable.  These include the runtime ramp
and the ALS configuration.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v3 - No changes - https://lore.kernel.org/patchwork/patch/1049026/

v2 - Fixed ramp-up and ramp-down properties, removed hard coded property values,
added ranges for variable properties, I did not change the label - https://lore.kernel.org/patchwork/patch/1048805/

 .../devicetree/bindings/leds/leds-lm3532.txt  | 127 ++++++++++++++++++
 .../devicetree/bindings/mfd/ti-lmu.txt        |  20 ---
 2 files changed, 127 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3532.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3532.txt b/Documentation/devicetree/bindings/leds/leds-lm3532.txt
new file mode 100644
index 000000000000..b267d696b511
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3532.txt
@@ -0,0 +1,127 @@
+* Texas Instruments - lm3532 White LED driver with ambient light sensing
+capability.
+
+The LM3532 provides the 3 high-voltage, low-side current sinks. The device is
+programmable over an I2C-compatible interface and has independent
+current control for all three channels. The adaptive current regulation
+method allows for different LED currents in each current sink thus allowing
+for a wide variety of backlight and keypad applications.
+
+The main features of the LM3532 include dual ambient light sensor inputs
+each with 32 internal voltage setting resistors, 8-bit logarithmic and linear
+brightness control, dual external PWM brightness control inputs, and up to
+1000:1 dimming ratio with programmable fade in and fade out settings.
+
+Required properties:
+	- compatible : "ti,lm3532"
+	- reg : I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Required child properties:
+	- reg : Indicates control bank the LED string is controlled by
+	- led-sources : see Documentation/devicetree/bindings/leds/common.txt
+	- ti,led-mode : Defines if the LED strings are manually controlled or
+			if the LED strings are controlled by the ALS.
+			0x00 - LED strings are I2C controlled via full scale
+			       brightness control register
+			0x01 - LED strings are ALS controlled
+
+Optional child properties:
+	Range for ramp settings: 8us - 65536us
+	- ramp-up-us - The Run time ramp rates/step are from one current
+		       set-point to another after the device has reached its
+		       initial target set point from turn-on
+	- ramp-down-us - The Run time ramp rates/step are from one current
+			 set-point to another after the device has reached its
+			 initial target set point from turn-on
+
+Optional child properties if ALS mode is used:
+	- als-vmin - Minimum ALS voltage defined in Volts
+	- als-vmax - Maximum ALS voltage defined in Volts
+	Per the data sheet the max ALS voltage is 2V and the min is 0V
+
+	- als1-imp-sel - ALS1 impedance resistor selection in Ohms
+	- als2-imp-sel - ALS2 impedance resistor selection in Ohms
+	Range for impedance select: 37000 Ohms - 1190 Ohms
+	Values above 37kohms will be set to the "High Impedance" setting
+
+	- als-avrg-time-us - Determines the length of time the device needs to
+			  average the two ALS inputs.  This is only used if
+			  the input mode is LM3532_ALS_INPUT_AVRG.
+			     Range: 17920us - 2293760us
+	- als-input-mode - Determines how the device uses the attached ALS
+			   devices.
+			   0x00 - ALS1 and ALS2 input average
+			   0x01 - ALS1 Input
+			   0x02 - ALS2 Input
+			   0x03 - Max of ALS1 and ALS2
+
+Optional LED child properties:
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+led-controller@38 {
+	compatible = "ti,lm3532";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x38>;
+
+	enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
+	ramp-up-ms = <1024>;
+	ramp-down-ms = <65536>;
+
+	lcd_backlight: led@0 {
+		reg = <0>;
+		led-sources = <2>;
+		ti,led-mode = <0>;
+		label = "backlight";
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		led-sources = <1>;
+		ti,led-mode = <0>;
+		label = "keypad";
+	};
+};
+
+Example with ALS:
+led-controller@38 {
+	compatible = "ti,lm3532";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x38>;
+
+	enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
+	ramp-up-ms = <1024>;
+	ramp-down-ms = <65536>;
+
+	als-vmin = <0>;
+	als-vmax = <2000>;
+	als1-imp-sel = <4110>;
+	als2-imp-sel = <2180>;
+	als-avrg-time-us = <17920>;
+	als-input-mode = <0x00>;
+
+	lcd_backlight: led@0 {
+		reg = <0>;
+		led-sources = <2>;
+		ti,led-mode = <1>;
+		label = "backlight";
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		led-sources = <1>;
+		ti,led-mode = <0>;
+		label = "keypad";
+	};
+};
+
+For more product information please see the links below:
+http://www.ti.com/product/LM3532
diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index c885cf89b8ce..980394d701a7 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -4,7 +4,6 @@ TI LMU driver supports lighting devices below.
 
    Name                  Child nodes
   ------      ---------------------------------
-  LM3532       Backlight
   LM3631       Backlight and regulator
   LM3632       Backlight and regulator
   LM3633       Backlight, LED and fault monitor
@@ -13,7 +12,6 @@ TI LMU driver supports lighting devices below.
 
 Required properties:
   - compatible: Should be one of:
-                "ti,lm3532"
                 "ti,lm3631"
                 "ti,lm3632"
                 "ti,lm3633"
@@ -23,7 +21,6 @@ Required properties:
          0x11 for LM3632
          0x29 for LM3631
          0x36 for LM3633, LM3697
-         0x38 for LM3532
          0x63 for LM3695
 
 Optional property:
@@ -47,23 +44,6 @@ Optional nodes:
 [2] ../leds/leds-lm3633.txt
 [3] ../regulator/lm363x-regulator.txt
 
-lm3532@38 {
-	compatible = "ti,lm3532";
-	reg = <0x38>;
-
-	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
-
-	backlight {
-		compatible = "ti,lm3532-backlight";
-
-		lcd {
-			led-sources = <0 1 2>;
-			ramp-up-msec = <30>;
-			ramp-down-msec = <0>;
-		};
-	};
-};
-
 lm3631@29 {
 	compatible = "ti,lm3631";
 	reg = <0x29>;
-- 
2.20.1.390.gb5101f9297

