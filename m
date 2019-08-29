Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA64C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781DD22CF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102415;
	bh=bCGZzDx5LUXzU8phWTW20IhX0zBK1LJRnCUKc57hfpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tjcqjt3Tuuqt+QDv1VuLwqN1K0WMdzlZRy/9KFJmFjPXpKOpIcATsYOcYZMwzNyJU
	 o9P7MYMGa2k65HF0Bw9kCkf/7zIq/xn9QqcLotY+9ugP3ZX5mkkHzRBun35MtNP7pN
	 lB+kCCFwYZmsQ/B7ESEnxyRDZc0zGxTm03ljayxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfH2SNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfH2SNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:13:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665C82189D;
        Thu, 29 Aug 2019 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102409;
        bh=bCGZzDx5LUXzU8phWTW20IhX0zBK1LJRnCUKc57hfpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcR5BFRSH2L8xumDKMH0/dj65eiXb8YPNCHweTqRezzMwpRAfv4BaRAa1W+h8bCSy
         yJMuz084YaZE43+sYcv+PQmsWBtmAZ+pT5ausIOXoX904QpXZTmdSXZSShq0FR4sh5
         LZKqdoKZwnPfLpur+D9HGUuxV5pyQQ9pDWZ6uTaY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jaafar Ali <jaafarkhalaf@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 06/76] clk: samsung: Change signature of exynos5_subcmus_init() function
Date:   Thu, 29 Aug 2019 14:12:01 -0400
Message-Id: <20190829181311.7562-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit bf32e7dbfce87d518c0ca77af890eae9ab8d6ab9 ]

In order to make it easier in subsequent patch to create different subcmu
lists for exynos5420 and exynos5800 SoCs the code is rewritten so we pass
an array of pointers to the subcmus initialization function.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Tested-by: Jaafar Ali <jaafarkhalaf@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Link: https://lkml.kernel.org/r/20190808144929.18685-1-s.nawrocki@samsung.com
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/samsung/clk-exynos5-subcmu.c | 16 +++----
 drivers/clk/samsung/clk-exynos5-subcmu.h |  2 +-
 drivers/clk/samsung/clk-exynos5250.c     |  7 ++-
 drivers/clk/samsung/clk-exynos5420.c     | 60 ++++++++++++++----------
 4 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index 91db7894125df..65c82d922b05c 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -14,7 +14,7 @@
 #include "clk-exynos5-subcmu.h"
 
 static struct samsung_clk_provider *ctx;
-static const struct exynos5_subcmu_info *cmu;
+static const struct exynos5_subcmu_info **cmu;
 static int nr_cmus;
 
 static void exynos5_subcmu_clk_save(void __iomem *base,
@@ -56,17 +56,17 @@ static void exynos5_subcmu_defer_gate(struct samsung_clk_provider *ctx,
  * when OF-core populates all device-tree nodes.
  */
 void exynos5_subcmus_init(struct samsung_clk_provider *_ctx, int _nr_cmus,
-			  const struct exynos5_subcmu_info *_cmu)
+			  const struct exynos5_subcmu_info **_cmu)
 {
 	ctx = _ctx;
 	cmu = _cmu;
 	nr_cmus = _nr_cmus;
 
 	for (; _nr_cmus--; _cmu++) {
-		exynos5_subcmu_defer_gate(ctx, _cmu->gate_clks,
-					  _cmu->nr_gate_clks);
-		exynos5_subcmu_clk_save(ctx->reg_base, _cmu->suspend_regs,
-					_cmu->nr_suspend_regs);
+		exynos5_subcmu_defer_gate(ctx, (*_cmu)->gate_clks,
+					  (*_cmu)->nr_gate_clks);
+		exynos5_subcmu_clk_save(ctx->reg_base, (*_cmu)->suspend_regs,
+					(*_cmu)->nr_suspend_regs);
 	}
 }
 
@@ -163,9 +163,9 @@ static int __init exynos5_clk_probe(struct platform_device *pdev)
 		if (of_property_read_string(np, "label", &name) < 0)
 			continue;
 		for (i = 0; i < nr_cmus; i++)
-			if (strcmp(cmu[i].pd_name, name) == 0)
+			if (strcmp(cmu[i]->pd_name, name) == 0)
 				exynos5_clk_register_subcmu(&pdev->dev,
-							    &cmu[i], np);
+							    cmu[i], np);
 	}
 	return 0;
 }
diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.h b/drivers/clk/samsung/clk-exynos5-subcmu.h
index 755ee8aaa3de5..9ae5356f25aa4 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.h
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.h
@@ -21,6 +21,6 @@ struct exynos5_subcmu_info {
 };
 
 void exynos5_subcmus_init(struct samsung_clk_provider *ctx, int nr_cmus,
-			  const struct exynos5_subcmu_info *cmu);
+			  const struct exynos5_subcmu_info **cmu);
 
 #endif
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index f2b8968817682..931c70a4da196 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -681,6 +681,10 @@ static const struct exynos5_subcmu_info exynos5250_disp_subcmu = {
 	.pd_name	= "DISP1",
 };
 
+static const struct exynos5_subcmu_info *exynos5250_subcmus[] = {
+	&exynos5250_disp_subcmu,
+};
+
 static const struct samsung_pll_rate_table vpll_24mhz_tbl[] __initconst = {
 	/* sorted in descending order */
 	/* PLL_36XX_RATE(rate, m, p, s, k) */
@@ -843,7 +847,8 @@ static void __init exynos5250_clk_init(struct device_node *np)
 
 	samsung_clk_sleep_init(reg_base, exynos5250_clk_regs,
 			       ARRAY_SIZE(exynos5250_clk_regs));
-	exynos5_subcmus_init(ctx, 1, &exynos5250_disp_subcmu);
+	exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5250_subcmus),
+			     exynos5250_subcmus);
 
 	samsung_clk_of_add_provider(np, ctx);
 
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 12d800fd95286..a6ea5d7e63d02 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1232,32 +1232,40 @@ static struct exynos5_subcmu_reg_dump exynos5x_mfc_suspend_regs[] = {
 	{ DIV4_RATIO, 0, 0x3 },			/* DIV dout_mfc_blk */
 };
 
-static const struct exynos5_subcmu_info exynos5x_subcmus[] = {
-	{
-		.div_clks	= exynos5x_disp_div_clks,
-		.nr_div_clks	= ARRAY_SIZE(exynos5x_disp_div_clks),
-		.gate_clks	= exynos5x_disp_gate_clks,
-		.nr_gate_clks	= ARRAY_SIZE(exynos5x_disp_gate_clks),
-		.suspend_regs	= exynos5x_disp_suspend_regs,
-		.nr_suspend_regs = ARRAY_SIZE(exynos5x_disp_suspend_regs),
-		.pd_name	= "DISP",
-	}, {
-		.div_clks	= exynos5x_gsc_div_clks,
-		.nr_div_clks	= ARRAY_SIZE(exynos5x_gsc_div_clks),
-		.gate_clks	= exynos5x_gsc_gate_clks,
-		.nr_gate_clks	= ARRAY_SIZE(exynos5x_gsc_gate_clks),
-		.suspend_regs	= exynos5x_gsc_suspend_regs,
-		.nr_suspend_regs = ARRAY_SIZE(exynos5x_gsc_suspend_regs),
-		.pd_name	= "GSC",
-	}, {
-		.div_clks	= exynos5x_mfc_div_clks,
-		.nr_div_clks	= ARRAY_SIZE(exynos5x_mfc_div_clks),
-		.gate_clks	= exynos5x_mfc_gate_clks,
-		.nr_gate_clks	= ARRAY_SIZE(exynos5x_mfc_gate_clks),
-		.suspend_regs	= exynos5x_mfc_suspend_regs,
-		.nr_suspend_regs = ARRAY_SIZE(exynos5x_mfc_suspend_regs),
-		.pd_name	= "MFC",
-	},
+static const struct exynos5_subcmu_info exynos5x_disp_subcmu = {
+	.div_clks	= exynos5x_disp_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(exynos5x_disp_div_clks),
+	.gate_clks	= exynos5x_disp_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(exynos5x_disp_gate_clks),
+	.suspend_regs	= exynos5x_disp_suspend_regs,
+	.nr_suspend_regs = ARRAY_SIZE(exynos5x_disp_suspend_regs),
+	.pd_name	= "DISP",
+};
+
+static const struct exynos5_subcmu_info exynos5x_gsc_subcmu = {
+	.div_clks	= exynos5x_gsc_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(exynos5x_gsc_div_clks),
+	.gate_clks	= exynos5x_gsc_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(exynos5x_gsc_gate_clks),
+	.suspend_regs	= exynos5x_gsc_suspend_regs,
+	.nr_suspend_regs = ARRAY_SIZE(exynos5x_gsc_suspend_regs),
+	.pd_name	= "GSC",
+};
+
+static const struct exynos5_subcmu_info exynos5x_mfc_subcmu = {
+	.div_clks	= exynos5x_mfc_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(exynos5x_mfc_div_clks),
+	.gate_clks	= exynos5x_mfc_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(exynos5x_mfc_gate_clks),
+	.suspend_regs	= exynos5x_mfc_suspend_regs,
+	.nr_suspend_regs = ARRAY_SIZE(exynos5x_mfc_suspend_regs),
+	.pd_name	= "MFC",
+};
+
+static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
+	&exynos5x_disp_subcmu,
+	&exynos5x_gsc_subcmu,
+	&exynos5x_mfc_subcmu,
 };
 
 static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
-- 
2.20.1

