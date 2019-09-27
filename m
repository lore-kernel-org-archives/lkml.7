Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31247C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA1720872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfI0Svr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:51:47 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:50229 "EHLO
        17.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0Svr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:51:47 -0400
Received: from player716.ha.ovh.net (unknown [10.109.160.217])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 8A16C1E31F5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 20:51:45 +0200 (CEST)
Received: from sk2.org (unknown [109.190.253.11])
        (Authenticated sender: steve@sk2.org)
        by player716.ha.ovh.net (Postfix) with ESMTPSA id 19D0DA43D52B;
        Fri, 27 Sep 2019 18:51:34 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] drivers/clk: convert VL struct to struct_size
Date:   Fri, 27 Sep 2019 20:51:10 +0200
Message-Id: <20190927185110.29897-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6503479337963834743
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few manually-calculated variable-length struct allocations
left, this converts them to use struct_size.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/clk/at91/sckc.c                     | 3 +--
 drivers/clk/imgtec/clk-boston.c             | 3 +--
 drivers/clk/ingenic/tcu.c                   | 3 +--
 drivers/clk/mvebu/ap-cpu-clk.c              | 4 ++--
 drivers/clk/mvebu/cp110-system-controller.c | 4 ++--
 drivers/clk/samsung/clk.c                   | 3 +--
 drivers/clk/uniphier/clk-uniphier-core.c    | 3 +--
 7 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 9bfe9a28294a..5ad6180449cb 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -478,8 +478,7 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
 	if (IS_ERR(slow_osc))
 		goto unregister_slow_rc;
 
-	clk_data = kzalloc(sizeof(*clk_data) + (2 * sizeof(struct clk_hw *)),
-			   GFP_KERNEL);
+	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
 	if (!clk_data)
 		goto unregister_slow_osc;
 
diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
index 33ab4ff61165..b00cbd045af5 100644
--- a/drivers/clk/imgtec/clk-boston.c
+++ b/drivers/clk/imgtec/clk-boston.c
@@ -58,8 +58,7 @@ static void __init clk_boston_setup(struct device_node *np)
 	cpu_div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK1DIV);
 	cpu_freq = mult_frac(in_freq, mul, cpu_div);
 
-	onecell = kzalloc(sizeof(*onecell) +
-			  (BOSTON_CLK_COUNT * sizeof(struct clk_hw *)),
+	onecell = kzalloc(struct_size(onecell, hws, BOSTON_CLK_COUNT),
 			  GFP_KERNEL);
 	if (!onecell)
 		return;
diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index a1a5f9cb439e..ad7daa494fd4 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -358,8 +358,7 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 		}
 	}
 
-	tcu->clocks = kzalloc(sizeof(*tcu->clocks) +
-			      sizeof(*tcu->clocks->hws) * TCU_CLK_COUNT,
+	tcu->clocks = kzalloc(struct_size(tcu->clocks, hws, TCU_CLK_COUNT),
 			      GFP_KERNEL);
 	if (!tcu->clocks) {
 		ret = -ENOMEM;
diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
index af5e5acad370..6b394302c76a 100644
--- a/drivers/clk/mvebu/ap-cpu-clk.c
+++ b/drivers/clk/mvebu/ap-cpu-clk.c
@@ -274,8 +274,8 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
 	if (!ap_cpu_clk)
 		return -ENOMEM;
 
-	ap_cpu_data = devm_kzalloc(dev, sizeof(*ap_cpu_data) +
-				sizeof(struct clk_hw *) * nclusters,
+	ap_cpu_data = devm_kzalloc(dev, struct_size(ap_cpu_data, hws,
+						    nclusters),
 				GFP_KERNEL);
 	if (!ap_cpu_data)
 		return -ENOMEM;
diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index 808463276145..84c8900542e4 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -235,8 +235,8 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	cp110_clk_data = devm_kzalloc(dev, sizeof(*cp110_clk_data) +
-				      sizeof(struct clk_hw *) * CP110_CLK_NUM,
+	cp110_clk_data = devm_kzalloc(dev, struct_size(cp110_clk_data, hws,
+						       CP110_CLK_NUM),
 				      GFP_KERNEL);
 	if (!cp110_clk_data)
 		return -ENOMEM;
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index e544a38106dd..dad31308c071 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -60,8 +60,7 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
 	struct samsung_clk_provider *ctx;
 	int i;
 
-	ctx = kzalloc(sizeof(struct samsung_clk_provider) +
-		      sizeof(*ctx->clk_data.hws) * nr_clks, GFP_KERNEL);
+	ctx = kzalloc(struct_size(ctx, clk_data.hws, nr_clks), GFP_KERNEL);
 	if (!ctx)
 		panic("could not allocate clock provider context.\n");
 
diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
index c6aaca73cf86..12380236d7ab 100644
--- a/drivers/clk/uniphier/clk-uniphier-core.c
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -64,8 +64,7 @@ static int uniphier_clk_probe(struct platform_device *pdev)
 	for (p = data; p->name; p++)
 		clk_num = max(clk_num, p->idx + 1);
 
-	hw_data = devm_kzalloc(dev,
-			sizeof(*hw_data) + clk_num * sizeof(struct clk_hw *),
+	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, clk_num),
 			GFP_KERNEL);
 	if (!hw_data)
 		return -ENOMEM;
-- 
2.20.1

