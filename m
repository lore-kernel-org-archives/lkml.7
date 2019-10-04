Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AF8C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297F5222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cIprtILG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfJDQ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:29:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14644 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbfJDQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:29:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9773690000>; Fri, 04 Oct 2019 09:29:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Oct 2019 09:29:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 04 Oct 2019 09:29:28 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 16:29:28 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Oct
 2019 16:29:28 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 4 Oct 2019 16:29:28 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.223]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d9773660000>; Fri, 04 Oct 2019 09:29:28 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v3 6/7] arm64: tegra: Add XUSB and pad controller on Tegra194
Date:   Sat, 5 Oct 2019 00:29:05 +0800
Message-ID: <20191004162906.4818-7-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004162906.4818-1-jckuo@nvidia.com>
References: <20191004162906.4818-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570206569; bh=JX8qhrz1+zKt2qJcgVcn5aN9RkoATiw8FgiV/Gtk4ZU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cIprtILGf3ZotoEhAzqEVd1oKrSBwM8IvL7XYoWESK2wmIIj/aQMrpsDxazULjURa
         +BdNKHjD6PQqZ2vUzWKswmpXeJxM8xmh9q5Ia07O+cscsUd9IPdMDIluSqeewi5Iac
         FCUGHebj3I3SP1xPDY//03NNDepAiR7pjEIAZTTtIGxmsCPlXRPmCGDX8bYNs+4Fh5
         wmUX10xPLSuy9AsKsWt3UNVncm0cp8mZFywNU+L3X6pCUBiQrySiSCgcAqPIs2iqs/
         XQ6GbHP8IsbadSanjVE8dokVmccwElQzZSnCJI3AcwJztA96SPx6jJagBy5DPRkApM
         NluKwoECaGffw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the XUSB pad and XUSB controllers on Tegra194.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
Changes in v3: none
Changes in v2:
 - renamed xhci@3610000 with usb@3610000
 - moved padctl@3520000 and usb@3610000 inside /cbb
 - cleaned up "clocks" property of usb@3610000 node
 - added blanks lines to visually separate blocks

 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 139 +++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 3c0cf54f0aab..3c7ea264bc1c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -487,6 +487,145 @@
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

