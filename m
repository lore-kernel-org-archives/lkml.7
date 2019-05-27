Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF89FC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C853B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cYhyX4RG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfE0MnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:43:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46235 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfE0MnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:43:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so16784109wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkQUEAAflpHSvleM8C2ksBIOQ078CZvnw80T6no6FBM=;
        b=cYhyX4RGU9ybatqZrlhu3awpU2uOva/ELw1S70I45twlrgLduhdjSDILCuC1PttuTt
         2nJtnJ9EI1+Gte7SaOiKxGN6NlhBzVGUL/5GqcRDlaxjzVt1dbTrMC4fozegF+qfUKor
         +q0HRs8ETsnOjl7w716PMmPAjFsl/TiWsfwRaZiNDXc6w0i+Czz02dK5G84tDs+GVikX
         jODGgnVwh2bNYkz7WTgyPYzc+Zr7ismMmQAxkXvj+QGfdB6q9znUmShuol85jBjPktLe
         gDlNW94XN1zObeIe3AbZ8iqc/xCSY2QCXpFaa2hZGh+54GiHebZMHEanOIok7LxAmBZF
         S9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkQUEAAflpHSvleM8C2ksBIOQ078CZvnw80T6no6FBM=;
        b=Tz4jqHJJX3a+yzibD02X/oRGzUCI4eKp2GpexByLQjK64pZ9VF7FmZ9CGsjNrSp9/1
         BoyKFem7YLhRkCSub9e/HbLvcrke53iFDQbo0J+hpQAcGWLPZPzqDRRdO6jHvFgagDVA
         CY8dIZg5r8O1eaNebI015v7vIDP8m4QPY8pEK+HZxcGTbGS5jd5OLSlIOug0sUWxDZyr
         PhI86ACij5VaQQ+RK5Ow48NdVx4iP2SJzDC73m9KLl7HTB0e9q88KqdSArXCOe0Hv8gg
         5YchUoz4APoW8y9EFY1RYAPg6FK4trsJzYnWtxGnFZB7ODF9U/OzJI0IR7D4lYPlqy3n
         fIWQ==
X-Gm-Message-State: APjAAAUu054g5n2KgY5ZpYfx01GoYRephpuR+1PTV2oxwV3EtsDfFcyj
        Hyn0DigaGHO4eqLmx3mKzKfovJ8baw864A==
X-Google-Smtp-Source: APXvYqwAZ8oF5h4lEBmdEoFJmg6fDQVHoyhJjYPqNt6yYmssL7+UTOhCpj7xzXiyMOi5Jk9dkPKd0A==
X-Received: by 2002:adf:8385:: with SMTP id 5mr658932wre.194.1558960993541;
        Mon, 27 May 2019 05:43:13 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm11494930wrt.45.2019.05.27.05.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 05:43:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     ulf.hansson@linaro.org, khilman@baylibre.com
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: g12a: add SDIO controller
Date:   Mon, 27 May 2019 14:43:07 +0200
Message-Id: <20190527124307.32075-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527124307.32075-1-narmstrong@baylibre.com>
References: <20190527124307.32075-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
add the port A (SDIO) pinctrl and controller nodes and mark this specific
controller with the amlogic,dram-access-quirk property.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 9f72396ba710..d1a3da9d0b2e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -202,6 +202,30 @@
 						};
 					};
 
+					sdio_pins: sdio {
+						mux {
+							groups = "sdio_d0",
+								 "sdio_d1",
+								 "sdio_d2",
+								 "sdio_d3",
+								 "sdio_cmd",
+								 "sdio_clk";
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
+
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -566,6 +590,19 @@
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
 		usb: usb@ffe09000 {
 			status = "disabled";
 			compatible = "amlogic,meson-g12a-usb-ctrl";
-- 
2.21.0

