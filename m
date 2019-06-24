Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0237AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0CC208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FFrpYwGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFXDDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:03:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13255 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfFXDDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:03:51 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d103d950000>; Sun, 23 Jun 2019 20:03:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 23 Jun 2019 20:03:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 23 Jun 2019 20:03:49 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 03:03:49 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 24 Jun 2019 03:03:49 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.126]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d103d930000>; Sun, 23 Jun 2019 20:03:49 -0700
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
Subject: [PATCH V4 16/18] soc/tegra: pmc: configure core power request polarity
Date:   Sun, 23 Jun 2019 20:02:57 -0700
Message-ID: <1561345379-2429-17-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561345379-2429-1-git-send-email-skomatineni@nvidia.com>
References: <1561345379-2429-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561345429; bh=ZIM1lgKmGOLI8vjBUZA7Djdy5mObSNe1HI0kza+VS88=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FFrpYwGf9dF5STigOtKoPoynIHZvhi0QAKR/vt8NZAklLimm/K7dbFsYJp0qs4X/8
         dIYqZhqEvOiimDRHlU6DXLodyFTVft+B6TJsIKvbJGRTqGsPl/AwoeIwakTBUXrr8n
         /73S5CU9bxLy3WIuJII/Nu392T9UFkRw0TYH+bHEVTV1aGhiWA4J5eK9AKffsts8PM
         jEdQV8m3oE5g8hk41QcK8b1+BcYnZuFbn9kF2+Cj1stwD+59nHTAtQUZy8d5fm0gMY
         4v2HMv40/QlwDLv/Hh1+ZO3v2ZxZKeJ8AlyqR0kP7NoxoSBnwCDRBQJVu295+56Le1
         A9/uEkeLOVdkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch configures polarity of the core power request signal
in PMC control register based on the device tree property.

PMC asserts and de-asserts power request signal based on it polarity
when it need to power-up and power-down the core rail during SC7.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 603fc3bd73f5..c9eea5ef008a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -56,6 +56,7 @@
 #define  PMC_CNTRL_SIDE_EFFECT_LP0	BIT(14) /* LP0 when CPU pwr gated */
 #define  PMC_CNTRL_SYSCLK_OE		BIT(11) /* system clock enable */
 #define  PMC_CNTRL_SYSCLK_POLARITY	BIT(10) /* sys clk polarity */
+#define  PMC_CNTRL_PWRREQ_POLARITY	BIT(8)
 #define  PMC_CNTRL_MAIN_RST		BIT(4)
 #define  PMC_CNTRL_LATCH_WAKEUPS	BIT(5)
 
@@ -2304,6 +2305,11 @@ static void tegra20_pmc_init(struct tegra_pmc *pmc)
 	else
 		value |= PMC_CNTRL_SYSCLK_POLARITY;
 
+	if (pmc->corereq_high)
+		value &= ~PMC_CNTRL_PWRREQ_POLARITY;
+	else
+		value |= PMC_CNTRL_PWRREQ_POLARITY;
+
 	/* configure the output polarity while the request is tristated */
 	tegra_pmc_writel(pmc, value, PMC_CNTRL);
 
-- 
2.7.4

