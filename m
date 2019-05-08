Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CC7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E3C20850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKKvrwln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfEHQxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:53:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33099 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfEHQxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:53:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id y3so10216156plp.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EINhzSK1TIKKHSccJ8597OGCeqJGeGH5R+zkRVceiWE=;
        b=nKKvrwlnksxxPvIwkEAEsZD7WkJNVGKgp86vtl+W9YfAV9LFqyoUMvlyou17f43gOv
         F5emed0wQ5JxviBGX27bMsvv8cneFeMCNyTDok/CFdQCkV/yToQDGvkcJ/B5JBAHowSS
         qFI1BoS+aQZeAcjc791HgdxH6ZIombGUqjLD5eF9AWqUVAX0iG7O5XTCjXYZszmonAJ0
         wVn2KjAKe2oPalNlhgkA6nIsyTlVr/nC+DQB2DjwPKYqE26B82orGprAcnscfHNaS8pZ
         diY9TmBrfqqKAzFWYmmxdqkPWkIysgjEGsNwClCrMp6S1GZ3croiKvKnlKlQ8qs94K7T
         vRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EINhzSK1TIKKHSccJ8597OGCeqJGeGH5R+zkRVceiWE=;
        b=DziWZvCd7sg1DDDyS8sTr2gvTyV9qMtMg/Dp+/N7BeY93PmxB/kv+1gOK0zmVYhuTQ
         82PIH20xNkZgrNnioBNVQGhoe6pPtNdOG0I7WZJU2akqdlaGPv8ITn6XsM87WQqTCBG9
         Ubc0aWLxgOKANbSqGGWBWqXLvaDwNeBA9ClyNQzwTUcwqhaqe2+CcqSvxmV5KPc+s9xf
         wuC5mMgJC5pgjxqQEo5wNge6xRQSkZItaT4Vx825MwhM3GHyG6Qs1vTw8v67TqQ71jVC
         ftHM35L7JLI7ruHfdbFQXWi9Tg6wsJYSEMWQ8IqPHDX30As62+YKCNVqhy/q7vBPO0mU
         jWKg==
X-Gm-Message-State: APjAAAWKc9PxiO8PynQ6m5kD+UMAmsKhvs4Qxd7TDKikXkE5T4iUm5ys
        FzrBn7cG3bME5Jir+tJzVUuV
X-Google-Smtp-Source: APXvYqyVEW/wse7wDY3onzNieYIAVnOTcgEz/EASoGAjdURYUHnxIPch+2JKtwC2CJpljW06JvPJSQ==
X-Received: by 2002:a17:902:9693:: with SMTP id n19mr48271204plp.92.1557334414722;
        Wed, 08 May 2019 09:53:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6000:7ab1:cd79:1ccc:df38:79c0])
        by smtp.gmail.com with ESMTPSA id m2sm25180676pfi.24.2019.05.08.09.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:53:33 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: reset: Add devicetree binding for BM1880 reset controller
Date:   Wed,  8 May 2019 22:23:16 +0530
Message-Id: <20190508165319.19822-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508165319.19822-1-manivannan.sadhasivam@linaro.org>
References: <20190508165319.19822-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Bitmain BM1880 SoC reset controller. This SoC
has two reset controllers each controlling reset lines of different
peripherals.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/reset/bitmain,bm1880-reset.txt   |  18 +++
 .../dt-bindings/reset/bitmain,bm1880-reset.h  | 106 ++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
 create mode 100644 include/dt-bindings/reset/bitmain,bm1880-reset.h

diff --git a/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt b/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
new file mode 100644
index 000000000000..0674ae904b19
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
@@ -0,0 +1,18 @@
+Bitmain BM1880 SoC Reset Controller
+===================================
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required properties:
+- compatible:   Should be "bitmain,bm1880-reset"
+- reg:          Offset and length of reset controller space in SCTRL.
+- #reset-cells: Must be 1.
+
+Example:
+
+        reset: reset-controller@800 {
+                compatible = "bitmain,bm1880-reset";
+                reg = <0x800 0x8>;
+                #reset-cells = <1>;
+        };
diff --git a/include/dt-bindings/reset/bitmain,bm1880-reset.h b/include/dt-bindings/reset/bitmain,bm1880-reset.h
new file mode 100644
index 000000000000..e8103ce6f4d6
--- /dev/null
+++ b/include/dt-bindings/reset/bitmain,bm1880-reset.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2018 Bitmain Ltd.
+ * Copyright (c) 2019 Linaro Ltd.
+ */
+
+#ifndef _DT_BINDINGS_BM1880_RESET_H
+#define _DT_BINDINGS_BM1880_RESET_H
+
+#define BM1880_RST_MAIN_AP		0
+#define BM1880_RST_SECOND_AP		1
+#define BM1880_RST_DDR			2
+#define BM1880_RST_VIDEO		3
+#define BM1880_RST_JPEG			4
+#define BM1880_RST_VPP			5
+#define BM1880_RST_GDMA			6
+#define BM1880_RST_AXI_SRAM		7
+#define BM1880_RST_TPU			8
+#define BM1880_RST_USB			9
+#define BM1880_RST_ETH0			10
+#define BM1880_RST_ETH1			11
+#define BM1880_RST_NAND			12
+#define BM1880_RST_EMMC			13
+#define BM1880_RST_SD			14
+#define BM1880_RST_SDMA			15
+#define BM1880_RST_I2S0			16
+#define BM1880_RST_I2S1			17
+#define BM1880_RST_UART0_1_CLK		18
+#define BM1880_RST_UART0_1_ACLK		19
+#define BM1880_RST_UART2_3_CLK		20
+#define BM1880_RST_UART2_3_ACLK		21
+#define BM1880_RST_MINER		22
+#define BM1880_RST_I2C0			23
+#define BM1880_RST_I2C1			24
+#define BM1880_RST_I2C2			25
+#define BM1880_RST_I2C3			26
+#define BM1880_RST_I2C4			27
+#define BM1880_RST_PWM0			28
+#define BM1880_RST_PWM1			29
+#define BM1880_RST_PWM2			30
+#define BM1880_RST_PWM3			31
+#define BM1880_RST_SPI			32
+#define BM1880_RST_GPIO0		33
+#define BM1880_RST_GPIO1		34
+#define BM1880_RST_GPIO2		35
+#define BM1880_RST_EFUSE		36
+#define BM1880_RST_WDT			37
+#define BM1880_RST_AHB_ROM		38
+#define BM1880_RST_SPIC			39
+
+#define BM1880_CLK_RST_A53		0
+#define BM1880_CLK_RST_50M_A53		1
+#define BM1880_CLK_RST_AHB_ROM		2
+#define BM1880_CLK_RST_AXI_SRAM		3
+#define BM1880_CLK_RST_DDR_AXI		4
+#define BM1880_CLK_RST_EFUSE		5
+#define BM1880_CLK_RST_APB_EFUSE	6
+#define BM1880_CLK_RST_AXI_EMMC		7
+#define BM1880_CLK_RST_EMMC		8
+#define BM1880_CLK_RST_100K_EMMC	9
+#define BM1880_CLK_RST_AXI_SD		10
+#define BM1880_CLK_RST_SD		11
+#define BM1880_CLK_RST_100K_SD		12
+#define BM1880_CLK_RST_500M_ETH0	13
+#define BM1880_CLK_RST_AXI_ETH0		14
+#define BM1880_CLK_RST_500M_ETH1	15
+#define BM1880_CLK_RST_AXI_ETH1		16
+#define BM1880_CLK_RST_AXI_GDMA		17
+#define BM1880_CLK_RST_APB_GPIO		18
+#define BM1880_CLK_RST_APB_GPIO_INTR	19
+#define BM1880_CLK_RST_GPIO_DB		20
+#define BM1880_CLK_RST_AXI_MINER	21
+#define BM1880_CLK_RST_AHB_SF		22
+#define BM1880_CLK_RST_SDMA_AXI		23
+#define BM1880_CLK_RST_SDMA_AUD		24
+#define BM1880_CLK_RST_APB_I2C		25
+#define BM1880_CLK_RST_APB_WDT		26
+#define BM1880_CLK_RST_APB_JPEG		27
+#define BM1880_CLK_RST_JPEG_AXI		28
+#define BM1880_CLK_RST_AXI_NF		29
+#define BM1880_CLK_RST_APB_NF		30
+#define BM1880_CLK_RST_NF		31
+#define BM1880_CLK_RST_APB_PWM		32
+#define BM1880_CLK_RST_RV		33
+#define BM1880_CLK_RST_APB_SPI		34
+#define BM1880_CLK_RST_TPU_AXI		35
+#define BM1880_CLK_RST_UART_500M	36
+#define BM1880_CLK_RST_APB_UART		37
+#define BM1880_CLK_RST_APB_I2S		38
+#define BM1880_CLK_RST_AXI_USB		39
+#define BM1880_CLK_RST_APB_USB		40
+#define BM1880_CLK_RST_125M_USB		41
+#define BM1880_CLK_RST_33K_USB		42
+#define BM1880_CLK_RST_12M_USB		43
+#define BM1880_CLK_RST_APB_VIDEO	44
+#define BM1880_CLK_RST_VIDEO_AXI	45
+#define BM1880_CLK_RST_VPP_AXI		46
+#define BM1880_CLK_RST_APB_VPP		47
+#define BM1880_CLK_RST_AXI1		48
+#define BM1880_CLK_RST_AXI2		49
+#define BM1880_CLK_RST_AXI3		50
+#define BM1880_CLK_RST_AXI4		51
+#define BM1880_CLK_RST_AXI5		52
+#define BM1880_CLK_RST_AXI6		53
+
+#endif /* _DT_BINDINGS_BM1880_RESET_H */
-- 
2.17.1

