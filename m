Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A1C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C1D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5Aojco+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLRNYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:24:14 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45385 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfLRNYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:24:11 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so1664125lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2E0JQXe1pZot4z3LbYAnlOx/3QufFKC+hmq2Am0jK/U=;
        b=w5Aojco+S485wwfMKoZYKx1/YAGbrjcHffhqg5wrUy0veQzYYvwH6nkaP0DZhuhwdX
         5W0JM5FNURjEYxLMd0w47qOEdmcwb5J9rBkTtlKs7ce+ZXmuyhWs6dgkGgQZKApYx20l
         ZcVcQWOOHm4cSSKvAcML1OVnYWD1uz0WDFPsg6QsdVJXp51VetZPRA6vfIZ3AVgCY3nY
         bXc7rnlkMqxpaMufndiG3vnB9ASdOA01Og0jgS3ILJwYrYG3jah+LcbhTxLnHyTU6VH3
         AnxfrBw0W9mDh0UB40tG3lWXY2PW6u4Ub2Fdm3StDn2hODcC9hX19SaQzGM/uj9ZBIW+
         R8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2E0JQXe1pZot4z3LbYAnlOx/3QufFKC+hmq2Am0jK/U=;
        b=Ge7m4tbbKM6jV0Iy26Chv84w/qWNph+vdOnCIi7gfS+zrVVcRuA2Nbg0XWIQw1bP5S
         8Y5dtBYtBwKXvGpTLQ2eJdhPz562Ot4SLdcbpwUc5DOlvwPR0xCk0bQkaLEeH2MmdVE8
         Ws8n5pYahrlFemaLyhg7jd8/+7IDsBqxEFo/1TxAUBB6bfart4xVq9aW2I67ltqJkkff
         yQCn/tAIw9p5rRnuo5xmB/4qMSKcf4o6ShAE3AqOpJ/ycEMvlZm5HBdQlrgzYhDPZj9H
         ANK5NV19l8GcAxRcviCzYhwJGaMZdcvHvzCu3pHZgNKVmxC1Vx9YGuDUspmL3n7CgJNN
         iNbA==
X-Gm-Message-State: APjAAAXPBLK2fUb7Pj+gGz0eSI1OrNfAekkjW4nmGyQzmPGbO96qhIxm
        FlqCmMWt5xFDdvt4qRADNghrhg==
X-Google-Smtp-Source: APXvYqx8kpR3Zy5ZCwc3C8hD1FpSX7vQgfyD2sGRnjhbocIJ/xVVLc3og9rYGWS/XhrxYJrRwwQPvw==
X-Received: by 2002:a19:4a12:: with SMTP id x18mr1712471lfa.158.1576675449583;
        Wed, 18 Dec 2019 05:24:09 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id z7sm1440667lfa.81.2019.12.18.05.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:24:09 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 07/12] dt-bindings: media: venus: Convert msm8996 to DT schema
Date:   Wed, 18 Dec 2019 15:22:46 +0200
Message-Id: <20191218132251.24161-8-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
References: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert qcom,msm8996-venus Venus binding to DT schema.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../bindings/media/qcom,venus-msm8996.yaml    | 139 ++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,venus-msm8996.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,venus-msm8996.yaml b/Documentation/devicetree/bindings/media/qcom,venus-msm8996.yaml
new file mode 100644
index 000000000000..8dd852aa0d25
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,venus-msm8996.yaml
@@ -0,0 +1,139 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/qcom,venus-msm8996.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Venus video encode and decode accelerators
+
+maintainers:
+  - Stanimir Varbanov <stanimir.varbanov@linaro.org>
+
+description: |
+  The Venus IP is a video encode and decode accelerator present
+  on Qualcomm platforms
+
+properties:
+  compatible:
+    enum:
+      - qcom,msm8996-venus
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    maxItems: 4
+    items:
+      - const: core
+      - const: iface
+      - const: bus
+      - const: mbus
+
+  iommus:
+    minItems: 1
+    maxItems: 20
+
+  memory-region:
+    maxItems: 1
+
+  video-decoder:
+    type: object
+
+    properties:
+      compatible:
+        const: "venus-decoder"
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        maxItems: 1
+        items:
+          - const: core
+
+    required:
+      - compatible
+
+  video-encoder:
+    type: object
+
+    properties:
+      compatible:
+        const: "venus-encoder"
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        maxItems: 1
+        items:
+          - const: core
+
+    required:
+      - compatible
+
+  video-firmware:
+    type: object
+
+    description: |
+      Firmware subnode is needed when the platform does not
+      have TrustZone.
+
+    properties:
+      iommus:
+        minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-domains
+  - clocks
+  - clock-names
+  - iommus
+  - memory-region
+  - video-decoder
+  - video-encoder
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
+
+        video-codec@c00000 {
+                compatible = "qcom,msm8996-venus";
+                reg = <0x00c00000 0xff000>;
+                interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&mmcc VIDEO_CORE_CLK>,
+                         <&mmcc VIDEO_AHB_CLK>,
+                         <&mmcc VIDEO_AXI_CLK>,
+                         <&mmcc VIDEO_MAXI_CLK>;
+                clock-names = "core", "iface", "bus", "mbus";
+                power-domains = <&mmcc VENUS_GDSC>;
+                iommus = <&iommu 0>;
+                memory-region = <&venus_mem>;
+
+                video-decoder {
+                        compatible = "venus-decoder";
+                        clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
+                        clock-names = "core";
+                        power-domains = <&mmcc VENUS_CORE0_GDSC>;
+                };
+
+                video-encoder {
+                        compatible = "venus-encoder";
+                        clocks = <&mmcc VIDEO_SUBCORE1_CLK>;
+                        clock-names = "core";
+                        power-domains = <&mmcc VENUS_CORE1_GDSC>;
+                };
+        };
-- 
2.17.1

