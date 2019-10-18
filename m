Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF494CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E70421D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504572AbfJRHPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:15:06 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:44105 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfJRHPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:15:05 -0400
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 18 Oct 2019
 15:14:38 +0800
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
Subject: [PATCH v2 2/3] clk: meson: add support for A1 PLL clock ops
Date:   Fri, 18 Oct 2019 15:14:24 +0800
Message-ID: <1571382865-41978-3-git-send-email-jian.hu@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571382865-41978-1-git-send-email-jian.hu@amlogic.com>
References: <1571382865-41978-1-git-send-email-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A1 PLL design is different with previous SoCs. The PLL
internal analog modules Power-on sequence is different
with previous, and thus requires a strict register sequence to
enable the PLL. Unlike the previous series, the maximum frequency
is 6G in G12A, for A1 the maximum is 1536M.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/clk/meson/clk-pll.h |  1 +
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index ddb1e56..b440e62 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -349,6 +349,56 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
 	meson_parm_write(clk->map, &pll->en, 0);
 }
 
+/*
+ * The A1 design is different with previous SoCs.The PLL
+ * internal analog modules Power-on sequence is different with
+ * previous, different PLL has the different sequence, and
+ * thus requires a strict register sequence to enable the PLL.
+ * When set a new target frequency, the sequence should keep
+ * the same with the initial sequence. Unlike the previous series,
+ * the maximum frequency is 6G in G12A, for A1 the maximum
+ * is 1536M.
+ */
+static void meson_params_update_with_init_seq(struct clk_regmap *clk,
+				       struct meson_clk_pll_data *pll,
+				       unsigned int m, unsigned int n,
+				       unsigned int frac)
+{
+	struct parm *pm = &pll->m;
+	struct parm *pn = &pll->n;
+	struct parm *pfrac = &pll->frac;
+	const struct reg_sequence *init_regs = pll->init_regs;
+	unsigned int i, val;
+
+	for (i = 0; i < pll->init_count; i++) {
+		if (pn->reg_off == init_regs[i].reg) {
+			/* Clear M N bits and Update M N value */
+			val = init_regs[i].def;
+			val &= CLRPMASK(pn->width, pn->shift);
+			val &= CLRPMASK(pm->width, pm->shift);
+			val |= n << pn->shift;
+			val |= m << pm->shift;
+			regmap_write(clk->map, pn->reg_off, val);
+		} else if (MESON_PARM_APPLICABLE(&pll->frac) &&
+			   (pfrac->reg_off == init_regs[i].reg)) {
+			/* Clear Frac bits and Update Frac value */
+			val = init_regs[i].def;
+			val &= CLRPMASK(pfrac->width, pfrac->shift);
+			val |= frac << pfrac->shift;
+			regmap_write(clk->map, pfrac->reg_off, val);
+		} else {
+			/*
+			 * According to the PLL hardware constraint,
+			 * the left registers should be setted again.
+			 */
+			val = init_regs[i].def;
+			regmap_write(clk->map, init_regs[i].reg, val);
+		}
+		if (init_regs[i].delay_us)
+			udelay(init_regs[i].delay_us);
+	}
+}
+
 static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long parent_rate)
 {
@@ -366,16 +416,20 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (ret)
 		return ret;
 
+	if (MESON_PARM_APPLICABLE(&pll->frac))
+		frac = __pll_params_with_frac(rate, parent_rate, m, n, pll);
+
 	enabled = meson_parm_read(clk->map, &pll->en);
 	if (enabled)
 		meson_clk_pll_disable(hw);
 
-	meson_parm_write(clk->map, &pll->n, n);
-	meson_parm_write(clk->map, &pll->m, m);
-
-	if (MESON_PARM_APPLICABLE(&pll->frac)) {
-		frac = __pll_params_with_frac(rate, parent_rate, m, n, pll);
-		meson_parm_write(clk->map, &pll->frac, frac);
+	if (pll->strict_sequence)
+		meson_params_update_with_init_seq(clk, pll, m, n, frac);
+	else {
+		meson_parm_write(clk->map, &pll->n, n);
+		meson_parm_write(clk->map, &pll->m, m);
+		if (MESON_PARM_APPLICABLE(&pll->frac))
+			meson_parm_write(clk->map, &pll->frac, frac);
 	}
 
 	/* If the pll is stopped, bail out now */
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 367efd0..d5789cef 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -41,6 +41,7 @@ struct meson_clk_pll_data {
 	const struct pll_params_table *table;
 	const struct pll_mult_range *range;
 	u8 flags;
+	bool strict_sequence;
 };
 
 extern const struct clk_ops meson_clk_pll_ro_ops;
-- 
1.9.1

