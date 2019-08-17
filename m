Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D0BC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F1921783
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTFdpglV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfHQSgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 14:36:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43651 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfHQSgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 14:36:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so4569719pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 11:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hn5wSwGbfV1ASKyLdnZBx4wD4svsXsjBYVfQupeV/uk=;
        b=mTFdpglV1XCrnX4v6GdHyklH4I6FWazbCF2q3yIZTX7zkzdu+heV9b4EnakjJCv8CA
         Xml/FdAUBvt33eL/9HRxPnegF59Ez3OYOlrGrdvUF+E5pJ3+B/fqILgk1PZLGVaT2y8i
         QorAGjENqYzTucRPyVdu9ISJjCMAVs7qZ1FUZQO9v86tvus4LPQd+9lPzqO2Zhz0taLX
         zJdwV1zHEBZQeoTtc5Xdga1pPX4N+LOjcAV7r1tXpa4L3+ENuAE6AjyzRxm/7AkhcwN/
         SPJVPj6YZdyxVh5GlnvA+vqgXqjiiSm1tg+BWMrqgxTuEi0DAI07vQdSfQWBOtkSfVFn
         +U0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hn5wSwGbfV1ASKyLdnZBx4wD4svsXsjBYVfQupeV/uk=;
        b=DENWIiZiEnyU7sX+Ovv5pG7gwuMOT4VVcdhva/REBD5B3mAQDvpwVS/R2PHq/ex3iI
         9LHxDzvUV1sVocGSlkb/G3eRui3fJa5oI1mksda0rQdGiG4srRMH0889l8chLnFFMv5s
         /1l0kbmWNVSuhrhQYt9An3oYrB4kalBmylbtAdOIu1+ZTvAOIEKZnZOHDAqRKRS11uNP
         C6prBZheI9sBlXzoD6r6y2twsQzEhIUYcJRJ0Ya4TxvysqGnHsYzDTbZ1ZNdsG7E0fuS
         HkHVeaqLGKIxFyiBxTJfovG84dLGG4x/H1Uyv09S5QFpZ2jUI/O8l/iQ+WY73rv6XSds
         MIVg==
X-Gm-Message-State: APjAAAXYzbR+hCZQXuhBmtIbs4s0is/f02t1Atwvhh+LvXbCSoAeO2K4
        rkRBkTI19rAzBSTihDH782wq
X-Google-Smtp-Source: APXvYqz7HOelwDjtmIcI/PRv0Sd5cOQooEFcTY/fW1d0rj2v0FQQcAowjpZp6w10tWJJxT4hIy2T9Q==
X-Received: by 2002:a17:90a:77c9:: with SMTP id e9mr12399635pjs.141.1566066996491;
        Sat, 17 Aug 2019 11:36:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:909:4559:9185:a772:a21d:70ac])
        by smtp.gmail.com with ESMTPSA id 33sm8588640pgy.22.2019.08.17.11.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 11:36:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/7] dt-bindings: clock: Add devicetree binding for BM1880 SoC
Date:   Sun, 18 Aug 2019 00:06:08 +0530
Message-Id: <20190817183614.8429-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190817183614.8429-1-manivannan.sadhasivam@linaro.org>
References: <20190817183614.8429-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML devicetree binding for Bitmain BM1880 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/clock/bitmain,bm1880-clk.yaml    | 83 +++++++++++++++++++
 include/dt-bindings/clock/bm1880-clock.h      | 82 ++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
 create mode 100644 include/dt-bindings/clock/bm1880-clock.h

diff --git a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
new file mode 100644
index 000000000000..a457f996287d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/clock/bitmain,bm1880-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bitmain BM1880 Clock Controller
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |
+  The Bitmain BM1880 clock controller generates and supplies clock to
+  various peripherals within the SoC.
+
+  This binding uses common clock bindings
+  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - bitmain,bm1880-clk
+
+  reg:
+    minItems: 2
+    maxItems: 2
+    items:
+      - description: pll registers
+      - description: system registers
+
+  reg-names:
+    items:
+      - const: pll
+      - const: sys
+
+  clocks:
+    maxItems: 1
+    description: Phandle of the input reference clock
+
+  clock-names:
+    maxItems: 1
+    items:
+      - const: osc
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+examples:
+  # Clock controller node:
+  - |
+    clk: clock-controller@e8 {
+        compatible = "bitmain,bm1880-clk";
+        reg = <0xe8 0x0c>, <0x800 0xb0>;
+        reg-names = "pll", "sys";
+        clocks = <&osc>;
+        clock-names = "osc";
+        #clock-cells = <1>;
+    };
+
+  # Example UART controller node that consumes clock generated by the clock controller:
+  - |
+    uart0: serial@58018000 {
+         compatible = "snps,dw-apb-uart";
+         reg = <0x0 0x58018000 0x0 0x2000>;
+         clocks = <&clk BM1880_CLK_UART_500M>;
+                  <&clk BM1880_CLK_APB_UART>;
+         clock-names = "baudclk", "apb_pclk";
+         interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+         reg-shift = <2>;
+         reg-io-width = <4>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/bm1880-clock.h b/include/dt-bindings/clock/bm1880-clock.h
new file mode 100644
index 000000000000..895646d66b07
--- /dev/null
+++ b/include/dt-bindings/clock/bm1880-clock.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Device Tree binding constants for Bitmain BM1880 SoC
+ *
+ * Copyright (c) 2019 Linaro Ltd.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BM1880_H
+#define __DT_BINDINGS_CLOCK_BM1880_H
+
+#define BM1880_CLK_OSC			0
+#define BM1880_CLK_MPLL			1
+#define BM1880_CLK_SPLL			2
+#define BM1880_CLK_FPLL			3
+#define BM1880_CLK_DDRPLL		4
+#define BM1880_CLK_A53			5
+#define BM1880_CLK_50M_A53		6
+#define BM1880_CLK_AHB_ROM		7
+#define BM1880_CLK_AXI_SRAM		8
+#define BM1880_CLK_DDR_AXI		9
+#define BM1880_CLK_EFUSE		10
+#define BM1880_CLK_APB_EFUSE		11
+#define BM1880_CLK_AXI5_EMMC		12
+#define BM1880_CLK_EMMC			13
+#define BM1880_CLK_100K_EMMC		14
+#define BM1880_CLK_AXI5_SD		15
+#define BM1880_CLK_SD			16
+#define BM1880_CLK_100K_SD		17
+#define BM1880_CLK_500M_ETH0		18
+#define BM1880_CLK_AXI4_ETH0		19
+#define BM1880_CLK_500M_ETH1		20
+#define BM1880_CLK_AXI4_ETH1		21
+#define BM1880_CLK_AXI1_GDMA		22
+#define BM1880_CLK_APB_GPIO		23
+#define BM1880_CLK_APB_GPIO_INTR	24
+#define BM1880_CLK_GPIO_DB		25
+#define BM1880_CLK_AXI1_MINER		26
+#define BM1880_CLK_AHB_SF		27
+#define BM1880_CLK_SDMA_AXI		28
+#define BM1880_CLK_SDMA_AUD		29
+#define BM1880_CLK_APB_I2C		30
+#define BM1880_CLK_APB_WDT		31
+#define BM1880_CLK_APB_JPEG		32
+#define BM1880_CLK_JPEG_AXI		33
+#define BM1880_CLK_AXI5_NF		34
+#define BM1880_CLK_APB_NF		35
+#define BM1880_CLK_NF			36
+#define BM1880_CLK_APB_PWM		37
+#define BM1880_CLK_DIV_0_RV		38
+#define BM1880_CLK_DIV_1_RV		39
+#define BM1880_CLK_MUX_RV		40
+#define BM1880_CLK_RV			41
+#define BM1880_CLK_APB_SPI		42
+#define BM1880_CLK_TPU_AXI		43
+#define BM1880_CLK_DIV_UART_500M	44
+#define BM1880_CLK_UART_500M		45
+#define BM1880_CLK_APB_UART		46
+#define BM1880_CLK_APB_I2S		47
+#define BM1880_CLK_AXI4_USB		48
+#define BM1880_CLK_APB_USB		49
+#define BM1880_CLK_125M_USB		50
+#define BM1880_CLK_33K_USB		51
+#define BM1880_CLK_DIV_12M_USB		52
+#define BM1880_CLK_12M_USB		53
+#define BM1880_CLK_APB_VIDEO		54
+#define BM1880_CLK_VIDEO_AXI		55
+#define BM1880_CLK_VPP_AXI		56
+#define BM1880_CLK_APB_VPP		57
+#define BM1880_CLK_DIV_0_AXI1		58
+#define BM1880_CLK_DIV_1_AXI1		59
+#define BM1880_CLK_AXI1			60
+#define BM1880_CLK_AXI2			61
+#define BM1880_CLK_AXI3			62
+#define BM1880_CLK_AXI4			63
+#define BM1880_CLK_AXI5			64
+#define BM1880_CLK_DIV_0_AXI6		65
+#define BM1880_CLK_DIV_1_AXI6		66
+#define BM1880_CLK_MUX_AXI6		67
+#define BM1880_CLK_AXI6			68
+#define BM1880_NR_CLKS			69
+
+#endif /* __DT_BINDINGS_CLOCK_BM1880_H */
-- 
2.17.1

