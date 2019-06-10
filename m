Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA898C468BD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC72D2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfFJCQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 22:16:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54986 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729916AbfFJCQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 22:16:29 -0400
X-UUID: 5169d795564c46f4a8375034bc4c54da-20190610
X-UUID: 5169d795564c46f4a8375034bc4c54da-20190610
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1210668403; Mon, 10 Jun 2019 10:16:17 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 10:16:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 10:16:15 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, <stable@vger.kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Dehui Sun <dehui.sun@mediatek.com>
Subject: [PATCH v2] clk: mediatek: mt8183: Register 13MHz clock earlier for clocksource
Date:   Mon, 10 Jun 2019 10:16:09 +0800
Message-ID: <1560132969-1960-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CAC1BC70DE426AEAA8E799500347601E8B809F99947FB5D622F96AFBA05C332B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 13MHz clock should be registered before clocksource driver is
initialized. Use CLK_OF_DECLARE_DRIVER() to guarantee.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 46 +++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 9d86510..bc01611 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -25,9 +25,11 @@
 	FIXED_CLK(CLK_TOP_UNIVP_192M, "univpll_192m", "univpll", 192000000),
 };
 
+static const struct mtk_fixed_factor top_early_divs[] = {
+	FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
+};
+
 static const struct mtk_fixed_factor top_divs[] = {
-	FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1,
-		2),
 	FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1,
 		2),
 	FACTOR(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1,
@@ -1167,37 +1169,57 @@ static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 }
 
+static struct clk_onecell_data *top_clk_data;
+
+static void clk_mt8183_top_init_early(struct device_node *node)
+{
+	int i;
+
+	top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+
+	for (i = 0; i < CLK_TOP_NR_CLK; i++)
+		top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+
+	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
+			top_clk_data);
+
+	of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+}
+
+CLK_OF_DECLARE_DRIVER(mt8183_topckgen, "mediatek,mt8183-topckgen",
+			clk_mt8183_top_init_early);
+
 static int clk_mt8183_top_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	void __iomem *base;
-	struct clk_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
-		clk_data);
+		top_clk_data);
+
+	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
+		top_clk_data);
 
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
 
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
-		node, &mt8183_clk_lock, clk_data);
+		node, &mt8183_clk_lock, top_clk_data);
 
 	mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
-		base, &mt8183_clk_lock, clk_data);
+		base, &mt8183_clk_lock, top_clk_data);
 
 	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
-		base, &mt8183_clk_lock, clk_data);
+		base, &mt8183_clk_lock, top_clk_data);
 
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
-		clk_data);
+		top_clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
 }
 
 static int clk_mt8183_infra_probe(struct platform_device *pdev)
-- 
1.8.1.1.dirty

