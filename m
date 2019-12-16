Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF59C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD91E20700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAy22QvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLPLlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:41:15 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:43079 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfLPLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:41:14 -0500
Received: by mail-pj1-f47.google.com with SMTP id g4so2849645pjs.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JpUV+EzBf5UQVu6B5s3q7vzuc+RcJYcN/8U92TH/gjg=;
        b=RAy22QvOHzC8pdsaTRdxjzH5m9jvEed2Mpca0DEnHg/e1CSge9uarJnVvbYrZqS5wc
         es0aj56YdAjBR5nVW2OSX/SquF/HGdASC/DFs3vsaIZELB7+Yfsv8Pk4mWvBHf5yOHwj
         3Vzh0w1so9l34pWouDf1+vNvtuTupoH5MLEapqCRvYzFEkvtSAlOTH5a30hXsA5ArEc2
         xzDnBg95Bk5cgAKZzYKcUMqxGWFYdu9D3P3QvrDz1uZcEKqYQyQdJlh6BGAN+ckLnhWU
         LJ5blbalmkhnTiZQFS2uYKZp9sibgdwWjz46yUjdkpbB5QBE5Mqqfjk4CAA6JJVKo8Io
         ru9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JpUV+EzBf5UQVu6B5s3q7vzuc+RcJYcN/8U92TH/gjg=;
        b=uUvzlkTjb9fhIS/qO2QkPiiY7KrqbTCEESyGL0Hwyas4zlUANt5GvAr8aQpWh6DYyt
         xsefq+R65hXQtY/g/H3sHG0V6NlVCKAk2IYFdq45dswPkANKCzaHhxvJhozYXg49LZdL
         6WTLe5a5nhLJZzYOX0XaduQRCV5kmqf1jU21B6LSOA0N/sSY/tiV4mCxUuhfkEY+7+aH
         xtxFp4AHYEeToJAkXlCNsAPBvBzjwPMYTykLOElyivhytxZLS/lYb7/s+yhpO0eJROnw
         lm8JPyMtTAD+NYR+zAL56DdW7h+7RNWOktmZq0BT6caMaghFrdTUhhKvXPTinh0cxHTV
         solg==
X-Gm-Message-State: APjAAAV2r3X9vBihIYiGeJKiUKlY+8bJBmYk8RdiUwBlP2H0dIeLvvDb
        QpnTNAPStkQbw2wUEpFUlmU=
X-Google-Smtp-Source: APXvYqxKXmKZJ64Gy45QPpVCgH9mAI5/xHNlz3KkdSGdtlVgmMvXgczSsn6Vd9I2UfFt1TdgUODEzg==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr3114245plt.159.1576496473673;
        Mon, 16 Dec 2019 03:41:13 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p124sm22432269pfb.52.2019.12.16.03.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Dec 2019 03:41:13 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v1 3/6] dt-bindings: display: add Unisoc's dpu bindings
Date:   Mon, 16 Dec 2019 19:40:16 +0800
Message-Id: <1576496419-12409-4-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576496419-12409-1-git-send-email-kevin3.tang@gmail.com>
References: <1576496419-12409-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
which transfers the image data from a video memory buffer to an internal
LCD interface.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../devicetree/bindings/display/sprd/dpu.yaml      | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dpu.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/dpu.yaml b/Documentation/devicetree/bindings/display/sprd/dpu.yaml
new file mode 100644
index 0000000..f84eddd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/dpu.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc SoC Display Processor Unit (DPU)
+
+maintainers:
+  - David Airlie <airlied@linux.ie>
+  - Daniel Vetter <daniel@ffwll.ch>
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Rutland <mark.rutland@arm.com>
+
+description: |
+  DPU (Display Processor Unit) is the Display Controller for the Unisoc SoCs
+  which transfers the image data from a video memory buffer to an internal
+  LCD interface.
+
+properties:
+  compatible:
+    const: sprd,display-processor
+
+  reg:
+    maxItems: 1
+    description:
+      Physical base address and length of the DPU registers set
+
+  interrupts:
+    maxItems: 1
+    description:
+      The interrupt signal from DPU
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: clk_src_128m
+      - const: clk_src_384m
+
+  power-domains:
+    description: A phandle to DPU power domain node.
+
+  iommus:
+    description: A phandle to DPU iommu node.
+
+  port:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+      That port should be the output endpoint, usually output to
+      the associated DSI.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    dpu: dpu@0x63000000 {
+          compatible = "sprd,display-processor";
+          reg = <0x0 0x63000000 0x0 0x1000>;
+          interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
+          clock-names = "clk_src_128m",
+      	        "clk_src_384m";
+
+          clocks = <&pll CLK_TWPLL_128M>,
+                <&pll CLK_TWPLL_384M>;
+
+          dpu_port: port {
+                  dpu_out: endpoint {
+                          remote-endpoint = <&dsi_in>;
+                  };
+          };
+    };
-- 
2.7.4

