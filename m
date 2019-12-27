Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61770C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E6920CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 09:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfL0Jqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 04:46:31 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:21110 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfL0Jqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 04:46:31 -0500
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 27 Dec 2019
 17:46:34 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 2/5] clk: meson: add support for A1 PLL clock ops
Date:   Fri, 27 Dec 2019 17:46:03 +0800
Message-ID: <20191227094606.143637-3-jian.hu@amlogic.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191227094606.143637-1-jian.hu@amlogic.com>
References: <20191227094606.143637-1-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared with the previous SoCs, self-adaption module current
is newly added for A1, And there is no reset parm except the
fixed pll. In A1 PLL the PLL enable sequence is different, Using
the new power-on sequence to enable the PLL.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 40 ++++++++++++++++++++++++++++++++-----
 drivers/clk/meson/clk-pll.h |  2 ++
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index ddb1e5634739..9eb7d465d123 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -283,10 +283,14 @@ static void meson_clk_pll_init(struct clk_hw *hw)
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
 	if (pll->init_count) {
-		meson_parm_write(clk->map, &pll->rst, 1);
+		if (MESON_PARM_APPLICABLE(&pll->rst))
+			meson_parm_write(clk->map, &pll->rst, 1);
+
 		regmap_multi_reg_write(clk->map, pll->init_regs,
 				       pll->init_count);
-		meson_parm_write(clk->map, &pll->rst, 0);
+
+		if (MESON_PARM_APPLICABLE(&pll->rst))
+			meson_parm_write(clk->map, &pll->rst, 0);
 	}
 }
 
@@ -294,9 +298,12 @@ static int meson_clk_pll_is_enabled(struct clk_hw *hw)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+	int ret = 0;
 
-	if (meson_parm_read(clk->map, &pll->rst) ||
-	    !meson_parm_read(clk->map, &pll->en) ||
+	if (MESON_PARM_APPLICABLE(&pll->rst))
+		ret = meson_parm_read(clk->map, &pll->rst);
+
+	if (ret || !meson_parm_read(clk->map, &pll->en) ||
 	    !meson_parm_read(clk->map, &pll->l))
 		return 0;
 
@@ -321,6 +328,23 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	/* do nothing if the PLL is already enabled */
 	if (clk_hw_is_enabled(hw))
 		return 0;
+	/*
+	 * Compared with the previous SoCs, self-adaption module current
+	 * is newly added for A1, keep the new power-on sequence to enable the
+	 * PLL.
+	 */
+	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
+		/* Enable the pll */
+		meson_parm_write(clk->map, &pll->en, 1);
+		udelay(10);
+		/* Enable the pll self-adaption module current */
+		meson_parm_write(clk->map, &pll->current_en, 1);
+		udelay(40);
+		/* Enable lock detect module */
+		meson_parm_write(clk->map, &pll->l_detect, 1);
+		meson_parm_write(clk->map, &pll->l_detect, 0);
+		goto out;
+	}
 
 	/* Make sure the pll is in reset */
 	meson_parm_write(clk->map, &pll->rst, 1);
@@ -331,6 +355,7 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	/* Take the pll out reset */
 	meson_parm_write(clk->map, &pll->rst, 0);
 
+out:
 	if (meson_clk_pll_wait_lock(hw))
 		return -EIO;
 
@@ -343,10 +368,15 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
 	/* Put the pll is in reset */
-	meson_parm_write(clk->map, &pll->rst, 1);
+	if (MESON_PARM_APPLICABLE(&pll->rst))
+		meson_parm_write(clk->map, &pll->rst, 1);
 
 	/* Disable the pll */
 	meson_parm_write(clk->map, &pll->en, 0);
+
+	/* Disable PLL internal self-adaption module current */
+	if (MESON_PARM_APPLICABLE(&pll->current_en))
+		meson_parm_write(clk->map, &pll->current_en, 0);
 }
 
 static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 367efd0f6410..a2228c0fdce5 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -36,6 +36,8 @@ struct meson_clk_pll_data {
 	struct parm frac;
 	struct parm l;
 	struct parm rst;
+	struct parm current_en;
+	struct parm l_detect;
 	const struct reg_sequence *init_regs;
 	unsigned int init_count;
 	const struct pll_params_table *table;
-- 
2.24.0

