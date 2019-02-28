Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BA4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB61218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9i3uLpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfB1Ppk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:45:40 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41105 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbfB1Ppi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:45:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id d25so9900956pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UlIvDrB8jEqxMcTRJrwwAoaBexZYNRihPSUXhNkMYCo=;
        b=Z9i3uLpKTrJ8YPmOgp6eUBBfB+cDVGhrKtQmPq4iGIzAdX6jtFeVIp/rtB6R6ONi93
         PkrZj/1nKA3DIrcP0/wlxyv2inKTwnsb+A9fQziCnrG/wjcNs9LpDsNES886UmTZhUb+
         LXTjf2JyP4voCKqen7fRAZxrT5bkIQJ1ntV+SEgWnvKyBNyEk0UH1FB5XaxJMs4sMYyU
         CmWU2ft/l5YVjocpzxnKMWfsPxb2SoFrTxsrWcHD6iXBI6XGRfD3EB9aGiCQqECOfrLr
         NeV8YrGtY/NEIpDFdMmP6WH24nffNWwtCtMS93AtE91atfuEUzSS1LTxemZ/Chj6OwpB
         43aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UlIvDrB8jEqxMcTRJrwwAoaBexZYNRihPSUXhNkMYCo=;
        b=t5XW1vqzKkQwRf+Q73dWtXagiDurUp2rqgxf4ASkfSEhl91qVUYtgZjQhCBH7OEO2W
         zNZPifcEzTNXpz/VsYVkV3N+LlQWyOxqyoS3PWhoBAEwp0ytlRMvI2xHd2Crf92GMRvu
         NJ8JG5LDnwXML8qu9kKNmZ7Zy5FsGhKVOIvaU6+H82RxQFqzja0wQKQzVo/CIWxI0v4y
         lxOTDgUzNU2bicJ3G9dKgKMc2LZH8OnqiE5ryOShhNnaYB/vbwLSdnezn4Jkniwh6rVR
         c6E094B7Im/6jSOF4GH7UIQw+3mB25hMPUG/L6w6eg1cy3xmT0qFZtfyDLw6TKNikq4o
         UK0A==
X-Gm-Message-State: AHQUAubF/HiBbGefd9k08n9WUo288hzAQrUI1UNk28RTnbDyA06h1BB3
        h1Arud/YkELedZl6BDfb9R4X
X-Google-Smtp-Source: AHgI3IafE/ZdJJ4AfmTyht9gsqDSUdX5g/BWYaDorJcNNm8O3SOvoQF7xK7UA8l8w6zGl4skqteqYg==
X-Received: by 2002:a63:d49:: with SMTP id 9mr9024690pgn.27.1551368737474;
        Thu, 28 Feb 2019 07:45:37 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:9c3:2dd3:3db1:5145:4da9])
        by smtp.gmail.com with ESMTPSA id m13sm37485286pff.175.2019.02.28.07.45.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:45:36 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        amit.kucheria@linaro.org, guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] arm64: dts: hisilicon: hi3670: Add MMC controller support
Date:   Thu, 28 Feb 2019 21:15:10 +0530
Message-Id: <20190228154511.17566-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228154511.17566-1-manivannan.sadhasivam@linaro.org>
References: <20190228154511.17566-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MMC controller support for HiSilicon HI3670 SoC reusing the HI3660
Designware MMC driver. There are 2 DWMMC controllers present in this SoC:

1. DWMMC1 is used for SD card (SD)
2. DWMMC2 is used for WiFi (SDIO)

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 37 +++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 9864cf59ebd8..080d6ba5ae39 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -671,5 +671,42 @@
 			resets = <&crg_rst 0x84 12>;
 			reset-names = "rst";
 		};
+
+		/* SD */
+		dwmmc1: dwmmc1@ff37f000 {
+			compatible = "hisilicon,hi3670-dw-mshc",
+				     "hisilicon,hi3660-dw-mshc";
+			reg = <0x0 0xff37f000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_SD>,
+				<&crg_ctrl HI3670_HCLK_GATE_SD>;
+			clock-names = "ciu", "biu";
+			clock-frequency = <3200000>;
+			resets = <&crg_rst 0x94 18>;
+			reset-names = "reset";
+			hisilicon,peripheral-syscon = <&sctrl>;
+			card-detect-delay = <200>;
+			status = "disabled";
+		};
+
+		/* SDIO */
+		dwmmc2: dwmmc2@fc183000 {
+			compatible = "hisilicon,hi3670-dw-mshc",
+				     "hisilicon,hi3660-dw-mshc";
+			reg = <0x0 0xfc183000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&crg_ctrl HI3670_CLK_GATE_SDIO>,
+				<&crg_ctrl HI3670_HCLK_GATE_SDIO>;
+			clock-names = "ciu", "biu";
+			clock-frequency = <3200000>;
+			resets = <&crg_rst 0x94 20>;
+			reset-names = "reset";
+			card-detect-delay = <200>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.17.1

