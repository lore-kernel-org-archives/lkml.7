Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F82C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B01521775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrE9UwpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfLQMRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:17:05 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36272 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbfLQMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:17:02 -0500
Received: by mail-wm1-f46.google.com with SMTP id p17so2910329wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+AW0y+KhVU3jf0iB/BqndDaok1jIhJNFK3eYQj1PhU=;
        b=FrE9UwpJmi6mEJteUDGLP4ThCEs9LXMKFqcJtYE06TT1bjMt9Z2j0+Glfvg3sby61p
         TaC5VCrQO9/0HngNxCpK3UpLqT/OMrvAuINsXE+5aCN+Yf/FEcxCzzPbGY/QOSi8wEhy
         1p2Dj7ZwX9FLRrNzFIpndju8VQbj89EJ7L8PH2vNhcg0yBEq90DBc/5XjD6OBaisOg+b
         cI3I+/95yrB906fEOw7tSKoAWOXHJL2HLRKAOQ5FZryajDhCNdnFrzAGMAFqbkIiMlVi
         g4A6j59bgFKgCwWfHOug0QJv2+FwIaIFzMz4npmkxoNOpGAett//Ns7a6sI9AokUfOET
         gJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+AW0y+KhVU3jf0iB/BqndDaok1jIhJNFK3eYQj1PhU=;
        b=aW3yuBkzKxzOh0WSiXkZfChlK3LNoOxA/1GGAHM8pyzp3g/wo25aVQl2lqql85Cq2C
         JA1teg6KgcVD42jTIKgM7IxcYEzH4Ap4AlMqzPP4Epk1wI53fUTCfv3aQeHRVtDngB7L
         +S3odKEXUnGyut/1lZNJxPZVH5F4l8POvgRXnSNOStd7IrrMjsBTatJPPoGpcJAjMP/A
         bergQa6UlNn3DI7gL4s+m2978l5CHb9EXx+26O2BQpaZwZaBAiQS9AtlwXOize6vJbrO
         J9ZC8MUmOEg0tZKWqq2w5owB5Pic5E4b4Cl/Ga6T9buGY6cCC8Ab2VskTvuDGM8rFfzY
         Bb6g==
X-Gm-Message-State: APjAAAVZ54QavyZBvOWQK/mANxx79tE80JyPKDVGZPWL1Xmb9J8Y5TSg
        L5BWDi1OE/eNUx+ybkDkvpp1mw==
X-Google-Smtp-Source: APXvYqyidSBTUzeTHPrZTpbNozxNQ+94YnhIUL+/jrc04ac9Mzy/FJYTbabINZrd6cUdDNxrROFqIw==
X-Received: by 2002:a1c:4b01:: with SMTP id y1mr4952482wma.12.1576585020342;
        Tue, 17 Dec 2019 04:17:00 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f1sm25087270wru.6.2019.12.17.04.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:16:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 01/11] ASoC: dt-bindings: add dt bindings for WCD9340/WCD9341 audio codec
Date:   Tue, 17 Dec 2019 12:16:32 +0000
Message-Id: <20191217121642.28534-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
References: <20191217121642.28534-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for wcd9340/wcd9341 audio codec which can
support both SLIMbus and I2S/I2C interface.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wcd934x.yaml          | 175 ++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
new file mode 100644
index 000000000000..38eaf0c028f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd934x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for Qualcomm WCD9340/WCD9341 Audio Codec
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm WCD9340/WCD9341 Codec is a standalone Hi-Fi audio codec IC.
+  It has in-built Soundwire controller, pin controller, interrupt mux and
+  supports both I2S/I2C and SLIMbus audio interfaces.
+
+properties:
+  compatible:
+    const: slim217,250
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO spec for reset line to use
+    maxItems: 1
+
+  slim-ifc-dev: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: extclk
+
+  vdd-buck-supply:
+    description: A reference to the 1.8V buck supply
+
+  vdd-buck-sido-supply:
+    description: A reference to the 1.8V SIDO buck supply
+
+  vdd-rx-supply:
+    description: A reference to the 1.8V rx supply
+
+  vdd-tx-supply:
+    description: A reference to the 1.8V tx supply
+
+  vdd-vbat-supply:
+    description: A reference to the vbat supply
+
+  vdd-io-supply:
+    description: A reference to the 1.8V I/O supply
+
+  vdd-micbias-supply:
+    description: A reference to the micbias supply
+
+  qcom,micbias1-microvolt:
+    description: micbias1 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias2-microvolt:
+    description: micbias2 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias3-microvolt:
+    description: micbias3 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  qcom,micbias4-microvolt:
+    description: micbias4 voltage
+    minimum: 1800000
+    maximum: 2850000
+
+  clock-output-names:
+    const: mclk
+
+  clock-frequency:
+    description: Clock frequency of output clk in Hz
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+  '#clock-cells':
+    const: 0
+
+  '#sound-dai-cells':
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  gpio@42:
+    type: object
+    allOf:
+      - $ref: ../gpio/qcom,wcd934x-gpio.yaml#
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    description: |
+      WCD934x subnode for each slave devices. Bindings of each subnodes
+      depends on the specific driver providing the functionality and
+      documented in their respective bindings.
+
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - slim-ifc-dev
+  - interrupts
+  - interrupt-controller
+  - clock-frequency
+  - clock-output-names
+  - qcom,micbias1-microvolt
+  - qcom,micbias2-microvolt
+  - qcom,micbias3-microvolt
+  - qcom,micbias4-microvolt
+  - "#interrupt-cells"
+  - "#clock-cells"
+  - "#sound-dai-cells"
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    codec@1,0{
+        compatible = "slim217,250";
+        reg  = <1 0>;
+        reset-gpios = <&tlmm 64 0>;
+        slim-ifc-dev  = <&wcd9340_ifd>;
+        #sound-dai-cells = <1>;
+        interrupt-parent = <&tlmm>;
+        interrupts = <54 4>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        #clock-cells = <0>;
+        clock-frequency = <9600000>;
+        clock-output-names = "mclk";
+        qcom,micbias1-microvolt = <1800000>;
+        qcom,micbias2-microvolt = <1800000>;
+        qcom,micbias3-microvolt = <1800000>;
+        qcom,micbias4-microvolt = <1800000>;
+        clock-names = "extclk";
+        clocks = <&rpmhcc 2>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        gpio@42 {
+            compatible = "qcom,wcd9340-gpio";
+            reg = <0x42 0x2>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
+
+...
-- 
2.21.0

