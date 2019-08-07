Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0E5C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814F121E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jlEgzIuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388870AbfHGQZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:25:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58547 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbfHGQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:25:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190807162513euoutp029eea646a3680e057eccbba459f854f8c~4sKmq9uHy0958909589euoutp02p
        for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2019 16:25:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190807162513euoutp029eea646a3680e057eccbba459f854f8c~4sKmq9uHy0958909589euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565195113;
        bh=2K7KEcP+kimYVvJP3walI9f/kxGTVXYr6YYRG716M1A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jlEgzIuSpHuTs/+yStffEcFSrzS+hkzuzVwkesdTdSVxTznh3X+3kGV2E3v/NSV2D
         7AvZyrGg550fdSr8VXRG4zlFp3PAcftgBhtC47t4jlBN00s8R5SpluESiOLrOl0I6O
         epbzNPlKISdxSOGeplnPyI2TZu1ieeJkIeR4kHAY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190807162512eucas1p2b0f5f5698a045f4bc8317114f44a0f15~4sKl9B1i00663006630eucas1p2_;
        Wed,  7 Aug 2019 16:25:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 77.0B.04309.86BFA4D5; Wed,  7
        Aug 2019 17:25:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190807162511eucas1p2eedb33bdee87f80528b59bb4e869daf1~4sKlIXS1e0663006630eucas1p29;
        Wed,  7 Aug 2019 16:25:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190807162511eusmtrp21f68436d743c6f41a60d889f5db8ebca~4sKk6PsKH2110421104eusmtrp2Q;
        Wed,  7 Aug 2019 16:25:11 +0000 (GMT)
X-AuditID: cbfec7f4-afbff700000010d5-e1-5d4afb68897f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0E.EF.04117.76BFA4D5; Wed,  7
        Aug 2019 17:25:11 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190807162510eusmtip2c2a6b10c105bf9cf2ef7571ce74776be~4sKkKCIs_0680706807eusmtip2h;
        Wed,  7 Aug 2019 16:25:10 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, cw00.choi@samsung.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 1/2] clk: samsung: Change signature of
 exynos5_subcmus_init() function
Date:   Wed,  7 Aug 2019 18:24:55 +0200
Message-Id: <20190807162456.28694-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfSzUcRzHfe93vwenaz8/Nh+S6pY2laey+ZUerdbxRw9/ZdlNJ785xdH9
        UMqW9UTC1DQ0K7HINfOQJGJ26DaNIyVc4Q/FPNdda7mQ8zv13/vh9d7n+8eXwpjruBsVo07k
        NGplrIyQiOvf/jZ4qyyhCr/Zlw5sTUEVzn4yj+OswVBNst+zhnG2r7GIYAsMLSJW96AZsZXt
        X0i2t/Mo2zadjrNL/TXiQw7yvv5eTD43cIuU12rvEPKcOi2Sm2o9TuJnJPuiuNiYZE7je+Cs
        RFVoNJIJHbsvd33F09D0jkxkTwEdAMVZFeJMJKEY+hkCXeWizZgRDFb1EIIxIaj4/BRfm3wY
        LbFR5Qja5rqJf5Pa1sFViqD9IbsjB1m1M+0N6WUtqxBG3xTBR3MJZi2c6DCo6ZoSZSKKEtOe
        8Kgr0hpL6SCwZAsI0JvgeXUrZt0C/YsA43idSCiOwNLUBCloJ5jU19m0Oyy/fiwSBjcQZDUZ
        ScHkIhjRFyOBCoI2fS9uvYzRXlDV6CvEh2Fo0UBYY6DXw8CMozXGVuT9+nxMiKWQcZsR6K1g
        0ebbnuMGd8eWxYKWw2jnt1XN0ApYaJgQ5SKPh/9vFSOkRS5cEh8XzfG71NwlH14Zxyepo33O
        xcfVopWf8W5Jb25AjX8idYimkGyd1K4nVMHgymQ+JU6HgMJkztLh5BAFI41SplzhNPERmqRY
        jtehDZRY5iK9ajcaztDRykTuAsclcJq1VkTZu6UhV6aUActGPSpKSgjIk2O4M0lPBlZiDuGZ
        O/uxsu4np8Z+DtyL8PEd8fa6Jjn/Y78MQhrny4NfnZDP20e4huryLvYEn9YHppKOQzOmaUnq
        VJq5+SCxd/Z9iLublmuK9NxyrDTj+B6Jd3vom22by1UtCzEVYQYRIXthLDT5mWViXqX0345p
        eOVfPV+QkhUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsVy+t/xe7rpv71iDbr3s1hsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxdojd9ktLp5ytTj8pp3V4t+1jSwO3B6Xr11k
        9nh/o5XdY9OqTjaPvi2rGD0+b5ILYI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaP
        tTIyVdK3s0lJzcksSy3St0vQy5h5+zZ7wVHjirNPWRsY32h3MXJySAiYSFx5sIili5GLQ0hg
        KaPEzFmrmLoYOYASUhLzW5QgaoQl/lzrYoOo+cQo8fP4dVaQBJuAoUTv0T5GEFtEQF9ictsG
        sEHMAn1MEnduXQErEhYIk3h7YRkLyFAWAVWJeWeTQMK8AtYSv3sXMUMskJdYveEA8wRGngWM
        DKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECw3TbsZ9bdjB2vQs+xCjAwajEw8twwStWiDWx
        rLgy9xCjBAezkgjvvTLPWCHelMTKqtSi/Pii0pzU4kOMpkC7JzJLiSbnA2MoryTe0NTQ3MLS
        0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD4/lZP1TnHvYtnfnKavEPQb8bt2Yc
        3XZtvoDIypsmk/grEnNfm02NP8exJjyHT3uvcFtwiSRn8r/wF5XvztW9esF59trBY30qi+z/
        7ufRDr9zh6dbkf/dMW5+ldnl167YLgjWuWr9aWns6R8epodnMhTPaxW643SakTnu0QvlY+fj
        X11craqzab0SS3FGoqEWc1FxIgCQFVLFaQIAAA==
X-CMS-MailID: 20190807162511eucas1p2eedb33bdee87f80528b59bb4e869daf1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190807162511eucas1p2eedb33bdee87f80528b59bb4e869daf1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190807162511eucas1p2eedb33bdee87f80528b59bb4e869daf1
References: <CGME20190807162511eucas1p2eedb33bdee87f80528b59bb4e869daf1@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make it easier in subsequent patch to create different subcmu
lists for exynos5420 and exynos5800 SoCs the code is rewritten so we pass
an array of pointers to the subcmus initialization function.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos5-subcmu.c | 16 +++----
 drivers/clk/samsung/clk-exynos5-subcmu.h |  2 +-
 drivers/clk/samsung/clk-exynos5250.c     |  7 ++-
 drivers/clk/samsung/clk-exynos5420.c     | 60 ++++++++++++++----------
 4 files changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index 91db7894125d..65c82d922b05 100644
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
index 755ee8aaa3de..9ae5356f25aa 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.h
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.h
@@ -21,6 +21,6 @@ struct exynos5_subcmu_info {
 };
 
 void exynos5_subcmus_init(struct samsung_clk_provider *ctx, int nr_cmus,
-			  const struct exynos5_subcmu_info *cmu);
+			  const struct exynos5_subcmu_info **cmu);
 
 #endif
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index f2b896881768..931c70a4da19 100644
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
index 01bca5a498b2..fdb17c799aa5 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1281,32 +1281,40 @@ static struct exynos5_subcmu_reg_dump exynos5x_mfc_suspend_regs[] = {
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
2.17.1

