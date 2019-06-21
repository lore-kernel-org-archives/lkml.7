Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FA6C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0452214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFUIoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:44:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24086 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726260AbfFUIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:44:22 -0400
X-UUID: df5a0797b6ec41d0a6de9dc38f569d99-20190621
X-UUID: df5a0797b6ec41d0a6de9dc38f569d99-20190621
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2013415344; Fri, 21 Jun 2019 16:43:58 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Jun 2019 16:43:56 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Jun 2019 16:43:56 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: soc: add mtk svs dt-bindings
Date:   Fri, 21 Jun 2019 16:43:47 +0800
Message-ID: <20190621084348.16834-2-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190621084348.16834-1-roger.lu@mediatek.com>
References: <20190621084348.16834-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F144FADBDB67B45ACF23EBA8D3C9D85094F7529EED67178D28B3EAFCBDDB50632000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the binding for enabling mtk svs on MediaTek SoC.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 .../devicetree/bindings/power/mtk-svs.txt     | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt

diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Documentation/devicetree/bindings/power/mtk-svs.txt
new file mode 100644
index 000000000000..6a71992ef162
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
@@ -0,0 +1,88 @@
+* Mediatek Smart Voltage Scaling (MTK SVS)
+
+This describes the device tree binding for the MTK SVS controller (bank)
+which helps provide the optimized CPU/GPU/CCI voltages. This device also
+needs thermal data to calculate thermal slope for accurately compensate
+the voltages when temperature change.
+
+Required properties:
+- compatible:
+  - "mediatek,mt8183-svs" : For MT8183 family of SoCs
+- reg: Address range of the MTK SVS controller.
+- interrupts: IRQ for the MTK SVS controller.
+- clocks, clock-names: Clocks needed for the svs controller. required
+                       clocks are:
+		       "main_clk": Main clock needed for register access
+- nvmem-cells: Phandle to the calibration data provided by a nvmem device.
+- nvmem-cell-names: Should be "svs-calibration-data" and "calibration-data"
+
+Subnodes:
+- svs_cpu_little: SVS bank device node of little CPU
+  compatible: "mediatek,mt8183-svs-cpu-little"
+  operating-points-v2: OPP table hooked by SVS little CPU bank.
+		       SVS will optimze this OPP table voltage part.
+  vcpu-little-supply: PMIC buck of little CPU
+- svs_cpu_big: SVS bank device node of big CPU
+  compatible: "mediatek,mt8183-svs-cpu-big"
+  operating-points-v2: OPP table hooked by SVS big CPU bank.
+		       SVS will optimze this OPP table voltage part.
+  vcpu-big-supply: PMIC buck of big CPU
+- svs_cci: SVS bank device node of CCI
+  compatible: "mediatek,mt8183-svs-cci"
+  operating-points-v2: OPP table hooked by SVS CCI bank.
+		       SVS will optimze this OPP table voltage part.
+  vcci-supply: PMIC buck of CCI
+- svs_gpu: SVS bank device node of GPU
+  compatible: "mediatek,mt8183-svs-gpu"
+  operating-points-v2: OPP table hooked by SVS GPU bank.
+		       SVS will optimze this OPP table voltage part.
+  vgpu-spply: PMIC buck of GPU
+
+Example:
+
+	svs: svs@1100b000 {
+		compatible = "mediatek,mt8183-svs";
+		reg = <0 0x1100b000 0 0x1000>;
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW 0>;
+		clocks = <&infracfg CLK_INFRA_THERM>;
+		clock-names = "main_clk";
+		nvmem-cells = <&svs_calibration>, <&thermal_calibration>;
+		nvmem-cell-names = "svs-calibration-data", "calibration-data";
+
+		svs_cpu_little: svs_cpu_little {
+			compatible = "mediatek,mt8183-svs-cpu-little";
+			operating-points-v2 = <&cluster0_opp>;
+		};
+
+		svs_cpu_big: svs_cpu_big {
+			compatible = "mediatek,mt8183-svs-cpu-big";
+			operating-points-v2 = <&cluster1_opp>;
+		};
+
+		svs_cci: svs_cci {
+			compatible = "mediatek,mt8183-svs-cci";
+			operating-points-v2 = <&cci_opp>;
+		};
+
+		svs_gpu: svs_gpu {
+			compatible = "mediatek,mt8183-svs-gpu";
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
+			operating-points-v2 = <&gpu_opp_table>;
+		};
+	};
+
+	&svs_cpu_little {
+		vcpu-little-supply = <&mt6358_vproc12_reg>;
+	};
+
+	&svs_cpu_big {
+		vcpu-big-supply = <&mt6358_vproc11_reg>;
+	};
+
+	&svs_cci {
+		vcci-supply = <&mt6358_vproc12_reg>;
+	};
+
+	&svs_gpu {
+		vgpu-spply = <&mt6358_vgpu_reg>;
+	};
-- 
2.18.0

