Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A280C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B4A2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1i18nve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfLWLea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 06:34:30 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:33757 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfLWLdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:33:52 -0500
Received: by mail-lj1-f169.google.com with SMTP id y6so9403549lji.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 03:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jkanxD20zHkGk3fihhvJoQvRjKe+QCxfIUzc4lNxBrk=;
        b=L1i18nvecldHa2M8xvd1KHs+F4+mRrL9Mhz/OTamE4p7N3xRkiUDwtZeUP4+yfhPZ3
         xf+IaoIjpyFT++N8BB/9k7gDDz0bcyLHFgJFU5Zt+bbtc/uDJjD7+X+1abPG87o3m8Qw
         8mHizWC2jY3EUxC4FOLNO1sAaLQTbH6bJnvoOG9hA+AQECHqgKtw0yXDPNidK/TtgHVK
         g9m/Ko4rvuK1Vdy9uyuNdvRcigeYQeyNclbd+uPO5Un/IaToFjlW503X79Mt7fxxTlFd
         5OYknwQw04TaIE39F4q8/+I8NmMvEb10B0mQeym2MYIL7lOUMUs5TRjnXnCy5xHliz/v
         LIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jkanxD20zHkGk3fihhvJoQvRjKe+QCxfIUzc4lNxBrk=;
        b=o54Je/+dhc0ZOab2Z9toNp7U0z2u07/aqOL/stP77rfXqXHlOc60MID8OnkolQnc4J
         5HP+x9zYeP6V3uU6Ef7jwPPUFgTg8Ihu5Vo15s4gIDRQTYJ8I8eUq30D1VM8wX4RjWv6
         tz302K6FLXuWAt+9iEdxarsLOKkb7KFumKruk990qPdTXGA+TLsn9andAtRdI94ys9HU
         p0MFd8GkHM9vfDmV/cCLOLUmzKzpAVFAh1StxRX+VHTBaIfBWttJxW3blYAdKsxmJCZP
         0y0ZVA0Q6htwbrrGv8EeZeAiw3rGuB8odgRCnaDZtLu2WyKHk4SNeZ6dck46ptnyRCBO
         1YbQ==
X-Gm-Message-State: APjAAAUs8XNeUWhrZg5F4ehZOgZFOjHCAeDWR97PSfPtUIYZI7+7FRcC
        1QrTDYcU3Mk8bjHQBDkWKM9mbQ==
X-Google-Smtp-Source: APXvYqyhB2qoRG2RiNVNKlOO3YVMdcRa3nVnxf3Irg7qXnuD1HAf8jS2H1uBVFD9ZkHDN2I+r+IdCg==
X-Received: by 2002:a2e:b4cf:: with SMTP id r15mr17687359ljm.52.1577100830595;
        Mon, 23 Dec 2019 03:33:50 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.193])
        by smtp.gmail.com with ESMTPSA id g15sm8381500ljk.8.2019.12.23.03.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 03:33:50 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 06/12] dt-bindings: media: venus: Convert msm8916 to DT schema
Date:   Mon, 23 Dec 2019 13:33:05 +0200
Message-Id: <20191223113311.20602-7-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223113311.20602-1-stanimir.varbanov@linaro.org>
References: <20191223113311.20602-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert qcom,msm8916-venus Venus binding to DT schema

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../bindings/media/qcom,msm8916-venus.yaml    | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml

diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
new file mode 100644
index 000000000000..14331c16135c
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/qcom,msm8916-venus.yaml#"
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
+    const: "qcom,msm8916-venus"
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
+    additionalProperties: false
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

