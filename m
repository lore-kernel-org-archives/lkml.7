Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4C7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC306214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfLKJ0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:26:44 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42562 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbfLKJ0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:26:06 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA4A220098F;
        Wed, 11 Dec 2019 10:26:03 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BD87F20026A;
        Wed, 11 Dec 2019 10:26:03 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 46FF620568;
        Wed, 11 Dec 2019 10:26:03 +0100 (CET)
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
Subject: [RESEND v2 03/11] clk: imx: Replace all the clk based helpers with macros
Date:   Wed, 11 Dec 2019 11:25:42 +0200
Message-Id: <1576056350-20715-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576056350-20715-1-git-send-email-abel.vesa@nxp.com>
References: <1576056350-20715-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing with macros all the clk based API helpers we reduce the code
duplication. The end goal is to get rid of all these macros when there
will be no more users of the clk based API, that is, when all the i.MX
clock provider drivers will be switched completely to the clk_hw based
API.

This is another step in moving away from the non clk_hw based API usage
throughout the i.MX clock drivers. The reason for doing that is to
have a clear split between the clock provider and the clock consumer API.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.h | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 4770a03..62b7c14 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -71,12 +71,24 @@ extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 #define imx_clk_gate_exclusive(name, parent, reg, shift, exclusive_mask) \
 	to_clk(imx_clk_hw_gate_exclusive(name, parent, reg, shift, exclusive_mask))
 
+#define imx_clk_fixed(name, rate) \
+	to_clk(imx_clk_hw_fixed(name, rate))
+
 #define imx_clk_fixed_factor(name, parent, mult, div) \
 	to_clk(imx_clk_hw_fixed_factor(name, parent, mult, div))
 
+#define imx_clk_divider(name, parent, reg, shift, width) \
+	to_clk(imx_clk_hw_divider(name, parent, reg, shift, width))
+
 #define imx_clk_divider2(name, parent, reg, shift, width) \
 	to_clk(imx_clk_hw_divider2(name, parent, reg, shift, width))
 
+#define imx_clk_divider_flags(name, parent, reg, shift, width, flags) \
+	to_clk(imx_clk_hw_divider_flags(name, parent, reg, shift, width, flags))
+
+#define imx_clk_gate(name, parent, reg, shift) \
+	to_clk(imx_clk_hw_gate(name, parent, reg, shift))
+
 #define imx_clk_gate_dis(name, parent, reg, shift) \
 	to_clk(imx_clk_hw_gate_dis(name, parent, reg, shift))
 
@@ -206,11 +218,6 @@ static inline struct clk *to_clk(struct clk_hw *hw)
 	return hw->clk;
 }
 
-static inline struct clk *imx_clk_fixed(const char *name, int rate)
-{
-	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
-}
-
 static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
 {
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
@@ -232,13 +239,6 @@ static inline struct clk_hw *imx_clk_hw_fixed_factor(const char *name,
 			CLK_SET_RATE_PARENT, mult, div);
 }
 
-static inline struct clk *imx_clk_divider(const char *name, const char *parent,
-		void __iomem *reg, u8 shift, u8 width)
-{
-	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
-			reg, shift, width, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_divider(const char *name,
 						const char *parent,
 						void __iomem *reg, u8 shift,
@@ -248,14 +248,6 @@ static inline struct clk_hw *imx_clk_hw_divider(const char *name,
 				       reg, shift, width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk *imx_clk_divider_flags(const char *name,
-		const char *parent, void __iomem *reg, u8 shift, u8 width,
-		unsigned long flags)
-{
-	return clk_register_divider(NULL, name, parent, flags,
-			reg, shift, width, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_divider_flags(const char *name,
 						   const char *parent,
 						   void __iomem *reg, u8 shift,
@@ -282,13 +274,6 @@ static inline struct clk *imx_clk_divider2_flags(const char *name,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
-static inline struct clk *imx_clk_gate(const char *name, const char *parent,
-		void __iomem *reg, u8 shift)
-{
-	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_gate_flags(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, unsigned long flags)
 {
-- 
2.7.4

