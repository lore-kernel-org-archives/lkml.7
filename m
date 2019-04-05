Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C8EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0674218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p+QUb9ui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfDEO3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:29:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34886 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfDEO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:29:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35ET0tS027176;
        Fri, 5 Apr 2019 09:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554474540;
        bh=l5eSoiqLV/oeEBaY0gCWYYb+K3ywm8WXxauGYkI2ai0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=p+QUb9uiPSZcQNvkXHKqs2MHWiNTEaVarZCy8zF4eup7HW4ujmQBQ5cmsKs8MWWIH
         1qoY7TIW295dHVuV/qiH7Ucd1pjNojSEIZUh5ShQG0GtDEi4YVNPgXaKOYefM/A0X4
         SeOM9Ieh9eUUrOmWcTbKZI84nr6KeWlI12noTKrI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35ET0I2080386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 09:29:00 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 09:28:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 09:28:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35ESxlt034153;
        Fri, 5 Apr 2019 09:28:59 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 4/6] dt-bindings: ti-lmu: Modify dt bindings for the LM3697
Date:   Fri, 5 Apr 2019 09:28:53 -0500
Message-ID: <20190405142855.3969-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20190405142855.3969-1-dmurphy@ti.com>
References: <20190405142855.3969-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LM3697 is a single function LED driver. The single function LED
driver needs to reside in the LED directory as a dedicated LED driver
and not as a MFD device.  The device does have common brightness and ramp
features and those can be accomodated by a TI LMU framework.

The LM3697 dt binding needs to be moved from the ti-lmu.txt and a dedicated
LED dt binding needs to be added.  The new LM3697 LED dt binding will then
reside in the Documentation/devicetree/bindings/leds directory and follow the
current LED and general bindings guidelines.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Made changes to reference ti,brightness-resolution to the ti-lmu.txt -
https://lore.kernel.org/patchwork/patch/1054501/

 .../devicetree/bindings/leds/leds-lm3697.txt  | 73 +++++++++++++++++++
 .../devicetree/bindings/mfd/ti-lmu.txt        | 27 +------
 2 files changed, 74 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3697.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3697.txt b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
new file mode 100644
index 000000000000..02378f33c9ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-lm3697.txt
@@ -0,0 +1,73 @@
+* Texas Instruments - LM3697 Highly Efficient White LED Driver
+
+The LM3697 11-bit LED driver provides high-
+performance backlight dimming for 1, 2, or 3 series
+LED strings while delivering up to 90% efficiency.
+
+This device is suitable for display and keypad Lighting
+
+Required properties:
+	- compatible:
+		"ti,lm3697"
+	- reg :  I2C slave address
+	- #address-cells : 1
+	- #size-cells : 0
+
+Optional properties:
+	- enable-gpios : GPIO pin to enable/disable the device
+	- vled-supply : LED supply
+
+Required child properties:
+	- reg : 0 - LED is Controlled by bank A
+		1 - LED is Controlled by bank B
+	- led-sources : Indicates which HVLED string is associated to which
+			control bank.  This is a zero based property so
+			HVLED1 = 0, HVLED2 = 1, HVLED3 = 2.
+			Additional information is contained
+			in Documentation/devicetree/bindings/leds/common.txt
+
+Optional child properties:
+	- ti,brightness-resolution - see Documentation/devicetree/bindings/mfd/ti-lmu.txt
+	- ramp-up-ms: see Documentation/devicetree/bindings/mfd/ti-lmu.txt
+	- ramp-down-ms: see Documentation/devicetree/bindings/mfd/ti-lmu.txt
+	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- linux,default-trigger :
+	   see Documentation/devicetree/bindings/leds/common.txt
+
+Example:
+
+HVLED string 1 and 3 are controlled by control bank A and HVLED 2 string is
+controlled by control bank B.
+
+led-controller@36 {
+	compatible = "ti,lm3697";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x36>;
+
+	enable-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	vled-supply = <&vbatt>;
+
+	led@0 {
+		reg = <0>;
+		led-sources = <0 2>;
+		ti,brightness-resolution = <2047>;
+		ramp-up-ms = <5000>;
+		ramp-down-ms = <1000>;
+		label = "white:first_backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+
+	led@1 {
+		reg = <1>;
+		led-sources = <1>;
+		ti,brightness-resolution = <255>;
+		ramp-up-ms = <500>;
+		ramp-down-ms = <1000>;
+		label = "white:second_backlight_cluster";
+		linux,default-trigger = "backlight";
+	};
+}
+
+For more product information please see the link below:
+http://www.ti.com/lit/ds/symlink/lm3697.pdf
diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index 5881929d5f7a..a948a8f41b2c 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -8,7 +8,6 @@ TI LMU driver supports lighting devices below.
   LM3632       Backlight and regulator
   LM3633       Backlight, LED and fault monitor
   LM3695       Backlight
-  LM3697       Backlight and fault monitor
 
 Required properties:
   - compatible: Should be one of:
@@ -16,11 +15,10 @@ Required properties:
                 "ti,lm3632"
                 "ti,lm3633"
                 "ti,lm3695"
-                "ti,lm3697"
   - reg: I2C slave address.
          0x11 for LM3632
          0x29 for LM3631
-         0x36 for LM3633, LM3697
+         0x36 for LM3633
          0x63 for LM3695
 
 Optional property:
@@ -51,7 +49,6 @@ Optional nodes:
     Required properties:
       - compatible: Should be one of:
                     "ti,lm3633-fault-monitor"
-                    "ti,lm3697-fault-monitor"
   - leds: LED properties for LM3633. Please refer to [2].
   - regulators: Regulator properties for LM3631 and LM3632.
                 Please refer to [3].
@@ -216,25 +213,3 @@ lm3695@63 {
 		};
 	};
 };
-
-lm3697@36 {
-	compatible = "ti,lm3697";
-	reg = <0x36>;
-
-	enable-gpios = <&pioC 2 GPIO_ACTIVE_HIGH>;
-
-	backlight {
-		compatible = "ti,lm3697-backlight";
-
-		lcd {
-			ti,brightness-resolution = <255>;
-			led-sources = <0 1 2>;
-			ramp-up-ms = <200>;
-			ramp-down-ms = <200>;
-		};
-	};
-
-	fault-monitor {
-		compatible = "ti,lm3697-fault-monitor";
-	};
-};
-- 
2.19.0

