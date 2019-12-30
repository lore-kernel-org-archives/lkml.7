Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53553C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A35D2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kaoEejQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfL3LOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:14:37 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15600 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfL3LOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:14:34 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e09dbf10000>; Mon, 30 Dec 2019 03:13:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Dec 2019 03:14:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Dec 2019 03:14:33 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Dec
 2019 11:14:33 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 30 Dec 2019 11:14:33 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e09dc150001>; Mon, 30 Dec 2019 03:14:32 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V3 15/18] arm64: tegra: Add xudc node for Tegra210
Date:   Mon, 30 Dec 2019 16:39:52 +0530
Message-ID: <1577704195-2535-16-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577704433; bh=7ejUB1oGm62lPB7PGZiuW/Dwg0gEEajiRqoMrnsKVgY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kaoEejQ50wEmPF6KbfCbdz/6OId2DJrFfGL5tIPz3C+ONCx0ftWauEFia/hVpf56q
         uNozqhnfoPZVm7ZG73aJrq76fqaGdk4i/00suJgt6bkIoXySIHOGZzDX+cgrAHBftO
         /KeRQw2dqNpBYOdmWoIMIbWeEXFJ+TXQMR5Af+nR9753UpO5gHKHN4LjbdbhfVj/Fx
         cUhomf/MJJPR4MQaULoD2VlmJooxCPtD8OfCRc9suJNUIuneUKxoMj0dX0+vX8iRro
         0y8jbbht3N7RbiAuPyJ9RBmtyZYasnxe7BDAknVZMA2bswvP0gjN9VTpfnOmll+f1t
         C3CimMadPMoZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 has one XUSB device mode controller, which can be operated
HS and SS modes. Add DT entry for XUSB device mode controller.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2-V3:
 - Updated clocks and clock-names sequence as per change in bindings doc.
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 48c6325..dfce47b 100644
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
+			 <&tegra_car TEGRA210_CLK_XUSB_FS_SRC>,
+			 <&tegra_car TEGRA210_CLK_XUSB_HS_SRC>;
+		clock-names = "dev", "ss", "ss_src", "fs_src", "hs_src";
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

