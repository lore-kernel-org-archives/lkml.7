Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F7C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A120644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hn86/R8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfDYMz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:55:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41965 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDYMz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:55:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so11139544pfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lN7d9AFnCFsQoNto1MmoxFEaROcLbNByuK9LsqS8Ur8=;
        b=Hn86/R8nm2cPg8z7qwJKKGxmsB4+pd5l8wrKGLq6KKtB5SMjb0MDI2di/dDTWopvkA
         yVd01k0BpGGpkduRV6wS4ymMA0kEZsFgi//EhuemiDW593jFbP2feJuo1LgbjVHZfe1G
         xYxHzfFXOnzHb2u9QjlFS0q6q+nRmW+bq5Wca50/14VKltyGsRhuw6vqT4VIvLHWQAZP
         BPTWp0eEX9zh6N+e09vul5j5F0DJm/lMCHmyiBwCRclNUEaNXvCoAI9VkOwS9fDgeQsi
         cazf+WCiupdt1UWhvbn5xxzAK91D3oWyfg2goGG08iqnuGd1TKbyud4WyyFSjLXbxfH1
         TSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lN7d9AFnCFsQoNto1MmoxFEaROcLbNByuK9LsqS8Ur8=;
        b=Ucgl8DA+7mSdzSV2Ksv0d7K2R4Pl1plYh9xm2/zrwqtLzLmxpWdXzKRn5KlUtdGaLh
         GJKIFpr8h7KS7mwNbCHsngjgM6VPOFtziUUsMYrTsR9GiQHYafG9Fy/qd/9Yi21FXh1m
         yAKj34cVppupGIHnUQMY2ikqA+xBzi35Lw6JHqW3f7qTWIqo29MGqU38PARSDO2FbvDP
         466sS1AR7Xx0qG9jwHGMSwu0psBukkJ1HCBD6KaL4o4BwBS1kZIgAG09LKZJ38gLyxxe
         +Wi5PN1OiU1U/Kb5TIRXO8Y1t26xp6AEFpHaGZ4LOOhWyLuKHr0T6s0EyfOa4vg1p5Fu
         fRbw==
X-Gm-Message-State: APjAAAU4f8I4dIZ7HWBtZf3gFsXw7e/2J5TYzJ4DxlOK7Gv6uQsFIulP
        RpYMrXHlchIErkju0Za1tMQk
X-Google-Smtp-Source: APXvYqyI1XoWAjh5ROIO2V3hlu6fXr66XrGC0Tt17nTKh9taRIDdhYPcvDOlxUwScMbzuvFUzzKXzw==
X-Received: by 2002:a65:648c:: with SMTP id e12mr36987444pgv.346.1556196928150;
        Thu, 25 Apr 2019 05:55:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:81e:2691:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id c18sm50507983pfc.0.2019.04.25.05.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 05:55:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] arm64: dts: bitmain: Add reset controller support for BM1880 SoC
Date:   Thu, 25 Apr 2019 18:25:07 +0530
Message-Id: <20190425125508.5965-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425125508.5965-1-manivannan.sadhasivam@linaro.org>
References: <20190425125508.5965-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller support for Bitmain BM1880 SoC. This SoC has two
reset controllers, each controlling reset lines of different peripherals.
This commit also adds reset support to UART peripherals.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index fdfdc65d29ef..37ecb760a2d2 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/bitmain,bm1880-reset.h>
 
 / {
 	compatible = "bitmain,bm1880";
@@ -92,6 +93,18 @@
 				compatible = "bitmain,bm1880-pinctrl";
 				reg = <0x50 0x4B0>;
 			};
+
+			clk_rst: reset-controller@800 {
+				compatible = "bitmain,bm1880-reset";
+				reg = <0x800 0x8>;
+				#reset-cells = <1>;
+			};
+
+			rst: reset-controller@C00 {
+				compatible = "bitmain,bm1880-reset";
+				reg = <0xC00 0x8>;
+				#reset-cells = <1>;
+			};
 		};
 
 		uart0: serial@58018000 {
@@ -100,6 +113,7 @@
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst BM1880_RST_UART0_1_CLK>;
 			status = "disabled";
 		};
 
@@ -109,6 +123,7 @@
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst BM1880_RST_UART0_1_ACLK>;
 			status = "disabled";
 		};
 
@@ -118,6 +133,7 @@
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst BM1880_RST_UART2_3_CLK>;
 			status = "disabled";
 		};
 
@@ -127,6 +143,7 @@
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst BM1880_RST_UART2_3_ACLK>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1

