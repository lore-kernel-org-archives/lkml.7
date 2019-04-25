Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C98DC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A2320678
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1EtZdHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfDYMzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:55:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44762 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDYMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:55:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id y12so8504569plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6hXOfflPIrcfGTPZaCTIS2JfePySj2SNkBJwDrcdy2M=;
        b=K1EtZdHR2+sdReH896jE8wtOjZVeBKH+qTEvPUC+dxQIL68C1Jj7+WXgxfaf5ExpkJ
         v/qvsF9n906LA/+mz6deh36sKPtW6rJnNDQoAtW87L+M3U/xZTtdQLr7hcjc202rLPjA
         +00NxaiLPalDKXKiX8wYt4oUcrOZeQc/Z5IAsEY5MsMqIqJIj/M8IBTh/qor/yUvW4dg
         Pe11tO3MgtMbObOT307zjugAmch4BNKsIhIEKFTPSI/VTCJoVmatzO1qRsAQhhVKHs4O
         AiPaR1AB4C0r8NpGOIk4gqjN8CVExiPV0U1v6JtaLAdj5zPHX3BPZPxgduVrDHk0jygu
         bPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6hXOfflPIrcfGTPZaCTIS2JfePySj2SNkBJwDrcdy2M=;
        b=WaOzRWgbF5wntiZ573VmZ2WhpGG4MjpquVzRVtN9XcZRFMNEIEQRgdYDEA96iVkIsh
         2VdrCK9rmyajYF9LQXGcGog/TASe8V3Lq76gG9Tf1OGJWoiWeYEisrrUZqk3KERjnrp1
         oKBxQei+DPGUJQ6338okdQGX3sW97us+EmBm4T9C2ZXXRQNUXNBxNiMhZxL+bQGevXob
         5pAYdOVJHfthqsVKTBNEXxrxSsQCmwdVs5wptKtO7tPktC7ea0g8OesTsls7ayvjGPIZ
         TmXIOg+85l6xXTlYtFQmC2+IaE2s2wKXG6e3W3DTV0J3cHMlyDFvIIMytraN83VyyWEZ
         UAeg==
X-Gm-Message-State: APjAAAUd0g0uyfJhpX6BWr4dzQfevsPybeUPh86f0l90XsfGtqnNWzEu
        L2uv7bniogyJcloOMxX8cSho
X-Google-Smtp-Source: APXvYqx5Cii2HO4iUTH83QIK9vyGUabGg4pGpk9KSMMpsN33HZ6sDyzwXrF+8ELFf5wgYFnHuVE4Dw==
X-Received: by 2002:a17:902:8a8a:: with SMTP id p10mr39624532plo.8.1556196923677;
        Thu, 25 Apr 2019 05:55:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:81e:2691:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id c18sm50507983pfc.0.2019.04.25.05.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 05:55:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: reset: Add devicetree binding for BM1880 reset controller
Date:   Thu, 25 Apr 2019 18:25:06 +0530
Message-Id: <20190425125508.5965-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425125508.5965-1-manivannan.sadhasivam@linaro.org>
References: <20190425125508.5965-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Bitmain BM1880 SoC reset controller. This SoC
has two reset controllers each controlling reset lines of different
peripherals.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

