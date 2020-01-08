Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ECDC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598AF2075B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OR9FULhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgAHEZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:25:53 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10331 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgAHEZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:25:52 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e15599a0000>; Tue, 07 Jan 2020 20:24:58 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 20:25:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jan 2020 20:25:47 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 04:25:46 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 8 Jan 2020 04:25:45 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.162.131]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1559c80001>; Tue, 07 Jan 2020 20:25:45 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 16/21] clk: tegra: Remove audio related clock enables from init_table
Date:   Tue, 7 Jan 2020 20:25:10 -0800
Message-ID: <1578457515-3477-17-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578457499; bh=y4o4se+Q1u8fqTGtRN8M6X6Tq927RxHHd6uBkUiOsIk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=OR9FULhfwqmfEyiyfJ6MyZ2Knx06uYKx2ybG3NwFaqEww90WgtaDV/RtTM9ruQ3Dp
         EYK4kgzPp44dmJRX8UO1YHML4/O7T2tMzPH8QbykAXUk6bUmoJ8oK+U2cjTPVkIdxL
         VNkBUakVfM15fJFSGpxXbNb5Es7iNEOYTyTBzTdPn3hRQsoWUloxeXtvM/Wxhzws8Z
         Sgnkm43IQg7CZd4dOp+7pVSYOBUTxxtXKxGpzNdTTkfeNFjFYlv4pzxzjELnLDLWBv
         1+e5FgVAvKRzoVBEKHpnThcqjDFybMaIVUFzQsjj3s0k8ZXsKglfzGbtKkv5o/hL6X
         2Rq13cWnAonMw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current clock driver enables PLLA, cdev1 on Tegra20 and extern1 on Tegra30
and above as a part of clocks init and there is no need to have this
clock enabled during the boot.

extern1 is used as parent for clk_out_1 and clk_out_1 is dedicated
for audio mclk on Tegra30 and above Tegra platforms and these clocks
are taken care by ASoC driver.

So, this patch removes parenting and enabling extern1 from clock init
of Tegra30 and above and removes enabling cdev1 from Tegra20 clock init.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c | 5 ++---
 drivers/clk/tegra/clk-tegra124.c | 5 ++---
 drivers/clk/tegra/clk-tegra20.c  | 5 ++---
 drivers/clk/tegra/clk-tegra210.c | 5 ++---
 drivers/clk/tegra/clk-tegra30.c  | 5 ++---
 5 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index c138ef75480b..bc9e47a4cb60 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1136,9 +1136,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA114_CLK_UARTB, TEGRA114_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA114_CLK_UARTC, TEGRA114_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA114_CLK_UARTD, TEGRA114_CLK_PLL_P, 408000000, 0 },
-	{ TEGRA114_CLK_PLL_A, TEGRA114_CLK_CLK_MAX, 564480000, 1 },
-	{ TEGRA114_CLK_PLL_A_OUT0, TEGRA114_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA114_CLK_EXTERN1, TEGRA114_CLK_PLL_A_OUT0, 0, 1 },
+	{ TEGRA114_CLK_PLL_A, TEGRA114_CLK_CLK_MAX, 564480000, 0 },
+	{ TEGRA114_CLK_PLL_A_OUT0, TEGRA114_CLK_CLK_MAX, 11289600, 0 },
 	{ TEGRA114_CLK_I2S0, TEGRA114_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA114_CLK_I2S1, TEGRA114_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA114_CLK_I2S2, TEGRA114_CLK_PLL_A_OUT0, 11289600, 0 },
diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 54cac77deaa3..64e229ddf2a5 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -1292,9 +1292,8 @@ static struct tegra_clk_init_table common_init_table[] __initdata = {
 	{ TEGRA124_CLK_UARTB, TEGRA124_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA124_CLK_UARTC, TEGRA124_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA124_CLK_UARTD, TEGRA124_CLK_PLL_P, 408000000, 0 },
-	{ TEGRA124_CLK_PLL_A, TEGRA124_CLK_CLK_MAX, 564480000, 1 },
-	{ TEGRA124_CLK_PLL_A_OUT0, TEGRA124_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA124_CLK_EXTERN1, TEGRA124_CLK_PLL_A_OUT0, 0, 1 },
+	{ TEGRA124_CLK_PLL_A, TEGRA124_CLK_CLK_MAX, 564480000, 0 },
+	{ TEGRA124_CLK_PLL_A_OUT0, TEGRA124_CLK_CLK_MAX, 11289600, 0 },
 	{ TEGRA124_CLK_I2S0, TEGRA124_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA124_CLK_I2S1, TEGRA124_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA124_CLK_I2S2, TEGRA124_CLK_PLL_A_OUT0, 11289600, 0 },
diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index fe536f1d770d..0da402c144d8 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -1029,9 +1029,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA20_CLK_UARTC, TEGRA20_CLK_PLL_P, 0, 0 },
 	{ TEGRA20_CLK_UARTD, TEGRA20_CLK_PLL_P, 0, 0 },
 	{ TEGRA20_CLK_UARTE, TEGRA20_CLK_PLL_P, 0, 0 },
-	{ TEGRA20_CLK_PLL_A, TEGRA20_CLK_CLK_MAX, 56448000, 1 },
-	{ TEGRA20_CLK_PLL_A_OUT0, TEGRA20_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA20_CLK_CDEV1, TEGRA20_CLK_CLK_MAX, 0, 1 },
+	{ TEGRA20_CLK_PLL_A, TEGRA20_CLK_CLK_MAX, 56448000, 0 },
+	{ TEGRA20_CLK_PLL_A_OUT0, TEGRA20_CLK_CLK_MAX, 11289600, 0 },
 	{ TEGRA20_CLK_I2S1, TEGRA20_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA20_CLK_I2S2, TEGRA20_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA20_CLK_SDMMC1, TEGRA20_CLK_PLL_P, 48000000, 0 },
diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
index d2f1e9c0ed25..c6304f5e813e 100644
--- a/drivers/clk/tegra/clk-tegra210.c
+++ b/drivers/clk/tegra/clk-tegra210.c
@@ -3442,9 +3442,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA210_CLK_UARTB, TEGRA210_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA210_CLK_UARTC, TEGRA210_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA210_CLK_UARTD, TEGRA210_CLK_PLL_P, 408000000, 0 },
-	{ TEGRA210_CLK_PLL_A, TEGRA210_CLK_CLK_MAX, 564480000, 1 },
-	{ TEGRA210_CLK_PLL_A_OUT0, TEGRA210_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA210_CLK_EXTERN1, TEGRA210_CLK_PLL_A_OUT0, 0, 1 },
+	{ TEGRA210_CLK_PLL_A, TEGRA210_CLK_CLK_MAX, 564480000, 0 },
+	{ TEGRA210_CLK_PLL_A_OUT0, TEGRA210_CLK_CLK_MAX, 11289600, 0 },
 	{ TEGRA210_CLK_I2S0, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA210_CLK_I2S1, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA210_CLK_I2S2, TEGRA210_CLK_PLL_A_OUT0, 11289600, 0 },
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 5732fdbe20db..53d1c48532ae 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1221,9 +1221,8 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_UARTC, TEGRA30_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA30_CLK_UARTD, TEGRA30_CLK_PLL_P, 408000000, 0 },
 	{ TEGRA30_CLK_UARTE, TEGRA30_CLK_PLL_P, 408000000, 0 },
-	{ TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
-	{ TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
-	{ TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
+	{ TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 0 },
+	{ TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 0 },
 	{ TEGRA30_CLK_I2S0, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA30_CLK_I2S1, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
 	{ TEGRA30_CLK_I2S2, TEGRA30_CLK_PLL_A_OUT0, 11289600, 0 },
-- 
2.7.4

