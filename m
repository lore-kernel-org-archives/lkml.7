Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69307C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4054E222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qJlSI+5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgACISd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:18:33 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5058 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbgACIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:18:29 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0ef8c50000>; Fri, 03 Jan 2020 00:18:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 00:18:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 00:18:28 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 08:18:28 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 08:18:28 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.118]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0ef8d10001>; Fri, 03 Jan 2020 00:18:27 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v5 4/5] arm64: tegra: Add XUSB and pad controller on Tegra194
Date:   Fri, 3 Jan 2020 16:18:13 +0800
Message-ID: <20200103081814.9848-5-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103081814.9848-1-jckuo@nvidia.com>
References: <20200103081814.9848-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578039493; bh=nmyzhD/f6mjDJQHt5dzAuBpxUM7e/MZRpBL0Z2t3sWI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=qJlSI+5WOGjDPcMrpv9cSo93dAHvLbYSOhLKRoaXFKjQ9r1B0kiPlwcO4rRXhCsZ/
         7QQHoMI1NFkxT4AZCqDgm+Qrndb4yC4Ci9RIjTHJgEX3hNqVzolUSkSg75a5fsafsD
         +FLxkvQ1eeN8gnoDWowU0svWHotCrm9ijege8BcSRyz6o9DIGV9J/OHRo7ZzoMf/Vc
         donuv2a8fISR3MAyS292TAIMpPGnhaIOwF7HFmBGmVOjJztci8TZ7e66T2RKgnxciT
         triUIpcTgaNWM3RvIVpYwpUZiP7fjGGedlFlTdnxqR4I6GQ5lznjln1UWsw+ayIAbr
         uUsJp0EksJA6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the XUSB pad and XUSB controllers on Tegra194.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
Changes in v5: none
Changes in v4: none
Changes in v3: none
Changes in v2:
 - renamed xhci@3610000 with usb@3610000
 - moved padctl@3520000 and usb@3610000 inside /cbb
 - cleaned up "clocks" property of usb@3610000 node
 - added blanks lines to visually separate blocks

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 139 +++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 11220d97adb8..495f692e6a0b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -488,6 +488,145 @@
 			status = "disabled";
 		};
 
+		xusb_padctl: padctl@3520000 {
+			compatible = "nvidia,tegra194-xusb-padctl";
+			reg = <0x03520000 0x1000>,
+			      <0x03540000 0x1000>;
+			reg-names = "padctl", "ao";
+
+			resets = <&bpmp TEGRA194_RESET_XUSB_PADCTL>;
+			reset-names = "padctl";
+
+			status = "disabled";
+
+			pads {
+				usb2 {
+					clocks = <&bpmp TEGRA194_CLK_USB2_TRK>;
+					clock-names = "trk";
+
+					lanes {
+						usb2-0 {
+							nvidia,function = "xusb";
+							status = "disabled";
+							#phy-cells = <0>;
+						};
+
+						usb2-1 {
+							nvidia,function = "xusb";
+							status = "disabled";
+							#phy-cells = <0>;
+						};
+
+						usb2-2 {
+							nvidia,function = "xusb";
+							status = "disabled";
+							#phy-cells = <0>;
+						};
+
+						usb2-3 {
+							nvidia,function = "xusb";
+							status = "disabled";
+							#phy-cells = <0>;
+						};
+					};
+				};
+
+				usb3 {
+					lanes {
+						usb3-0 {
+							nvidia,function = "xusb";
+							status = "disabled";
+							#phy-cells = <0>;
+						};
+
+						usb3-1 {
+							nvidia,function = "xusb";
+							status = "disabled";
+							#phy-cells = <0>;
+						};
+
+						usb3-2 {
+							nvidia,function = "xusb";
+							status = "disabled";
+							#phy-cells = <0>;
+						};
+
+						usb3-3 {
+							nvidia,function = "xusb";
+							status = "disabled";
+							#phy-cells = <0>;
+						};
+					};
+				};
+			};
+
+			ports {
+				usb2-0 {
+					status = "disabled";
+				};
+
+				usb2-1 {
+					status = "disabled";
+				};
+
+				usb2-2 {
+					status = "disabled";
+				};
+
+				usb2-3 {
+					status = "disabled";
+				};
+
+				usb3-0 {
+					status = "disabled";
+				};
+
+				usb3-1 {
+					status = "disabled";
+				};
+
+				usb3-2 {
+					status = "disabled";
+				};
+
+				usb3-3 {
+					status = "disabled";
+				};
+			};
+		};
+
+		usb@3610000 {
+			compatible = "nvidia,tegra194-xusb";
+			reg = <0x03610000 0x40000>,
+			      < 0x03600000 0x10000>;
+			reg-names = "hcd", "fpci";
+
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&bpmp TEGRA194_CLK_XUSB_CORE_HOST>,
+				 <&bpmp TEGRA194_CLK_XUSB_FALCON>,
+				 <&bpmp TEGRA194_CLK_XUSB_CORE_SS>,
+				 <&bpmp TEGRA194_CLK_XUSB_SS>,
+				 <&bpmp TEGRA194_CLK_CLK_M>,
+				 <&bpmp TEGRA194_CLK_XUSB_FS>,
+				 <&bpmp TEGRA194_CLK_UTMIPLL>,
+				 <&bpmp TEGRA194_CLK_CLK_M>,
+				 <&bpmp TEGRA194_CLK_PLLE>;
+			clock-names = "xusb_host", "xusb_falcon_src",
+				      "xusb_ss", "xusb_ss_src", "xusb_hs_src",
+				      "xusb_fs_src", "pll_u_480m", "clk_m",
+				      "pll_e";
+
+			power-domains = <&bpmp TEGRA194_POWER_DOMAIN_XUSBC>,
+					<&bpmp TEGRA194_POWER_DOMAIN_XUSBA>;
+			power-domain-names = "xusb_host", "xusb_ss";
+
+			nvidia,xusb-padctl = <&xusb_padctl>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@3881000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.17.1

