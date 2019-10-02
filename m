Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6631DC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D13215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RCM8HZf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfJBIBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:01:24 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17310 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbfJBIBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:01:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d94594d0001>; Wed, 02 Oct 2019 01:01:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Oct 2019 01:01:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Oct 2019 01:01:17 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Oct
 2019 08:01:17 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Oct 2019 08:01:17 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.102]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d94594b0005>; Wed, 02 Oct 2019 01:01:17 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH 5/6] arm64: tegra: Add XUSB and pad controller on Tegra194
Date:   Wed, 2 Oct 2019 16:00:50 +0800
Message-ID: <20191002080051.11142-6-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002080051.11142-1-jckuo@nvidia.com>
References: <20191002080051.11142-1-jckuo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570003277; bh=o8bDxCf7vU577SjvijUEsK69snK9HzRW9IGnXhmXZHU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=RCM8HZf7t1Kx9gPUqCV+FevkEkUbvkQBE6BaJ/qNhMaZOe5jluOEg+HT6C0vkhrhu
         7SRyxylLwSiFERE5MUBLCCLC6E73Gs3YLPkqlKnxsZN3kym4eLe8Obdrj+cT1XUVMX
         3GFoqIUdp6Zk5OK3dFB5hnz+BT0ab/w8JECHaAa4/qzPRSv6Ks9O1VCbG2vdB+UZA5
         ak0ooj7U0X62EZHpHzPGQDiRdJBZR8B28wceFuXmngGRdVltrZpNvdBibUZ4Wx7G+q
         23amYZ/B/d1AB7GdbNyxzjahCuIbr0/74oes1DYbzKIFEQNuoX7MW03Ow+ws9pCLT8
         SCN1IMtLXSYFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the XUSB pad and XUSB controllers on Tegra194.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 130 +++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 3c0cf54f0aab..4d3371d3a407 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1599,4 +1599,134 @@
 		interrupt-parent = <&gic>;
 		always-on;
 	};
+
+	xusb_padctl: padctl@3520000 {
+		compatible = "nvidia,tegra194-xusb-padctl";
+		reg = <0x0 0x03520000 0x0 0x1000>,
+			<0x0 0x03540000 0x0 0x1000>;
+		reg-names = "padctl", "ao";
+
+		resets = <&bpmp TEGRA194_RESET_XUSB_PADCTL>;
+		reset-names = "padctl";
+
+		status = "disabled";
+
+		pads {
+			usb2 {
+				clocks = <&bpmp TEGRA194_CLK_USB2_TRK>;
+				clock-names = "trk";
+
+				lanes {
+					usb2-0 {
+						nvidia,function = "xusb";
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+					usb2-1 {
+						nvidia,function = "xusb";
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+					usb2-2 {
+						nvidia,function = "xusb";
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+					usb2-3 {
+						nvidia,function = "xusb";
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+				};
+			};
+			usb3 {
+				lanes {
+					usb3-0 {
+						nvidia,function = "xusb";
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+					usb3-1 {
+						nvidia,function = "xusb";
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+					usb3-2 {
+						nvidia,function = "xusb";
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+					usb3-3 {
+						nvidia,function = "xusb";
+						status = "disabled";
+						#phy-cells = <0>;
+					};
+				};
+			};
+		};
+
+		ports {
+			usb2-0 {
+				status = "disabled";
+			};
+			usb2-1 {
+				status = "disabled";
+			};
+			usb2-2 {
+				status = "disabled";
+			};
+			usb2-3 {
+				status = "disabled";
+			};
+			usb3-0 {
+				status = "disabled";
+			};
+			usb3-1 {
+				status = "disabled";
+			};
+			usb3-2 {
+				status = "disabled";
+			};
+			usb3-3 {
+				status = "disabled";
+			};
+		};
+	};
+
+	tegra_xhci: xhci@3610000 {
+		compatible = "nvidia,tegra194-xusb";
+		reg = <0x0 0x03610000 0x0 0x40000>,
+			<0x0 0x03600000 0x0 0x10000>;
+		reg-names = "hcd", "fpci";
+
+		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+
+		clocks = <&bpmp TEGRA194_CLK_XUSB_CORE_MUX>,
+			<&bpmp TEGRA194_CLK_XUSB_CORE_HOST>,
+			<&bpmp TEGRA194_CLK_XUSB_CORE_SS>,
+			<&bpmp TEGRA194_CLK_XUSB_FALCON>,
+			<&bpmp TEGRA194_CLK_XUSB_FALCON_HOST>,
+			<&bpmp TEGRA194_CLK_XUSB_FALCON_SS>,
+			<&bpmp TEGRA194_CLK_XUSB_FS>,
+			<&bpmp TEGRA194_CLK_XUSB_FS_HOST>,
+			<&bpmp TEGRA194_CLK_XUSB_SS>,
+			<&bpmp TEGRA194_CLK_XUSB_SS_SUPERSPEED>,
+			<&bpmp TEGRA194_CLK_UTMIPLL>,
+			<&bpmp TEGRA194_CLK_CLK_M>,
+			<&bpmp TEGRA194_CLK_PLLE>;
+		clock-names = "xusb_hs_src", "xusb_host",
+			"xusb_core_superspeed_clk", "xusb_falcon_src",
+			"xusb_falcon_host_clk", "xusb_falcon_superspeed_clk",
+			"xusb_fs_src", "xusb_fs_host_clk", "xusb_ss_src",
+			"xusb_ss", "pll_u_480m", "clk_m", "pll_e";
+
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_XUSBC>,
+				<&bpmp TEGRA194_POWER_DOMAIN_XUSBA>;
+		power-domain-names = "xusb_host", "xusb_ss";
+
+		nvidia,xusb-padctl = <&xusb_padctl>;
+		status = "disabled";
+	};
 };
-- 
2.17.1

