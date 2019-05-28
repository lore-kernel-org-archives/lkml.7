Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CC9C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911332133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 04:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfE1E4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 00:56:04 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:44462 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfE1E4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 00:56:04 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 May 2019 00:56:02 EDT
Received: from jay.xu?rock-chips.com (unknown [192.168.167.229])
        by regular1.263xmail.com (Postfix) with ESMTP id 09B0F907;
        Tue, 28 May 2019 12:48:57 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P6627T140475876996864S1559018932287865_;
        Tue, 28 May 2019 12:48:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dc6bc3b2d626c351f61daca14b30d2eb>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: xjq@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     jay.xu@rock-chips.com, heiko@sntech.de, mark.rutland@arm.com,
        robh+dt@kernel.org
Cc:     zhangzj@rock-chips.com, manivannan.sadhasivam@linaro.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: rockchip: add core dtsi file for RK3399Pro SoCs
Date:   Tue, 28 May 2019 12:48:50 +0800
Message-Id: <20190528044850.23703-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds core dtsi file for Rockchip RK3399Pro SoCs,
include rk3399.dtsi. Also enable these nodes:
- dfi/dmc for ddr devfreq
- pcie/pcie_phy
- sdhci/sdio/emmc/sdmmc

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399pro.dtsi | 111 ++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
new file mode 100644
index 000000000000..62f67f857c45
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd.
+
+#include "rk3399.dtsi"
+
+/ {
+	compatible = "rockchip,rk3399pro";
+
+	xin32k: xin32k {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		#clock-cells = <0>;
+	};
+};
+
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+	center-supply = <&vdd_log>;
+	upthreshold = <40>;
+	downdifferential = <20>;
+	system-status-freq = <
+		/*system status         freq(KHz)*/
+		SYS_STATUS_NORMAL       800000
+		SYS_STATUS_REBOOT       528000
+		SYS_STATUS_SUSPEND      200000
+		SYS_STATUS_VIDEO_1080P  200000
+		SYS_STATUS_VIDEO_4K     600000
+		SYS_STATUS_VIDEO_4K_10B 800000
+		SYS_STATUS_PERFORMANCE  800000
+		SYS_STATUS_BOOST        400000
+		SYS_STATUS_DUALVIEW     600000
+		SYS_STATUS_ISP          600000
+	>;
+	vop-pn-msch-readlatency = <
+	/* plane_number  readlatency */
+		0	0
+		4	0x20
+	>;
+	vop-bw-dmc-freq = <
+	/* min_bw(MB/s) max_bw(MB/s) freq(KHz) */
+		0       762      200000
+		763     1893     400000
+		1894    3012     528000
+		3013    99999    800000
+	>;
+	auto-min-freq = <200000>;
+};
+
+&emmc_phy {
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
+&pcie0 {
+	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
+	num-lanes = <4>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_clkreqn_cpm>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	supports-emmc;
+	non-removable;
+	keep-power-in-suspend;
+	mmc-hs400-enhanced-strobe;
+	status = "okay";
+};
+
+&sdio0 {
+	clock-frequency = <150000000>;
+	clock-freq-min-max = <200000 150000000>;
+	supports-sdio;
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&sdmmc {
+	clock-frequency = <150000000>;
+	clock-freq-min-max = <400000 150000000>;
+	supports-sd;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	num-slots = <1>;
+	vqmmc-supply = <&vccio_sd>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	status = "okay";
+};
-- 
2.17.1



