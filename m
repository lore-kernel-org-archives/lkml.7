Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229F7C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF5320870
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AF45FZq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfHUCk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:40:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42321 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHUCkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:40:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so462676plp.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GdUGLfzA/moIy9fqv00a3/N33TZrVkt63TobdJZyyCw=;
        b=AF45FZq/9GIa/RSGGKlY6M1BOYxvVfJ8bVFO2XKZAlJlRX5GB0czlvwCPkIeIgwm9p
         UyN4cOdOloa9yDmFhlq1R5MG4iChc172UUytA9c9inXamtyPkvH/CSwCw4jfBfUvlvfA
         e5XDXtcy91HNpqIJFPlD3F03JPLqaXcTgbSQ27OZ1FaHyr6psIkXoD0N3RlelwlvJNBu
         8jldz8zyPQ7qy+gWZAqr41/t+K+fTg8eg/cbKE4SYJOMgxzAqMz7EBGKzuEyg54qutcs
         HdwSeLjzb5I82RRg9ZDXsGKgvK9Z1yElT9k+/YJutOhW2OAfWEU3d2Nk0zkslnkPlMXX
         Y6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GdUGLfzA/moIy9fqv00a3/N33TZrVkt63TobdJZyyCw=;
        b=m3l6+fhyNoVqc4yQBIzSsVp/lXB71SHURjbLfj2CNfGVWBAlHgk4KJln66uL5ZQOc4
         fyD7+DlmX83Kl+OJYkJ1Gdgb6Ct1dZm5aBUT40j2HJZypWTGBTn9PC66gPceumfbFcpL
         l02aqkHAPySd/Ylwl4WyxASCnH6WQbyk4bhlz9I2K3GARiIdnEKIoQF0BmpOLdco3BAH
         fvEJ2SidtMh5aN6bmCuSEcOIoZByvdHLli3jtoo70dB4cV3U84X3vs+XNR9WJJj0KJoP
         kgiB8n0h35ReKkCrU5kpCsR7vq3sgYB66VPOYOfiqu5ry/dNdvYe0NDcHJo56kijjIlC
         3/pw==
X-Gm-Message-State: APjAAAXk5/W08S1e6+ajSYiiRdz1lJjpXdCWxT4D+w6WGD4Vx7dPYWmw
        FGbAsndXtx/NreVnT9rjlykT
X-Google-Smtp-Source: APXvYqzX351Wmm+kwzgjdUdao7XB7TObisEn5eBl3G9W2w+85A6ymPIpsyrlpxme8Ye0ZdI8AdGnmg==
X-Received: by 2002:a17:902:f217:: with SMTP id gn23mr31247981plb.21.1566355254909;
        Tue, 20 Aug 2019 19:40:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:40:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/7] arm64: dts: actions: Add MMC controller support for S900
Date:   Wed, 21 Aug 2019 08:10:10 +0530
Message-Id: <20190821024014.14070-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMC controller support for Actions Semi S900 SoC. There are 4 MMC
controllers in this SoC which can be used for accessing SD/MMC/SDIO cards.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index df3a68a3ac97..eb35cf78ab73 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/actions,s900-cmu.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/actions,s900-reset.h>
 
@@ -284,5 +285,49 @@
 			dma-requests = <46>;
 			clocks = <&cmu CLK_DMAC>;
 		};
+
+		mmc0: mmc@e0330000 {
+			compatible = "actions,owl-mmc";
+			reg = <0x0 0xe0330000 0x0 0x4000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD0>;
+			resets = <&cmu RESET_SD0>;
+			dmas = <&dma 2>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc1: mmc@e0334000 {
+			compatible = "actions,owl-mmc";
+			reg = <0x0 0xe0334000 0x0 0x4000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD1>;
+			resets = <&cmu RESET_SD1>;
+			dmas = <&dma 3>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc2: mmc@e0338000 {
+			compatible = "actions,owl-mmc";
+			reg = <0x0 0xe0338000 0x0 0x4000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD2>;
+			resets = <&cmu RESET_SD2>;
+			dmas = <&dma 4>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc3: mmc@e033c000 {
+			compatible = "actions,owl-mmc";
+			reg = <0x0 0xe033c000 0x0 0x4000>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD3>;
+			resets = <&cmu RESET_SD3>;
+			dmas = <&dma 46>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
 	};
 };
-- 
2.17.1

