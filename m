Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FECEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC5920717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fsoyqQLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLRJSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:18:03 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19209 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLRJSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:18:01 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9eebe0000>; Wed, 18 Dec 2019 01:17:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 01:18:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 18 Dec 2019 01:18:00 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:17:59 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Dec 2019 09:17:59 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df9eec40000>; Wed, 18 Dec 2019 01:17:59 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V2 17/18] arm64: tegra: Add xudc node for Tegra186
Date:   Wed, 18 Dec 2019 14:46:30 +0530
Message-ID: <1576660591-10383-18-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576660670; bh=u56kuKvD0QC19uezFlNqhgQEVRQZqZ66T/03zSFec1s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=fsoyqQLB8Zv0SwUlI/fftG10wxt38iaEM5zIlimmBkO37UrXZgoe2CxvnCvjsvPYC
         K8vEU5gRK+ec7y+RaYnxdlrpgGdDJMC9p2lXbJyMQFcYkEheRx6duSjQzQIX8MgnZ5
         DU4oeKp26eXfbHczgRua3RlXung9BDKKAFOiQBduWmEGlpho3/1dkFmb6L1pEEF0Af
         AwCZtFXNMHvzxa1U2rTrWTcIQBGJzMo5NFCkL+btWxaTQXKzCCBR0TDobuV/8k+HvY
         Ec0RH8vHZfNKsvZv8QRyKAgWQkf3NsKmobUycmkEkF3KyQowNYj+6VYamLj0itUxmV
         ns3c1VXoTBitQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 has one XUSB device mode controller, which can be operated
HS and SS modes. Add DT entry for XUSB device mode controller.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
V2:
 - No changes in this version
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 7893d78..6da9d09 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -554,6 +554,25 @@
 		#size-cells = <0>;
 	};
 
+	usb@3550000 {
+		compatible = "nvidia,tegra186-xudc";
+		reg = <0x0 0x03550000 0x0 0x8000>,
+		      <0x0 0x03558000 0x0 0x1000>;
+		reg-names = "base", "fpci";
+		interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&bpmp TEGRA186_CLK_XUSB_CORE_DEV>,
+			 <&bpmp TEGRA186_CLK_XUSB_SS>,
+			 <&bpmp TEGRA186_CLK_XUSB_CORE_SS>,
+			 <&bpmp TEGRA186_CLK_XUSB_FS>;
+		clock-names = "dev", "ss", "ss_src", "fs_src";
+		iommus = <&smmu TEGRA186_SID_XUSB_DEV>;
+		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_XUSBB>,
+				<&bpmp TEGRA186_POWER_DOMAIN_XUSBA>;
+		power-domain-names = "dev", "ss";
+		nvidia,xusb-padctl = <&padctl>;
+		status = "disabled";
+	};
+
 	fuse@3820000 {
 		compatible = "nvidia,tegra186-efuse";
 		reg = <0x0 0x03820000 0x0 0x10000>;
-- 
2.7.4

