Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DAEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E38C2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPCw4Yfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfKOQ3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:29:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43192 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfKOQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:29:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so6221017pgh.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kgB5pCuOS2QWyyNQUlCeMbbF7mRF+VE6sHHJ2GG7b1c=;
        b=DPCw4YfmrPfIgUhG16uvQMRN7kf1wj+SQYtjvVHjuxE1Hv1ch62Cfh7kou2hEyYSZ5
         7LwEuMMWfyvXrJnPVHsCtm74cUzTzgosSdBhvRe8+sjK3RysoZmkokbUquRgeOJyMe/U
         b7Z4acrZ0FM89wNyRnkMZboq08n8w3jNSURdrQOgvjWFhGRPULR50s8V4CSLzuWHJNYB
         hCdmAiHMQiXVfpIf+NXE2eXy3cYlrw+YA/1NM5DIdeU2QDiKhAcvtP79GuuoZtTbzmo4
         0KDzEu0t/Mq8jKEvpKBQ/zbqyNRhvwqf0nBYG5d0lwBy8u0qcEMo4T05rrtbrSV9od+W
         yX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kgB5pCuOS2QWyyNQUlCeMbbF7mRF+VE6sHHJ2GG7b1c=;
        b=Ntr0FBFKVjdUYk9rFOJtkmTNNeo2LoVdVkzeP26VFJ7DVeNxDHK9QxhWy5DtwSxm8z
         jKIHdO+IjkSCzcVmnzthcp2n7cYaz8TY/deJY9O/eBHe5qg7RE/HZ3NB0ADfs34J/MuG
         98o/QTkqwZWkl7xnbU6vU9oBWARdexfsd1xATpdDhe405q146xdF7EkVwr0EGwlwPbb/
         QMlRyAN/7h1l1z66VxVQduwqLXmhMogc8sehn7YUJ8P9yLcDJItRq6GPspFQ7VjHJ/gi
         rZQKLHZvSBTLGfbIj+z76+oh8jCoM0SO0pn2YXeGE9EBYLPjCiUUhdyzg4yLo84Cnu9N
         mLVQ==
X-Gm-Message-State: APjAAAWUXOSiy2guTSnaPcl2LaWwjzHKJXQEPH27Bb7oHSFm4wHOlLz7
        RFKpzzTOIVOjYa95SF6ytRCg
X-Google-Smtp-Source: APXvYqwZn6dxcQPBpbgoqwnQ04VH5ZcpzfVAJNhCMjTihlFvznEL0cUiGT1gTcrM2VWqQ4PTe0uYxA==
X-Received: by 2002:aa7:959d:: with SMTP id z29mr18009674pfj.208.1573835385291;
        Fri, 15 Nov 2019 08:29:45 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6183:6d55:8418:2bbc:e6d8:2b4])
        by smtp.gmail.com with ESMTPSA id y24sm12295288pfr.116.2019.11.15.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:29:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 5/7] arm64: dts: bitmain: Source common clock for UART controllers
Date:   Fri, 15 Nov 2019 21:58:59 +0530
Message-Id: <20191115162901.17456-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org>
References: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove fixed clock and source common clock for UART controllers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts |  9 ---------
 arch/arm64/boot/dts/bitmain/bm1880.dtsi            | 12 ++++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
index 3e8c70778e24..7a2c7f9c2660 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
+++ b/arch/arm64/boot/dts/bitmain/bm1880-sophon-edge.dts
@@ -49,12 +49,6 @@
 		reg = <0x1 0x00000000 0x0 0x40000000>; // 1GB
 	};
 
-	uart_clk: uart-clk {
-		compatible = "fixed-clock";
-		clock-frequency = <500000000>;
-		#clock-cells = <0>;
-	};
-
 	soc {
 		gpio0: gpio@50027000 {
 			porta: gpio-controller@0 {
@@ -173,21 +167,18 @@
 
 &uart0 {
 	status = "okay";
-	clocks = <&uart_clk>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0_default>;
 };
 
 &uart1 {
 	status = "okay";
-	clocks = <&uart_clk>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1_default>;
 };
 
 &uart2 {
 	status = "okay";
-	clocks = <&uart_clk>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2_default>;
 };
diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index 8471662413da..fa6e6905f588 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -174,6 +174,9 @@
 		uart0: serial@58018000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x58018000 0x0 0x2000>;
+			clocks = <&clk BM1880_CLK_UART_500M>,
+				 <&clk BM1880_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
@@ -184,6 +187,9 @@
 		uart1: serial@5801A000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x5801a000 0x0 0x2000>;
+			clocks = <&clk BM1880_CLK_UART_500M>,
+				 <&clk BM1880_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
@@ -194,6 +200,9 @@
 		uart2: serial@5801C000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x5801c000 0x0 0x2000>;
+			clocks = <&clk BM1880_CLK_UART_500M>,
+				 <&clk BM1880_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
@@ -204,6 +213,9 @@
 		uart3: serial@5801E000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x5801e000 0x0 0x2000>;
+			clocks = <&clk BM1880_CLK_UART_500M>,
+				 <&clk BM1880_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-- 
2.17.1

