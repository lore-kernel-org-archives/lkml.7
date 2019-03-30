Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC5C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740E82184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfC3JNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:13:04 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47167 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730422AbfC3JNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:13:01 -0400
X-UUID: 883a3a42cd0548a6ac1ad1c0b5ae1e8c-20190330
X-UUID: 883a3a42cd0548a6ac1ad1c0b5ae1e8c-20190330
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 743333797; Sat, 30 Mar 2019 17:12:44 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 30 Mar 2019 17:12:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 30 Mar 2019 17:12:36 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 1/4] phy: phy-mtk-tphy: get optional clock by devm_clk_get_optional()
Date:   Sat, 30 Mar 2019 17:11:35 +0800
Message-ID: <a8539bcf66065380069676fbea99a51254309803.1553914418.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() to get optional clock

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 5b6a470ca145..cb2ed3b25068 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -1103,13 +1103,9 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 	}
 
 	/* it's deprecated, make it optional for backward compatibility */
-	tphy->u3phya_ref = devm_clk_get(dev, "u3phya_ref");
-	if (IS_ERR(tphy->u3phya_ref)) {
-		if (PTR_ERR(tphy->u3phya_ref) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		tphy->u3phya_ref = NULL;
-	}
+	tphy->u3phya_ref = devm_clk_get_optional(dev, "u3phya_ref");
+	if (IS_ERR(tphy->u3phya_ref))
+		return PTR_ERR(tphy->u3phya_ref);
 
 	tphy->src_ref_clk = U3P_REF_CLK;
 	tphy->src_coef = U3P_SLEW_RATE_COEF;
-- 
2.20.1

