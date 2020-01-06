Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA47AC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1C9207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEEyM7WI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgAFPu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:50:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43341 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgAFPuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:50:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so51383309ljm.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=avd0gAE0YudQqA9I+NWgjCLJ34qPm3zqYQKHubXVmwA=;
        b=XEEyM7WIm0tT0+eqHeR2s1Ea70I6YGi4OMTFIWpzskPT9FIbsE/KuhcO+Q65Qr0glO
         z8SM0D2NALRVNaxlyFe0KB3UamBFiUzTmshAgrYvtqCs4kRs4Q8DO8xh7xG99E1jOjX+
         VTbFIi9TC+MSH/JrxlGprvzhMJ9Ef3GD0gNw9r7f1Br9AEszV2Krft1Gek14slzru1TC
         xlUXJWbdVA6nM+BMdSZEHC1XnssFfeA5bCPhxmG5uJHhsoZNfVXFGFXApGyaRX5htDmi
         KgH1E66nHeTrzIsFwJJUEfk9SIs16FlL4/aeL40Sc9H4MkvlHpog1Cjb+0kchEESnMLC
         RPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=avd0gAE0YudQqA9I+NWgjCLJ34qPm3zqYQKHubXVmwA=;
        b=CMCBsCR9/SFR/bFU4Eo7uJmdc8s5iCCAEC7yEfBvuOoXvuj2CfI4UK5krftsK7UF8u
         87/YqU9ixVnRvtxPQSHYxXE2Liz9sj4pQalCFQnfdX35KRscs7tv+4EDRP7PmZiuH/Bp
         Gs9u4nO+KHtDwyi12cOsqTwrLLY2TkusXCel5oWOKdr/Cho+JCQPrGv4UdNVvvJzglFn
         w37KVOFvqarl9CJNrQqooLVC7RYMUX1hx/oycfEErCfadM11tCVoTLGHuYsTxJMYMvpC
         9eWUoEvVuDVaZ49CViT75E77q1SFVDdr4kg1fvhRvFlicM50lmoVQWywq76/K8VNaZjT
         4wbg==
X-Gm-Message-State: APjAAAVmIgpZCZiZBcxFo9+RABhLTQ2bsjJB6/oExncM4FdqronZOg9F
        s1FKWAGGpoZiKmokIfOqba/Qfg==
X-Google-Smtp-Source: APXvYqwuW9osTzmFgEwlAwOqRx/9PhjxqTq/hXh9qxAlyPAHk0PkwPRGgSIW8aUu1G/w70pzJPuRdA==
X-Received: by 2002:a2e:814e:: with SMTP id t14mr58689016ljg.149.1578325821026;
        Mon, 06 Jan 2020 07:50:21 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id x84sm29388259lfa.97.2020.01.06.07.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:50:20 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 09/12] dt-bindings: media: venus: Add sdm845v2 DT schema
Date:   Mon,  6 Jan 2020 17:49:26 +0200
Message-Id: <20200106154929.4331-10-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new qcom,sdm845-venus-v2 DT binding schema.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../bindings/media/qcom,sdm845-venus-v2.yaml  | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
new file mode 100644
index 000000000000..8552f4ab907e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/qcom,sdm845-venus-v2.yaml#"
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
+    const: qcom,sdm845-venus-v2
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 3
+
+  power-domain-names:
+    items:
+      - const: venus
+      - const: vcodec0
+      - const: vcodec1
+
+  clocks:
+    maxItems: 7
+
+  clock-names:
+    items:
+      - const: core
+      - const: iface
+      - const: bus
+      - const: vcodec0_core
+      - const: vcodec0_bus
+      - const: vcodec1_core
+      - const: vcodec1_bus
+
+  iommus:
+    maxItems: 2
+
+  memory-region:
+    maxItems: 1
+
+  video-core0:
+    type: object
+
+    properties:
+      compatible:
+        const: venus-decoder
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+  video-core1:
+    type: object
+
+    properties:
+      compatible:
+        const: venus-encoder
+
+    required:
+      - compatible
+
+    additionalProperties: false
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
+        maxItems: 1
+
+    required:
+      - iommus
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-domains
+  - power-domain-names
+  - clocks
+  - clock-names
+  - iommus
+  - memory-region
+  - video-core0
+  - video-core1
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        #include <dt-bindings/clock/qcom,videocc-sdm845.h>
+
+        video-codec@aa00000 {
+                compatible = "qcom,sdm845-venus-v2";
+                reg = <0 0x0aa00000 0 0xff000>;
+                interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
+                         <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+                         <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
+                         <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+                         <&videocc VIDEO_CC_VCODEC0_AXI_CLK>,
+                         <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
+                         <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
+                clock-names = "core", "iface", "bus",
+                              "vcodec0_core", "vcodec0_bus",
+                              "vcodec1_core", "vcodec1_bus";
+                power-domains = <&videocc VENUS_GDSC>,
+                                <&videocc VCODEC0_GDSC>,
+                                <&videocc VCODEC1_GDSC>;
+                power-domain-names = "venus", "vcodec0", "vcodec1";
+                iommus = <&apps_smmu 0x10a0 0x8>,
+                         <&apps_smmu 0x10b0 0x0>;
+                memory-region = <&venus_mem>;
+
+                video-core0 {
+                        compatible = "venus-decoder";
+                };
+
+                video-core1 {
+                        compatible = "venus-encoder";
+                };
+        };
-- 
2.17.1

