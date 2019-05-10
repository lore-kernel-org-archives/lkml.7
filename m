Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD11EC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768B021479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSmkaRdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfEJSp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:45:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38542 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfEJSp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:45:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id a59so3228915pla.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZM7SY/0BpFAbopYEDbwnieszVXK8F7PH873RQSPiOGw=;
        b=eSmkaRdfluc3LITMaj52pu9Lm3tSLmTqyzpSePda+Stm7E9Nvv4lCWt62yvZEMnqC3
         r7afY22FHunRw47eNe4uw3BYf3x1JEdpF3RmPZ+Yp1CJG/T8fHghd/qMkCqdjmia/E3O
         EpojE9CCfBucSdWMnF3lhlPgGEUxGIdquEDFsKZJR/rjQ2TWYBca341e9eSShXJBow98
         lJNweQrjhv+0lHoDhv9EjYUoC247BylKAH5g8Lfbwi6TycVeSCKXBH/1dIoV/GjQIhxa
         HrWmQa7dJDlgFxXV3fRkcBE4NtxIEYQ2u4trrqqeppiKG11BHlVV1p55O3CF0pE9+BJg
         pguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZM7SY/0BpFAbopYEDbwnieszVXK8F7PH873RQSPiOGw=;
        b=aC68UnkNSJBY5EGybROVfAx2d2EyI10OFjDIKKKkcWF9v/foABoXUJWBIl6BGQbYEB
         nd6SksMZVFPnv2vU/0wDQ0BtNWRuk3cTvd+kOl6jSkOc4GhdTI/hj3eITCSokSKUeWq6
         CRViUm3LGdyX+yFQGsxFc+uKg0dIHWDvEJ8GjSTcEytmRa/mD2b/FGK/MCqHHB3UnmJN
         kISEycaKNzcY5Yg55CUlaadh/xhs1ntOfPJzVRyVYAU04rFxvBUNjPT8fg4AvFs6jk+X
         rBvuUHzlvFuVo8s9rTbKzfIfoqIn2R/xdQnMEC3jWUvy/MXrlny+JVpOwt/N0Vn94zmw
         7Jlg==
X-Gm-Message-State: APjAAAU7ueT3EcuRX8+/vIZfOdwZT5pNsplXLaC4BzzqyzdnURTP6OmI
        WBF8JXqwA483aqV2OT4jh1YQ
X-Google-Smtp-Source: APXvYqxehUfLgKa/EJLFMORNrx2COq3ir5fRNxBGMKqgYwg3ZYbf0h6xEgq3a/Wkcs4t665qS0wXlg==
X-Received: by 2002:a17:902:868e:: with SMTP id g14mr15465190plo.183.1557513955941;
        Fri, 10 May 2019 11:45:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c1:9991:95b6:5055:2390:bf9b])
        by smtp.gmail.com with ESMTPSA id g188sm8652049pfc.151.2019.05.10.11.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:45:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/4] arm64: dts: bitmain: Add reset controller support for BM1880 SoC
Date:   Sat, 11 May 2019 00:15:23 +0530
Message-Id: <20190510184525.13568-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
References: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller support for Bitmain BM1880 SoC. This commit also
adds reset support to UART peripherals.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index fdfdc65d29ef..3ab039029bf2 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/bitmain,bm1880-reset.h>
 
 / {
 	compatible = "bitmain,bm1880";
@@ -92,6 +93,12 @@
 				compatible = "bitmain,bm1880-pinctrl";
 				reg = <0x50 0x4B0>;
 			};
+
+			rst: reset-controller@c00 {
+				compatible = "bitmain,bm1880-reset";
+				reg = <0xc00 0x8>;
+				#reset-cells = <1>;
+			};
 		};
 
 		uart0: serial@58018000 {
@@ -100,6 +107,7 @@
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst BM1880_RST_UART0_1_CLK>;
 			status = "disabled";
 		};
 
@@ -109,6 +117,7 @@
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst BM1880_RST_UART0_1_ACLK>;
 			status = "disabled";
 		};
 
@@ -118,6 +127,7 @@
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst BM1880_RST_UART2_3_CLK>;
 			status = "disabled";
 		};
 
@@ -127,6 +137,7 @@
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
+			resets = <&rst BM1880_RST_UART2_3_ACLK>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1

