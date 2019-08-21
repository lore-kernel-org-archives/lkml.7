Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E21C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDB9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566413084;
	bh=hCktM8GcuwpJvQ7AURIkhebu2j7uMWcei5qNOl1nD58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LKSe43rY+Lrt29tKjQn/+yxPZIqq7AzMoRHKmFG3GAQO1Spl7i31fqzdk6L/RhBoS
	 uvUs8hWGxgjwJBFbLNCO/FYQUmF3hscEzqQaLB03nJXPinSWnRb8RGBPkveRgvjCoh
	 S9IJ+E/x8+rdbjbC8oHTCJlWExKzpGykLKCY/XCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfHUSon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfHUSom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:44:42 -0400
Received: from localhost.localdomain (unknown [106.201.100.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47AC214DA;
        Wed, 21 Aug 2019 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566413080;
        bh=hCktM8GcuwpJvQ7AURIkhebu2j7uMWcei5qNOl1nD58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhwpjn0jk6Pcr/+9N51w3KcLyzaof8a7ATZBDH1Rx75plnIO2Mh6eqB2M0LDUBQCr
         OLyk89pvJDmdJFdPHtJlYv1ZMwr/+Eab+tKThaonskRpTx0uWG/FmsOIJnFNn7KpGh
         AtTzvDAfGxHydbLqZEYOTqywn+qrLw1DGkZc1qCE=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v4 8/8] arm64: dts: qcom: sm8150: Add apps shared nodes
Date:   Thu, 22 Aug 2019 00:12:39 +0530
Message-Id: <20190821184239.12364-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821184239.12364-1-vkoul@kernel.org>
References: <20190821184239.12364-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hwlock, pmu, smem, tcsr_mutex_regs, apss_shared mailbox, apps_rsc
including the rpmhcc child nodes to the SM8150 DTSI

Co-developed-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 63 ++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index c739b4647db9..8f23fcadecb8 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -144,12 +144,23 @@
 		};
 	};
 
+	tcsr_mutex: hwlock {
+		compatible = "qcom,tcsr-mutex";
+		syscon = <&tcsr_mutex_regs 0 0x1000>;
+		#hwlock-cells = <1>;
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the size */
 		reg = <0x0 0x80000000 0x0 0x0>;
 	};
 
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
@@ -266,6 +277,12 @@
 		};
 	};
 
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -306,6 +323,11 @@
 			};
 		};
 
+		tcsr_mutex_regs: syscon@1f40000 {
+			compatible = "syscon";
+			reg = <0x0 0x01f40000 0x0 0x40000>;
+		};
+
 		tlmm: pinctrl@3100000 {
 			compatible = "qcom,sm8150-pinctrl";
 			reg = <0x0 0x03100000 0x0 0x300000>,
@@ -321,6 +343,16 @@
 			#interrupt-cells = <2>;
 		};
 
+		aoss_qmp: power-controller@c300000 {
+			compatible = "qcom,sm8150-aoss-qmp";
+			reg = <0x0 0x0c300000 0x0 0x100000>;
+			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&apss_shared 0>;
+
+			#clock-cells = <0>;
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x0c440000 0x0 0x0001100>,
@@ -349,6 +381,12 @@
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		apss_shared: mailbox@17c00000 {
+			compatible = "qcom,sm8150-apss-shared";
+			reg = <0x0 0x17c00000 0x0 0x1000>;
+			#mbox-cells = <1>;
+		};
+
 		timer@17c20000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
@@ -407,6 +445,31 @@
 				status = "disabled";
 			};
 		};
+
+		apps_rsc: rsc@18200000 {
+			label = "apps_rsc";
+			compatible = "qcom,rpmh-rsc";
+			reg = <0x0 0x18200000 0x0 0x10000>,
+			      <0x0 0x18210000 0x0 0x10000>,
+			      <0x0 0x18220000 0x0 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS  2>,
+					  <SLEEP_TCS   1>,
+					  <WAKE_TCS    1>,
+					  <CONTROL_TCS 0>;
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,sm8150-rpmh-clk";
+				#clock-cells = <1>;
+				clock-names = "xo";
+				clocks = <&xo_board>;
+			};
+		};
 	};
 
 	timer {
-- 
2.20.1

