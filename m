Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E1C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1447F2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfDIGxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:53:46 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:8999 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726205AbfDIGxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:53:44 -0400
X-UUID: 7b988eebbf0943bc9aa864fc316494e8-20190409
X-UUID: 7b988eebbf0943bc9aa864fc316494e8-20190409
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wangyan.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1791833000; Tue, 09 Apr 2019 14:53:29 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 9 Apr
 2019 14:53:27 +0800
Received: from mszsdclx1067.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 9 Apr 2019 14:53:26 +0800
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
Subject: [PATCH V10 5/5] drm/mediatek: no change parent rate in round_rate() for mt2701 hdmi phy
Date:   Tue, 9 Apr 2019 14:53:07 +0800
Message-ID: <20190409065307.82280-6-wangyan.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190409065307.82280-1-wangyan.wang@mediatek.com>
References: <20190409065307.82280-1-wangyan.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wangyan Wang <wangyan.wang@mediatek.com>

This is the third step to make MT2701 HDMI stable.
We should not change the rate of parent for hdmi phy when
doing round_rate for this clock. The parent clock of hdmi
phy must be the same as it. We change it when doing set_rate
only.

Signed-off-by: Wangyan Wang <wangyan.wang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c        | 14 --------------
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h        |  2 --
 drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c |  6 ++++++
 drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c | 14 ++++++++++++++
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
index 9e153e080739..e3a6b50e0cf2 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.c
@@ -15,20 +15,6 @@ static const struct phy_ops mtk_hdmi_phy_dev_ops = {
 	.owner = THIS_MODULE,
 };
 
-long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-			     unsigned long *parent_rate)
-{
-	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
-
-	hdmi_phy->pll_rate = rate;
-	if (rate <= 74250000)
-		*parent_rate = rate;
-	else
-		*parent_rate = rate / 2;
-
-	return rate;
-}
-
 void mtk_hdmi_phy_clear_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 			     u32 bits)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
index d28b8d5ed2b4..2d8b3182470d 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_phy.h
@@ -49,8 +49,6 @@ void mtk_hdmi_phy_set_bits(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 void mtk_hdmi_phy_mask(struct mtk_hdmi_phy *hdmi_phy, u32 offset,
 		       u32 val, u32 mask);
 struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
-long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-			     unsigned long *parent_rate);
 
 extern struct platform_driver mtk_hdmi_phy_driver;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
diff --git a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
index b24ea6651db4..e3f05ad89b1e 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c
@@ -106,6 +106,12 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
 	usleep_range(80, 100);
 }
 
+static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	return rate;
+}
+
 static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long parent_rate)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
index 625739b4e938..78c638c29102 100644
--- a/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
+++ b/drivers/gpu/drm/mediatek/mtk_mt8173_hdmi_phy.c
@@ -199,6 +199,20 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
 	usleep_range(100, 150);
 }
 
+long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	hdmi_phy->pll_rate = rate;
+	if (rate <= 74250000)
+		*parent_rate = rate;
+	else
+		*parent_rate = rate / 2;
+
+	return rate;
+}
+
 static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long parent_rate)
 {
-- 
2.14.1

