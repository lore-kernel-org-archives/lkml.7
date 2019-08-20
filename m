Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FA6C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4DC22CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566283460;
	bh=mmQH2esYZ1N+wsWUb12A/fzu4sEoHA+QJHLpq/196p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bLIjBc82zvZP27BjWOxBN2TI/4CqM1T1ry+I9PDgcx4b6XZRBKqtksseedK0OPjoQ
	 6vF5cFvkMgBAMCkhfVaL2YzgRXxjj4rid8FVqQ9xjZ52m7yEw4gnydSd9QqzcqIRIv
	 Gpm3HDMC97iOJO+XUhwUyG598sKo9LLKa5MPjQio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfHTGoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbfHTGoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:44:18 -0400
Received: from localhost.localdomain (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDD522CF8;
        Tue, 20 Aug 2019 06:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566283458;
        bh=mmQH2esYZ1N+wsWUb12A/fzu4sEoHA+QJHLpq/196p4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7vXzUK0oQ6lX56iwC3pw/cyQhsL6EoNhSqNnHlDhzoAglCmipXzhcHF6y93Tf70m
         0LWemwnPOb2sXmlRhTpLL3TxZQ15mH6g4V3PNKTzUEY7Dx6PI1Kf6rk3Lx83AOFXks
         /jjfhJancoaPC+zqVxmuvM/UvOmsQCLua86EKnOw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] arm64: dts: qcom: pm8150b: Add Base DTS file
Date:   Tue, 20 Aug 2019 12:12:11 +0530
Message-Id: <20190820064216.8629-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820064216.8629-1-vkoul@kernel.org>
References: <20190820064216.8629-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMIC pm8150b is a slave pmic and this adds base DTS file for pm8150b
with pon, adc, and gpio nodes

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 84 +++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8150b.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
new file mode 100644
index 000000000000..dfb71fb8c90a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: BSD-3-Clause
+// Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+// Copyright (c) 2019, Linaro Limited
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmic@2 {
+		compatible = "qcom,pm8150b", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		power-on@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x0800>;
+
+			status = "disabled";
+		};
+
+		adc@3100 {
+			compatible = "qcom,spmi-adc5";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+
+			status = "disabled";
+
+			ref-gnd@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			vref-1p25@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			die-temp@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+
+			chg-temp@9 {
+				reg = <ADC5_CHG_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "chg_temp";
+			};
+		};
+
+		pm8150b_gpios: gpio@c000 {
+			compatible = "qcom,pm8150b-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0x2 0xc0 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc1 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc2 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc3 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc4 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc5 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc6 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc7 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc8 0 IRQ_TYPE_NONE>,
+				     <0x2 0xc9 0 IRQ_TYPE_NONE>,
+				     <0x2 0xca 0 IRQ_TYPE_NONE>,
+				     <0x2 0xcb 0 IRQ_TYPE_NONE>;
+		};
+	};
+
+	pmic@3 {
+		compatible = "qcom,pm8150b", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.20.1

