Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5038EC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BA6216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vt7j6L61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfGEPPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:15:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35652 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfGEPPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:15:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so4455424pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skO3SVLCULqV725lDp5RSaTuL4Bi/TaYFURtZV70gok=;
        b=Vt7j6L61rYAQf5Be/HraOnjt90etsMPttOB3DyLM8TEVV/tMk/SnBoIlHBeYH8IWaG
         AZPXZxTFgX1lg8QUCqDCJlBYLT9cCsDyoh9UpU6Th7gXTQKZtkLmFhjCyV6UiwRhzhPN
         peNkVujPMKyQWaYVIWE+UUp9ftVCjxDUhjYnh3JGlWVD6mMIVFxiJHCa2wMXDfy9QZdl
         KxAvZnTBdisUyTH7rc4nDhqJD6ZkZWZBDhlS7wfssCIJ+xIrnYMKQyi6YFJHIhpRt3ks
         id7aaCopcmhn0HOo1gmf+lzw+lalX+BhDzR0pQHWT9Bo6ITqx0JvhApqrsO5aU33lXkh
         UbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skO3SVLCULqV725lDp5RSaTuL4Bi/TaYFURtZV70gok=;
        b=GT3ZwS5M9ijTiQQPN7daeUsbU2QOypiMH4oOaSVsBtt/ihvKmguAcMdnZp4A+3PosW
         mp4BEHQGhPH5vR4fhjCU5qteif8jC43syTHzA6XoeyvqVv6ngpEnIj+B0PwHgclriyep
         E7QegaIu90Kss2tmafFq0BScBdLuDM4zqdrdyZIjC9kB2ICfq3FcYwieH1+asdxMfq3S
         xNr///x/Qo+Q6aFfCJW+qfMZIu429Wcjg/XMSCRLd/7/0C83SZ82rE2DQeY2/ZsQuqDo
         b/Qzt5RXmjyK3NTb/08Zs02QHa/KXl/gyghfu7Qg2mWoUotQ0Hm7vYUAU/67WoCma4HV
         DSRw==
X-Gm-Message-State: APjAAAXWckMSNl03SAgXauj/1LByAz26nsZuDhqoRQriGo3AnebdJtJU
        BHSfvhj5xpIp8e8T+FRfeR59
X-Google-Smtp-Source: APXvYqxuwrnPnLD0ZqVJEGEjmNvmY38DXOXlqXwNHG3jKeadBVvXBNVdH3X7E+bo9GiSoKcovyaxsw==
X-Received: by 2002:a17:90a:2567:: with SMTP id j94mr6228538pje.121.1562339713648;
        Fri, 05 Jul 2019 08:15:13 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:916:7317:a59d:72b6:ef7f:a938])
        by smtp.gmail.com with ESMTPSA id w3sm8248778pgl.31.2019.07.05.08.15.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 08:15:13 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/5] arm64: dts: bitmain: Source common clock for UART controllers
Date:   Fri,  5 Jul 2019 20:44:38 +0530
Message-Id: <20190705151440.20844-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org>
References: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org>
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
index d2edb2e28bf2..408b76087762 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -172,6 +172,9 @@
 		uart0: serial@58018000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x58018000 0x0 0x2000>;
+			clocks = <&clk BM1880_CLK_UART_500M>,
+				 <&clk BM1880_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
@@ -182,6 +185,9 @@
 		uart1: serial@5801A000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x5801a000 0x0 0x2000>;
+			clocks = <&clk BM1880_CLK_UART_500M>,
+				 <&clk BM1880_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
@@ -192,6 +198,9 @@
 		uart2: serial@5801C000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x0 0x5801c000 0x0 0x2000>;
+			clocks = <&clk BM1880_CLK_UART_500M>,
+				 <&clk BM1880_CLK_APB_UART>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
@@ -202,6 +211,9 @@
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

