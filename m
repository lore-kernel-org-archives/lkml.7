Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204FFC10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDCE218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfC3JMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:12:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52584 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729755AbfC3JMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:12:53 -0400
X-UUID: 33e173a396ad48b99d6bf0e7a68925cb-20190330
X-UUID: 33e173a396ad48b99d6bf0e7a68925cb-20190330
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1464810860; Sat, 30 Mar 2019 17:12:46 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 30 Mar 2019 17:12:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 30 Mar 2019 17:12:44 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 3/4] phy: socionext: get optional clock by devm_clk_get_optional()
Date:   Sat, 30 Mar 2019 17:11:37 +0800
Message-ID: <f3370a0619d40c40676ed029cc04a3ed1c12b991.1553914418.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a8539bcf66065380069676fbea99a51254309803.1553914418.git.chunfeng.yun@mediatek.com>
References: <a8539bcf66065380069676fbea99a51254309803.1553914418.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() to get optional clock

Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/socionext/phy-uniphier-usb3hs.c | 10 +++-------
 drivers/phy/socionext/phy-uniphier-usb3ss.c | 10 +++-------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/socionext/phy-uniphier-usb3hs.c b/drivers/phy/socionext/phy-uniphier-usb3hs.c
index b1b048be6166..50f379fc4e06 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3hs.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
@@ -335,13 +335,9 @@ static int uniphier_u3hsphy_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk_parent))
 		return PTR_ERR(priv->clk_parent);
 
-	priv->clk_ext = devm_clk_get(dev, "phy-ext");
-	if (IS_ERR(priv->clk_ext)) {
-		if (PTR_ERR(priv->clk_ext) == -ENOENT)
-			priv->clk_ext = NULL;
-		else
-			return PTR_ERR(priv->clk_ext);
-	}
+	priv->clk_ext = devm_clk_get_optional(dev, "phy-ext");
+	if (IS_ERR(priv->clk_ext))
+		return PTR_ERR(priv->clk_ext);
 
 	priv->rst = devm_reset_control_get_shared(dev, "phy");
 	if (IS_ERR(priv->rst))
diff --git a/drivers/phy/socionext/phy-uniphier-usb3ss.c b/drivers/phy/socionext/phy-uniphier-usb3ss.c
index 4be95679c7d8..ec231e40ef2a 100644
--- a/drivers/phy/socionext/phy-uniphier-usb3ss.c
+++ b/drivers/phy/socionext/phy-uniphier-usb3ss.c
@@ -238,13 +238,9 @@ static int uniphier_u3ssphy_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->clk))
 			return PTR_ERR(priv->clk);
 
-		priv->clk_ext = devm_clk_get(dev, "phy-ext");
-		if (IS_ERR(priv->clk_ext)) {
-			if (PTR_ERR(priv->clk_ext) == -ENOENT)
-				priv->clk_ext = NULL;
-			else
-				return PTR_ERR(priv->clk_ext);
-		}
+		priv->clk_ext = devm_clk_get_optional(dev, "phy-ext");
+		if (IS_ERR(priv->clk_ext))
+			return PTR_ERR(priv->clk_ext);
 
 		priv->rst = devm_reset_control_get_shared(dev, "phy");
 		if (IS_ERR(priv->rst))
-- 
2.20.1

