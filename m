Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84971C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545E22063F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uqGZrz2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfCRJ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:59:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37632 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfCRJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:59:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15so16270801wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9EioP8T7LI4Uy8dBmKG3aC7DgMQWG+51HGznOMhw3V4=;
        b=uqGZrz2R/fewUc9eUMs4QTydVILxyq5+7yIo5wzVdwaLCPO0kCCcqSBFWQX52mYb9I
         EUc5YykPPxSQUc5nvP7JPsBhJ3VkJYWZ3XMv7a6WhoTUiiLZaeYcCrv/QK8CgQ6XD4oH
         YSEK7tFBw4d7HZMMVmvve1HwaPlaHYK1qR+fLqIEtgiHLqNBgPTaqlEDBHx1R9XCKGgX
         fBlOnrJ0wHPGfzFVnQe7qDWnI52R1tBlZL8gqhkzV2ImNBK/e1pTXvEmnbmydoo6UJj2
         lkQ7zBwWdKvH9Awm9XAE0CgILaE8nhjzgUpiM6hKNAeSpylM/kzcnAhp+uBre+tbNijo
         /t/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9EioP8T7LI4Uy8dBmKG3aC7DgMQWG+51HGznOMhw3V4=;
        b=MElgMouFQ0j7NBiMoaIrknmy1qvt1PbkGt+RNC9EL8AhrpkRGewEBeo2tzsy8Rl5xN
         hM6qHa3TEyEa9NZPcRlqr7GXRrGVMgwhZxFVrhP+mXlFavpjbve7jA0Ss6RxhG9JzwEB
         rWjNz00TUYaqnbJHusfnxsin71FyMLJPyLjkUE0fWmPtHeS3ppajHGoWnIN0CcEZAXAQ
         rRyk0YtZMAK17EO1YF3eqdynyE2bQYuwIKyPk2JVb634Qb2rWEAGvbz8I9b/PLa+0eY7
         ecnLn9t1UHEauWgGNT0dZzzazp6j+F3jmpBsPXH8XOMUv9UyxNWya6iQZOMMrG5Grb5g
         IjLg==
X-Gm-Message-State: APjAAAVUBL4rYnaP3qw4M6+K/egtEsEUkM0t3p/RzYT68Dbgwx/qFQAL
        ygZ1POto8UPDRS5a9JNq7UNAbw==
X-Google-Smtp-Source: APXvYqw2j8aVz8JHkcIL7kul6LNskzjeo7tEIM8Qx9ypPmyjqNydMuFGNQcfAkqQs9VeB4K9VUvk2A==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr11236056wrk.65.1552903139357;
        Mon, 18 Mar 2019 02:58:59 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g8sm5459034wro.77.2019.03.18.02.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 02:58:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] arm64: dts: meson: g12a: Add UART A, B & C nodes and pins
Date:   Mon, 18 Mar 2019 10:58:48 +0100
Message-Id: <20190318095851.4062-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318095851.4062-1-narmstrong@baylibre.com>
References: <20190318095851.4062-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the 3 UART nodes in the EE power domain with the corresponding
pinctrl nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 72 +++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index cefd6e27c7a7..992751024366 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -114,6 +114,51 @@
 						#gpio-cells = <2>;
 						gpio-ranges = <&periphs_pinctrl 0 0 86>;
 					};
+
+					uart_a_pins: uart-a {
+						mux {
+							groups = "uart_a_tx",
+								 "uart_a_rx";
+							function = "uart_a";
+							bias-disable;
+						};
+					};
+
+					uart_a_cts_rts_pins: uart-a-cts-rts {
+						mux {
+							groups = "uart_a_cts",
+								 "uart_a_rts";
+							function = "uart_a";
+							bias-disable;
+						};
+					};
+
+					uart_b_pins: uart-b {
+						mux {
+							groups = "uart_b_tx",
+								 "uart_b_rx";
+							function = "uart_b";
+							bias-disable;
+						};
+					};
+
+					uart_c_pins: uart-c {
+						mux {
+							groups = "uart_c_tx",
+								 "uart_c_rx";
+							function = "uart_c";
+							bias-disable;
+						};
+					};
+
+					uart_c_cts_rts_pins: uart-c-cts-rts {
+						mux {
+							groups = "uart_c_cts",
+								 "uart_c_rts";
+							function = "uart_c";
+							bias-disable;
+						};
+					};
 				};
 			};
 
@@ -258,6 +303,33 @@
 				compatible = "amlogic,meson-g12a-clk-measure";
 				reg = <0x0 0x18000 0x0 0x10>;
 			};
+
+			uart_C: serial@22000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x22000 0x0 0x18>;
+				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&clkc CLKID_UART2>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+
+			uart_B: serial@23000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x23000 0x0 0x18>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&clkc CLKID_UART1>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
+
+			uart_A: serial@24000 {
+				compatible = "amlogic,meson-gx-uart";
+				reg = <0x0 0x24000 0x0 0x18>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+				clock-names = "xtal", "pclk", "baud";
+				status = "disabled";
+			};
 		};
 	};
 
-- 
2.20.1

