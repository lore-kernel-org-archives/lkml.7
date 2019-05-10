Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA93AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7444217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvfe1T+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfEJSpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:45:52 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45335 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfEJSpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:45:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id a5so3211621pls.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H82q20L1aKXqNAtIH0Eb2SbfOdSZqnQm58Vm0JnT9D0=;
        b=jvfe1T+wn6nLz6baqZjEiJRUdTe8jBDiqtDZIU6lueztNU0Y2Mghocharb/nPRfIP8
         DE7bOxChVNSEdNTdPNjOe9JX6eyqgggMziJJADTk6aXWw85AZ2erQ9hGOFMXkWxXIy2z
         +fPEfQf7B7DsLGsI32WaaWzGmJOgZ5G84o0NjHWcYz90O1F/lIa2pJUl02FC6wgBnWfb
         9AHek+kjBStyQF+l4FluHdlDuvvMY9j9t6p7b08sviPX/KqEdGmGkV317JTrn0yWMr6i
         sSFt7wyh8sPZft4ran/9JqtTkqkJsPbJXEGURW/MIEGEFj7K94l/YlnWJbmTQRnF1T5C
         GY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H82q20L1aKXqNAtIH0Eb2SbfOdSZqnQm58Vm0JnT9D0=;
        b=bXsq8F6rMJO/fMQITTKyKSC7iU6pYwClqYAYFfwO4Nqc4SiaDKPdt5yy+IsKfRDmcO
         wwEl1TsMAWA29L8AUNlLxx4oGBklYeKmY6BAlspm52v49Vbym1uieoa5XWn+2BZL2Ymj
         5Uf1utwIOa64ZZaI5ysS/ZUy+3SxqE82sKApSgGHIAnimNrAkukOxyF72OMbWPSmMg9p
         1WaGQg1D3EWwwbRY08trQfwMrWK07L6VtXgmpC9sSUWjHNctr2sF0KjZSSJyEc2Uy3cv
         4Ef42pguJwDFU7DyAWnmoWwXBclpYBQ8TZ7LmiANaLo/cUSS2gBFMFOOKQb9hNv3d3NZ
         gYzw==
X-Gm-Message-State: APjAAAVQwMErg4EGGFVlkdIvtHLH/OGw/bf5c6Nu+92IdmFHvyFapAqF
        WHs+Js7VtLBHqYCbNYHaQPOS
X-Google-Smtp-Source: APXvYqzgLh8oziITJmYrfo0oAWdVE1RymvVNXRGjYIOASRWqA8BB/3AnvviuQ4u1+j27uNeaI0eudg==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr15213080plp.118.1557513950351;
        Fri, 10 May 2019 11:45:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c1:9991:95b6:5055:2390:bf9b])
        by smtp.gmail.com with ESMTPSA id g188sm8652049pfc.151.2019.05.10.11.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:45:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: reset: Add devicetree binding for BM1880 reset controller
Date:   Sat, 11 May 2019 00:15:22 +0530
Message-Id: <20190510184525.13568-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
References: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Bitmain BM1880 SoC reset controller.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/reset/bitmain,bm1880-reset.txt   | 18 +++++++
 .../dt-bindings/reset/bitmain,bm1880-reset.h  | 51 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
 create mode 100644 include/dt-bindings/reset/bitmain,bm1880-reset.h

diff --git a/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt b/Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
new file mode 100644
index 000000000000..a6f8455ae6c4
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
+        rst: reset-controller@c00 {
+                compatible = "bitmain,bm1880-reset";
+                reg = <0xc00 0x8>;
+                #reset-cells = <1>;
+        };
diff --git a/include/dt-bindings/reset/bitmain,bm1880-reset.h b/include/dt-bindings/reset/bitmain,bm1880-reset.h
new file mode 100644
index 000000000000..4c0de5223773
--- /dev/null
+++ b/include/dt-bindings/reset/bitmain,bm1880-reset.h
@@ -0,0 +1,51 @@
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
+#endif /* _DT_BINDINGS_BM1880_RESET_H */
-- 
2.17.1

