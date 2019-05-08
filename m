Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3816C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20F1214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 22:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdT8BY5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfEHWnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 18:43:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39701 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfEHWnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 18:43:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so104329plm.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZRWOAg/RyHnGg26N15yptA5VgOFfFjkzmzqD1kcfUOw=;
        b=RdT8BY5t8wPzm+4po1DJeApnXg3skW0a2CPSwwA/bsFs8Vj4+pFwxByzwZjW8sK8wN
         rA4i0GwqqgOFGvf/Tz+SyKfKVLveGxi12/drxfs0A45/+geWHyUP4RbbvKmuRV75YOS6
         +xnR4i1S5iR6FdROsAr57ggWtH4GqlCQudDQdlbJ3qbZFrwYNv4QPqXQtmNitRI4r6tT
         N09mpV+sfgE8URu8yOsw8V/Zd3nOJajqkvrO53+iaFDldnJV2Fic3nSQzmZKxwqGFYCX
         pM6+qFODqdiVAew5IGuCBcRvRyHOXhPZAK6SnydWxsnMiSXCOBUf9TMxS0SWKOPryHb7
         3d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZRWOAg/RyHnGg26N15yptA5VgOFfFjkzmzqD1kcfUOw=;
        b=hZmdf7gOVlRk3Br0sHgjzhtoQj3LbsKxpP5gGe/3POcQUUvCVMZHy1nvCzkZCTzFf6
         Pf0AX1IWI/Q/n15frlnEPqp0s7M5cFDi7aGD5Meq3XiKvhV/CzTchBVnVs9gxG0rdQhc
         GWnX8BdTZnXTnhf4ssfxSpfUd27q+tjUd+D12Rhs+XIDLui2KjXFVYMx0DT1sCFG3ZvI
         9CtdFJwj09DqMqyu3ehucW76kVufY6wEE1dXt66sUV7scHTg9AF9Ey3mjx/lK+F85uaX
         zFAR5HoUkozFKy4buohb1FzKY8p9erxTUkB3zneKtfjUB05fMaiXqB8/3Rtv6BvuYYwW
         F++g==
X-Gm-Message-State: APjAAAW/IMdfab5cSAAOXeTIorarea5Qax8SP/BIlDPJObQzEzEJurw5
        e98H7NzQ56jDSU1HefODAoxcaQ==
X-Google-Smtp-Source: APXvYqzp0faxVfN4AREXFDyjq/oRrZq5pxi5rj2y4qzUEN/mC7d+4AQVN2DyqyI6hlzo4Qqwb2cyoA==
X-Received: by 2002:a17:902:7294:: with SMTP id d20mr406356pll.276.1557355395687;
        Wed, 08 May 2019 15:43:15 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 25sm320494pfo.145.2019.05.08.15.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 15:43:14 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] arm64: dts: qcom: qcs404: Add PCIe related nodes
Date:   Wed,  8 May 2019 15:43:08 -0700
Message-Id: <20190508224309.5744-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190508224309.5744-1-bjorn.andersson@linaro.org>
References: <20190508224309.5744-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QCS404 has a PCIe2 PHY and a Qualcomm PCIe controller, define these
to for the platform.

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Split single patch, no functional change

 arch/arm64/boot/dts/qcom/qcs404.dtsi | 65 ++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 65a2cbeb28be..f97e9c96b7f7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -412,6 +412,21 @@
 			#interrupt-cells = <4>;
 		};
 
+		pcie_phy: phy@7786000 {
+			compatible = "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy";
+			reg = <0x07786000 0xb8>;
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+			resets = <&gcc GCC_PCIEPHY_0_PHY_BCR>,
+				 <&gcc GCC_PCIE_0_PIPE_ARES>;
+			reset-names = "phy", "pipe";
+
+			clock-output-names = "pcie_0_pipe_clk";
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
 		sdcc1: sdcc@7804000 {
 			compatible = "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
@@ -797,6 +812,56 @@
 				status = "disabled";
 			};
 		};
+
+		pcie: pci@10000000 {
+			compatible = "qcom,pcie-qcs404", "snps,dw-pcie";
+			reg =  <0x10000000 0xf1d>,
+			       <0x10000f20 0xa8>,
+			       <0x07780000 0x2000>,
+			       <0x10001000 0x2000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0 0          0x10003000 0 0x00010000>, /* I/O */
+				 <0x82000000 0 0x10013000 0x10013000 0 0x007ed000>; /* memory */
+
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+			clock-names = "iface", "aux", "master_bus", "slave_bus";
+
+			resets = <&gcc GCC_PCIE_0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE_0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE_0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE_0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE_0_BCR>,
+				 <&gcc GCC_PCIE_0_AHB_ARES>;
+			reset-names = "axi_m",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "pipe_sticky",
+				      "pwr",
+				      "ahb";
+
+			phys = <&pcie_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.18.0

