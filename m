Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C377C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D1A216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuzK2PS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfGEPPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:15:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42732 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbfGEPPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:15:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so4449943pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mjL8OgcUqCdXJCy0GfBuE6r63TAGGvJ9nWUjkkaFavo=;
        b=nuzK2PS76JIoq2zHczYHawZXYT1Fi/gI8aF8SQXrzrHCxKDc7WlCDzeAw9wMbAoWH7
         Th88EomCpd0XOi3JsK3j408CCRtICGs0sS/aDaNRRg6OCdkAnvDYpF36RnDijZwDKtoY
         wWhixqI3i/ME9nJO6CdFpVx4hhIfp8nIfqfdgt0BDCxewUGLCtnDc0uO5FovCukuCyXk
         6L3V2hSmUgxOm7l2o0EM12FmvFSBV061LGq6aAxwqDjTRUgdxWCnh+pgkkcRRWoRg7jt
         8UMVDWCDB2xIeAthUa6Vv8NL+IPPUKRQPbtI7ZHLBwyonmE6zy0Pxn3QzKY2A5PsYLSZ
         sn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mjL8OgcUqCdXJCy0GfBuE6r63TAGGvJ9nWUjkkaFavo=;
        b=hxpKGDIf9Sv9BZA85THHcbkrBNli09N7hQoZKDpFzY/GCXlS0v7f5zwreywN6zGKfD
         M/TYXty7Wne7rStYLN3+GV/C+hsLqiirwLQf6QO8BU5jsinnNOHtDCwZAK9RkmYiMHDt
         TTQCmxbts7KapfZk7YWLovd5sTS4HpSIH0C7fAd4z3d3tCXif64trFPyYvUf+Z/jK2eS
         iSz0gbssEvGOan0SU4h6ndo07jEquSvHLG1l/Pn6itW4oZJLJXu2nTPXK/N+sstMCjUM
         xSUiTRQw6ppA1K9ftf5TKNb2MijcR0MPbW4csMdkGK42XPiXYyIg+6Yb6vyVH4KGb32O
         E2/Q==
X-Gm-Message-State: APjAAAUOctOTiicnH3OzZYuwmg9pSL28X7aTi2H0dXn4HK3IgIKSmiPI
        /bfxs8RWgGLroRIfrRgrljJZ
X-Google-Smtp-Source: APXvYqzEsjdYZuaprjK/zBLUAkskhOfN3XKcQCcN4ZRGquCJmmkY7bKa+rH+pMRrBZjas0P0U0PyMg==
X-Received: by 2002:a63:d415:: with SMTP id a21mr5920071pgh.229.1562339699909;
        Fri, 05 Jul 2019 08:14:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:916:7317:a59d:72b6:ef7f:a938])
        by smtp.gmail.com with ESMTPSA id w3sm8248778pgl.31.2019.07.05.08.14.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 08:14:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] dt-bindings: clock: Add Bitmain BM1880 SoC clock controller binding
Date:   Fri,  5 Jul 2019 20:44:36 +0530
Message-Id: <20190705151440.20844-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org>
References: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Bitmain BM1880 SoC clock controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/clock/bitmain,bm1880-clk.txt     | 47 +++++++++++
 include/dt-bindings/clock/bm1880-clock.h      | 82 +++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
 create mode 100644 include/dt-bindings/clock/bm1880-clock.h

diff --git a/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
new file mode 100644
index 000000000000..9c967095d430
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.txt
@@ -0,0 +1,47 @@
+* Bitmain BM1880 Clock Controller
+
+The Bitmain BM1880 clock controler generates and supplies clock to
+various peripherals within the SoC.
+
+Required Properties:
+
+- compatible: Should be "bitmain,bm1880-clk"
+- reg :	Register address and size of PLL and SYS control domains
+- reg-names : Register domain names: "pll" and "sys"
+- clocks : Phandle of the input reference clock.
+- #clock-cells: Should be 1.
+
+Each clock is assigned an identifier, and client nodes can use this identifier
+to specify the clock which they consume.
+
+All available clocks are defined as preprocessor macros in corresponding
+dt-bindings/clock/bm1880-clock.h header and can be used in device tree sources.
+
+External clocks:
+
+The osc clock used as the input for the plls is generated outside the SoC.
+It is expected that it is defined using standard clock bindings as "osc".
+
+Example: 
+
+        clk: clock-controller@800 {
+                compatible = "bitmain,bm1880-clk";
+                reg = <0xe8 0x0c>,<0x800 0xb0>;
+                reg-names = "pll", "sys";
+                clocks = <&osc>;
+                #clock-cells = <1>;
+        };
+
+Example: UART controller node that consumes clock generated by the clock
+controller:
+
+        uart0: serial@58018000 {
+                compatible = "snps,dw-apb-uart";
+                reg = <0x0 0x58018000 0x0 0x2000>;
+                clocks = <&clk BM1880_CLK_UART_500M>;
+                         <&clk BM1880_CLK_APB_UART>;
+                clock-names = "baudclk", "apb_pclk";
+                interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+                reg-shift = <2>;
+                reg-io-width = <4>;
+        };
diff --git a/include/dt-bindings/clock/bm1880-clock.h b/include/dt-bindings/clock/bm1880-clock.h
new file mode 100644
index 000000000000..764472b9a4fd
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
+#define BM1880_CLK_DDRPLL 		4
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

