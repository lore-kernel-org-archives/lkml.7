Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD8EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2389620850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfDJGNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:13:33 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:60737 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726879AbfDJGNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:13:30 -0400
X-UUID: 62c40f664b494fb0875b822245c793e6-20190410
X-UUID: 62c40f664b494fb0875b822245c793e6-20190410
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 840614488; Wed, 10 Apr 2019 14:13:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Apr 2019 14:13:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Apr 2019 14:13:09 +0800
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
        <linux-arm-msm@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [v2 PATCH 2/4] phy: qcom-qusb2: get optional clock by devm_clk_get_optional()
Date:   Wed, 10 Apr 2019 14:13:04 +0800
Message-ID: <50f5c2410bb86691329e5cb4d7ec38d1811fff33.1554874961.git.chunfeng.yun@mediatek.com>
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

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 8fd7ce139772..1cbf1d6f28ce 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -822,14 +822,9 @@ static int qusb2_phy_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	qphy->iface_clk = devm_clk_get(dev, "iface");
-	if (IS_ERR(qphy->iface_clk)) {
-		ret = PTR_ERR(qphy->iface_clk);
-		if (ret == -EPROBE_DEFER)
-			return ret;
-		qphy->iface_clk = NULL;
-		dev_dbg(dev, "failed to get iface clk, %d\n", ret);
-	}
+	qphy->iface_clk = devm_clk_get_optional(dev, "iface");
+	if (IS_ERR(qphy->iface_clk))
+		return PTR_ERR(qphy->iface_clk);
 
 	qphy->phy_reset = devm_reset_control_get_by_index(&pdev->dev, 0);
 	if (IS_ERR(qphy->phy_reset)) {
-- 
2.21.0

