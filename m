Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33CAC00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEC620842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCEFGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:06:08 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59665 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725924AbfCEFGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 00:06:06 -0500
X-UUID: 3a89430512b8437c9de0b7271488aa1e-20190305
X-UUID: 3a89430512b8437c9de0b7271488aa1e-20190305
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1632267032; Tue, 05 Mar 2019 13:05:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Mar 2019 13:05:54 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Mar 2019 13:05:54 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
Subject: [PATCH v5 1/9] clk: mediatek: Disable tuner_en before change PLL rate
Date:   Tue, 5 Mar 2019 13:05:38 +0800
Message-ID: <20190305050546.23431-3-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190305050546.23431-1-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Owen Chen <owen.chen@mediatek.com>

PLLs with tuner_en bit, such as APLL1, need to disable
tuner_en before apply new frequency settings, or the new frequency
settings (pcw) will not be applied.
The tuner_en bit will be disabled during changing PLL rate
and be restored after new settings applied.

Fixes: e2f744a82d725 (clk: mediatek: Add MT2712 clock support)
Cc: <stable@vger.kernel.org>
Signed-off-by: Owen Chen <owen.chen@mediatek.com>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-pll.c | 48 ++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index f54e4015b0b1..18842d660317 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -88,6 +88,32 @@ static unsigned long __mtk_pll_recalc_rate(struct mtk_clk_pll *pll, u32 fin,
 	return ((unsigned long)vco + postdiv - 1) / postdiv;
 }
 
+static void __mtk_pll_tuner_enable(struct mtk_clk_pll *pll)
+{
+	u32 r;
+
+	if (pll->tuner_en_addr) {
+		r = readl(pll->tuner_en_addr) | BIT(pll->data->tuner_en_bit);
+		writel(r, pll->tuner_en_addr);
+	} else if (pll->tuner_addr) {
+		r = readl(pll->tuner_addr) | AUDPLL_TUNER_EN;
+		writel(r, pll->tuner_addr);
+	}
+}
+
+static void __mtk_pll_tuner_disable(struct mtk_clk_pll *pll)
+{
+	u32 r;
+
+	if (pll->tuner_en_addr) {
+		r = readl(pll->tuner_en_addr) & ~BIT(pll->data->tuner_en_bit);
+		writel(r, pll->tuner_en_addr);
+	} else if (pll->tuner_addr) {
+		r = readl(pll->tuner_addr) & ~AUDPLL_TUNER_EN;
+		writel(r, pll->tuner_addr);
+	}
+}
+
 static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 		int postdiv)
 {
@@ -96,6 +122,9 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 
 	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
 
+	/* disable tuner */
+	__mtk_pll_tuner_disable(pll);
+
 	/* set postdiv */
 	val = readl(pll->pd_addr);
 	val &= ~(POSTDIV_MASK << pll->data->pd_shift);
@@ -122,6 +151,9 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 	if (pll->tuner_addr)
 		writel(con1 + 1, pll->tuner_addr);
 
+	/* restore tuner_en */
+	__mtk_pll_tuner_enable(pll);
+
 	if (pll_en)
 		udelay(20);
 }
@@ -228,13 +260,7 @@ static int mtk_pll_prepare(struct clk_hw *hw)
 	r |= pll->data->en_mask;
 	writel(r, pll->base_addr + REG_CON0);
 
-	if (pll->tuner_en_addr) {
-		r = readl(pll->tuner_en_addr) | BIT(pll->data->tuner_en_bit);
-		writel(r, pll->tuner_en_addr);
-	} else if (pll->tuner_addr) {
-		r = readl(pll->tuner_addr) | AUDPLL_TUNER_EN;
-		writel(r, pll->tuner_addr);
-	}
+	__mtk_pll_tuner_enable(pll);
 
 	udelay(20);
 
@@ -258,13 +284,7 @@ static void mtk_pll_unprepare(struct clk_hw *hw)
 		writel(r, pll->base_addr + REG_CON0);
 	}
 
-	if (pll->tuner_en_addr) {
-		r = readl(pll->tuner_en_addr) & ~BIT(pll->data->tuner_en_bit);
-		writel(r, pll->tuner_en_addr);
-	} else if (pll->tuner_addr) {
-		r = readl(pll->tuner_addr) & ~AUDPLL_TUNER_EN;
-		writel(r, pll->tuner_addr);
-	}
+	__mtk_pll_tuner_disable(pll);
 
 	r = readl(pll->base_addr + REG_CON0);
 	r &= ~CON0_BASE_EN;
-- 
2.18.0

