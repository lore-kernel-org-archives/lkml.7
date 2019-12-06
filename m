Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF2C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C422245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kqCDz0c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfLFKwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:52:25 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19290 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfLFKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:52:20 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dea32df0000>; Fri, 06 Dec 2019 02:52:15 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 06 Dec 2019 02:52:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 06 Dec 2019 02:52:19 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 10:52:19 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 10:52:19 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dea32e00000>; Fri, 06 Dec 2019 02:52:18 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [PATCH 15/18] arm64: tegra: Add xudc node for Tegra210
Date:   Fri, 6 Dec 2019 16:20:18 +0530
Message-ID: <1575629421-7039-16-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
References: <1575629421-7039-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575629535; bh=k1hERykyDGeY+BPAlSv53u4qAur4S4wkbdwb+KrEKng=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kqCDz0c2lR5hXk/4hf68i58QneQ4OciN6r34HdiykKSapWMJlcKHrOfguMVetQAlV
         6+AyZxSnQvcHU/ABVozQerZPGIufClDZ9H7C2aTAMGxVC9dGP1opXJgcxMfF+jZWi8
         IYkny7xeFFR2hb6A1Xy9o0Awblj8s8PnRfjFPIWY6zWeJvc4DvFr5VrJLRZJTB0jHU
         /I5jrOatHEC8aSHOAwGWm6aDQMEmclvgRYhEceoi9s1bM+Crg0EwZJGqMNZoY9q2SN
         pylibx4Cci7RGByvcggBNKBH2rjDpxFogwEWGH4LVBHeISlRVqklbc0jLH5BRzNTvX
         nSbFVfTe+6DpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 has one XUSB device mode controller, which can be operated
HS and SS modes. Add DT entry for XUSB device mode controller.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 48c6325..023f4c3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1207,6 +1207,25 @@
 		status = "disabled";
 	};
 
+	usb@700d0000 {
+		compatible = "nvidia,tegra210-xudc";
+		reg = <0x0 0x700d0000 0x0 0x8000>,
+		      <0x0 0x700d8000 0x0 0x1000>,
+		      <0x0 0x700d9000 0x0 0x1000>;
+		reg-names = "base", "fpci", "ipfs";
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA210_CLK_XUSB_DEV>,
+			 <&tegra_car TEGRA210_CLK_XUSB_SS>,
+			 <&tegra_car TEGRA210_CLK_XUSB_SSP_SRC>,
+			 <&tegra_car TEGRA210_CLK_XUSB_HS_SRC>,
+			 <&tegra_car TEGRA210_CLK_XUSB_FS_SRC>;
+		clock-names = "dev", "ss", "ss_src", "hs_src", "fs_src";
+		power-domains = <&pd_xusbdev>, <&pd_xusbss>;
+		power-domain-names = "dev", "ss";
+		nvidia,xusb-padctl = <&padctl>;
+		status = "disabled";
+	};
+
 	mipi: mipi@700e3000 {
 		compatible = "nvidia,tegra210-mipi";
 		reg = <0x0 0x700e3000 0x0 0x100>;
-- 
2.7.4

