Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCA8C2D0C7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A2D214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfLKJ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:26:09 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42596 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfLKJ0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:26:06 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E356B200987;
        Wed, 11 Dec 2019 10:26:04 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D736E200983;
        Wed, 11 Dec 2019 10:26:04 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F18920568;
        Wed, 11 Dec 2019 10:26:04 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND v2 05/11] clk: imx: pllv2: Switch to clk_hw based API
Date:   Wed, 11 Dec 2019 11:25:44 +0200
Message-Id: <1576056350-20715-6-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576056350-20715-1-git-send-email-abel.vesa@nxp.com>
References: <1576056350-20715-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the imx_clk_pllv2 register function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pllv2.c | 14 +++++++++-----
 drivers/clk/imx/clk.h       |  5 ++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv2.c b/drivers/clk/imx/clk-pllv2.c
index eeba3cb..ff17f06 100644
--- a/drivers/clk/imx/clk-pllv2.c
+++ b/drivers/clk/imx/clk-pllv2.c
@@ -239,12 +239,13 @@ static const struct clk_ops clk_pllv2_ops = {
 	.set_rate = clk_pllv2_set_rate,
 };
 
-struct clk *imx_clk_pllv2(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_pllv2(const char *name, const char *parent,
 		void __iomem *base)
 {
 	struct clk_pllv2 *pll;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
@@ -259,10 +260,13 @@ struct clk *imx_clk_pllv2(const char *name, const char *parent,
 	init.num_parents = 1;
 
 	pll->hw.init = &init;
+	hw = &pll->hw;
 
-	clk = clk_register(NULL, &pll->hw);
-	if (IS_ERR(clk))
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(pll);
+		return ERR_PTR(ret);
+	}
 
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 9dd5ea5..6cd8975 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -113,13 +113,16 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_pllv1(type, name, parent, base) \
 	to_clk(imx_clk_hw_pllv1(type, name, parent, base))
 
+#define imx_clk_pllv2(name, parent, base) \
+	to_clk(imx_clk_hw_pllv2(name, parent, base))
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
 
 struct clk_hw *imx_clk_hw_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
 
-struct clk *imx_clk_pllv2(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_pllv2(const char *name, const char *parent,
 		void __iomem *base);
 
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
-- 
2.7.4

