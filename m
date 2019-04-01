Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FF3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA723213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="frMLJ+LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfDAKan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:30:43 -0400
Received: from onstation.org ([52.200.56.107]:36876 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfDAKal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:30:41 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D6E334571C;
        Mon,  1 Apr 2019 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1554114640;
        bh=MaQ72dM4520+ySIKlG5tbgDHj3EHxaDHTUGUZDJs7gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=frMLJ+LOQ/SwroHGCUpg9OTXbwgFUiGZnos5PezPrXobFvwocjUeB+b23o7W/9faR
         FEIoUsjCbrJ1dw34VEBEz1521GLZtujVsJtgz5wuuZiwCNoKVDjRIWlscLvsfm2UiP
         uUrnIvynAMMKlODDwT2QD8w5cGiMwfLdS5LQJDXg=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Date:   Mon,  1 Apr 2019 06:30:33 -0400
Message-Id: <20190401103034.21062-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401103034.21062-1-masneyb@onstation.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new backlight bindings for the TI LM3630A dual-string white LED.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 .../leds/backlight/lm3630a-backlight.yaml     | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
new file mode 100644
index 000000000000..42a8c59d237a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3630A High-Efficiency Dual-String White LED
+
+maintainers:
+  - Lee Jones <lee.jones@linaro.org>
+  - Daniel Thompson <daniel.thompson@linaro.org>
+  - Jingoo Han <jingoohan1@gmail.com>
+
+description: |
+  The LM3630A is a current-mode boost converter which supplies the power and
+  controls the current in up to two strings of 10 LEDs per string.
+  https://www.ti.com/product/LM3630A
+
+properties:
+  compatible:
+    const: ti,lm3630a
+
+  reg:
+    maxItems: 1
+
+  ti,linear-mapping-mode:
+    description: |
+      Enable linear mapping mode. If disabled, then it will use exponential
+      mapping mode in which the ramp up/down appears to have a more uniform
+      tranisiton to the human eye.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^led*$":
+    type: object
+    description: |
+      Properties for a string of connected LEDs.
+
+    properties:
+      label:
+        description: |
+          The label for this LED. If omitted, the label is taken from the node
+          name (excluding the unit address). It has to uniquely identify a
+          device, i.e. no other LED class device can be assigned the same label.
+
+      led-sources:
+        description: |
+          List of device current outputs the LED is connected to.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+          - minItems: 1
+            maxItems: 2
+            items:
+              minimum: 0
+              maximum: 1
+
+      default-brightness:
+        description: Default brightness level on boot.
+        minimum: 0
+        maximum: 255
+
+      max-brightness:
+        description: Maximum brightness level on boot.
+        minimum: 0
+        maximum: 255
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lm3630a_bl@38 {
+                compatible = "ti,lm3630a";
+                status = "ok";
+                reg = <0x38>;
+
+                led {
+                        label = "main-lcd";
+                        led-sources = <0 1>;
+                        default-brightness = <200>;
+                        max-brightness = <255>;
+                };
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lm3630a_bl@38 {
+                compatible = "ti,lm3630a";
+                status = "ok";
+                reg = <0x38>;
+
+                led-bank-a {
+                        led-sources = <0>;
+                        default-brightness = <150>;
+                        ti,linear-mapping-mode;
+                };
+
+                led-bank-b {
+                        led-sources = <1>;
+                        default-brightness = <225>;
+                        ti,linear-mapping-mode;
+                };
+        };
+    };
-- 
2.20.1

