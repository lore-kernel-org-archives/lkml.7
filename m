Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D9EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854402245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Rt/B9sJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfLFCtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:49:19 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16025 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfLFCtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:49:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de9c1980000>; Thu, 05 Dec 2019 18:48:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Dec 2019 18:49:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Dec 2019 18:49:12 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 02:49:11 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 02:49:11 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 02:49:11 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.163.171]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5de9c1a60000>; Thu, 05 Dec 2019 18:49:11 -0800
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
Subject: [PATCH v3 10/15] clk: tegra: Remove extern1 and cdev1 from clocks inittable
Date:   Thu, 5 Dec 2019 18:48:50 -0800
Message-ID: <1575600535-26877-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575600536; bh=iSBAO4auyq2tYF1A9pztdK3nD0cVudD9yYPyVdJsf98=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Rt/B9sJpUtSXhL/O4AgJ1eVKWSOCEoE8FXgvgBWXRkpfvMQE45cb3t7j/6WNSuinB
         fErCwmJx10fz5eEMdaS1aeBgkNCC9K//sWRyS4TzEKsMWYaMLGyS0bW7bBpURkqbW/
         tAeujdpMZQL/V9Dkoh2yETQ4x0x1CDr0Z+cFZjQnpKoX/8RDhVto4IQrijLLsvwnDx
         zlNrR4Y0QAfUMv9pnHlkolG+/bryuarTimMG2FkPo3d8whtH0ievE9dVcEIC+UzB5I
         EuOP8+Mv8fcFhGatsA42+6X+T/v5LMFAV84spBGrqw8v2Qgqpf4GJwm6CatyJ5fL/3
         9hQjRs5oi932g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current clock driver enables cdev1 on Tegra20 and extern1 on Tegra30
and above as a part of clocks init and there is no need to have this
clock enabled during the boot.

extern1 is used as parent for clk_out_1 and clk_out_1 is dedicated
for audio mclk on Tegra30 and above Tegra platforms and these clocks
are taken care by ASoC driver.

So, this patch removes parenting and enabling extern1 from clock init
of Tegra30 and above and removes enabling cdev1 from Tegra20 clock init.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c | 1 -
 drivers/clk/tegra/clk-tegra124.c | 1 -
 drivers/clk/tegra/clk-tegra20.c  | 1 -
 drivers/clk/tegra/clk-tegra210.c | 1 -
 drivers/clk/tegra/clk-tegra30.c  | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 36ba1eb3dbe0..3c29896b19a7 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1147,7 +1147,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA114_CLK_UARTD, TEGRA114_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA114_CLK_PLL_A, TEGRA114_CLK_CLK_MAX, 564480000, 1 },
 	{ TEGRA114_CLK_PLL_A_OUT0, TEGRA114_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA114_CLK_EXTERN1, TEGRA114_CLK_PLL_A_OUT0, 0, 1 },
 	{ TEGRA114_CLK_I2S0, TEGRA114_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA114_CLK_I2S1, TEGRA114_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA114_CLK_I2S2, TEGRA114_CLK_PLL_A_OUT0, 11289600, 0 },
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 24532d70e469..6861ded135e0 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1292,7 +1292,6 @@ static struct tegra_clk_init_table common_init_table[] __initdata = {
 	{ TEGRA124_CLK_UARTD, TEGRA124_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA124_CLK_PLL_A, TEGRA124_CLK_CLK_MAX, 564480000, 1 },
 	{ TEGRA124_CLK_PLL_A_OUT0, TEGRA124_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA124_CLK_EXTERN1, TEGRA124_CLK_PLL_A_OUT0, 0, 1 },
 	{ TEGRA124_CLK_I2S0, TEGRA124_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA124_CLK_I2S1, TEGRA124_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA124_CLK_I2S2, TEGRA124_CLK_PLL_A_OUT0, 11289600, 0 },
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index fe536f1d770d..a552dafb8174 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1031,7 +1031,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA20_CLK_UARTE, TEGRA20_CLK_PLL_P, 0, 0 },
 	{ TEGRA20_CLK_PLL_A, TEGRA20_CLK_CLK_MAX, 56448000, 1 },
 	{ TEGRA20_CLK_PLL_A_OUT0, TEGRA20_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA20_CLK_CDEV1, TEGRA20_CLK_CLK_MAX, 0, 1 },
 	{ TEGRA20_CLK_I2S1, TEGRA20_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA20_CLK_I2S2, TEGRA20_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA20_CLK_SDMMC1, TEGRA20_CLK_PLL_P, 48000000, 0 },
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index af5119481d54..252859faeb4a 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3442,7 +3442,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA210_CLK_UARTD, TEGRA210_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA210_CLK_PLL_A, TEGRA210_CLK_CLK_MAX, 564480000, 1 },
 	{ TEGRA210_CLK_PLL_A_OUT0, TEGRA210_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA210_CLK_EXTERN1, TEGRA210_CLK_PLL_A_OUT0, 0, 1 },
 	{ TEGRA210_CLK_I2S0, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA210_CLK_I2S1, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA210_CLK_I2S2, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 24599ed2e6ff..65fdead2c764 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1221,7 +1221,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_UARTE, TEGRA30_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
 	{ TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
 	{ TEGRA30_CLK_I2S0, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA30_CLK_I2S1, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA30_CLK_I2S2, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
-- 
2.7.4

