Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BF7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9813B218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIzBRJzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCTUZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:25:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44250 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfCTUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:25:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id i2so2588316pgj.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eAdIcXOpcOR3wLEK4yruXkVpo6EckNrG1lSlt64OUZI=;
        b=gIzBRJzcM+k5r6H4u4+EmCE3SkWkBarn6xj+dfByEbYU7tyCwU8C8qRM8SuVpGSwwI
         nNWEdn4Y1qh6rTXdtp1RwtsToGSGVArL0l2IsBLMuig1aTa+NDPOZsObVCR0DWiBe3bg
         KBiF4CHp1gHIcKbIoB/Lquzlp/1Y+doko+byLhUG1GyuHD8/Zdk2qOZO3t+23Ma/WRD+
         mMaDMQjMYyWj5SnCGo57GVIZ+XTbDUfy7IM6b/5XQx3uz5vPDntMxGGrELPt3VBf7uEo
         A0dtp8mzjiqSmhRuz54+EWjWc6EAhdFB3H9+RXfrAVBQW8OJ0o+Jer5+O/6Xaq/XZ/jP
         eFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eAdIcXOpcOR3wLEK4yruXkVpo6EckNrG1lSlt64OUZI=;
        b=M6WnT3VuQGlC00gGZgk0dAkPJlM7vTK+q6d83QM/vvAf6fp3sbaqVLR58wmyk0ukRy
         F66RhDcBiCVZctBNIVqQnOwHQWcWb4XzTmbuWKbyr1MFm3agRuCk/UCvIhVf3c5ylrCE
         2Yz7mfal3q3cU+16p4xECH9HfPkVYvKbA2/RsHDsqkMGl0IhjOOobvkD3OM2vdk9We/F
         Ruycth4NEwG4wo7+H8Hs4ilGNPc3+/umIFmsTh3J0GATTBUmbxPX2E9yV2Tk4hgLsqz0
         qu3fYPJVVJ4XhQTHE/rOACym4USA3wnc71ERTJ/+gwA3JW6PTZs7tTlMEI1JrS9irik6
         GEjg==
X-Gm-Message-State: APjAAAWx/bDh7AB5ymEFnAG1LTKcCaUvHnfJ6JLHpAHgIk7w8GdI2Z7v
        88so83lDw8ZqNcUK8ipJ3HNOzxpwbxo=
X-Google-Smtp-Source: APXvYqx6PDtUYK1QEqYly0pizPEw5ZfEhXv7OAmY9NV/TFotUocn/4vIvwVyax2nNAujPSdtMxpjkg==
X-Received: by 2002:a63:e801:: with SMTP id s1mr30451014pgh.378.1553113546379;
        Wed, 20 Mar 2019 13:25:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id u187sm866338pfu.113.2019.03.20.13.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 13:25:45 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: hi3660: Add dma to uart nodes
Date:   Wed, 20 Mar 2019 13:25:38 -0700
Message-Id: <1553113540-28726-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553113540-28726-1-git-send-email-john.stultz@linaro.org>
References: <1553113540-28726-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to add DMA support to the uart nodes following
the assignments made in the dts from the victoria vendor kernel
here:
https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v3:
* Remove dma enablment on uart0 which would use reserved channel 0
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 2f19e0e..a3eeab1 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -478,6 +478,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf00000 0x0 0x1000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 2 &dma0 3>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
 			clock-names = "uartclk", "apb_pclk";
@@ -490,6 +492,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf03000 0x0 0x1000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 4 &dma0 5>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
 				 <&crg_ctrl HI3660_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
@@ -514,6 +518,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf01000 0x0 0x1000>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 6 &dma0 7>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
 			clock-names = "uartclk", "apb_pclk";
@@ -526,6 +532,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf05000 0x0 0x1000>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 8 &dma0 9>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART5>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART5>;
 			clock-names = "uartclk", "apb_pclk";
-- 
2.7.4

