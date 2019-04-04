Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C754F2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqhXud9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfDDIQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:16:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34298 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfDDIQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:16:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so790941plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3WFDGlXmYECw79Q41NjIHGfPygiaXYVxcsbulVh6YIk=;
        b=xqhXud9D8ZzCmeNC+QrKKIVT/UiIn9dig1QYWFOsNlIqPrHFW6xklV/clsCXg5AZDy
         UG2AlkD/QMa24G9mgqBTIcQUMVO3uUsYvrwcCRCVnY6GGYVYJlPWJY+vNP4C9/KzgcUG
         gJur1UWcQMxN5XJ/Yi28RoJ2LYVFTOHTYMUoAQYHFGMiVHY8s+t+UbaF8jFhjdyy1Diw
         RPU1i1ZGBIGr8BWShbl8yeHdIXDcJSez62uEOSRysvspiUCo1GEeq59HRq9itOxTT0ck
         w3UT5zTTpVMmfHlarxqEZYRS3nWhTyGgxbesnz13LF+uQioZbARJJkkplj/Bi8JXPTCb
         qzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3WFDGlXmYECw79Q41NjIHGfPygiaXYVxcsbulVh6YIk=;
        b=oSVV0iEZTxNd7/UloUecmpnK8IsbuOn3NaiajBz1YDPJfyv11Bh6CuS7f8v95uenrw
         LJLNldP3aBhw7otgz3L1i+/E1vmaeSn1GTK5GaZF/ygMZA5lDpnJ4An8fXgu+YmXXYR/
         4F4vO7i8SmeIDRkQZFDhZJb3cD64Qw+lJ1naWMCy7AedeOHvf/US/+cOzFt+Ghym23A1
         DZ7ow7Yq/+yn8FJC2MaK+gS0MRyoJSjkyb3PloviptkwZa9GBOWuV+oWv8wrGG56dUrp
         mvWxVkV699S4823zwQgTqOOGuzjVWS8ZgLePpZEFClaNx3wtJ0Zt9D29WCt4GP1q8uIt
         nIwA==
X-Gm-Message-State: APjAAAVJtX283rd20AHfG74W7bicm5rGjNV3N+QprY2/NPk9F8s6prh0
        yGaKO4ZRm4MJWYGR8T8qdSdrG2Ig+9Y=
X-Google-Smtp-Source: APXvYqxOJZkdZc7XRyOpy0yck6xh7db+3GYFns8oLKKHvkJELSlhfGsMaakrZsTuwxhQpS0eV8bZUg==
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr4817116pln.144.1554365798362;
        Thu, 04 Apr 2019 01:16:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id d129sm26041389pfa.142.2019.04.04.01.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 01:16:37 -0700 (PDT)
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
Subject: [RESEND][PATCH 1/3] arm64: dts: hi3660: Add dma to uart nodes
Date:   Thu,  4 Apr 2019 01:16:26 -0700
Message-Id: <1554365788-25610-2-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554365788-25610-1-git-send-email-john.stultz@linaro.org>
References: <1554365788-25610-1-git-send-email-john.stultz@linaro.org>
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
index 1734675..37a997a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -484,6 +484,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf00000 0x0 0x1000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 2 &dma0 3>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART1>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART1>;
 			clock-names = "uartclk", "apb_pclk";
@@ -496,6 +498,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf03000 0x0 0x1000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 4 &dma0 5>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART2>,
 				 <&crg_ctrl HI3660_PCLK>;
 			clock-names = "uartclk", "apb_pclk";
@@ -520,6 +524,8 @@
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x0 0xfdf01000 0x0 0x1000>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+			dma-names = "rx", "tx";
+			dmas =  <&dma0 6 &dma0 7>;
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UART4>,
 				 <&crg_ctrl HI3660_CLK_GATE_UART4>;
 			clock-names = "uartclk", "apb_pclk";
@@ -532,6 +538,8 @@
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

