Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C798CC10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969D7206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfCKDsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 23:48:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24875 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726976AbfCKDsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 23:48:15 -0400
X-UUID: 7effe1dd8a0144d997111e23c79637b3-20190311
X-UUID: 7effe1dd8a0144d997111e23c79637b3-20190311
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 166520814; Mon, 11 Mar 2019 11:48:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Mar 2019 11:48:08 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Mar 2019 11:48:08 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH v2 7/9] arm64: dts: mt6358: add PMIC MT6358 related nodes
Date:   Mon, 11 Mar 2019 11:46:29 +0800
Message-ID: <1552275991-34648-8-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add PMIC MT6358 related nodes which is for mt8183 platform

Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 318 +++++++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6358.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
new file mode 100644
index 0000000..a7c02ab
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+&pwrap {
+	pmic: mt6358 {
+		compatible = "mediatek,mt6358";
+		interrupt-controller;
+		interrupt-parent = <&pio>;
+		interrupts = <182 IRQ_TYPE_LEVEL_HIGH 190 0>;
+		#interrupt-cells = <2>;
+
+		mt6358codec: mt6358codec {
+			compatible = "mediatek,mt6358-sound";
+		};
+
+		mt6358regulator: mt6358regulator {
+			compatible = "mediatek,mt6358-regulator";
+
+			mt6358_vdram1_reg: buck_vdram1 {
+				regulator-compatible = "buck_vdram1";
+				regulator-name = "vdram1";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2087500>;
+				regulator-ramp-delay = <12500>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+				regulator-allowed-modes = <0 1>;
+			};
+			mt6358_vcore_reg: buck_vcore {
+				regulator-name = "vcore";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+				regulator-allowed-modes = <0 1>;
+			};
+			mt6358_vpa_reg: buck_vpa {
+				regulator-name = "vpa";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3650000>;
+				regulator-ramp-delay = <50000>;
+				regulator-enable-ramp-delay = <250>;
+				regulator-allowed-modes = <0 1>;
+			};
+			mt6358_vproc11_reg: buck_vproc11 {
+				regulator-name = "vproc11";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+				regulator-allowed-modes = <0 1>;
+			};
+			mt6358_vproc12_reg: buck_vproc12 {
+				regulator-name = "vproc12";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-always-on;
+				regulator-allowed-modes = <0 1>;
+			};
+			mt6358_vgpu_reg: buck_vgpu {
+				regulator-name = "vgpu";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <200>;
+				regulator-allowed-modes = <0 1>;
+			};
+			mt6358_vs2_reg: buck_vs2 {
+				regulator-name = "vs2";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2087500>;
+				regulator-ramp-delay = <12500>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+			mt6358_vmodem_reg: buck_vmodem {
+				regulator-name = "vmodem";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <900>;
+				regulator-always-on;
+				regulator-allowed-modes = <0 1>;
+			};
+			mt6358_vs1_reg: buck_vs1 {
+				regulator-name = "vs1";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <2587500>;
+				regulator-ramp-delay = <12500>;
+				regulator-enable-ramp-delay = <0>;
+				regulator-always-on;
+			};
+			mt6358_vdram2_reg: ldo_vdram2 {
+				regulator-name = "vdram2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <3300>;
+			};
+			mt6358_vsim1_reg: ldo_vsim1 {
+				regulator-name = "vsim1";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <540>;
+			};
+			mt6358_vibr_reg: ldo_vibr {
+				regulator-name = "vibr";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+			mt6358_vrf12_reg: ldo_vrf12 {
+				compatible = "regulator-fixed";
+				regulator-name = "vrf12";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+			mt6358_vio18_reg: ldo_vio18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vio18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <2700>;
+				regulator-always-on;
+			};
+			mt6358_vusb_reg: ldo_vusb {
+				regulator-name = "vusb";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+			mt6358_vcamio_reg: ldo_vcamio {
+				compatible = "regulator-fixed";
+				regulator-name = "vcamio";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vcamd_reg: ldo_vcamd {
+				regulator-name = "vcamd";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vcn18_reg: ldo_vcn18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vcn18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vfe28_reg: ldo_vfe28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vfe28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vsram_proc11_reg: ldo_vsram_proc11 {
+				regulator-name = "vsram_proc11";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6358_vcn28_reg: ldo_vcn28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vcn28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vsram_others_reg: ldo_vsram_others {
+				regulator-name = "vsram_others";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6358_vsram_gpu_reg: ldo_vsram_gpu {
+				regulator-name = "vsram_gpu";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <240>;
+			};
+			mt6358_vxo22_reg: ldo_vxo22 {
+				compatible = "regulator-fixed";
+				regulator-name = "vxo22";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-enable-ramp-delay = <120>;
+				regulator-always-on;
+			};
+			mt6358_vefuse_reg: ldo_vefuse {
+				regulator-name = "vefuse";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1900000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vaux18_reg: ldo_vaux18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vaux18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vmch_reg: ldo_vmch {
+				regulator-name = "vmch";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+			mt6358_vbif28_reg: ldo_vbif28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vbif28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vsram_proc12_reg: ldo_vsram_proc12 {
+				regulator-name = "vsram_proc12";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1293750>;
+				regulator-ramp-delay = <6250>;
+				regulator-enable-ramp-delay = <240>;
+				regulator-always-on;
+			};
+			mt6358_vcama1_reg: ldo_vcama1 {
+				regulator-name = "vcama1";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vemc_reg: ldo_vemc {
+				regulator-name = "vemc";
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <60>;
+				regulator-always-on;
+			};
+			mt6358_vio28_reg: ldo_vio28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vio28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_va12_reg: ldo_va12 {
+				compatible = "regulator-fixed";
+				regulator-name = "va12";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-enable-ramp-delay = <270>;
+				regulator-always-on;
+			};
+			mt6358_vrf18_reg: ldo_vrf18 {
+				compatible = "regulator-fixed";
+				regulator-name = "vrf18";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-enable-ramp-delay = <120>;
+			};
+			mt6358_vcn33_bt_reg: ldo_vcn33_bt {
+				regulator-name = "vcn33_bt";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vcn33_wifi_reg: ldo_vcn33_wifi {
+				regulator-name = "vcn33_wifi";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vcama2_reg: ldo_vcama2 {
+				regulator-name = "vcama2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vmc_reg: ldo_vmc {
+				regulator-name = "vmc";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-enable-ramp-delay = <60>;
+			};
+			mt6358_vldo28_reg: ldo_vldo28 {
+				regulator-name = "vldo28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vaud28_reg: ldo_vaud28 {
+				compatible = "regulator-fixed";
+				regulator-name = "vaud28";
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-enable-ramp-delay = <270>;
+			};
+			mt6358_vsim2_reg: ldo_vsim2 {
+				regulator-name = "vsim2";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <3100000>;
+				regulator-enable-ramp-delay = <540>;
+			};
+		};
+	};
+};
-- 
1.9.1

