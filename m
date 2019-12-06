Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F309C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBCB24658
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfLFHlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:41:15 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:26913 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfLFHlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:41:12 -0500
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 6 Dec 2019
 15:41:36 +0800
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
Subject: [PATCH v4 2/6] clk: meson: add support for A1 PLL clock ops
Date:   Fri, 6 Dec 2019 15:40:48 +0800
Message-ID: <20191206074052.15557-3-jian.hu@amlogic.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206074052.15557-1-jian.hu@amlogic.com>
References: <20191206074052.15557-1-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A1 PLL design is different with previous SoCs. The PLL
internal analog modules Power-on sequence is different
with previous, and thus requires a strict register sequence to
enable the PLL.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 21 +++++++++++++++++++++
 drivers/clk/meson/clk-pll.h |  1 +
 drivers/clk/meson/parm.h    |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index ddb1e5634739..4aff31a51589 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -318,6 +318,23 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 
+	/*
+	 * The A1 design is different with previous SoCs.The PLL
+	 * internal analog modules Power-on sequence is different with
+	 * previous, and thus requires a strict register sequence to
+	 * enable the PLL.
+	 */
+	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
+		/* Enable the pll */
+		meson_parm_write(clk->map, &pll->en, 1);
+		udelay(10);
+		/* Enable the pll self-adaption module current */
+		meson_parm_write(clk->map, &pll->current_en, 1);
+		udelay(40);
+		meson_parm_write(clk->map, &pll->rst, 1);
+		meson_parm_write(clk->map, &pll->rst, 0);
+	}
+
 	/* do nothing if the PLL is already enabled */
 	if (clk_hw_is_enabled(hw))
 		return 0;
@@ -347,6 +364,10 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
 
 	/* Disable the pll */
 	meson_parm_write(clk->map, &pll->en, 0);
+
+	/* Disable PLL internal self-adaption module current */
+	if (MESON_PARM_APPLICABLE(&pll->current_en))
+		meson_parm_write(clk->map, &pll->current_en, 0);
 }
 
 static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 367efd0f6410..30f039242a65 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -36,6 +36,7 @@ struct meson_clk_pll_data {
 	struct parm frac;
 	struct parm l;
 	struct parm rst;
+	struct parm current_en;
 	const struct reg_sequence *init_regs;
 	unsigned int init_count;
 	const struct pll_params_table *table;
diff --git a/drivers/clk/meson/parm.h b/drivers/clk/meson/parm.h
index 3c9ef1b505ce..c53fb26577e3 100644
--- a/drivers/clk/meson/parm.h
+++ b/drivers/clk/meson/parm.h
@@ -20,6 +20,7 @@
 	(((reg) & CLRPMASK(width, shift)) | ((val) << (shift)))
 
 #define MESON_PARM_APPLICABLE(p)		(!!((p)->width))
+#define MESON_PARM_CURRENT(p)			(!!((p)->width))
 
 struct parm {
 	u16	reg_off;
-- 
2.24.0

