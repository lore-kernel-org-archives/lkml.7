Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1F9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08305206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="K6EBvzH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfFMPhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:37:00 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16433 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfFMKQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:16:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d02227e0000>; Thu, 13 Jun 2019 03:16:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 03:16:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 03:16:30 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 10:16:30 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 10:16:30 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 13 Jun 2019 10:16:30 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d02227c0000>; Thu, 13 Jun 2019 03:16:30 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v4 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
Date:   Thu, 13 Jun 2019 15:46:11 +0530
Message-ID: <1560420972-22350-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560420990; bh=9c7yqiehVPBF0gU8twCaup2E2H4w3JuhvGV1X2GVlCU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=K6EBvzH+bvA2GdIjtkVvyMLDKjKUQGlru5RmPCgeEfWCT5mxr29UDkhnXkCBmBedB
         4Rqsa4Y8mcbMi7/rRw3W3om1Wv1OsFQy2QEmCMm69NF6GOBzf3uvBaiAR8zvFCuZ4H
         Xm8n9YBkN0q0Pfr0QNpXKm+NuyY3b2s3gLpKXzVrDEu8d6IbU8kAlgNffhbzpe2rhO
         NQMl8fBcZsmgGMEPpppP8XhpQ2yunXoGnfBAzOlxjDH0+r6pMVYFME+3bZjnqIV6/u
         COuFKcjJSdD9yaN/DBU6Vzhto87wCTVrmyZFSQwISZG9kIq3KbjOqFb8rgslXfS8Sy
         N7xUJoCFtV5IA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for following devices on Tegra186 and Tegra194
 * ACONNECT
 * ADMA
 * AGIC

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 changes in current revision
  * node names changed for aconnect and agic
  * size value updated for ranges property in aconnect node

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 426ac0b..017fddd 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1295,4 +1295,71 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
+
+	aconnect {
+		compatible = "nvidia,tegra210-aconnect";
+		clocks = <&bpmp TEGRA186_CLK_APE>,
+			 <&bpmp TEGRA186_CLK_APB2APE>;
+		clock-names = "ape", "apb2ape";
+		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_AUD>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x02900000 0x0 0x02900000 0x1fffff>;
+		status = "disabled";
+
+		dma-controller@2930000 {
+			compatible = "nvidia,tegra186-adma";
+			reg = <0x02930000 0x50000>;
+			interrupt-parent = <&agic>;
+			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&bpmp TEGRA186_CLK_AHUB>;
+			clock-names = "d_audio";
+			status = "disabled";
+		};
+
+		agic: interrupt-controller@2a41000 {
+			compatible = "nvidia,tegra210-agic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x02a41000 0x1000>,
+			      <0x02a42000 0x2000>;
+			interrupts = <GIC_SPI 145
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&bpmp TEGRA186_CLK_APE>;
+			clock-names = "clk";
+			status = "disabled";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c77ca21..06608d8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1054,4 +1054,71 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
+
+	aconnect {
+		compatible = "nvidia,tegra210-aconnect";
+		clocks = <&bpmp TEGRA194_CLK_APE>,
+			 <&bpmp TEGRA194_CLK_APB2APE>;
+		clock-names = "ape", "apb2ape";
+		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_AUD>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x02900000 0x0 0x02900000 0x1fffff>;
+		status = "disabled";
+
+		dma-controller@2930000 {
+			compatible = "nvidia,tegra186-adma";
+			reg = <0x02930000 0x50000>;
+			interrupt-parent = <&agic>;
+			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			clocks = <&bpmp TEGRA194_CLK_AHUB>;
+			clock-names = "d_audio";
+			status = "disabled";
+		};
+
+		agic: interrupt-controller@2a41000 {
+			compatible = "nvidia,tegra210-agic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x02a41000 0x1000>,
+			      <0x02a42000 0x2000>;
+			interrupts = <GIC_SPI 145
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&bpmp TEGRA194_CLK_APE>;
+			clock-names = "clk";
+			status = "disabled";
+		};
+	};
 };
-- 
2.7.4

