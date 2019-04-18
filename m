Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA3AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E6620674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="dUOpg6aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbfDRPM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:12:27 -0400
Received: from onstation.org ([52.200.56.107]:46778 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389499AbfDRPMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:12:16 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id E826544972;
        Thu, 18 Apr 2019 15:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1555600335;
        bh=59GGuqXw52juvL+qWBFG5wCf1XCDiAoDpvpLrKAQTI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dUOpg6aMQVqK2IVjm9QavKuMgMpseucdsMV6MU+moCWWxEwiMPv/HJmtk28KoOydT
         9mrXBd2EqeFdD3yinL/pMe/0tzP+Zrohu6xzBqUwoo+wsKOfvvsWjY1Ln9YVxtZbLr
         Nb5S0zBKx7ke2gdQ69yDrwJicVuWnfJ1Z3uq82CY=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: [PATCH v5 2/3] dt-bindings: backlight: add lm3630a bindings
Date:   Thu, 18 Apr 2019 11:11:42 -0400
Message-Id: <20190418151143.26068-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418151143.26068-1-masneyb@onstation.org>
References: <20190418151143.26068-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new backlight bindings for the TI LM3630A dual-string white LED.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v4:
- Drop $ref from led-sources
- Drop description from reg of i2c address
- Expand description of reg for the control bank
- Drop status from examples

Changes since v3:
- Add label. I didn't add a description for it since that'll come from
  the common properties once its converted.

Changes since v2:
- Update description of max-brightness
- Add description for reg
- Correct typo: s/tranisiton/transition
- add reg to control banks
- add additionalProperties

 .../leds/backlight/lm3630a-backlight.yaml     | 129 ++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
new file mode 100644
index 000000000000..e754df569365
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
@@ -0,0 +1,129 @@
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
+      transition to the human eye.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^led@[01]$":
+    type: object
+    description: |
+      Properties for a string of connected LEDs.
+
+    properties:
+      reg:
+        description: |
+          The control bank that is used to program the two current sinks. The
+          LM3630A has two control banks (A and B) and are represented as 0 or 1
+          in this property. The two current sinks can be controlled
+          independently with both banks, or bank A can be configured to control
+          both sinks with the led-sources property.
+        maxItems: 1
+        minimum: 0
+        maximum: 1
+
+      label:
+        maxItems: 1
+
+      led-sources:
+        allOf:
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
+        description: Maximum brightness that is allowed during runtime.
+        minimum: 0
+        maximum: 255
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lm3630a_bl@38 {
+                compatible = "ti,lm3630a";
+                reg = <0x38>;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                        reg = <0>;
+                        led-sources = <0 1>;
+                        label = "lcd-backlight";
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
+                reg = <0x38>;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                        reg = <0>;
+                        default-brightness = <150>;
+                        ti,linear-mapping-mode;
+                };
+
+                led@1 {
+                        reg = <1>;
+                        default-brightness = <225>;
+                        ti,linear-mapping-mode;
+                };
+        };
+    };
-- 
2.20.1

