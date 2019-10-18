Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8099C222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="j7mHojFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442375AbfJRJjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:39:43 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16385 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442324AbfJRJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:39:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da988600000>; Fri, 18 Oct 2019 02:39:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 18 Oct 2019 02:39:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 18 Oct 2019 02:39:40 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Oct
 2019 09:39:39 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 18 Oct 2019 09:39:39 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.66.147]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da988580000>; Fri, 18 Oct 2019 02:39:39 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V11 08/11] arm64: tegra: Add xudc node for Tegra186
Date:   Fri, 18 Oct 2019 15:08:13 +0530
Message-ID: <1571391496-20834-9-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571391496-20834-1-git-send-email-nkristam@nvidia.com>
References: <1571391496-20834-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571391584; bh=w72BBQ6rZrWBjbV2UbDsA/SKmkqcjWtSQJI7Apq0E00=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=j7mHojFHkbD7rgi0C+QWcoEeGx1o0jsBNw2L/rbdpNFZy5CNwmZiCxOnziHXQEehm
         7jo+QC6ayKhX91rjTLJcY3oqzt65deuf+CODlYVBPDw+Z23dbbu1FEn/XxWvDsjY5G
         20zSgebsoQxfN6pOxF42eAufXTJRtXH0ex7zMRJTRaf6Db8+OgZnBzJ30Arh9bjaVM
         aw9E9cl0br/plBRGw4yQn7AJdZybnn10HPYFrXkrbXpTh9Xfmu8SH61Uw8YQOUxGR/
         u29xVyvzt4xlFn+mkWiN4M/pCZ3gmAdgNhGXdS0T/vJqOb51jiOPMmqGMZaW7L3PVs
         NJt+NI+lMmgHg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 has one XUSB device mode controller, which can be operated
HS and SS modes. Add DT support for XUSB device mode controller.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index abdc81f..005112a 100644
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

