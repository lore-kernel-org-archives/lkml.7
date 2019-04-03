Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30658C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A7A2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDCJo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:44:27 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:46258 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDCJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:44:27 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.129])
        by regular1.263xmail.com (Postfix) with ESMTP id 8CAC675C;
        Wed,  3 Apr 2019 17:44:22 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26871T139922146150144S1554284659844462_;
        Wed, 03 Apr 2019 17:44:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3f014b76466a981cf48f8baaa8ddc16e>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 6/6] clk: rockchip: support pll setting by auto
Date:   Wed,  3 Apr 2019 17:44:23 +0800
Message-Id: <1554284663-28570-1-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com>
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If setting freq is not support in rockchip_pll_rate_table,
It can calculate and set pll params by auto.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-pll.c | 215 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 200 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 9fe1227e77e9..e718a791b8c2 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -23,6 +23,7 @@
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <linux/gcd.h>
 #include "clk.h"
 
 #define PLL_MODE_MASK		0x3
@@ -55,6 +56,198 @@ struct rockchip_clk_pll {
 #define to_rockchip_clk_pll_nb(nb) \
 			container_of(nb, struct rockchip_clk_pll, clk_nb)
 
+#define MHZ			(1000UL * 1000UL)
+#define KHZ			(1000UL)
+
+/* CLK_PLL_TYPE_RK3066_AUTO type ops */
+#define PLL_FREF_MIN		(269 * KHZ)
+#define PLL_FREF_MAX		(2200 * MHZ)
+
+#define PLL_FVCO_MIN		(440 * MHZ)
+#define PLL_FVCO_MAX		(2200 * MHZ)
+
+#define PLL_FOUT_MIN		(27500 * KHZ)
+#define PLL_FOUT_MAX		(2200 * MHZ)
+
+#define PLL_NF_MAX		(4096)
+#define PLL_NR_MAX		(64)
+#define PLL_NO_MAX		(16)
+
+/* CLK_PLL_TYPE_RK3036/3366/3399_AUTO type ops */
+#define MIN_FOUTVCO_FREQ	(800 * MHZ)
+#define MAX_FOUTVCO_FREQ	(2000 * MHZ)
+
+static struct rockchip_pll_rate_table auto_table;
+
+static struct rockchip_pll_rate_table *rk_pll_rate_table_get(void)
+{
+	return &auto_table;
+}
+
+static int rockchip_pll_clk_set_postdiv(unsigned long fout_hz,
+					u32 *postdiv1,
+					u32 *postdiv2,
+					u32 *foutvco)
+{
+	unsigned long freq;
+
+	if (fout_hz < MIN_FOUTVCO_FREQ) {
+		for (*postdiv1 = 1; *postdiv1 <= 7; (*postdiv1)++) {
+			for (*postdiv2 = 1; *postdiv2 <= 7; (*postdiv2)++) {
+				freq = fout_hz * (*postdiv1) * (*postdiv2);
+				if (freq >= MIN_FOUTVCO_FREQ &&
+				    freq <= MAX_FOUTVCO_FREQ) {
+					*foutvco = freq;
+					return 0;
+				}
+			}
+		}
+		pr_err("CANNOT FIND postdiv1/2 to make fout in range from 800M to 2000M,fout = %lu\n",
+		       fout_hz);
+	} else {
+		*postdiv1 = 1;
+		*postdiv2 = 1;
+	}
+	return 0;
+}
+
+static struct rockchip_pll_rate_table *
+rockchip_pll_clk_set_by_auto(struct rockchip_clk_pll *pll,
+			     unsigned long fin_hz,
+			     unsigned long fout_hz)
+{
+	struct rockchip_pll_rate_table *rate_table = rk_pll_rate_table_get();
+	/* FIXME set postdiv1/2 always 1*/
+	u32 foutvco = fout_hz;
+	u64 fin_64, frac_64;
+	u32 f_frac, postdiv1, postdiv2;
+	unsigned long clk_gcd = 0;
+
+	if (fin_hz == 0 || fout_hz == 0 || fout_hz == fin_hz)
+		return NULL;
+
+	rockchip_pll_clk_set_postdiv(fout_hz, &postdiv1, &postdiv2, &foutvco);
+	rate_table->postdiv1 = postdiv1;
+	rate_table->postdiv2 = postdiv2;
+	rate_table->dsmpd = 1;
+
+	if (fin_hz / MHZ * MHZ == fin_hz && fout_hz / MHZ * MHZ == fout_hz) {
+		fin_hz /= MHZ;
+		foutvco /= MHZ;
+		clk_gcd = gcd(fin_hz, foutvco);
+		rate_table->refdiv = fin_hz / clk_gcd;
+		rate_table->fbdiv = foutvco / clk_gcd;
+
+		rate_table->frac = 0;
+
+		pr_debug("fin = %lu, fout = %lu, clk_gcd = %lu, refdiv = %u, fbdiv = %u, postdiv1 = %u, postdiv2 = %u, frac = %u\n",
+			 fin_hz, fout_hz, clk_gcd, rate_table->refdiv,
+			 rate_table->fbdiv, rate_table->postdiv1,
+			 rate_table->postdiv2, rate_table->frac);
+	} else {
+		pr_debug("frac div running, fin_hz = %lu, fout_hz = %lu, fin_INT_mhz = %lu, fout_INT_mhz = %lu\n",
+			 fin_hz, fout_hz,
+			 fin_hz / MHZ * MHZ,
+			 fout_hz / MHZ * MHZ);
+		pr_debug("frac get postdiv1 = %u,  postdiv2 = %u, foutvco = %u\n",
+			 rate_table->postdiv1, rate_table->postdiv2, foutvco);
+		clk_gcd = gcd(fin_hz / MHZ, foutvco / MHZ);
+		rate_table->refdiv = fin_hz / MHZ / clk_gcd;
+		rate_table->fbdiv = foutvco / MHZ / clk_gcd;
+		pr_debug("frac get refdiv = %u,  fbdiv = %u\n",
+			 rate_table->refdiv, rate_table->fbdiv);
+
+		rate_table->frac = 0;
+
+		f_frac = (foutvco % MHZ);
+		fin_64 = fin_hz;
+		do_div(fin_64, (u64)rate_table->refdiv);
+		frac_64 = (u64)f_frac << 24;
+		do_div(frac_64, fin_64);
+		rate_table->frac = (u32)frac_64;
+		if (rate_table->frac > 0)
+			rate_table->dsmpd = 0;
+		pr_debug("frac = %x\n", rate_table->frac);
+	}
+	return rate_table;
+}
+
+static struct rockchip_pll_rate_table *
+rockchip_rk3066_pll_clk_set_by_auto(struct rockchip_clk_pll *pll,
+				    unsigned long fin_hz,
+				    unsigned long fout_hz)
+{
+	struct rockchip_pll_rate_table *rate_table = rk_pll_rate_table_get();
+	u32 nr, nf, no, nonr;
+	u32 nr_out, nf_out, no_out;
+	u32 n;
+	u32 numerator, denominator;
+	u64 fref, fvco, fout;
+	unsigned long clk_gcd = 0;
+
+	nr_out = PLL_NR_MAX + 1;
+	no_out = 0;
+	nf_out = 0;
+
+	if (fin_hz == 0 || fout_hz == 0 || fout_hz == fin_hz)
+		return NULL;
+
+	clk_gcd = gcd(fin_hz, fout_hz);
+
+	numerator = fout_hz / clk_gcd;
+	denominator = fin_hz / clk_gcd;
+
+	for (n = 1;; n++) {
+		nf = numerator * n;
+		nonr = denominator * n;
+		if (nf > PLL_NF_MAX || nonr > (PLL_NO_MAX * PLL_NR_MAX))
+			break;
+
+		for (no = 1; no <= PLL_NO_MAX; no++) {
+			if (!(no == 1 || !(no % 2)))
+				continue;
+
+			if (nonr % no)
+				continue;
+			nr = nonr / no;
+
+			if (nr > PLL_NR_MAX)
+				continue;
+
+			fref = fin_hz / nr;
+			if (fref < PLL_FREF_MIN || fref > PLL_FREF_MAX)
+				continue;
+
+			fvco = fref * nf;
+			if (fvco < PLL_FVCO_MIN || fvco > PLL_FVCO_MAX)
+				continue;
+
+			fout = fvco / no;
+			if (fout < PLL_FOUT_MIN || fout > PLL_FOUT_MAX)
+				continue;
+
+			/* select the best from all available PLL settings */
+			if ((no > no_out) ||
+			    ((no == no_out) && (nr < nr_out))) {
+				nr_out = nr;
+				nf_out = nf;
+				no_out = no;
+			}
+		}
+	}
+
+	/* output the best PLL setting */
+	if ((nr_out <= PLL_NR_MAX) && (no_out > 0)) {
+		rate_table->nr = nr_out;
+		rate_table->nf = nf_out;
+		rate_table->no = no_out;
+	} else {
+		return NULL;
+	}
+
+	return rate_table;
+}
+
 static const struct rockchip_pll_rate_table *rockchip_get_pll_settings(
 			    struct rockchip_clk_pll *pll, unsigned long rate)
 {
@@ -66,24 +259,16 @@ static const struct rockchip_pll_rate_table *rockchip_get_pll_settings(
 			return &rate_table[i];
 	}
 
-	return NULL;
+	if (pll->type == pll_rk3066)
+		return rockchip_rk3066_pll_clk_set_by_auto(pll, 24 * MHZ, rate);
+	else
+		return rockchip_pll_clk_set_by_auto(pll, 24 * MHZ, rate);
 }
 
 static long rockchip_pll_round_rate(struct clk_hw *hw,
 			    unsigned long drate, unsigned long *prate)
 {
-	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
-	const struct rockchip_pll_rate_table *rate_table = pll->rate_table;
-	int i;
-
-	/* Assumming rate_table is in descending order */
-	for (i = 0; i < pll->rate_count; i++) {
-		if (drate >= rate_table[i].rate)
-			return rate_table[i].rate;
-	}
-
-	/* return minimum supported value */
-	return rate_table[i - 1].rate;
+	return drate;
 }
 
 /*
@@ -163,7 +348,7 @@ static unsigned long rockchip_rk3036_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
 	struct rockchip_pll_rate_table cur;
-	u64 rate64 = prate;
+	u64 rate64 = prate, frac_rate64 = prate;
 
 	rockchip_rk3036_pll_get_params(pll, &cur);
 
@@ -172,7 +357,7 @@ static unsigned long rockchip_rk3036_pll_recalc_rate(struct clk_hw *hw,
 
 	if (cur.dsmpd == 0) {
 		/* fractional mode */
-		u64 frac_rate64 = prate * cur.frac;
+		frac_rate64 *= cur.frac;
 
 		do_div(frac_rate64, cur.refdiv);
 		rate64 += frac_rate64 >> 24;
-- 
1.9.1



