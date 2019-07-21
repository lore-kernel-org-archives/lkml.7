Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A24C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E094420823
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XKatg5BM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfGUTl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 15:41:29 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9038 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfGUTlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 15:41:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d34bfdb0000>; Sun, 21 Jul 2019 12:41:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 21 Jul 2019 12:41:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 21 Jul 2019 12:41:18 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jul
 2019 19:41:17 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 21 Jul 2019 19:41:17 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.85]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d34bfdc0000>; Sun, 21 Jul 2019 12:41:17 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <linus.walleij@linaro.org>,
        <stefan@agner.ch>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <jckuo@nvidia.com>,
        <josephl@nvidia.com>, <talho@nvidia.com>, <skomatineni@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mperttunen@nvidia.com>, <spatra@nvidia.com>, <robh+dt@kernel.org>,
        <digetx@gmail.com>, <devicetree@vger.kernel.org>
Subject: [PATCH V6 17/21] arm64: tegra: Enable wake from deep sleep on RTC alarm.
Date:   Sun, 21 Jul 2019 12:40:56 -0700
Message-ID: <1563738060-30213-18-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563738060-30213-1-git-send-email-skomatineni@nvidia.com>
References: <1563738060-30213-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563738076; bh=r/7sch8XJz5tT01ckyUKnesfNR9nppNjP97KIR+puRI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XKatg5BMYhd1l1mZyFttY82ElDwsjSu57utLBxqhcl7Amk7dHKK/ekHbY/+pM0q4i
         ETQGWDXdMicqBpDQ/NnJVBMWDLLq2HdaZgdtpwhYl5a9ExqOjLnVRB6ePYp/cLxQzx
         n+s+QD0L1yec31PMTgSVX7ey6sRnXYuZzsRKRPiJCCZ3c+Au/pmtNhP2IgNei62kpF
         kgKydXIzjrzwYUb8rxLVUnnMMHuvq7wfo+8dwFUEIBLcSnPk4O6AjXQHavrS5iYv+/
         0bAuM0ExcZmxBgcWw2q9Nd1MBcoEZf8OKwDZy1hYVnSHXP3d1Q3syUakNXxI3W3RgZ
         kRBTNTak2SGTQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates device tree for RTC and PMC to allow system wake
from deep sleep on RTC alarm.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 659753118e96..30a7c48385a2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -768,7 +768,8 @@
 	rtc@7000e000 {
 		compatible = "nvidia,tegra210-rtc", "nvidia,tegra20-rtc";
 		reg = <0x0 0x7000e000 0x0 0x100>;
-		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&pmc>;
 		clocks = <&tegra_car TEGRA210_CLK_RTC>;
 		clock-names = "rtc";
 	};
@@ -778,6 +779,8 @@
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#interrupt-cells = <2>;
+		interrupt-controller;
 
 		powergates {
 			pd_audio: aud {
-- 
2.7.4

