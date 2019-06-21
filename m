Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D035C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126EC21530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP2XjrYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfFULQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:16:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36864 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfFULQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:16:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so3444432pfa.4;
        Fri, 21 Jun 2019 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vwabYDjGbQrLkZt11xJPWZePoxPgRcXGMpjTzWYuVms=;
        b=qP2XjrYfPcIg6m90nvxE5mv1tO7LwZAfjv5T3Y9DVlvVbv/w7UNTw7OsAi9BVVj9is
         wU6xjmi5UFjq4COdkQ8DH80fvsE2LOYSFNfgGNzwW/RpLVbv/4L2uf4aEPAwcIrUZetr
         xL0i9Y3RmxUtrHk8MMfMRxFeSHP0Sd0UB04TYc2afuSMYZXtK+9ZCELqaJNfeIzVAIYX
         QJk8kyd8D/QoxfPksIHwD/ZC6UuqFqK6oo9F5rPSxLkQjQuAr1OK64A0H86ndiYch+8y
         wu9kcon4l/zBD5AXgOKXemlvOThtm3FMapOS75cBDVljewUlaPVqiAM9Em+oM0UYQTTD
         jhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vwabYDjGbQrLkZt11xJPWZePoxPgRcXGMpjTzWYuVms=;
        b=nkPnU9nGPb64Pq/AG/QB2oZyPDHyz9DDBaEiy1ZP0L+5Dvbv+Pm5w+OWm+S5ebjWM6
         WLXEK/fUt1WiuZHIzd/p5P8iRFuxAnmHlOZsrYidN/5X5ttO4to8PMmYiXQM5hz0BgMT
         kO9pnsuuccnGG9+iDLyJW36dKIsgn2hJIsFmEhzJhxOMIOurYvTBnySmXDGPt3BDSqaT
         fJCKfTvlg+mR4A+54F1xY2+SG2aVI2/Hy+fUODh310Hf1tVzQW+O0J0OHZYThrd1EUov
         0gohf7UJdK/nbdgQkmRRLPCCoFbKOw1I7a6kB7CbE5L1IEcd7p+HfTr27qoh3vOd77C3
         7GjA==
X-Gm-Message-State: APjAAAWB/M3mclFp5/q/PgRGaJ8SykQ80PTx07o+AuzWSje0/oCwhw2w
        QS9E6BAlQ78XfmU/YpWXnTw=
X-Google-Smtp-Source: APXvYqxI9bXXVbbvvPMG+TvLTGibLafT4/isMhPHhu2dF14XjhC+5TV/AQ/aefXFfsPHZCVrOy0Yvg==
X-Received: by 2002:a17:90a:af8b:: with SMTP id w11mr5932415pjq.135.1561115775282;
        Fri, 21 Jun 2019 04:16:15 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id w4sm2405737pfw.97.2019.06.21.04.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 04:16:14 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 3/5] DT nodes for AST2500 DMA UART driver
Date:   Fri, 21 Jun 2019 16:47:33 +0530
Message-Id: <1561115855-4186-4-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
References: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

DT node for DMA controller(ast_uart_sdma) doesn't bind to any DMA controller driver.
This is because Software for DMA controller is not based on DMA framework,but is dedicated
and serves only UARTs in AST2500. ast_uart_sdma node is searched by compatible string in the 
driver software.basic use of this node is to provide register base address of DMA controller and DMA irq number(<50>).
IRQ of DMA controller is of crucial importance, which does RX and TX of UART data. 

uart nodes dma_uart1,2...etc binds to the platform driver.
irq numbers <9>,<32>,<33>,<34> in dma_uart nodes install ISRs which are of not much interest in uart data TX/RX .


Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 21 +++++++
 arch/arm/boot/dts/aspeed-g5.dtsi         | 71 ++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 5dbb33c10c4f..4da09fbe94df 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -64,6 +64,27 @@
 	status = "okay";
 };
 
+&ast_uart_sdma {
+	status = "okay";
+};
+
+&dma_uart1 {
+	status = "okay";
+};
+
+&dma_uart2 {
+	status = "okay";
+};
+
+&dma_uart3 {
+	status = "okay";
+};
+
+&dma_uart4 {
+	status = "okay";
+};
+
+
 &mac0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 674746513031..fb7b3ed463de 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -23,10 +23,10 @@
 		i2c11 = &i2c11;
 		i2c12 = &i2c12;
 		i2c13 = &i2c13;
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
+		serial0 = &dma_uart1;
+		serial1 = &dma_uart2;
+		serial2 = &dma_uart3;
+		serial3 = &dma_uart4;
 		serial4 = &uart5;
 		serial5 = &vuart;
 		peci0 = &peci0;
@@ -497,6 +497,69 @@
 				status = "disabled";
 			};
 
+			ast_uart_sdma: uart_sdma@1e79e000 {
+				compatible = "aspeed,ast-uart-sdma";
+				reg = <0x1e79e000 0x400>;
+				interrupts = <50>;
+				status = "disabled";
+			};
+
+			dma_uart1: dma_uart1@1e783000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e783000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <9>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+				dma-channel = <0>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd1_default
+							 &pinctrl_rxd1_default>;
+				status = "disabled";
+			};
+
+			dma_uart2: dma_uart2@1e78d000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78d000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <32>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
+				dma-channel = <1>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd2_default
+							 &pinctrl_rxd2_default>;
+				status = "disabled";
+			};
+
+			dma_uart3: dma_uart3@1e78e000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78e000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <33>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
+				dma-channel = <2>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd3_default
+							 &pinctrl_rxd3_default>;
+				status = "disabled";
+			};
+
+			dma_uart4: dma_uart4@1e78f000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78f000 0x1000>;
+				reg-shift = <2>;
+				interrupts = <34>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
+				dma-channel = <3>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd4_default
+							 &pinctrl_rxd4_default>;
+				status = "disabled";
+			};
+
 			i2c: bus@1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
-- 
2.17.1

