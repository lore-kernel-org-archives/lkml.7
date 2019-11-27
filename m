Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193D4C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECDA2068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TVmieoxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfK0FAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:00:02 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17866 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfK0E7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:59:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dde02c60000>; Tue, 26 Nov 2019 20:59:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Nov 2019 20:59:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Nov 2019 20:59:46 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:59:46 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Nov 2019 04:59:46 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.149]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dde02c10001>; Tue, 26 Nov 2019 20:59:46 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/11] arm64: tegra: smaug: Change clk_out_2 provider from tegra_car to pmc
Date:   Tue, 26 Nov 2019 20:59:32 -0800
Message-ID: <1574830773-14892-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574830790; bh=AZT3qfqFQF36ckzWiswHL93ouN6Ik9+Ewp55cqiFurE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=TVmieoxegaXPI+wFlWhFLjWQQtZv+NnXIxhMc5b5rXfMkVqdOGM/bsiWe/RPM44b+
         RQm8mMreYdOxnAJvDNbWKOKSpeCk+QWFsfxwRLw7/W2l3kCCXxZrLmvyPohihPrTQH
         Hv+KwBSaoPWT0xiRSPfEMU8HREtd0J9QvFu8I4oz/wezLZ32VS7nwXTko38V3v8rR2
         /+ugQi7T75zT7NcpUoXciDUSvtxNxJhIGEDM39adrjmszvZ5o/bah9sTkeELldOZRu
         tr8zqdCFTc7b6n60D3y1hlpQHjGmpJxTBc/DACO9fg/Ka5H9xzTYstQ+WaCoLgS/nh
         //D6gSaHk0hzQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_out_2 is the clocks from Tegra PMC block with clock source and state
control part of Tegra PMC.

Tegra pmc node is the provider for these clocks.

This patch changes clk_out_2 provider to pmc and uses corresponding pmc
clock id for clk_out_2.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 72c7a04ac1df..4376c38d78f4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1592,7 +1592,7 @@
 			reg = <0x1a>;
 			interrupt-parent = <&gpio>;
 			interrupts = <TEGRA_GPIO(E, 6) IRQ_TYPE_LEVEL_LOW>;
-			clocks = <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
+			clocks = <&pmc TEGRA_PMC_CLK_OUT_2>;
 			clock-names = "mclk";
 
 			nuvoton,jkdet-enable;
-- 
2.7.4

