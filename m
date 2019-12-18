Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8240C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAF02146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sd9/Owv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLRNYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:24:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37320 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfLRNYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:24:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so2125388lja.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 05:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=elchFhZaQqCljObbrVWX5gAwlUOkHif5wtGb7OTNVrQ=;
        b=Sd9/Owv7c4QCll0EOO34jDhL1TvjTR3zg7RdBLhRq2l9YNY56Z+nkVsfGhAhPnTr6W
         kXP2Qpq3mdlhErLzCofHRUpBbfac4KpS4c9LIe3R98MVHNJajyGzDZkrQrJMvb78uhqH
         xi3PG1w3+dH1997lQCiCT4GEf/4WgV84185mRRfolgRVgTgZWEunmprO17CqINodLAKC
         8orR+BZQHIyN6J9tLaUChiggcnED4oLFTZ+6g0AF+RFlLxX5ND9kjKhmDX81y27rjsBu
         V+CNNTZT7nWL8o7OhwUQJ/4zP7XhgwA0RFdsiIUo8WsskKxMSB24ZC46t1K7EiHXeWyF
         57qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=elchFhZaQqCljObbrVWX5gAwlUOkHif5wtGb7OTNVrQ=;
        b=gLjwE3YffwXUV8R8ACsh7oJ6aC/wKUoD7MKlKrch7g0ODxrpbauXzWiodIzFocnR31
         iWvtMdUB6P2PdrNmtPudP1Gzxw6RDIiEiAj44WHkcUekWchtBkeIEcI84igBYYrdNXmz
         x03XpADahTlO9G/tOlP2cvIpLtUCaN6vYLyqC9g8oW+6mUFdtrwerb4qBqeLz3x1gink
         mDiHYGlVH65jakKAQP0BNsBDpocCyMjS2pNU8DTspBRIDu5iozN1ac60C2D58flH9OwF
         a5RY1giGSAwrj/PkNOPNxDxjSxLnTMwkgilVt6VkFi7P+RguiLebjOnyBA91RCatw6xl
         emfQ==
X-Gm-Message-State: APjAAAWyEOUaH2CxTJWgEJqyAfD0gkDLAPROYP9LA7GvNNaxId0iqkNN
        NhxMyKz3ndvscKr1TytjnglUJg==
X-Google-Smtp-Source: APXvYqw/YpsnLKoxW7oc20j6FpIPNJ9NW1Ga9H1UzJFPdm9s3pixEKWCujufRKB2Qa/5Kms1jd5eDg==
X-Received: by 2002:a2e:999a:: with SMTP id w26mr1783354lji.142.1576675447780;
        Wed, 18 Dec 2019 05:24:07 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id z7sm1440667lfa.81.2019.12.18.05.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 05:24:07 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 06/12] dt-bindings: media: venus: Convert msm8916 to DT schema
Date:   Wed, 18 Dec 2019 15:22:45 +0200
Message-Id: <20191218132251.24161-7-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
References: <20191218132251.24161-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert qcom,msm8916-venus Venus binding to DT schema

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../bindings/media/qcom,venus-msm8916.yaml    | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,venus-msm8916.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,venus-msm8916.yaml b/Documentation/devicetree/bindings/media/qcom,venus-msm8916.yaml
new file mode 100644
index 000000000000..f82a8d968202
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,venus-msm8916.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/qcom,venus-msm8916.yaml#"
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
+      - qcom,msm8916-venus
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
+  video-decoder:
+    type: object
+
+    properties:
+      compatible:
+        const: "venus-decoder"
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
+        #include <dt-bindings/clock/qcom,gcc-msm8916.h>
+
+        video-codec@1d00000 {
+                compatible = "qcom,msm8916-venus";
+                reg = <0x01d00000 0xff000>;
+                interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&gcc GCC_VENUS0_VCODEC0_CLK>,
+                        <&gcc GCC_VENUS0_AHB_CLK>,
+                        <&gcc GCC_VENUS0_AXI_CLK>;
+                clock-names = "core", "iface", "bus";
+                power-domains = <&gcc VENUS_GDSC>;
+                iommus = <&apps_iommu 5>;
+                memory-region = <&venus_mem>;
+
+                video-decoder {
+                        compatible = "venus-decoder";
+                };
+
+                video-encoder {
+                        compatible = "venus-encoder";
+                };
+        };
-- 
2.17.1

