Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EEEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F1A20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfCYRhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:37:35 -0400
Received: from ns.iliad.fr ([212.27.33.1]:52534 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729946AbfCYRhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:37:33 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3C2CC208E6;
        Mon, 25 Mar 2019 18:37:31 +0100 (CET)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 22D0120814;
        Mon, 25 Mar 2019 18:37:31 +0100 (CET)
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham <kishon@ti.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] arm64: dts: qcom: msm8998: Add PCIe PHY node
Message-ID: <cd3633a4-1781-0998-794d-d609daa9a89b@free.fr>
Date:   Mon, 25 Mar 2019 18:37:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Mar 25 18:37:31 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSM8998 PCIe QMP PHY DT node.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f9a922fdae75..8344ed1bf08d 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -606,6 +606,45 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		phy@1c06000 {
+			compatible = "qcom,msm8998-qmp-pcie-phy";
+			reg = <0x01c06000 0x18c>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clock-names =
+				"aux",
+				"cfg_ahb",
+				"ref";
+			clocks =
+				<&gcc GCC_PCIE_PHY_AUX_CLK>,
+				<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_CLKREF_CLK>;
+
+			reset-names =
+				"phy",
+				"common",
+				"cfg";
+			resets =
+				<&gcc GCC_PCIE_PHY_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_BCR>,
+				<&gcc GCC_PCIE_PHY_NOCSR_COM_PHY_BCR>;
+
+			vdda-phy-supply = <&vreg_l1a_0p875>;
+			vdda-pll-supply = <&vreg_l2a_1p2>;
+
+			pciephy: lane@1c06800 {
+				reg = <0x01c06200 0x128>, <0x01c06400 0x1fc>, <0x01c06800 0x20c>;
+				#phy-cells = <0>;
+
+				clock-names = "pipe0";
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-output-names = "pcie_0_pipe_clk_src";
+				#clock-cells = <0>;
+			};
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x1f40000 0x20000>;
-- 
2.17.1
