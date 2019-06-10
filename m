Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA47DC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5142085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbfFJM4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:56:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39902 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388373AbfFJM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:56:32 -0400
X-UUID: c7fad4a2478545429dbaf22f5d46e1c6-20190610
X-UUID: c7fad4a2478545429dbaf22f5d46e1c6-20190610
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 159690519; Mon, 10 Jun 2019 20:56:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Jun 2019 20:56:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Jun 2019 20:56:17 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yingjoe.chen@mediatek.com>,
        <yong.wu@mediatek.com>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>
Subject: [PATCH v2 04/12] memory: mtk-smi: Add device-link between smi-larb and smi-common
Date:   Mon, 10 Jun 2019 20:55:05 +0800
Message-ID: <1560171313-28299-5-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, If the smi-larb HW need work, we should enable the smi-common
HW power and clock firstly.
This patch adds device-link between the smi-larb dev and the smi-common
dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
(smi-common-dev) will be called automatically.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Suggested-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 9688341..98b1180 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -271,6 +271,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *smi_node;
 	struct platform_device *smi_pdev;
+	struct device_link *link;
 
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
 	if (!larb)
@@ -310,6 +311,13 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 		if (!platform_get_drvdata(smi_pdev))
 			return -EPROBE_DEFER;
 		larb->smi_common_dev = &smi_pdev->dev;
+		link = device_link_add(dev, larb->smi_common_dev,
+				       DL_FLAG_PM_RUNTIME |
+				       DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!link) {
+			dev_err(dev, "Unable to link smi-common dev\n");
+			return -ENODEV;
+		}
 	} else {
 		dev_err(dev, "Failed to get the smi_common device\n");
 		return -EINVAL;
@@ -333,17 +341,9 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
 	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
 	int ret;
 
-	/* Power on smi-common. */
-	ret = pm_runtime_get_sync(larb->smi_common_dev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
-		return ret;
-	}
-
 	ret = mtk_smi_clk_enable(&larb->smi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable clock(%d).\n", ret);
-		pm_runtime_put_sync(larb->smi_common_dev);
 		return ret;
 	}
 
@@ -358,7 +358,6 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 
 	mtk_smi_clk_disable(&larb->smi);
-	pm_runtime_put_sync(larb->smi_common_dev);
 	return 0;
 }
 
-- 
1.9.1

