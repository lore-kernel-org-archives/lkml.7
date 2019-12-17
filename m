Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CA3C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735E921775
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZfuNq+ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfLQUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:04:40 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1842 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfLQUE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:04:26 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df934c00000>; Tue, 17 Dec 2019 12:04:16 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 17 Dec 2019 12:04:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Dec 2019 12:04:25 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 20:04:24 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Dec 2019 20:04:24 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.101]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df934c80001>; Tue, 17 Dec 2019 12:04:24 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 19/19] ASoC: nau8825: change Tegra clk_out_2 provider from tegra_car to pmc
Date:   Tue, 17 Dec 2019 12:04:06 -0800
Message-ID: <1576613046-17159-20-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576613056; bh=PrJKaLT/EBKy1A4Ripk7ZLqgcw5ax7h/7twSjXlR9bk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZfuNq+aoAZXKKt2lAJBUGgoo6EqlGW2cMO02Jo72CGhp8jynF/7tHEzACu4tVaNfY
         nq8lLcDdii/LDWMdC3HvflQwwkjuc4ZiMsf4q1mk5NoCs/2xmmvSDJId4TEED7gsa/
         Ke+hA/2sc/KTyDGzh0N8gshBC+gqrRqpw81N5MxqhRedAQ38JqRPgedvyEMOm5YRPH
         DLlfjtA+DycPyVawKkY7bmIGiNAW1TVd1MFoa+U10SqrKxIKO8/djJKt4g+4T2Cnf8
         clBINMfCPbsIS2ZIvXTzInO39zLVz+nsMPB+VRSqHnt/CS8Fi2jMrK0HWTRcbWeOIT
         0FczNivRmQsBQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra clk_out_1, clk_out_2, and clk_out_3 are part of PMC block and
these clocks are moved from clock drvier to pmc driver with pmc as
a provider for these clocks.

Update bindings document to use pmc as clock provider for clk_out_2 and
change id to pmc clock id.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/sound/nau8825.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/nau8825.txt b/Documentation/devicetree/bindings/sound/nau8825.txt
index d16d96839bcb..487eb9574ee2 100644
--- a/Documentation/devicetree/bindings/sound/nau8825.txt
+++ b/Documentation/devicetree/bindings/sound/nau8825.txt
@@ -101,5 +101,5 @@ Example:
       nuvoton,crosstalk-enable;
 
       clock-names = "mclk";
-      clocks = <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
+      clocks = <&pmc TEGRA_PMC_CLK_OUT_2>;
   };
-- 
2.7.4

