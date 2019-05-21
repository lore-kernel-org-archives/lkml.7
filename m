Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B31C072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA7A217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 21:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558473812;
	bh=87KpimrWOTJvr7l4tbHegrPfi0P8T8mQUtghYrUM1wo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YdxwnEXGs4YgkW4hdXMmmRAyvvUANMvunHPUdeei6TAgLsonaxD9WVdcbak3SsxKJ
	 uEoe5pueazSzKq3vF/J+RxVwTSCkZEesI8ixnDUwYRV5MuOgStj84Eg/9BZB0lHO5w
	 TgZh+62eLRx3iKSNnG9fzlsfhsBM02a5Mgx93QbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfEUVXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 17:23:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46566 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfEUVX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:23:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id j49so105414otc.13;
        Tue, 21 May 2019 14:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqAy2tu1FFqlI/CRjq09V8yQxMvBSVTSPxlWezcgKGg=;
        b=dfpvE6SfjM3a66zQ9tKFxvDhnykaulTHm/Rx0awHLE4Kiv4oJWKygp2FEm3ucK4WL1
         OrxsX+HucL9ygPxFpOfvqcazOym43ziFIv5I7PXQogwQf56RS/UmyM3OCv6KgMifDtEV
         3Zz/6e/waEZlDNHtqGLbQfRVomQua+ocq7Z1TQ3VgMLbntdCrlOzvkbvwTQCxy2fI6bj
         NMBzommvJxoqoDmqBljagJVVpEmX/Zsj9aUwwNo7ewF/ieRtaiSfDG7qKGN+f9RO1N9G
         g6gJBpPKNVVWWI8/Pa4B3/rGO3rpO1AXzKVg5Ro7DXLQ1xwVIYUWbMMpFI+SrP5LKavP
         2ehQ==
X-Gm-Message-State: APjAAAVhcbTsg5dIaz0wv8VvPmcyOUQWju/EVOxyi/KnoGPxP5YtNh9C
        rF8NA0r0yvrlF9/CM5kfFQ==
X-Google-Smtp-Source: APXvYqzhMQubjFBn9Wr/shxi3QOZv21jPoLOUF+H3Tyk3H+LV4pShyHV/+1b7UcJZhdKLjC+akUbTQ==
X-Received: by 2002:a9d:6195:: with SMTP id g21mr24908otk.179.1558473808278;
        Tue, 21 May 2019 14:23:28 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id w24sm4835474otk.74.2019.05.21.14.23.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 14:23:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: Convert spi-gpio binding to json-schema
Date:   Tue, 21 May 2019 16:23:25 -0500
Message-Id: <20190521212325.16639-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the spi-gpio binding to DT schema format.

Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-gpio.txt      | 43 -----------
 .../devicetree/bindings/spi/spi-gpio.yaml     | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.txt b/Documentation/devicetree/bindings/spi/spi-gpio.txt
deleted file mode 100644
index 52db562f17a4..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-gpio.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-SPI-GPIO devicetree bindings
-
-This represents a group of 3-n GPIO lines used for bit-banged SPI on dedicated
-GPIO lines.
-
-Required properties:
-
- - compatible: should be set to "spi-gpio"
- - #address-cells: should be set to <0x1>
- - ranges
- - sck-gpios: GPIO spec for the SCK line to use
- - miso-gpios: GPIO spec for the MISO line to use
- - mosi-gpios: GPIO spec for the MOSI line to use
- - cs-gpios: GPIOs to use for chipselect lines.
-             Not needed if num-chipselects = <0>.
- - num-chipselects: Number of chipselect lines. Should be <0> if a single device
-                    with no chip select is connected.
-
-Deprecated bindings:
-
-These legacy GPIO line bindings can alternatively be used to define the
-GPIO lines used, they should not be used in new device trees.
-
- - gpio-sck: GPIO spec for the SCK line to use
- - gpio-miso: GPIO spec for the MISO line to use
- - gpio-mosi: GPIO spec for the MOSI line to use
-
-Example:
-
-	spi {
-		compatible = "spi-gpio";
-		#address-cells = <0x1>;
-		ranges;
-
-		sck-gpios = <&gpio 95 0>;
-		miso-gpios = <&gpio 98 0>;
-		mosi-gpios = <&gpio 97 0>;
-		cs-gpios = <&gpio 125 0>;
-		num-chipselects = <1>;
-
-		/* clients */
-	};
-
diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.yaml b/Documentation/devicetree/bindings/spi/spi-gpio.yaml
new file mode 100644
index 000000000000..55c4f1705f07
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-gpio.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-GPIO devicetree bindings
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description:
+  This represents a group of 3-n GPIO lines used for bit-banged SPI on
+  dedicated GPIO lines.
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: spi-gpio
+
+  sck-gpios:
+    description: GPIO spec for the SCK line to use
+    maxItems: 1
+
+  miso-gpios:
+    description: GPIO spec for the MISO line to use
+    maxItems: 1
+
+  mosi-gpios:
+    description: GPIO spec for the MOSI line to use
+    maxItems: 1
+
+  cs-gpios:
+    description: GPIOs to use for chipselect lines.
+      Not needed if num-chipselects = <0>.
+    minItems: 1
+    maxItems: 1024
+
+  num-chipselects:
+    description: Number of chipselect lines. Should be <0> if a single device
+      with no chip select is connected.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  # Deprecated properties
+  gpio-sck: false
+  gpio-miso: false
+  gpio-mosi: false
+
+required:
+  - compatible
+  - num-chipselects
+  - sck-gpios
+
+examples:
+  - |
+    spi {
+      compatible = "spi-gpio";
+      #address-cells = <0x1>;
+      #size-cells = <0x0>;
+
+      sck-gpios = <&gpio 95 0>;
+      miso-gpios = <&gpio 98 0>;
+      mosi-gpios = <&gpio 97 0>;
+      cs-gpios = <&gpio 125 0>;
+      num-chipselects = <1>;
+
+      /* clients */
+    };
+
+...
-- 
2.20.1

