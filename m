Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A3BC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA1F2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfDJGNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:13:36 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:11983 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbfDJGN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:13:29 -0400
X-UUID: 0cf77139607a445b83c138a92dbd324b-20190410
X-UUID: 0cf77139607a445b83c138a92dbd324b-20190410
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 600075048; Wed, 10 Apr 2019 14:13:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Apr 2019 14:13:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Apr 2019 14:13:10 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Kevin Hilman <khilman@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Motoya Tanigawa <tanigawa.motoya@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [v2 PATCH 3/4] phy: socionext: get optional clock by devm_clk_get_optional()
Date:   Wed, 10 Apr 2019 14:13:05 +0800
Message-ID: <f3d8f2f8d2c7bbcb88e813a647c798aa5d42543a.1554874961.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a8539bcf66065380069676fbea99a51254309803.1554874961.git.chunfeng.yun@mediatek.com>
References: <a8539bcf66065380069676fbea99a51254309803.1554874961.git.chunfeng.yun@mediatek.com>
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
Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
v2: add Reviewed-by Kunihiko Hayashi
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
2.21.0

