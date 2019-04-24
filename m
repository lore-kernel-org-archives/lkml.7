Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B613C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105AD218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yrXSgBWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfDXMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:03:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37301 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfDXMDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:03:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so9290572pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o1BE+Lvm1P0Zy9V+X0g8sBTlpGL1gkXzWIVJDLVxgUQ=;
        b=yrXSgBWHOLW3k6sGjU2DzaPMuJetuFp9MxBNSr11uZR00yusCZ6RT4Sesrb31GncBR
         imlDBprVX2EJt6p8X8RrNW6/zzp5yhDm8skcyZSVYbZ3B7B97oPYXcg9thvmoVRsHV6U
         9/YsOEDdhi3ZlOoCBe5P1NBIcZegIx3tqvHQWhhRM+UoMacTbfqD81z9bTLkDfHWjOMc
         RL8W9smTXXHsUvwdMNA2AL60L3pxwiySlnQ+4lnS+ux5yMpKO9urXui+3mB9BQWFT10T
         fvYhee1Wxs1H7F299tp5S9JpYWnvIUUGART0wNhtV6SRZ8D6M0/7lja6U8boLAUzovfw
         51iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o1BE+Lvm1P0Zy9V+X0g8sBTlpGL1gkXzWIVJDLVxgUQ=;
        b=oKDEX6Ny3vaainDTCWog6/nI8/x78Baa/oXFvYnxquP2MbuiBuhtwia87yvYpG6TOB
         9fT+wdBGg+MWFeBPwOquMLzFa6x1i6xSzgO3igAuN9Vo7duu4KZrNU9rc5gx2D3t7bmT
         iKK2Zo/SBukRpPcuzXtyVeT0P2TnHoEfwIWUEkTk55c0wwS1/lo+9kBwf6EkeQATOYFY
         d+YsACGa0zYseuY6LT9LhuFwG+zFW6bRpFNzK5mL9ZBgi1M1NxGarbsROVO6QEspDpts
         2E0tM8gA47/ezSUQcfMpPJiQU7ATZpfxsr7Uq8VIyrrFwAJhbu9HRIrZ4LX+QDoRSiCp
         w3Uw==
X-Gm-Message-State: APjAAAU9PSShbECq2+KN9ROszFHvEFduKJ4J0yZ6xJhjq8JX3GgaISAP
        yDdxVg+ef/bCaqbQbOK3jXP0K+aglA==
X-Google-Smtp-Source: APXvYqyh94Vd+h3WzUCbY2kTfTOmxUAM7kJYCCp5Rbw1LATVp96ostk759mFTvTkHtqod6FOEcBj1g==
X-Received: by 2002:a63:6988:: with SMTP id e130mr30616329pgc.150.1556107402644;
        Wed, 24 Apr 2019 05:03:22 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:711:bac8:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id j22sm25870840pfn.129.2019.04.24.05.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:03:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        linux-gpio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] dt-bindings: pinctrl: Add BM1880 pinctrl binding
Date:   Wed, 24 Apr 2019 17:32:20 +0530
Message-Id: <20190424120224.22660-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
References: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl binding for Bitmain BM1880 SoC. The SoC is not capable
of handling pinconf, thereby supporting only pinmux and this limitation
is documented.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../pinctrl/bitmain,bm1880-pinctrl.txt        | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
new file mode 100644
index 000000000000..ed34bb1ee81c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
@@ -0,0 +1,98 @@
+Bitmain BM1880 Pin Controller
+
+This binding describes the pin controller found in the BM1880 SoC.
+
+Required Properties:
+
+- compatible:   Should be "bitmain,bm1880-pinctrl"
+- reg:          Offset and length of pinctrl space in SCTRL.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning of the
+phrase "pin configuration node".
+
+The pin configuration nodes act as a container for an arbitrary number of
+subnodes. Each of these subnodes represents some desired configuration for a
+pin, a group, or a list of pins or groups. This configuration for BM1880 SoC
+includes only pinmux as there is no pinconf support available in SoC.
+
+Each configuration node can consist of multiple nodes describing the pinmux
+options. The name of each subnode is not important; all subnodes should be
+enumerated and processed purely based on their content.
+
+The following generic properties as defined in pinctrl-bindings.txt are valid
+to specify in a pinmux subnode:
+
+Required Properties:
+
+- pins:           An array of strings, each string containing the name of a pin.
+                  Valid values for pins are:
+
+                  MIO0 - MIO111
+
+- groups:         An array of strings, each string containing the name of a pin
+                  group. Valid values for groups are:
+
+                  nand_grp, spi_grp, emmc_grp, sdio_grp, eth0_grp, pwm0_grp,
+                  pwm1_grp, pwm2_grp, pwm3_grp, pwm4_grp, pwm5_grp, pwm6_grp,
+                  pwm7_grp, pwm8_grp, pwm9_grp, pwm10_grp, pwm11_grp, pwm12_grp,
+                  pwm13_grp, pwm14_grp, pwm15_grp, pwm16_grp, pwm17_grp,
+                  pwm18_grp, pwm19_grp, pwm20_grp, pwm21_grp, pwm22_grp,
+                  pwm23_grp, pwm24_grp, pwm25_grp, pwm26_grp, pwm27_grp,
+                  pwm28_grp, pwm29_grp, pwm30_grp, pwm31_grp, pwm32_grp,
+                  pwm33_grp, pwm34_grp, pwm35_grp, pwm36_grp, i2c0_grp,
+                  i2c1_grp, i2c2_grp, i2c3_grp, i2c4_grp, uart0_grp, uart1_grp,
+                  uart2_grp, uart3_grp, uart4_grp, uart5_grp, uart6_grp,
+                  uart7_grp, uart8_grp, uart9_grp, uart10_grp, uart11_grp,
+                  uart12_grp, uart13_grp, uart14_grp, uart15_grp, gpio0_grp,
+                  gpio1_grp, gpio2_grp, gpio3_grp, gpio4_grp, gpio5_grp,
+                  gpio6_grp, gpio7_grp, gpio8_grp, gpio9_grp, gpio10_grp,
+                  gpio11_grp, gpio12_grp, gpio13_grp, gpio14_grp, gpio15_grp,
+                  gpio16_grp, gpio17_grp, gpio18_grp, gpio19_grp, gpio20_grp,
+                  gpio21_grp, gpio22_grp, gpio23_grp, gpio24_grp, gpio25_grp,
+                  gpio26_grp, gpio27_grp, gpio28_grp, gpio29_grp, gpio30_grp,
+                  gpio31_grp, gpio32_grp, gpio33_grp, gpio34_grp, gpio35_grp,
+                  gpio36_grp, gpio37_grp, gpio38_grp, gpio39_grp, gpio40_grp,
+                  gpio41_grp, gpio42_grp, gpio43_grp, gpio44_grp, gpio45_grp,
+                  gpio46_grp, gpio47_grp, gpio48_grp, gpio49_grp, gpio50_grp,
+                  gpio51_grp, gpio52_grp, gpio53_grp, gpio54_grp, gpio55_grp,
+                  gpio56_grp, gpio57_grp, gpio58_grp, gpio59_grp, gpio60_grp,
+                  gpio61_grp, gpio62_grp, gpio63_grp, gpio64_grp, gpio65_grp,
+                  gpio66_grp, gpio67_grp, eth1_grp, i2s0_grp, i2s0_mclkin_grp,
+                  i2s1_grp, i2s1_mclkin_grp, spi0_grp
+
+- function:       An array of strings, each string containing the name of the
+                  pinmux functions. The following are the list of pinmux
+                  functions available:
+
+                  nand, spi, emmc, sdio, eth0, pwm0, pwm1, pwm2, pwm3, pwm4,
+                  pwm5, pwm6, pwm7, pwm8, pwm9, pwm10, pwm11, pwm12, pwm13,
+                  pwm14, pwm15, pwm16, pwm17, pwm18, pwm19, pwm20, pwm21, pwm22,
+                  pwm23, pwm24, pwm25, pwm26, pwm27, pwm28, pwm29, pwm30, pwm31,
+                  pwm32, pwm33, pwm34, pwm35, pwm36, i2c0, i2c1, i2c2, i2c3,
+                  i2c4, uart0, uart1, uart2, uart3, uart4, uart5, uart6, uart7,
+                  uart8, uart9, uart10, uart11, uart12, uart13, uart14, uart15,
+                  gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpio7, gpio8,
+                  gpio9, gpio10, gpio11, gpio12, gpio13, gpio14, gpio15, gpio16,
+                  gpio17, gpio18, gpio19, gpio20, gpio21, gpio22, gpio23,
+                  gpio24, gpio25, gpio26, gpio27, gpio28, gpio29, gpio30,
+                  gpio31, gpio32, gpio33, gpio34, gpio35, gpio36, gpio37,
+                  gpio38, gpio39, gpio40, gpio41, gpio42, gpio43, gpio44,
+                  gpio45, gpio46, gpio47, gpio48, gpio49, gpio50, gpio51,
+                  gpio52, gpio53, gpio54, gpio55, gpio56, gpio57, gpio58,
+                  gpio59, gpio60, gpio61, gpio62, gpio63, gpio64, gpio65,
+                  gpio66, gpio67, eth1, i2s0, i2s0_mclkin, i2s1, i2s1_mclkin,
+                  spi0
+
+Example:
+        pinctrl: pinctrl@50 {
+                compatible = "bitmain,bm1880-pinctrl";
+                reg = <0x50 0x4B0>;
+
+                pinctrl_uart0_default: uart0-default {
+                        pinmux {
+                                groups = "uart0_grp";
+                                function = "uart0";
+                        };
+                };
+        };
-- 
2.17.1

