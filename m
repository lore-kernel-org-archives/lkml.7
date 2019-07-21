Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37AFC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2D2208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yov7EyoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfGUTk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 15:40:57 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12449 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfGUTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 15:40:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d34bfc70000>; Sun, 21 Jul 2019 12:40:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jul 2019 12:40:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jul 2019 12:40:55 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jul
 2019 19:40:55 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 21 Jul 2019 19:40:55 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.85]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d34bfc50004>; Sun, 21 Jul 2019 12:40:55 -0700
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
Subject: [PATCH V6 03/21] pinctrl: tegra210: Add Tegra210 pinctrl pm ops
Date:   Sun, 21 Jul 2019 12:40:42 -0700
Message-ID: <1563738060-30213-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563738060-30213-1-git-send-email-skomatineni@nvidia.com>
References: <1563738060-30213-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563738056; bh=Zm1gtaqy4b8W/mJsa6WY/rY4ZSHBss5j7JPBEnDqUv4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Yov7EyoSlKhZwur9Ak2Z4mnldWpAp7IVmLUAlX5s0nprQMM/TgJjZLppmCSYyQ5Bt
         p9Ddvlc6ghD9a4YgJkkfYlQ2Mvg+TqCU+SCemk8TnCPQQVgRfkhmJq2ogKVEeeUuKk
         6XnYicWvvzXkczDgkevf3VJDSQy+Aa5DdSbCbuIrQvWF9+G0fgKSvU9enb3PjPK4Hz
         17gsPfYzRGy0RNvaASWskxhHP80sxoImtdxBjcfvqw7f5sFwDt7XSvhgZL0n91KxW8
         prHvIhVv8iwvGlgm7unBlfaEOakcIb6HMFmO53rCoLIoPuK8i1i/OVRr/gUJVKdMl7
         9lMFW1rcM0NDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds suspend and resume functionality to Tegra210 pinctrl.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra210.c b/drivers/pinctrl/tegra/pinctrl-tegra210.c
index 39ab6480a941..fc072a36deb3 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra210.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra210.c
@@ -1571,6 +1571,7 @@ static struct platform_driver tegra210_pinctrl_driver = {
 	.driver = {
 		.name = "tegra210-pinctrl",
 		.of_match_table = tegra210_pinctrl_of_match,
+		.pm = &tegra_pinctrl_pm,
 	},
 	.probe = tegra210_pinctrl_probe,
 };
-- 
2.7.4

