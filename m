Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F2FECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7598B20659
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYNRTX88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbfJPCwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:52:30 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:46929 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbfJPCw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:52:29 -0400
Received: by mail-qk1-f179.google.com with SMTP id e66so791278qkf.13;
        Tue, 15 Oct 2019 19:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bUPgOrzO03ynjh7f8hMryc9lj72KYAMDsgA/uPPC8XM=;
        b=gYNRTX88YXnJAS4PWAu/QZoCvEfhgvphEAR8wIr+TnZn0wLvA4DO6bFaDdC6koJnyq
         f50wrcrBEgUntsBq7BHlSVi6NfK0vh9OV3142qYQ7xMJ4Yp+5e3AActXpNxPnFA+7Jf+
         kRJf3AbqM6o5Ze96RA0IhYtRgfNbIcPqfW0BZfJBcRZFHuoKt5RimUY7jyDmhI8vRy1t
         B3f56psva5uHsCzJwZO+E2D9TFrWKEOzKLm1lrW9KV6vcPGQas4XaTquynlvMOZa6nR3
         WEFeF343VuYBCXRjucVWFE952OWK5s8mwJcLtihVpmNwgENoRkANM03vnhU3y4W8WBfn
         wxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bUPgOrzO03ynjh7f8hMryc9lj72KYAMDsgA/uPPC8XM=;
        b=kuV+KuXpjTgin2u+6skFh+FwfnhyAX1ZBkjW8PGv/xLD6R2TmnCEQ0OZGbzdCIYsD6
         HaP1Mca2pf4nrXXKcnC0tHFyJ/jlofIj9E05Lg3FadRHiilPzG9MTZuDq1tsvjZPCA/M
         wD1A7tyZQQhOSvoWAC98dPvfz3oxoEuxda0oVXTvgO6CCJVLqbG6Lk3XObmOUNvhAUAU
         04UNQKicuBlmuZO+/2R/MQqj/ptTcntt4vUngCeUu/CN6AFxyKv7n/6/HBSJedvFDZZL
         kOpU1sBI4qdkY76NvRsy39lLRZbKx+3Nd7MCCjJkcjn/XmJlojo/nysFRNr39uTup2Mz
         p8TA==
X-Gm-Message-State: APjAAAWBR5bCdLM1XTFjBagm05kMa5wYCleoj+RUlGDPAxPh7NUteoAh
        b4RAz6+uUMEvo+KFPnab4Qw=
X-Google-Smtp-Source: APXvYqyIv/kjCfPmmI1ZZH1sTicpI04pvyW71VV9KONREQ4437Jw3v70SYAVIrXdkVem9he1PZGXGg==
X-Received: by 2002:a37:4703:: with SMTP id u3mr39297600qka.130.1571194348643;
        Tue, 15 Oct 2019 19:52:28 -0700 (PDT)
Received: from smtp.gmail.com ([2804:d43:421:ecd6:45ed:dc65:8f65:8e1])
        by smtp.gmail.com with ESMTPSA id v7sm10850321qte.29.2019.10.15.19.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 19:52:28 -0700 (PDT)
Date:   Tue, 15 Oct 2019 23:52:23 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     jic23@kernel.org
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 2/2] dt-bindings: iio: adc: Add DT docs for AD7292
Message-ID: <20191016025220.td3xb7oxlfkznxl6@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree binding doc for AD7292 monitor and control system.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../bindings/iio/adc/adi,ad7292.yaml          | 107 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
new file mode 100644
index 000000000000..40028332d9e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7292.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7292 10-Bit Monitor and Control System
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt1@gmail.com>
+
+description: |
+  Analog Devices AD7292 10-Bit Monitor and Control System with ADC, DACs,
+  Temperature Sensor, and GPIOs
+
+  Specifications about the part can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7292
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: |
+      The regulator supply for ADC and DAC reference voltage.
+    maxItems: 1
+
+  spi-cpha:
+    description: |
+      See Documentation/devicetree/bindings/spi/spi-controller.yaml
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+patternProperties:
+  "^channel@[0-7]$":
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+      See Documentation/devicetree/bindings/iio/adc/adc.txt.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 8 channels numbered from 0 to 7.
+        maxItems: 1
+
+      diff-channels:
+        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
+        maxItems: 1
+
+    required:
+      - reg
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ad7292: ad7292@0 {
+        compatible = "adi,ad7292";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi-max-frequency = <25000000>;
+        vref-supply = <&adc_vref>;
+        spi-cpha;
+
+        channel@0 {
+          reg = <0>;
+          diff-channels = <0 1>;
+        };
+        channel@2 {
+          reg = <2>;
+        };
+        channel@3 {
+          reg = <3>;
+        };
+        channel@4 {
+          reg = <4>;
+        };
+        channel@5 {
+          reg = <5>;
+        };
+        channel@6 {
+          reg = <6>;
+        };
+        channel@7 {
+          reg = <7>;
+        };
+      };
+    }
diff --git a/MAINTAINERS b/MAINTAINERS
index e78317a5f4f1..5941cfc0d6f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -819,6 +819,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7292.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
 
 ANALOG DEVICES INC AD7606 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.23.0

