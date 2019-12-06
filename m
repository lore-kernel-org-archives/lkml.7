Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64463C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E9324674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cojyUFS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLFCtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:49:14 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4492 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfLFCtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:49:11 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de9c1aa0001>; Thu, 05 Dec 2019 18:49:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 05 Dec 2019 18:49:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 05 Dec 2019 18:49:10 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 02:49:10 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 02:49:10 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.163.171]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5de9c1a40002>; Thu, 05 Dec 2019 18:49:09 -0800
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
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexios.zavras@intel.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH v3 09/15] ASoC: tegra: Add fallback for audio mclk
Date:   Thu, 5 Dec 2019 18:48:49 -0800
Message-ID: <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575600555; bh=QpuTCwWQ7OA+cLjLXqsb+rGtt5ndNflALwObfnlfPq8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cojyUFS2tKje+kPVeDyds/3HD82HQ0sRmRNmatwG60gi6wlvjAU6NYzeJpS1NteMD
         0sLPPn0JNbRGgsqjJlMCWPYpUe0LCvhXAVOtOfurLVVXMJt8gdnUQApnp2kl48r9X5
         2y4E8YpWtNBqgqR3e52V9gxHA5hjDRV6nKNuZVYzlbuW10esyHWRJqqL/2Tgb23fLt
         1qlxpQcWIH0v5o/quppnK1wQifJx55xGMVNUcMKrvHXZxwbUTe99w6NlFn4tDip921
         n4i52QvZ6ltEpkNOeCRo8+wiTlkc68nczuD3y6iuNlIi65H+DSOgtoshje8X9Ht+/V
         j/1Raw4Xsg5hA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
are moved to Tegra PMC driver with pmc as clock provider and using pmc
clock ids.

New device tree uses clk_out_1 from pmc clock provider.

So, this patch adds fallback to extern1 in case of retrieving mclk fails
to be backward compatible of new device tree with older kernels.

Cc: stable@vger.kernel.org

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 sound/soc/tegra/tegra_asoc_utils.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
index 8e3a3740df7c..f7408d5240c0 100644
--- a/sound/soc/tegra/tegra_asoc_utils.c
+++ b/sound/soc/tegra/tegra_asoc_utils.c
@@ -211,8 +211,14 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
 	data->clk_cdev1 = clk_get(dev, "mclk");
 	if (IS_ERR(data->clk_cdev1)) {
 		dev_err(data->dev, "Can't retrieve clk cdev1\n");
-		ret = PTR_ERR(data->clk_cdev1);
-		goto err_put_pll_a_out0;
+		data->clk_cdev1 = clk_get_sys("clk_out_1", "extern1");
+		if (IS_ERR(data->clk_cdev1)) {
+			dev_err(data->dev, "Can't retrieve clk extern1\n");
+			ret = PTR_ERR(data->clk_cdev1);
+			goto err_put_pll_a_out0;
+		}
+
+		dev_err(data->dev, "Falling back to extern1\n");
 	}
 
 	/*
-- 
2.7.4

