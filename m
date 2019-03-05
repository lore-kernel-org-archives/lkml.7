Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD11C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC7320675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 05:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCEFGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 00:06:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:31470 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725976AbfCEFGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 00:06:06 -0500
X-UUID: 758242b7fb5f4a98a5a24eedca018f23-20190305
X-UUID: 758242b7fb5f4a98a5a24eedca018f23-20190305
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1443501067; Tue, 05 Mar 2019 13:05:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 5 Mar 2019 13:05:55 +0800
Received: from mtkslt210.mediatek.inc (10.21.14.14) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Mar 2019 13:05:55 +0800
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
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v5 7/9] clk: mediatek: Add configurable pcw_chg_reg to mtk_pll_data
Date:   Tue, 5 Mar 2019 13:05:44 +0800
Message-ID: <20190305050546.23431-9-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190305050546.23431-1-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A427876116C948A4DDBDA531EEA06691223D362E671A29201BA8EDB6E0A0F2A72000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous MediaTek PLL design, it assumes the pcw change control
is always on the CON1 register.
However, the pcw change bit on MT8183 was moved onto CON0 because
the the PCW length of audio PLLs are extended to 32-bit.
Add configurable pcw_chg_reg to set the pcw change control register
address or using the default control register CON1 if without
setting in pll data.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.h |  1 +
 drivers/clk/mediatek/clk-pll.c | 17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 928905496c4b..37ae944548e9 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -221,6 +221,7 @@ struct mtk_pll_data {
 	int pcwibits;
 	uint32_t pcw_reg;
 	int pcw_shift;
+	uint32_t pcw_chg_reg;
 	const struct mtk_pll_div_table *div_table;
 	const char *parent_name;
 };
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 67aaa3082d9b..65cee1d6c400 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -27,7 +27,7 @@
 #define CON0_BASE_EN		BIT(0)
 #define CON0_PWR_ON		BIT(0)
 #define CON0_ISO_EN		BIT(1)
-#define CON0_PCW_CHG		BIT(31)
+#define PCW_CHG_MASK		BIT(31)
 
 #define AUDPLL_TUNER_EN		BIT(31)
 
@@ -51,6 +51,7 @@ struct mtk_clk_pll {
 	void __iomem	*tuner_addr;
 	void __iomem	*tuner_en_addr;
 	void __iomem	*pcw_addr;
+	void __iomem	*pcw_chg_addr;
 	const struct mtk_pll_data *data;
 };
 
@@ -122,7 +123,7 @@ static void __mtk_pll_tuner_disable(struct mtk_clk_pll *pll)
 static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 		int postdiv)
 {
-	u32 con1, val;
+	u32 chg, val;
 	int pll_en;
 
 	pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
@@ -147,14 +148,14 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 	val |= pcw << pll->data->pcw_shift;
 	writel(val, pll->pcw_addr);
 
-	con1 = readl(pll->base_addr + REG_CON1);
+	chg = readl(pll->pcw_chg_addr);
 
 	if (pll_en)
-		con1 |= CON0_PCW_CHG;
+		chg |= PCW_CHG_MASK;
 
-	writel(con1, pll->base_addr + REG_CON1);
+	writel(chg, pll->pcw_chg_addr);
 	if (pll->tuner_addr)
-		writel(con1 + 1, pll->tuner_addr);
+		writel(val + 1, pll->tuner_addr);
 
 	/* restore tuner_en */
 	__mtk_pll_tuner_enable(pll);
@@ -329,6 +330,10 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
 	pll->pwr_addr = base + data->pwr_reg;
 	pll->pd_addr = base + data->pd_reg;
 	pll->pcw_addr = base + data->pcw_reg;
+	if (data->pcw_chg_reg)
+		pll->pcw_chg_addr = base + data->pcw_chg_reg;
+	else
+		pll->pcw_chg_addr = pll->base_addr + REG_CON1;
 	if (data->tuner_reg)
 		pll->tuner_addr = base + data->tuner_reg;
 	if (data->tuner_en_reg)
-- 
2.18.0

