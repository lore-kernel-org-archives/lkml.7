Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE37C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF33208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgaqhj0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfITVxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:53:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36492 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfITVw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:52:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so5409277pfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 14:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EisBycQfg22rkqlbD/WfJdnqHrhEo+fDOE2xHm2q2PU=;
        b=cgaqhj0gUrKqsx+oAGu8MgcFUf6Io7Cz60RPQmsT0FNbIP/mhtP6lRNvFzCPqbb8Uk
         EmeLkdbsmqyoV3UBufEATqAvgdNXReHWx9EGzBpF4PtXS+dXW8pulSeUgdxWXBBCDxD3
         tQDKQQ0M9M1owHUyZ7L8Siq5LqQGlL7Iaiqbo9G1uxjAJ94HJf7+PHDtSj6/dhq8Tl1s
         ut1QkejBvaezdJKDQQvnYRsmozS2LVp2xsPTXLC8zQGo24yANgPViXQhSnud+WUyxvYF
         BPTJpJWLijVr/mAzy/ZIMYrtedDfxYdhjO77n48EutUmaikbyXlED0JxugzYkZiYj3nk
         X9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EisBycQfg22rkqlbD/WfJdnqHrhEo+fDOE2xHm2q2PU=;
        b=ZZTTCTLElsnR1D0dg7VPcP7Yi9FFd6989CSLAiNgcxMdLhxzyFYd7ZZ/5sw67NvaI2
         BAUFw8ifw9QMDPwYtpAcHZf1MRTWciydGndnY8U0ryZmgFve23at3HlMonYWtb826eOt
         SXVXsRUXgDG7UeXq2dxYSaEOJv+yTc3X/on6F45u5iLB8dF3mZWljomfQtggHXjSAh1Q
         +g/Kd+ORly8yULe19ysj96FN62CAz9MRaTyWIuzbe6SwiVk+VKb+6e+KE5B8l64qrU91
         pV8hEu9H7/L1k4oppy1J/qty1qPlpEbFADDY80ICtKCoMotiYzEI75/9KoBHGqUSJd76
         SGcQ==
X-Gm-Message-State: APjAAAXCoMmPFFewtENbQl6M3u6o1AJFn1lbm5ovhwsp4e5pt03CYvkz
        OCgSR7oJCeQ3aD2bP5DlVGkxQGsTYyc4aA==
X-Google-Smtp-Source: APXvYqwhQ08r8BXT6wek+hg80kIzt5NaY088KoL/aF9iq3ra+XR4yb4vy0lb1Rarkmh3K/NokiZBjQ==
X-Received: by 2002:aa7:8c19:: with SMTP id c25mr19340570pfd.150.1569016375721;
        Fri, 20 Sep 2019 14:52:55 -0700 (PDT)
Received: from localhost (wsip-98-175-107-49.sd.sd.cox.net. [98.175.107.49])
        by smtp.gmail.com with ESMTPSA id h4sm2798527pgg.81.2019.09.20.14.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 14:52:55 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        masneyb@onstation.org, swboyd@chromium.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 07/15] dt-bindings: thermal: tsens: Convert over to a yaml schema
Date:   Fri, 20 Sep 2019 14:52:22 -0700
Message-Id: <805a2ae9c95f41dc733ccc80346941998e1b230c.1569015835.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older IP only supports the 'uplow' interrupt, but newer IP supports
'uplow' and 'critical' interrupts. Document interrupt support in the
tsens driver by converting over to a YAML schema.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../bindings/thermal/qcom-tsens.txt           |  55 ------
 .../bindings/thermal/qcom-tsens.yaml          | 168 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 169 insertions(+), 55 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
deleted file mode 100644
index 673cc1831ee9..000000000000
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* QCOM SoC Temperature Sensor (TSENS)
-
-Required properties:
-- compatible:
-  Must be one of the following:
-    - "qcom,msm8916-tsens" (MSM8916)
-    - "qcom,msm8974-tsens" (MSM8974)
-    - "qcom,msm8996-tsens" (MSM8996)
-    - "qcom,qcs404-tsens", "qcom,tsens-v1" (QCS404)
-    - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
-    - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
-  The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
-  with version 2 of the TSENS IP. MSM8996 is the only exception because the
-  generic property did not exist when support was added.
-  Similarly, the generic "qcom,tsens-v1" property must be used as a fallback for
-  any SoC with version 1 of the TSENS IP.
-
-- reg: Address range of the thermal registers.
-  New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
-  register spaces separately, with order being TM before SROT.
-  See Example 2, below.
-
-- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
-- #qcom,sensors: Number of sensors in tsens block
-- Refer to Documentation/devicetree/bindings/nvmem/nvmem.txt to know how to specify
-nvmem cells
-
-Example 1 (legacy support before a fallback tsens-v2 property was introduced):
-tsens: thermal-sensor@900000 {
-		compatible = "qcom,msm8916-tsens";
-		reg = <0x4a8000 0x2000>;
-		nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
-		nvmem-cell-names = "caldata", "calsel";
-		#thermal-sensor-cells = <1>;
-	};
-
-Example 2 (for any platform containing v2 of the TSENS IP):
-tsens0: thermal-sensor@c263000 {
-		compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
-		reg = <0xc263000 0x1ff>, /* TM */
-			<0xc222000 0x1ff>; /* SROT */
-		#qcom,sensors = <13>;
-		#thermal-sensor-cells = <1>;
-	};
-
-Example 3 (for any platform containing v1 of the TSENS IP):
-tsens: thermal-sensor@4a9000 {
-		compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
-		reg = <0x004a9000 0x1000>, /* TM */
-		      <0x004a8000 0x1000>; /* SROT */
-		nvmem-cells = <&tsens_caldata>;
-		nvmem-cell-names = "calib";
-		#qcom,sensors = <10>;
-		#thermal-sensor-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
new file mode 100644
index 000000000000..23afc7bf5a44
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -0,0 +1,168 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+# Copyright 2019 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QCOM SoC Temperature Sensor (TSENS)
+
+maintainers:
+  - Amit Kucheria <amit.kucheria@linaro.org>
+
+description: |
+  QCOM SoCs have TSENS IP to allow temperature measurement. There are currently
+  three distinct major versions of the IP that is supported by a single driver.
+  The IP versions are named v0.1, v1 and v2 in the driver, where v0.1 captures
+  everything before v1 when there was no versioning information.
+
+properties:
+  compatible:
+    oneOf:
+      - description: v0.1 of TSENS
+        items:
+          - enum:
+              - qcom,msm8916-tsens
+              - qcom,msm8974-tsens
+          - const: qcom,tsens-v0_1
+
+      - description: v1 of TSENS
+        items:
+          - enum:
+              - qcom,qcs404-tsens
+          - const: qcom,tsens-v1
+
+      - description: v2 of TSENS
+        items:
+          - enum:
+              - qcom,msm8996-tsens
+              - qcom,msm8998-tsens
+              - qcom,sdm845-tsens
+          - const: qcom,tsens-v2
+
+  reg:
+    maxItems: 2
+    items:
+      - description: TM registers
+      - description: SROT registers
+
+  nvmem-cells:
+    minItems: 1
+    maxItems: 2
+    description:
+      Reference to an nvmem node for the calibration data
+
+  nvmem-cells-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - enum:
+        - caldata
+        - calsel
+
+  "#qcom,sensors":
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 1
+      - maximum: 16
+    description:
+      Number of sensors enabled on this platform
+
+  "#thermal-sensor-cells":
+    const: 1
+    description:
+      Number of cells required to uniquely identify the thermal sensors. Since
+      we have multiple sensors this is set to 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8916-tsens
+              - qcom,msm8974-tsens
+              - qcom,qcs404-tsens
+              - qcom,tsens-v0_1
+              - qcom,tsens-v1
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
+        interrupt-names:
+          items:
+            - const: uplow
+
+    else:
+      properties:
+        interrupts:
+          items:
+            - description: Combined interrupt if upper or lower threshold crossed
+            - description: Interrupt if critical threshold crossed
+        interrupt-names:
+          items:
+            - const: uplow
+            - const: critical
+
+required:
+  - compatible
+  - reg
+  - "#qcom,sensors"
+  - interrupts
+  - interrupt-names
+  - "#thermal-sensor-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 1 (legacy: for pre v1 IP):
+    tsens1: thermal-sensor@900000 {
+           compatible = "qcom,msm8916-tsens", "qcom,tsens-v0_1";
+           reg = <0x4a9000 0x1000>, /* TM */
+                 <0x4a8000 0x1000>; /* SROT */
+
+           nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
+           nvmem-cell-names = "caldata", "calsel";
+
+           interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "uplow";
+
+           #qcom,sensors = <5>;
+           #thermal-sensor-cells = <1>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 2 (for any platform containing v1 of the TSENS IP):
+    tsens2: thermal-sensor@4a9000 {
+          compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+          reg = <0x004a9000 0x1000>, /* TM */
+                <0x004a8000 0x1000>; /* SROT */
+
+          nvmem-cells = <&tsens_caldata>;
+          nvmem-cell-names = "calib";
+
+          interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-names = "uplow";
+
+          #qcom,sensors = <10>;
+          #thermal-sensor-cells = <1>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    // Example 3 (for any platform containing v2 of the TSENS IP):
+    tsens3: thermal-sensor@c263000 {
+           compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+           reg = <0xc263000 0x1ff>,
+                 <0xc222000 0x1ff>;
+
+           interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+                        <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+           interrupt-names = "uplow", "critical";
+
+           #qcom,sensors = <13>;
+           #thermal-sensor-cells = <1>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e7a47b5210fd..ff757a4a060c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13360,6 +13360,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/thermal/qcom/
+F:	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
 
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
 M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
-- 
2.17.1

