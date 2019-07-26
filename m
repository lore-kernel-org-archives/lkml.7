Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3217C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A97222BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0pEeb8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfGZNZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:25:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32938 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGZNZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:25:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id f20so15565126pgj.0;
        Fri, 26 Jul 2019 06:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MquKBd9hqVjp/9J/EBQwb+pNJa32VY/RVtfqOZkVTYM=;
        b=h0pEeb8eJmv0OWlzU8c/oZZxxlqWUWnjqI7h0wMYSo1EDOqzSN8fzh9i5qaJbRTsMJ
         ZXXj1+P+jyzfKrIS31BiT9UYFd05eHa3hQxp3hE/0SaWhzM+gqKTXP6Ie1ctglELY9ep
         bMyP82ohvp7tUxGMEFgBwZWi7dY4wrsxBNqd5SaV0Q4gJqm2cAx3IO6Vu1dAveBFKivY
         ji2ISZUSgNCVwozsCuOc8udRSAJAWv4qxWQ4wYL/Gu0yVu93lwdNL5oPEqi8Mp40xTY9
         vZnKKuLISbJ+FK7ANJ06/n838OV7DTM0c0dTEfMUk1ojzRwTkCdZ0KBf011mhIpVN7Xd
         ADww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MquKBd9hqVjp/9J/EBQwb+pNJa32VY/RVtfqOZkVTYM=;
        b=gRk/9yUnksbBbG5yiLdakvgfqDNhsm5NkViOG8pRMFU2DNwiQaR4TtN4SG4VFoJRgg
         hOiriRqwOLpXdLClmctfC7EY+/SmogW+W2NR1nFp4RB0oDZEk4QUn/LeeAmhqHVHxC9I
         8UZg3eoSPf8YBJTiG8f6dK7cOaREsnwcxYJtCoHf2af14cHJr3PJWmmo1cN9smwCPcZx
         mcIMipLXKK3iElWXkoPmT67zqFejQansZ910xyMu/GqDYj6+0tZXn1A/7TNTGbe43ugh
         AZdIDv6I41UPSnBm4cKxtK/yE59CoPxRZWwvfgPg7668m10VbC991j6SYTHfZ8lwPkR2
         RhaQ==
X-Gm-Message-State: APjAAAV1tWJ88xiE+0HjB22UMe50j2MCz5Z4lORanZUByY1U1HrCI8oA
        u6GxAAq5QJvM/A+BfJrBSvg=
X-Google-Smtp-Source: APXvYqylom4Oby1O6RsLiZ+JCG1HqcBX0N6tZc7gxaPQuePmybgdxMkBUpAzRhY5+z/zhx5R3s/MHQ==
X-Received: by 2002:a63:490a:: with SMTP id w10mr89969624pga.6.1564147537087;
        Fri, 26 Jul 2019 06:25:37 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id k36sm54544603pgl.42.2019.07.26.06.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 06:25:36 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v4 3/5] DT nodes for AST2500 DMA UART driver
Date:   Fri, 26 Jul 2019 18:57:18 +0530
Message-Id: <1564147640-30753-4-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
References: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
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

changes from v3->v4:
-
changes from v2->v3:
- change logs added

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

