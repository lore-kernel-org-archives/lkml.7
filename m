Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B639AC76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99996217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 15:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390858AbfGRPNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 11:13:55 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37022 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbfGRPNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 11:13:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 705442000AC;
        Thu, 18 Jul 2019 17:13:51 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6004520011A;
        Thu, 18 Jul 2019 17:13:51 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E110205C7;
        Thu, 18 Jul 2019 17:13:50 +0200 (CEST)
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        daniel.baluta@nxp.com, shengjiu.wang@nxp.com, paul.olaru@nxp.com,
        aisheng.dong@nxp.com, leonard.crestez@nxp.com, anson.huang@nxp.com,
        peng.fan@nxp.com, Frank.Li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
Subject: [PATCH 2/3] arm64: dts: imx8qxp: Add DSP DT node
Date:   Thu, 18 Jul 2019 18:13:45 +0300
Message-Id: <20190718151346.3523-3-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718151346.3523-1-daniel.baluta@nxp.com>
References: <20190718151346.3523-1-daniel.baluta@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This includes DSP reserved memory, ADMA DSP device and DSP MU
communication channels description.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  4 +++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 32 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index bfdada2db176..19468058e6ae 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -230,3 +230,7 @@
 		>;
 	};
 };
+
+&adma_dsp {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 05fa0b7f36bb..6a4efb1f0fa2 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -113,6 +113,17 @@
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dsp_reserved: dsp@92400000 {
+			reg = <0 0x92400000 0 0x2000000>;
+			no-map;
+		};
+	};
+
 	pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
@@ -204,6 +215,27 @@
 			#clock-cells = <1>;
 		};
 
+		adma_dsp: dsp@596e8000 {
+			compatible = "fsl,imx8qxp-dsp";
+			reg = <0x596e8000 0x88000>;
+			clocks = <&adma_lpcg IMX_ADMA_LPCG_DSP_IPG_CLK>,
+				<&adma_lpcg IMX_ADMA_LPCG_OCRAM_IPG_CLK>,
+				<&adma_lpcg IMX_ADMA_LPCG_DSP_CORE_CLK>;
+			clock-names = "ipg", "ocram", "core";
+			power-domains = <&pd IMX_SC_R_MU_13A>,
+				<&pd IMX_SC_R_MU_13B>,
+				<&pd IMX_SC_R_DSP>,
+				<&pd IMX_SC_R_DSP_RAM>;
+			mbox-names = "txdb0", "txdb1",
+				"rxdb0", "rxdb1";
+			mboxes = <&lsio_mu13 2 0>,
+				<&lsio_mu13 2 1>,
+				<&lsio_mu13 3 0>,
+				<&lsio_mu13 3 1>;
+			reserved-region = <&dsp_reserved>;
+			status = "disabled";
+		};
+
 		adma_lpuart0: serial@5a060000 {
 			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 			reg = <0x5a060000 0x1000>;
-- 
2.17.1

