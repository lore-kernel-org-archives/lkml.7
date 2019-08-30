Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E8C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4361723405
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfH3HPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:15:36 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:63127 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbfH3HPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:15:17 -0400
X-UUID: 7c375393aa2041aab66d6e541707b36f-20190830
X-UUID: 7c375393aa2041aab66d6e541707b36f-20190830
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1773231967; Fri, 30 Aug 2019 15:15:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 15:15:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 15:15:14 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 09/11] phy: phy-mtk-tphy: remove unused u3phya_ref clock
Date:   Fri, 30 Aug 2019 15:14:56 +0800
Message-ID: <1567149298-29366-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567149298-29366-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1567149298-29366-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 50916D6C08F2C6DD0F4EE15C240C8747F061D63966345F4D9CA9A79D2CE459DA2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The u3phya_ref clock is already moved into sub-node, and
renamed as ref clock, no used anymore now, so remove it,
this can avoid confusion when support new platforms

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 96c62e3a3300..c6424fd2a06d 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -312,8 +312,6 @@ struct mtk_phy_instance {
 struct mtk_tphy {
 	struct device *dev;
 	void __iomem *sif_base;	/* only shared sif */
-	/* deprecated, use @ref_clk instead in phy instance */
-	struct clk *u3phya_ref;	/* reference clock of usb3 anolog phy */
 	const struct mtk_phy_pdata *pdata;
 	struct mtk_phy_instance **phys;
 	int nphys;
@@ -921,12 +919,6 @@ static int mtk_phy_init(struct phy *phy)
 	struct mtk_tphy *tphy = dev_get_drvdata(phy->dev.parent);
 	int ret;
 
-	ret = clk_prepare_enable(tphy->u3phya_ref);
-	if (ret) {
-		dev_err(tphy->dev, "failed to enable u3phya_ref\n");
-		return ret;
-	}
-
 	ret = clk_prepare_enable(instance->ref_clk);
 	if (ret) {
 		dev_err(tphy->dev, "failed to enable ref_clk\n");
@@ -992,7 +984,6 @@ static int mtk_phy_exit(struct phy *phy)
 		u2_phy_instance_exit(tphy, instance);
 
 	clk_disable_unprepare(instance->ref_clk);
-	clk_disable_unprepare(tphy->u3phya_ref);
 	return 0;
 }
 
@@ -1127,11 +1118,6 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* it's deprecated, make it optional for backward compatibility */
-	tphy->u3phya_ref = devm_clk_get_optional(dev, "u3phya_ref");
-	if (IS_ERR(tphy->u3phya_ref))
-		return PTR_ERR(tphy->u3phya_ref);
-
 	tphy->src_ref_clk = U3P_REF_CLK;
 	tphy->src_coef = U3P_SLEW_RATE_COEF;
 	/* update parameters of slew rate calibrate if exist */
@@ -1178,10 +1164,6 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 		phy_set_drvdata(phy, instance);
 		port++;
 
-		/* if deprecated clock is provided, ignore instance's one */
-		if (tphy->u3phya_ref)
-			continue;
-
 		instance->ref_clk = devm_clk_get_optional(&phy->dev, "ref");
 		if (IS_ERR(instance->ref_clk)) {
 			dev_err(dev, "failed to get ref_clk(id-%d)\n", port);
-- 
2.23.0

