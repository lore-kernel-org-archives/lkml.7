Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD11DC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40392176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PY1qWRdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfLRNYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:24:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40849 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLRNYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:24:14 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so2121070ljk.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=unqIuIpnL0SKav+KaURk+5yuOec5tbAyPzTEx5H0hC0=;
        b=PY1qWRdU8/IJtzEkH9dEi7ciUkruMXnneayBeR6VHlIyzfG52/l5OqxiD4bMqdQZv6
         m4st955NgxkUXzg2lkGxJ72Vt7u32kCnSsm6BePQJJ0YoA86+12iDAh+4/EyNogR+BTV
         pO6XNfGRqjhHYWo4/k/CeYJeH08ak7JFxyVJORvfhgaFJ4oEnLRTdWUf+Zn7wT69Giyf
         VBSF6LV3kg0roqFJDDhLvZiw4vt7PnlixzXZHfvOt+KOQP7fH2S+P3EnCnMCvEJKEHEj
         FherkDEjnsiGsSp6gvPHczQRbAWocD6qCShi7x4ITOtVF/cj1H5j59w0z4H0PultmYCh
         +ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=unqIuIpnL0SKav+KaURk+5yuOec5tbAyPzTEx5H0hC0=;
        b=adx5Q6ORaR1C6CcnRplmmVreW/YfxFge4OYnRXqg0JaMtMR4bThICBrY9A5MIrmZ+U
         MCjF9fcO/jxHMyXKpgYVKYTJgQYKO1fjolanILBtCpudoZrK5AvvVYyy2+lC7k7ZOy20
         VTKDeJOmKvotMJgnOR0+A1I5iyjZnH/eMtRyhe2D+B4LfMk+iAbgxiJVv2aUyZqyl2I8
         aHXTmGHHcFTYb9ct9Sx597mWUaEq6nuOwqfHWmTlps/Dq3AdVS6JDkDo2+hQoTSNloef
         BriXkRVjZdagX3sI2jCfalYR3JAu9F5zJmkgM7iYNBPFzA1AoM1me7nJTETxHEk8sqxJ
         3lBw==
X-Gm-Message-State: APjAAAV8smJA84GBN1EQfm9YwHgNOyCeLbTzTbyozUFe7kCmYdltLPF9
        SXnGMx/tCvvMJLiA4VNeQ6xq0g==
X-Google-Smtp-Source: APXvYqyCKS0JXJzqWtstsL6t6OlHNUXPgonafhakg0IOrxL8NfSw9XxJ1gwqYOmdWfTSNu7A4t1mdw==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr1645018lji.247.1576675451419;
        Wed, 18 Dec 2019 05:24:11 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id z7sm1440667lfa.81.2019.12.18.05.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:24:10 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 08/12] dt-bindings: media: venus: Convert sdm845 to DT schema
Date:   Wed, 18 Dec 2019 15:22:47 +0200
Message-Id: <20191218132251.24161-9-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
References: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert qcom,sdm845-venus Venus binding to DT schema.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../bindings/media/qcom,venus-sdm845.yaml     | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,venus-sdm845.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,venus-sdm845.yaml b/Documentation/devicetree/bindings/media/qcom,venus-sdm845.yaml
new file mode 100644
index 000000000000..4136a0d979d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,venus-sdm845.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/qcom,venus-sdm845.yaml#"
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
+      - qcom,sdm845-venus
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    minItems: 1
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    maxItems: 3
+    items:
+      - const: core
+      - const: iface
+      - const: bus
+
+  iommus:
+    minItems: 1
+    maxItems: 20
+
+  memory-region:
+    maxItems: 1
+
+  video-core0:
+    type: object
+
+    properties:
+      compatible:
+        const: "venus-decoder"
+
+      clocks:
+        maxItems: 2
+
+      clock-names:
+        maxItems: 2
+        items:
+          - const: core
+          - const: bus
+
+      power-domains:
+        minItems: 1
+        maxItems: 1
+
+    required:
+      - compatible
+
+  video-core1:
+    type: object
+
+    properties:
+      compatible:
+        const: "venus-encoder"
+
+      clocks:
+        maxItems: 2
+
+      clock-names:
+        maxItems: 2
+        items:
+          - const: core
+          - const: bus
+
+      power-domains:
+        minItems: 1
+        maxItems: 1
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
+  - video-core0
+  - video-core1
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        #include <dt-bindings/clock/qcom,videocc-sdm845.h>
+
+        video-codec@aa00000 {
+                compatible = "qcom,sdm845-venus";
+                reg = <0 0x0aa00000 0 0xff000>;
+                interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
+                         <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+                         <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
+                clock-names = "core", "iface", "bus";
+                power-domains = <&videocc VENUS_GDSC>;
+                iommus = <&apps_smmu 0x10a0 0x8>,
+                         <&apps_smmu 0x10b0 0x0>;
+                memory-region = <&venus_mem>;
+
+                video-core0 {
+                        compatible = "venus-decoder";
+                        clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+                                 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
+                        clock-names = "core", "bus";
+                        power-domains = <&videocc VCODEC0_GDSC>;
+                };
+
+                video-core1 {
+                        compatible = "venus-encoder";
+                        clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
+                                 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
+                        clock-names = "core", "bus";
+                        power-domains = <&videocc VCODEC1_GDSC>;
+                };
+        };
-- 
2.17.1

