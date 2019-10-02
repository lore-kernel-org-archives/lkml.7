Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E949C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAB12246B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="x774vBXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfJBHU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:20:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32796 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfJBHU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:20:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so4230787wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 00:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVeija8izmHAdZ2KAw8CMxpHYhKosiGHrmDwIMpjElY=;
        b=x774vBXkOgSY/byW+bo39MD70Xbp/IrcihA+0ifIntJCWYERcFOet9cRaxG+jBYseM
         PYVpsE2WrVND7HnW2NvlfcgJu4mu1uol9iiYnr4u1GRR6NHZjs0nxMVTe915rpBWMNBx
         uYAfK1BksbFoYliPIJqZL4zZhG6E4M0ePD0dannvLBoxG2swPtL2IE1C+Kz1dEHx836n
         kAQVK8Je7ersqktwR6Wi4N22f1mDYIzAa7JfEoXpZX4j/oFR59kGaYA5+X/al04KZ4LW
         Q3X/zK6ar6t/e7IEo46Uz3Uyjx5LTz9yJ24SDVGe+yr1jHlOzexC8LVCxS6mejOJ929P
         uYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVeija8izmHAdZ2KAw8CMxpHYhKosiGHrmDwIMpjElY=;
        b=ZbA+Zy8+tPlrPOShUQAmFazuKz4nSAmaaW0jQxS5xkGwwQKUMhvARYn+UwjqBItwAO
         WqLGn36hJOqgonvS4oHA8YTLl84LGBZCUjAN8kkbTgboP3uw0t7/h1ihKRJtmlH7uL6D
         9SKsj9FUD2cLdeGLiFi4+5Fg9QFYpayDsqcxXjBL1ipNklMEFslNtX2gVDyJGaRJh8yf
         9lDJyg2tz3RZlXUwZh12ogdJGbX1UIVpuvvouD3YK2DlYPEeJL7R/y+TwkdXVTrsSpS+
         ybZFsL/csgJT2iFsOjK5wRqTdmZrVmqiDkYKe9zLQJAzNa9LrSQJkuYGMU1WARGsH3qv
         YyZw==
X-Gm-Message-State: APjAAAUQ2ZkWvorNRAQzvBveOJi2jIbzEJ5iWufwRkDLqSe/TNVpRse7
        PhdPjdL4rPKT5Xlco2g1Q6AG6Q==
X-Google-Smtp-Source: APXvYqw37EMIlDO3/i8K7x2vCe9aidvUlQNhuE8pYv8+zuHm4N1YQISfuteHZshlR+FRVCbQrseHUA==
X-Received: by 2002:a1c:b745:: with SMTP id h66mr1550049wmf.70.1570000852856;
        Wed, 02 Oct 2019 00:20:52 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n18sm3850640wmi.20.2019.10.02.00.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 00:20:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: at24: convert the binding document to yaml
Date:   Wed,  2 Oct 2019 09:20:46 +0200
Message-Id: <20191002072047.20895-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002072047.20895-1-brgl@bgdev.pl>
References: <20191002072047.20895-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for at24 EEPROMs from txt to yaml. The
compatible property uses a regex pattern to address all the possible
combinations of "vendor,model" strings.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
[robh: rework compatible schema, fix missing allOf for $ref, fix errors in example]
Signed-off-by: Rob Herring <robh@kernel.org>
[Bartosz: added comments explaining the compatible property]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/eeprom/at24.txt       |  90 +--------
 .../devicetree/bindings/eeprom/at24.yaml      | 185 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 187 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/eeprom/at24.yaml

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 22aead844d0f..c94acbb8cb0c 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -1,89 +1 @@
-EEPROMs (I2C)
-
-Required properties:
-
-  - compatible: Must be a "<manufacturer>,<model>" pair. The following <model>
-                values are supported (assuming "atmel" as manufacturer):
-
-                "atmel,24c00",
-                "atmel,24c01",
-                "atmel,24cs01",
-                "atmel,24c02",
-                "atmel,24cs02",
-                "atmel,24mac402",
-                "atmel,24mac602",
-                "atmel,spd",
-                "atmel,24c04",
-                "atmel,24cs04",
-                "atmel,24c08",
-                "atmel,24cs08",
-                "atmel,24c16",
-                "atmel,24cs16",
-                "atmel,24c32",
-                "atmel,24cs32",
-                "atmel,24c64",
-                "atmel,24cs64",
-                "atmel,24c128",
-                "atmel,24c256",
-                "atmel,24c512",
-                "atmel,24c1024",
-                "atmel,24c2048",
-
-                If <manufacturer> is not "atmel", then a fallback must be used
-                with the same <model> and "atmel" as manufacturer.
-
-                Example:
-                        compatible = "microchip,24c128", "atmel,24c128";
-
-                Supported manufacturers are:
-
-                "catalyst",
-                "microchip",
-                "nxp",
-                "ramtron",
-                "renesas",
-                "rohm",
-                "st",
-
-                Some vendors use different model names for chips which are just
-                variants of the above. Known such exceptions are listed below:
-
-                "nxp,se97b" - the fallback is "atmel,24c02",
-                "renesas,r1ex24002" - the fallback is "atmel,24c02"
-                "renesas,r1ex24016" - the fallback is "atmel,24c16"
-                "renesas,r1ex24128" - the fallback is "atmel,24c128"
-                "rohm,br24t01" - the fallback is "atmel,24c01"
-
-  - reg: The I2C address of the EEPROM.
-
-Optional properties:
-
-  - pagesize: The length of the pagesize for writing. Please consult the
-              manual of your device, that value varies a lot. A wrong value
-              may result in data loss! If not specified, a safety value of
-              '1' is used which will be very slow.
-
-  - read-only: This parameterless property disables writes to the eeprom.
-
-  - size: Total eeprom size in bytes.
-
-  - no-read-rollover: This parameterless property indicates that the
-                      multi-address eeprom does not automatically roll over
-                      reads to the next slave address. Please consult the
-                      manual of your device.
-
-  - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
-
-  - address-width: number of address bits (one of 8, 16).
-
-  - num-addresses: total number of i2c slave addresses this device takes
-
-Example:
-
-eeprom@52 {
-	compatible = "atmel,24c32";
-	reg = <0x52>;
-	pagesize = <32>;
-	wp-gpios = <&gpio1 3 0>;
-	num-addresses = <8>;
-};
+This file has been moved to at24.yaml.
diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
new file mode 100644
index 000000000000..c56f27fde3b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -0,0 +1,185 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright 2019 BayLibre SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/eeprom/at24.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: I2C EEPROMs compatible with Atmel's AT24
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        pattern: "^atmel,(24(c|cs|mac)[0-9]+|spd)$"
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^eeprom@[0-9a-f]{1,2}$"
+
+  # There are multiple known vendors who manufacture EEPROM chips compatible
+  # with Atmel's AT24. The compatible string requires either a single item
+  # if the memory comes from Atmel (in which case the vendor part must be
+  # 'atmel') or two items with the same 'model' part where the vendor part of
+  # the first one is the actual manufacturer and the second item is the
+  # corresponding 'atmel,<model>' from Atmel.
+  compatible:
+    oneOf:
+      - allOf:
+          - minItems: 1
+            maxItems: 2
+            items:
+              - pattern: "^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),(24(c|cs|mac)[0-9]+|spd)$"
+              - pattern: "^atmel,(24(c|cs|mac)[0-9]+|spd)$"
+          - oneOf:
+              - items:
+                  pattern: c00$
+              - items:
+                  pattern: c01$
+              - items:
+                  pattern: cs01$
+              - items:
+                  pattern: c02$
+              - items:
+                  pattern: cs02$
+              - items:
+                  pattern: mac402$
+              - items:
+                  pattern: mac602$
+              - items:
+                  pattern: c04$
+              - items:
+                  pattern: cs04$
+              - items:
+                  pattern: c08$
+              - items:
+                  pattern: cs08$
+              - items:
+                  pattern: c16$
+              - items:
+                  pattern: cs16$
+              - items:
+                  pattern: c32$
+              - items:
+                  pattern: cs32$
+              - items:
+                  pattern: c64$
+              - items:
+                  pattern: cs64$
+              - items:
+                  pattern: c128$
+              - items:
+                  pattern: cs128$
+              - items:
+                  pattern: c256$
+              - items:
+                  pattern: cs256$
+              - items:
+                  pattern: c512$
+              - items:
+                  pattern: cs512$
+              - items:
+                  pattern: c1024$
+              - items:
+                  pattern: cs1024$
+              - items:
+                  pattern: c2048$
+              - items:
+                  pattern: cs2048$
+              - items:
+                  pattern: spd$
+      # These are special cases that don't conform to the above pattern.
+      # Each requires a standard at24 model as fallback.
+      - items:
+          - const: rohm,br24t01
+          - const: atmel,24c01
+      - items:
+          - const: nxp,se97b
+          - const: atmel,24c02
+      - items:
+          - const: renesas,r1ex24002
+          - const: atmel,24c02
+      - items:
+          - const: renesas,r1ex24016
+          - const: atmel,24c16
+      - items:
+          - const: renesas,r1ex24128
+          - const: atmel,24c128
+
+  reg:
+    maxItems: 1
+
+  pagesize:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The length of the pagesize for writing. Please consult the
+      manual of your device, that value varies a lot. A wrong value
+      may result in data loss! If not specified, a safety value of
+      '1' is used which will be very slow.
+    enum: [ 1, 8, 16, 32, 64, 128, 258 ]
+    default: 1
+
+  read-only:
+    $ref: /schemas/types.yaml#definitions/flag
+    description:
+      Disables writes to the eeprom.
+
+  size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Total eeprom size in bytes.
+
+  no-read-rollover:
+    $ref: /schemas/types.yaml#definitions/flag
+    description:
+      Indicates that the multi-address eeprom does not automatically roll
+      over reads to the next slave address. Please consult the manual of
+      your device.
+
+  wp-gpios:
+    description:
+      GPIO to which the write-protect pin of the chip is connected.
+    maxItems: 1
+
+  address-width:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of address bits.
+    default: 8
+    enum: [ 8, 16 ]
+
+  num-addresses:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Total number of i2c slave addresses this device takes.
+    default: 1
+    minimum: 1
+    maximum: 8
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      eeprom@52 {
+          compatible = "microchip,24c32", "atmel,24c32";
+          reg = <0x52>;
+          pagesize = <32>;
+          wp-gpios = <&gpio1 3 0>;
+          num-addresses = <8>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..320fc8bba872 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2699,7 +2699,7 @@ M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
 L:	linux-i2c@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
 S:	Maintained
-F:	Documentation/devicetree/bindings/eeprom/at24.txt
+F:	Documentation/devicetree/bindings/eeprom/at24.yaml
 F:	drivers/misc/eeprom/at24.c
 
 ATA OVER ETHERNET (AOE) DRIVER
-- 
2.23.0

