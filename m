Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B967DC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8815922DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgdjrGiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfHUC5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:57:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40400 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHUC5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:57:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so434027pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GdUGLfzA/moIy9fqv00a3/N33TZrVkt63TobdJZyyCw=;
        b=mgdjrGiz62SCcRImp4lqZD+9mH5SwVkqQCSliznjEvV9q9/Er6oVHnaigYH4FDlvZX
         U7MdbJUMTC5pkc/5ZS1tm2xCzCCvH9ULdqQ5hRXwncNHEI2F45qVGgrjtH4bXgmmDLTg
         3TDB1x9tfFtP/cUW8W3KU8Chq+RZQju7gaWkXh4qRYlg+KEWub80DutBlEiy7wX2CHuJ
         xfsx+iQmXlWF9JDDZ/asaA6j1O4GK1ggNZX0GU49A6JSwuVNFYEFr/QS2ukMmSyKGfpp
         qTMYWg8T3h9VsH4H0E1P+98pYxi5vlaSiZtsnr0h073E8LrUCeA7LmV667sBvYxKBK3N
         Bckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GdUGLfzA/moIy9fqv00a3/N33TZrVkt63TobdJZyyCw=;
        b=A3MOkwJ7HZ4Yj3gnV86f49GgZuf4m8DLH0JyUOYQhK5NSrU3JHGwpj9tbuFw2jxak2
         lOWDjvnGiqsboQFHnb26RwtzmEXbhtF9bWorlIP0TTA6oFOqEHz15S+Lpkv0aOBu1HDl
         lhibPUjSdTVuoMQi1877bQ36ieyHVZR12h2a+V3gf3X/a0Z8DtfArb4yLLRsPHCsXZd9
         h4VGMHpt1nkl/yd1yBCSrpS7fPqA0P+SNwr0ibG46f+gdne41zCrA0oXL2N8iGFW3Ox9
         ScDoPHmSQfyXjDfHZiuIh72uJgZ697JuS+YbcL7Sy3LiF1w4dEYeB5kZa1JL8CpXzHjT
         3Kbw==
X-Gm-Message-State: APjAAAV3uaPYhC1U4U5pqDQ/aB67IZ2STE2h/CfA84HE2ixmUn7pDskU
        THAlDSxpAU4xD/gjZKDNNdF9
X-Google-Smtp-Source: APXvYqzt5FTFseENmSuwukyXUbG5RlqSoMxXpSBPztasWpkSwaY0hyoCHv3gUjgzXK2xs00/klXpYw==
X-Received: by 2002:a62:8745:: with SMTP id i66mr32855184pfe.259.1566356225413;
        Tue, 20 Aug 2019 19:57:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id d16sm13251682pfd.81.2019.08.20.19.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:57:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/7] arm64: dts: actions: Add MMC controller support for S900
Date:   Wed, 21 Aug 2019 08:26:25 +0530
Message-Id: <20190821025629.15470-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
References: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
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

