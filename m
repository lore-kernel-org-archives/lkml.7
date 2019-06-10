Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E77C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D3A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vPytJ7dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390050AbfFJMtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:49:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44578 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389623AbfFJMtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:49:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id b17so9033975wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 05:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=paZ5pWp7Tw9Kqpu3mv/pxtbEqmzU7N+ABWaMNMy3HrM=;
        b=vPytJ7dJXkP1fOwjeKYjBWk81r/Ejltc5k1ajCYbmyhnSp6Xzx9aL+/KnPEHvv843o
         sjRZrvswUUZoTRSosIwhd6otjZoHVxoSUX9/4DkilztMtX+cJm1m3LIxQ/MEAPvK/k71
         DyFrJBXiqtmBGr3yuiBjks4cVBPJnvj5bsR5h3pE55neZbUPHMogJhmLmFj8/0HEG+kE
         xNTFydhLuO7A/8lOI7ZK3KSHjydcKiWn7uqHsQnV1r/YhKte5xkxWPL9XnTyug2Ae5eE
         a+v87M/TIuZRvWOWlwZgXiVY6Y1uphLRVvZhOEGOt688wKX2E62XTu6UU6KbAN/LGHRb
         CSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=paZ5pWp7Tw9Kqpu3mv/pxtbEqmzU7N+ABWaMNMy3HrM=;
        b=AYPHGFi7FezV8bqdMxcuVyJcHpa4z8YJBwMTvxMMuVfjCuzTJ8FbgmXz1uXpgZghdC
         +5o5BYAyODYCeeeAg1bYt32RJAMGNVQ8kf78McbkMYii5MWvAAo/OUas/SJPxGXdDknI
         XgPJYjxaeazh7hxOq7tdu9Aljl7sIC9tru8K08XSmKw85xzcSBUFpJT0g+fsXBgwB4vL
         tag42oV0W5XDku6GHW1IJNog059evFi4e14vdqQpAjcJ6eNbxdPuRjGkij5Yy8nL+1uD
         1Y26EeY6hf7oEuI8H+6hO3KdvxVVzqoqkrG9vFlyYIbZtDngqd037IURTp/UvpB6mbsZ
         z1rg==
X-Gm-Message-State: APjAAAXvQSnI6sdvL6CwPv8Q5o/t9KXXIx+Uuni+hNZSxVbsuxK8YQFS
        67cvR3K8UdhzbzBFIrm+oqmbjA==
X-Google-Smtp-Source: APXvYqw3xovslR/1IsJwGC2mxhAa5CikdWZnlwoZKEOVXpgVqn2wnhmDPTd/DUL87e+yhezi7pr04g==
X-Received: by 2002:adf:9023:: with SMTP id h32mr45385160wrh.95.1560170977216;
        Mon, 10 Jun 2019 05:49:37 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id v24sm7550504wmj.26.2019.06.10.05.49.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 05:49:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: g12a: sort sdio nodes correctly
Date:   Mon, 10 Jun 2019 14:49:31 +0200
Message-Id: <20190610124931.17422-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sdio node order in the soc device tree

Fixes: a1737347250e ("arm64: dts: meson: g12a: add SDIO controller")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 73 ++++++++++-----------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 6aec4cf87350..0642e0a6c605 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -843,6 +843,29 @@
 						};
 					};
 
+					sdio_pins: sdio {
+						mux {
+							groups = "sdio_d0",
+								 "sdio_d1",
+								 "sdio_d2",
+								 "sdio_d3",
+								 "sdio_clk",
+								 "sdio_cmd";
+							function = "sdio";
+							bias-disable;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					sdio_clk_gate_pins: sdio_clk_gate {
+						mux {
+							groups = "GPIOX_4";
+							function = "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
 					spdif_in_a10_pins: spdif-in-a10 {
 						mux {
 							groups = "spdif_in_a10";
@@ -1326,30 +1349,6 @@
 						};
 					};
 
-					sdio_pins: sdio {
-						mux {
-							groups = "sdio_d0",
-								 "sdio_d1",
-								 "sdio_d2",
-								 "sdio_d3",
-								 "sdio_cmd",
-								 "sdio_clk";
-							function = "sdio";
-							bias-disable;
-							drive-strength-microamp = <4000>;
-						};
-					};
-
-					sdio_clk_gate_pins: sdio_clk_gate {
-						mux {
-							groups = "GPIOX_4";
-							function = "gpio_periphs";
-							bias-pull-down;
-							drive-strength-microamp = <4000>;
-						};
-					};
-
-
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -2316,6 +2315,19 @@
 			};
 		};
 
+		sd_emmc_a: sd@ffe03000 {
+			compatible = "amlogic,meson-axg-mmc";
+			reg = <0x0 0xffe03000 0x0 0x800>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+			clocks = <&clkc CLKID_SD_EMMC_A>,
+				 <&clkc CLKID_SD_EMMC_A_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "core", "clkin0", "clkin1";
+			resets = <&reset RESET_SD_EMMC_A>;
+			amlogic,dram-access-quirk;
+		};
+
 		sd_emmc_b: sd@ffe05000 {
 			compatible = "amlogic,meson-axg-mmc";
 			reg = <0x0 0xffe05000 0x0 0x800>;
@@ -2340,19 +2352,6 @@
 			resets = <&reset RESET_SD_EMMC_C>;
 		};
 
-		sd_emmc_a: sd@ffe03000 {
-			compatible = "amlogic,meson-axg-mmc";
-			reg = <0x0 0xffe03000 0x0 0x800>;
-			interrupts = <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
-			status = "disabled";
-			clocks = <&clkc CLKID_SD_EMMC_A>,
-				 <&clkc CLKID_SD_EMMC_A_CLK0>,
-				 <&clkc CLKID_FCLK_DIV2>;
-			clock-names = "core", "clkin0", "clkin1";
-			resets = <&reset RESET_SD_EMMC_A>;
-			amlogic,dram-access-quirk;
-		};
-
 		usb: usb@ffe09000 {
 			status = "disabled";
 			compatible = "amlogic,meson-g12a-usb-ctrl";
-- 
2.20.1

