Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07175C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEE02184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbfC3JMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:12:52 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:23859 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730415AbfC3JMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:12:52 -0400
X-UUID: 1a9c0ae767614fd88d56f81ba1bd1556-20190330
X-UUID: 1a9c0ae767614fd88d56f81ba1bd1556-20190330
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 54419257; Sat, 30 Mar 2019 17:12:45 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 30 Mar 2019 17:12:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 30 Mar 2019 17:12:43 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 2/4] phy: qcom-qusb2: get optional clock by devm_clk_get_optional()
Date:   Sat, 30 Mar 2019 17:11:36 +0800
Message-ID: <50f5c2410bb86691329e5cb4d7ec38d1811fff33.1553914418.git.chunfeng.yun@mediatek.com>
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

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
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
2.20.1

