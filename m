Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F4CC74A59
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C816521019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 15:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfGKPMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:12:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44696 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfGKPMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 11:12:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 237121A09EA;
        Thu, 11 Jul 2019 17:12:09 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 167A21A00DD;
        Thu, 11 Jul 2019 17:12:09 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B39D205E4;
        Thu, 11 Jul 2019 17:12:08 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] clk: imx: Remove unused clk based API
Date:   Thu, 11 Jul 2019 18:11:50 +0300
Message-Id: <1562857910-29501-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the i.MX6 and i.MX7 clock drivers have been switched to clk_hw based,
we can remove the clk based API that is not used by any i.MX clock driver.

The following APIs are going away now:
- imx_clk_busy_divider
- imx_clk_busy_mux
- imx_clk_fixup_divider
- imx_clk_fixup_mux
- imx_clk_mux_ldb
- imx_clk_gate_dis_flags
- imx_clk_gate_flags

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d94d9cb..592eca1 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -50,12 +50,6 @@ struct imx_pll14xx_clk {
 	int flags;
 };
 
-#define imx_clk_busy_divider(name, parent_name, reg, shift, width, busy_reg, busy_shift) \
-	imx_clk_hw_busy_divider(name, parent_name, reg, shift, width, busy_reg, busy_shift)->clk
-
-#define imx_clk_busy_mux(name, reg, shift, width, busy_reg, busy_shift, parent_names, num_parents) \
-	imx_clk_hw_busy_mux(name, reg, shift, width, busy_reg, busy_shift, parent_names, num_parents)->clk
-
 #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
 	imx_clk_hw_cpu(name, parent_name, div, mux, pll, step)->clk
 
@@ -73,15 +67,6 @@ struct imx_pll14xx_clk {
 #define imx_clk_gate_exclusive(name, parent, reg, shift, exclusive_mask) \
 	imx_clk_hw_gate_exclusive(name, parent, reg, shift, exclusive_mask)->clk
 
-#define imx_clk_fixup_divider(name, parent, reg, shift, width, fixup) \
-	imx_clk_hw_fixup_divider(name, parent, reg, shift, width, fixup)->clk
-
-#define imx_clk_fixup_mux(name, reg, shift, width, parents, num_parents, fixup) \
-	imx_clk_hw_fixup_mux(name, reg, shift, width, parents, num_parents, fixup)->clk
-
-#define imx_clk_mux_ldb(name, reg, shift, width, parents, num_parents) \
-	imx_clk_hw_mux_ldb(name, reg, shift, width, parents, num_parents)->clk
-
 #define imx_clk_fixed_factor(name, parent, mult, div) \
 	imx_clk_hw_fixed_factor(name, parent, mult, div)->clk
 
@@ -91,21 +76,12 @@ struct imx_pll14xx_clk {
 #define imx_clk_gate_dis(name, parent, reg, shift) \
 	imx_clk_hw_gate_dis(name, parent, reg, shift)->clk
 
-#define imx_clk_gate_dis_flags(name, parent, reg, shift, flags) \
-	imx_clk_hw_gate_dis_flags(name, parent, reg, shift, flags)->clk
-
-#define imx_clk_gate_flags(name, parent, reg, shift, flags) \
-	imx_clk_hw_gate_flags(name, parent, reg, shift, flags)->clk
-
 #define imx_clk_gate2(name, parent, reg, shift) \
 	imx_clk_hw_gate2(name, parent, reg, shift)->clk
 
 #define imx_clk_gate2_flags(name, parent, reg, shift, flags) \
 	imx_clk_hw_gate2_flags(name, parent, reg, shift, flags)->clk
 
-#define imx_clk_gate2_shared(name, parent, reg, shift, share_count) \
-	imx_clk_hw_gate2_shared(name, parent, reg, shift, share_count)->clk
-
 #define imx_clk_gate2_shared2(name, parent, reg, shift, share_count) \
 	imx_clk_hw_gate2_shared2(name, parent, reg, shift, share_count)->clk
 
-- 
2.7.4

