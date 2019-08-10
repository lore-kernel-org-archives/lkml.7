Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199F0C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E466F2184E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owjCa9lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfHJF36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:29:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42223 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHJF3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:29:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so47103397pff.9;
        Fri, 09 Aug 2019 22:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wjQ5RBMUscwhPovbCKs/X+MccsfEX8ouNnM/eU9tQdY=;
        b=owjCa9lXzv2/DwkfhVrhXGPfLgD8hjoGMaHzNtHK8q9nZFQLhg0aAuY2svLpXwtORD
         NcaMD7Xoi1eTrqSTeWXAdJTm6w7xsh3+ekzHVnQlUd6evrD1UaF0V5jA0xR0susVtGqK
         0E9Dqep2V9kZz9TJplT0xU6lPOE608vmJZCkcy4tFplb4Pr+b7RWp8661wdtUQBuYhmT
         cSlJV9R/IpJ8+PGtAooQJrVzgnoV9ux306PKcqD/2x4HLWnw4Om/JHW2XKA+lY2y+sYZ
         WNIQvi0mzQCMkjOUGMYYLFBoz6oocY6mck/do2zFdCcA3JJcNwATwqlbhtQ8u6d2A155
         hUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wjQ5RBMUscwhPovbCKs/X+MccsfEX8ouNnM/eU9tQdY=;
        b=TpSQmjJ6ggjppnvP7QaQ2/oD2Mgcowh5lS2qbFWJcjXldpKM7DR16aaXv9EC2sQ1+E
         OvxcZ7hhTtZbPCeMXvv5mLfawF6MwvrtzVSfNsma4NUI2YWBNCdgJOTGLWCkMbPwEXGt
         /BFMdCytbe1OXX1Xoo/uFpxgKa3BhGf6vZnqi83U2t8LmZ53dc86dzdGKPHuq533r1KG
         kKTDCpzHaqI43jTJRbVbLgUKd2Hfa7ISuNMNbHE1F9fr/rrs3P4dKXHQkupBRJ4SqSAF
         0oMNb6xoGgwViBoEJxWwzCf0rxO7ra5tUqWtkqqFefqTIXBnT5QjfiWeZjBN3mzHmLtm
         P1rA==
X-Gm-Message-State: APjAAAUiAsKL828edJSCtDJ1/JErOPzyES+vBh6Xj5qKcPBURB1XqHVi
        21vschDtzJpdOJFEmW/qYWY=
X-Google-Smtp-Source: APXvYqw8vs8pLZBSxmUAg7iqaM6hn9kfidzUufWlKeYMFwYYXWPhKeZ2pwcEdEyO8GNSSc0MtJ7W1w==
X-Received: by 2002:a62:7a0f:: with SMTP id v15mr6362442pfc.35.1565414994464;
        Fri, 09 Aug 2019 22:29:54 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id s24sm62023523pgm.3.2019.08.09.22.29.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:29:53 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 10/18] dt-bindings: thermal: add binding document for h3 thermal controller
Date:   Sat, 10 Aug 2019 05:28:21 +0000
Message-Id: <20190810052829.6032-11-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding document for allwinner h3 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 .../bindings/thermal/sun8i-thermal.yaml       | 81 ++++++++++++++++++-
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
index e0973199ba3c..6624cf6b1ce8 100644
--- a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
@@ -16,6 +16,7 @@ description: |-
 properties:
   compatible:
     enum:
+      - allwinner,sun8i-h3-ths
       - allwinner,sun50i-h6-ths
 
   reg:
@@ -28,13 +29,21 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: ths bus clock
+      - description: ths mod clock
 
   clock-names:
-    const: bus
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: bus
+      - const: mod
 
   "#thermal-sensor-cells":
-    const: 1
+    enum: [ 0, 1 ]
 
   nvmem-cells:
     description: ths calibrate data
@@ -51,9 +60,75 @@ required:
   - interrupts
   - "#thermal-sensor-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h6-ths
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+
+        clock-names:
+          minItems: 1
+          maxItems: 1
+
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+
+        clock-names:
+          minItems: 2
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun8i-h3-ths
+
+    then:
+      properties:
+        "#thermal-sensor-cells":
+          const: 0
+
+    else:
+      properties:
+        "#thermal-sensor-cells":
+          const: 1
+
 additionalProperties: false
 
 examples:
+  - |
+    ths: ths@1c25000 {
+        compatible = "allwinner,sun8i-h3-ths";
+        reg = <0x01c25000 0x400>;
+        clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+        clock-names = "bus", "mod";
+        resets = <&ccu RST_BUS_THS>;
+        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+        nvmem-cells = <&tsen_calib>;
+        nvmem-cell-names = "calib";
+        #thermal-sensor-cells = <0>;
+    };
+
+    sid: sid@1c14000 {
+        compatible = "allwinner,sun8i-h3-sid";
+        reg = <0x1c14000 0x400>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        tsen_calib: calib@34 {
+                reg = <0x34 2>;
+        };
+    };
+
   - |
     ths: ths@5070400 {
         compatible = "allwinner,sun50i-h6-ths";
-- 
2.17.1

