Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9046FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635A421897
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SbzODjEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfJZLDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:03:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46294 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfJZLDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:03:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id q21so2767375plr.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kgB5pCuOS2QWyyNQUlCeMbbF7mRF+VE6sHHJ2GG7b1c=;
        b=SbzODjEX5F2nsIQtMtE/7zuAlvFC33+amDdkHp/rJOQk+V4QHMFoQEYKjTxrC7+0EH
         wfNC62GWoHZmzKCTfwGoze1lAZBCWhEiWmwnCiJKrHFsSu0yrrd69ax3bTQ/tbegcPRD
         KEJNpF7IrbjXa68LgYojYW7Erv19baPm5EDA8nKxzMCT37CIQ4opheXBMf+LFFBG7D1p
         IkB/vAWuQNfOmAL/CdFzRXdrBSoVj5/mhLTqM+rgZIXk0Qo/yOrM7ULQak2F+9xcHCoL
         ilxiNnBL2BPrkGTB1+J37JkxCKv3HdYEU5Oxda/Nq7a1YtihiaNGrocqpwvRckfZImlR
         3chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kgB5pCuOS2QWyyNQUlCeMbbF7mRF+VE6sHHJ2GG7b1c=;
        b=BPe7zFqDaoeKgjhat4JI7hyQ5PDDCvCBnlVgUiGb63RuIs/UCKxcvCysPVxwu6VzCN
         BkLlEpBBdY8/QkysjWc7nf+4bbTk83sJMY4xUaJr+eFek31hE2bONOR/EjBD9ioGqHUa
         WDt2aEC5cIVoEzrL2cpcvxiadFnFLtU9ERP5PwQkgxxJukksa1V0IdlWbXMzsQvDSUk8
         8lYyGykvDPxzmmSvVep1j80gGTroXwtjOeIleQqOCxOb0wsIdtSzcWpPg4Pcbb2nl04Q
         IIGTz6Adr9W2z5h1Y/zI4fdMr4R+uVycmKAGkpZxGA76LXzzrPwCJL1kwdPIXcdN63n/
         vkYg==
X-Gm-Message-State: APjAAAXUY1fkriYcT8JhedH63nrvzq17qmwXdyGhgaDn6b/AZMX9IZP4
        XyYFpddB/EKacdM0f6QJiZ/XjbWRzA==
X-Google-Smtp-Source: APXvYqwbH7mjVVUHhMYS154eXjE/fFoPl0MGad/FpwQLPO3npUi6yjuvIMCeLcnwpi73LOcno2tHWA==
X-Received: by 2002:a62:37c7:: with SMTP id e190mr10304501pfa.130.1572087819846;
        Sat, 26 Oct 2019 04:03:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6214:69c4:49ad:ba3c:6f9:2d8a])
        by smtp.gmail.com with ESMTPSA id x129sm5543379pfx.14.2019.10.26.04.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 04:03:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 5/7] arm64: dts: bitmain: Source common clock for UART controllers
Date:   Sat, 26 Oct 2019 16:32:51 +0530
Message-Id: <20191026110253.18426-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
References: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
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

