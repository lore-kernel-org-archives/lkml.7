Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1399BC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D321A2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfDBJgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:36:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:7062 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729695AbfDBJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:36:18 -0400
X-UUID: 5fad853e449346b0bd6c2233d3dd3009-20190402
X-UUID: 5fad853e449346b0bd6c2233d3dd3009-20190402
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2025049961; Tue, 02 Apr 2019 17:36:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 2 Apr
 2019 17:36:12 +0800
Received: from mszsdclx1067.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 2 Apr 2019 17:36:11 +0800
From:   wangyan wang <wangyan.wang@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     wangyan wang <wangyan.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH V8 1/5] drm/mediatek: remove flag CLK_SET_RATE_PARENT for mt2701 hdmi phy to not propagate rate change to parent
Date:   Tue, 2 Apr 2019 17:36:01 +0800
Message-ID: <20190402093605.82004-2-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190402093605.82004-1-wangyan.wang@mediatek.com>
References: <20190402093605.82004-1-wangyan.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wangyan Wang <wangyan.wang@mediatek.com>

This is the first step to make MT2701 hdmi stable.
The parent rate of hdmi phy had set by DPI driver.
We should not set or change the parent rate of MT2701 hdmi phy,
as a result we should remove the flags of "CLK_SET_RATE_PARENT"
from the clock of MT2701 hdmi phy.

Signed-off-by: Wangyan Wang <wangyan.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 13 +++++--------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  1 +
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c |  1 +
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c |  1 +
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
index 4ef9c57ffd44..13bbaf997819 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -110,13 +110,11 @@ mtk_hdmi_phy_dev_get_ops(const struct mtk_hdmi_phy *hdmi_phy)
 		return NULL;
 }
 
-static void mtk_hdmi_phy_clk_get_ops(struct mtk_hdmi_phy *hdmi_phy,
-				     const struct clk_ops **ops)
+static void mtk_hdmi_phy_clk_get_data(struct mtk_hdmi_phy *hdmi_phy,
+				     struct clk_init_data *clk_init)
 {
-	if (hdmi_phy && hdmi_phy->conf && hdmi_phy->conf->hdmi_phy_clk_ops)
-		*ops = hdmi_phy->conf->hdmi_phy_clk_ops;
-	else
-		dev_err(hdmi_phy->dev, "Failed to get clk ops of phy\n");
+	clk_init->flags = hdmi_phy->conf->flags;
+	clk_init->ops = hdmi_phy->conf->hdmi_phy_clk_ops;
 }
 
 static int mtk_hdmi_phy_probe(struct platform_device *pdev)
@@ -129,7 +127,6 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 	struct clk_init_data clk_init = {
 		.num_parents = 1,
 		.parent_names = (const char * const *)&ref_clk_name,
-		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	};
 
 	struct phy *phy;
@@ -167,7 +164,7 @@ static int mtk_hdmi_phy_probe(struct platform_device *pdev)
 	hdmi_phy->dev = dev;
 	hdmi_phy->conf =
 		(struct mtk_hdmi_phy_conf *)of_device_get_match_data(dev);
-	mtk_hdmi_phy_clk_get_ops(hdmi_phy, &clk_init.ops);
+	mtk_hdmi_phy_clk_get_data(hdmi_phy, &clk_init);
 	hdmi_phy->pll_hw.init = &clk_init;
 	hdmi_phy->pll = devm_clk_register(dev, &hdmi_phy->pll_hw);
 	if (IS_ERR(hdmi_phy->pll)) {
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
index f39b1fc66612..0045824c1be9 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -21,6 +21,7 @@ struct mtk_hdmi_phy;
 
 struct mtk_hdmi_phy_conf {
 	bool tz_disabled;
+	unsigned long flags;
 	const struct clk_ops *hdmi_phy_clk_ops;
 	void (*hdmi_phy_enable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
 	void (*hdmi_phy_disable_tmds)(struct mtk_hdmi_phy *hdmi_phy);
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index fcc42dc6ea7f..67a814649e19 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -202,6 +202,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
 
 struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf = {
 	.tz_disabled = true,
+	.flags = CLK_SET_RATE_GATE,
 	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
 	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
 	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index ed5916b27658..f44066875dcd 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -309,6 +309,7 @@ static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
 }
 
 struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf = {
+	.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
 	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
 	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
-- 
2.14.1

