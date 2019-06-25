Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E152CC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34BA20663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo6gK3Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbfFYKnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:43:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36319 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfFYKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:43:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so8648642plt.3;
        Tue, 25 Jun 2019 03:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RdQ4/TNxX8P3rj9r1+mVksjXamNrHwQHZzXzgzYLWPE=;
        b=Eo6gK3DzX72K9zDQ32h70P7c2d4iG/y/kQJSwJNZWhGEZYADvrcT2ozOxgq49YPj6+
         7PF+1ookbxqkIFIglAfgsxBrNMsjhH8MPW0P4rAx5nA8A010hexlos0iJdgeYHzITZy/
         FrPL1fob7RYSHSynl192BrjxRwWBe/0p9YtqiKs+Qth0J24PhK7MtdXW/wRnoQKKl8b/
         ulslzZ2ErYtYpraAtg8J7U+0EDLvF8WB8DlrY5BlSmxINiRgom3WkC/+1rPQkqHUPDx8
         IuTt2VCygKNeBEPfn+BWit+AsxZ1hbu9bMYpPbZ3fwF/tL/B43bnQcwthG9btqgqSeJP
         T6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RdQ4/TNxX8P3rj9r1+mVksjXamNrHwQHZzXzgzYLWPE=;
        b=JO/rPzEvkYcDyktEKOyLbfTn3lfVxvOsLNnQUSVTVJuiTMJViiHWwDKotZovKenvvL
         kXt8CLjsJZ+NupjfI9+j6TC1BFJoTgeY+2VPYWvooSHphg3CHKwRxiZOwY6LKHwRb8G2
         +h86bMIjPWjRBf2rKKeis4347cAC9gcB4hbeLm2RUdiAgZCdCFkBcaxDDaGK/0fRDvQW
         y5y0StZtuMW0cRzdHuocUfJgWqJTREAMxwmZ60TnaZOD8IumE7HchBNm1JyW/Cm463mc
         IH1we7xqUQcWkG36wQoA7z/rSGzVqV5hxl2/XHdWlb8BToMVKBvydmmU/lC+Os9sfaKf
         QVvQ==
X-Gm-Message-State: APjAAAW1FAI6DKo42iEIchhMGujvEcM9QgRF6ojsjdd4SoQ70Pcx1T9+
        JGJmesLtn3VZOqamDDkpN9I=
X-Google-Smtp-Source: APXvYqwdhu5Sh3pRbyMHd04wYl66p/1LqFdMgqLs2+DFAUhMMolq7t8YI/ozohyWTZDyxIGyYghiww==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr139302256plb.60.1561459383760;
        Tue, 25 Jun 2019 03:43:03 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id 14sm22026759pfj.36.2019.06.25.03.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 03:43:03 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v3 3/5] DT nodes for AST2500 DMA UART driver
Date:   Tue, 25 Jun 2019 16:14:34 +0530
Message-Id: <1561459476-14268-4-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
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

changes in v3:
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

