Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBE4C2D0C7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDEE2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfLKJ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:26:14 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42628 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728488AbfLKJ0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:26:08 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C05C2015A6;
        Wed, 11 Dec 2019 10:26:06 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F08992015A2;
        Wed, 11 Dec 2019 10:26:05 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7968120568;
        Wed, 11 Dec 2019 10:26:05 +0100 (CET)
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
Subject: [RESEND v2 07/11] clk: imx: Rename sccg and frac pll register to suggest clk_hw
Date:   Wed, 11 Dec 2019 11:25:46 +0200
Message-Id: <1576056350-20715-8-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576056350-20715-1-git-send-email-abel.vesa@nxp.com>
References: <1576056350-20715-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming the imx_clk_frac_pll and imx_clk_sccg_pll register functions to
imx_clk_hw_frac_pll, respectively imx_clk_hw_sccg_pll to be more obvious
that they are clk_hw based.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-frac-pll.c |  7 ++++---
 drivers/clk/imx/clk-sscg-pll.c |  4 ++--
 drivers/clk/imx/clk.h          | 12 ++++++++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
index fece503..101e0a3 100644
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -201,8 +201,9 @@ static const struct clk_ops clk_frac_pll_ops = {
 	.set_rate	= clk_pll_set_rate,
 };
 
-struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
-			     void __iomem *base)
+struct clk_hw *imx_clk_hw_frac_pll(const char *name,
+				   const char *parent_name,
+				   void __iomem *base)
 {
 	struct clk_init_data init;
 	struct clk_frac_pll *pll;
@@ -230,5 +231,5 @@ struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
 		return ERR_PTR(ret);
 	}
 
-	return hw->clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk-sscg-pll.c b/drivers/clk/imx/clk-sscg-pll.c
index 0669e17..acd1b90 100644
--- a/drivers/clk/imx/clk-sscg-pll.c
+++ b/drivers/clk/imx/clk-sscg-pll.c
@@ -506,7 +506,7 @@ static const struct clk_ops clk_sscg_pll_ops = {
 	.determine_rate	= clk_sscg_pll_determine_rate,
 };
 
-struct clk *imx_clk_sscg_pll(const char *name,
+struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
 				const char * const *parent_names,
 				u8 num_parents,
 				u8 parent, u8 bypass1, u8 bypass2,
@@ -545,5 +545,5 @@ struct clk *imx_clk_sscg_pll(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	return hw->clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8ffdaca..23c73a2 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -116,6 +116,14 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_pllv2(name, parent, base) \
 	to_clk(imx_clk_hw_pllv2(name, parent, base))
 
+#define imx_clk_frac_pll(name, parent_name, base) \
+	to_clk(imx_clk_hw_frac_pll(name, parent_name, base))
+
+#define imx_clk_sscg_pll(name, parent_names, num_parents, parent,\
+				bypass1, bypass2, base, flags) \
+	to_clk(imx_clk_hw_sscg_pll(name, parent_names, num_parents, parent,\
+				bypass1, bypass2, base, flags))
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
 
@@ -125,10 +133,10 @@ struct clk_hw *imx_clk_hw_pllv1(enum imx_pllv1_type type, const char *name,
 struct clk_hw *imx_clk_hw_pllv2(const char *name, const char *parent,
 		void __iomem *base);
 
-struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_frac_pll(const char *name, const char *parent_name,
 			     void __iomem *base);
 
-struct clk *imx_clk_sscg_pll(const char *name,
+struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
 				const char * const *parent_names,
 				u8 num_parents,
 				u8 parent, u8 bypass1, u8 bypass2,
-- 
2.7.4

