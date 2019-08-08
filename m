Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE90BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA932173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TtgAYNfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbfHHOtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:49:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43646 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732815AbfHHOtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:49:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808144937euoutp0103672d36e6ae1a9ee8cc0bf49d6ba206~4_gbdBVIx1970319703euoutp01O
        for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2019 14:49:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808144937euoutp0103672d36e6ae1a9ee8cc0bf49d6ba206~4_gbdBVIx1970319703euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565275777;
        bh=2ks9tmLm7Z/SWJU1b0Qco0DGAZfOgIqai21P2NmInLM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TtgAYNfgjE4Iv6MEfV1XU4Hx1c6Emk+P9BIeyf758pIUanDCN0xZg4tQsKlHQ0n+0
         kPoP0+F0wTeYdVScc85DZ96cp62DMEwaokd+f25BA5A2EJsiFFqhstq0qfipQT95u1
         d3EL5ECWxVAT1AhBi4c3XnOrxaQVADaS7GuRK5Mg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190808144937eucas1p2e455616f70d817fab175d304282d2032~4_gaqQ3l20507405074eucas1p2a;
        Thu,  8 Aug 2019 14:49:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EA.7D.04374.0863C4D5; Thu,  8
        Aug 2019 15:49:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190808144936eucas1p2e65eddc3d970de35590cb84fe200b438~4_gZ4bJrk0504905049eucas1p2U;
        Thu,  8 Aug 2019 14:49:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808144935eusmtrp2725b08c9b7c49172bf5d284ce662585f~4_gZqSZmM2303923039eusmtrp2L;
        Thu,  8 Aug 2019 14:49:35 +0000 (GMT)
X-AuditID: cbfec7f5-4ddff70000001116-f0-5d4c3680d14c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 64.2D.04117.F763C4D5; Thu,  8
        Aug 2019 15:49:35 +0100 (BST)
Received: from AMDC3061.DIGITAL.local (unknown [106.120.51.75]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190808144935eusmtip2f234b77e1a7843927a870a32b66242c4~4_gZIy8FQ1429614296eusmtip2g;
        Thu,  8 Aug 2019 14:49:35 +0000 (GMT)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux@armlinux.org.uk, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org, cw00.choi@samsung.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 1/2] clk: samsung: Change signature of
 exynos5_subcmus_init() function
Date:   Thu,  8 Aug 2019 16:49:28 +0200
Message-Id: <20190808144929.18685-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduzned0GM59Yg6O/9Sw2zljPanH9y3NW
        i/PnN7BbfOy5x2pxedccNosZ5/cxWRyaupfRYu2Ru+wWF0+5Whx+085q8e/aRhYHbo/L1y4y
        e7y/0crusWlVJ5tH35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZUxsusla8Mak4suOXtYGxh86
        XYycHBICJhK9x+4xdTFycQgJrGCU+D1nISOE84VR4vqT6ywQzmdGiX3fHwFlOMBajt3Ug4gv
        Z5T4M2ciQse5lfOZQOayCRhK9B7tYwSxRQR0JdqX7WMDKWIWaGGSuPplETNIQlggWuLAmVVg
        NouAqsTET42sIDavgLXEkn0tbBAHykus3nCAGaRZQuA7m8SmPy1MEAkXiZ0vZjFC2MISr45v
        YYewZST+75zPBNHQzCjRs/s2O4QzgVHi/vEFUB3WEoePX2QFeYhZQFNi/S59iLCjxN/NP5kg
        /uSTuPFWECTMDGRO2jadGSLMK9HRJgRRrSLxe9V0qHOkJLqf/GeBKPGQOP/JAyQsJBAr8e3t
        a9YJjHKzEFYtYGRcxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZgyTv87/nUH474/SYcY
        BTgYlXh4GxR9YoVYE8uKK3MPMUpwMCuJ8N4r84wV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN
        8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwGh/68DkP4vuPzg96duLi91pN2RS7omVPvxsNGnKFQem
        H1fNzL+puIuYPDTjmn9saZVJ7qTyMz/P+Xo+lEo7MdX2Z9Oz1lhvG69/AZoMkYIO1737VzrV
        /Z6oeKp2dsBcpokPrU+LhbcltmS8zxW4uTCeuejP82NLJ949s2uHtdKUo4HrdhmH2OkpsRRn
        JBpqMRcVJwIA2sgcGBUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xe7r1Zj6xBu+Om1tsnLGe1eL6l+es
        FufPb2C3+Nhzj9Xi8q45bBYzzu9jsjg0dS+jxdojd9ktLp5ytTj8pp3V4t+1jSwO3B6Xr11k
        9nh/o5XdY9OqTjaPvi2rGD0+b5ILYI3SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaP
        tTIyVdK3s0lJzcksSy3St0vQy5jYdJO14I1JxZcdvawNjD90uhg5OCQETCSO3dTrYuTkEBJY
        yijR+9YCIiwlMb9FCSQsISAs8edaF1sXIxdQySdGiYsfbjKBJNgEDCV6j/YxgtgiAvoSk9s2
        sIAUMQv0MUncuXWFFWSQsECkxNYzviA1LAKqEhM/NbKC2LwC1hJL9rWwQSyQl1i94QDzBEae
        BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQKDdNuxn1t2MHa9Cz7EKMDBqMTDqyHvEyvE
        mlhWXJl7iFGCg1lJhPdemWesEG9KYmVValF+fFFpTmrxIUZToOUTmaVEk/OBEZRXEm9oamhu
        YWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoHx6ked9x9YpCpl/vVs73QS8nHs
        K9k1R733lDG73LVDe59c6Qw6feFhxounbQfmbZH+ca3Dg+nbUo7vKkxRMU9mhgScStwuq6L5
        b5V38qzIqaZzLlj4/bZh1LDc9015r8ZaHdVPfEeimipfb866lyL1V25L4H7jPd8O3Th2ae25
        SC+FPXcfXgxdosRSnJFoqMVcVJwIAPf+8bFoAgAA
X-CMS-MailID: 20190808144936eucas1p2e65eddc3d970de35590cb84fe200b438
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190808144936eucas1p2e65eddc3d970de35590cb84fe200b438
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190808144936eucas1p2e65eddc3d970de35590cb84fe200b438
References: <CGME20190808144936eucas1p2e65eddc3d970de35590cb84fe200b438@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make it easier in subsequent patch to create different subcmu
lists for exynos5420 and exynos5800 SoCs the code is rewritten so we pass
an array of pointers to the subcmus initialization function.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Tested-by: Jaafar Ali <jaafarkhalaf@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - added "Fixes" tag.
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

