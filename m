Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EFD22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfHUN5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:57:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49911 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729030AbfHUN5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:57:12 -0400
X-UUID: 2fc3599708324c9886ba502338d6de50-20190821
X-UUID: 2fc3599708324c9886ba502338d6de50-20190821
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 885575724; Wed, 21 Aug 2019 21:57:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 21 Aug 2019 21:57:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 21 Aug 2019 21:57:00 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v10 19/23] memory: mtk-smi: Invoke pm runtime_callback to enable clocks
Date:   Wed, 21 Aug 2019 21:53:22 +0800
Message-ID: <1566395606-7975-20-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch only move the clk_prepare_enable and config_port into the
runtime suspend/resume callback. It doesn't change the code content
and sequence.

This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
(SMI_BUS_SEL need to be restored after smi-common resume every time.)
Also it gives a chance to get rid of mtk_smi_larb_get/put which could
be a next topic.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/memory/mtk-smi.c | 113 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 41 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 3dd05de..2bb55b86 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -78,17 +78,13 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	u32				*mmu;
 };
 
-static int mtk_smi_enable(const struct mtk_smi *smi)
+static int mtk_smi_clk_enable(const struct mtk_smi *smi)
 {
 	int ret;
 
-	ret = pm_runtime_get_sync(smi->dev);
-	if (ret < 0)
-		return ret;
-
 	ret = clk_prepare_enable(smi->clk_apb);
 	if (ret)
-		goto err_put_pm;
+		return ret;
 
 	ret = clk_prepare_enable(smi->clk_smi);
 	if (ret)
@@ -110,59 +106,28 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
 	clk_disable_unprepare(smi->clk_smi);
 err_disable_apb:
 	clk_disable_unprepare(smi->clk_apb);
-err_put_pm:
-	pm_runtime_put_sync(smi->dev);
 	return ret;
 }
 
-static void mtk_smi_disable(const struct mtk_smi *smi)
+static void mtk_smi_clk_disable(const struct mtk_smi *smi)
 {
 	clk_disable_unprepare(smi->clk_gals1);
 	clk_disable_unprepare(smi->clk_gals0);
 	clk_disable_unprepare(smi->clk_smi);
 	clk_disable_unprepare(smi->clk_apb);
-	pm_runtime_put_sync(smi->dev);
 }
 
 int mtk_smi_larb_get(struct device *larbdev)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
-	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
-	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
-	int ret;
+	int ret = pm_runtime_get_sync(larbdev);
 
-	/* Enable the smi-common's power and clocks */
-	ret = mtk_smi_enable(common);
-	if (ret)
-		return ret;
-
-	/* Enable the larb's power and clocks */
-	ret = mtk_smi_enable(&larb->smi);
-	if (ret) {
-		mtk_smi_disable(common);
-		return ret;
-	}
-
-	/* Configure the iommu info for this larb */
-	larb_gen->config_port(larbdev);
-
-	return 0;
+	return (ret < 0) ? ret : 0;
 }
 EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
 
 void mtk_smi_larb_put(struct device *larbdev)
 {
-	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
-	struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
-
-	/*
-	 * Don't de-configure the iommu info for this larb since there may be
-	 * several modules in this larb.
-	 * The iommu info will be reset after power off.
-	 */
-
-	mtk_smi_disable(&larb->smi);
-	mtk_smi_disable(common);
+	pm_runtime_put_sync(larbdev);
 }
 EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
 
@@ -377,12 +342,52 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
+	int ret;
+
+	/* Power on smi-common. */
+	ret = pm_runtime_get_sync(larb->smi_common_dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
+		return ret;
+	}
+
+	ret = mtk_smi_clk_enable(&larb->smi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable clock(%d).\n", ret);
+		pm_runtime_put_sync(larb->smi_common_dev);
+		return ret;
+	}
+
+	/* Configure the basic setting for this larb */
+	larb_gen->config_port(dev);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+
+	mtk_smi_clk_disable(&larb->smi);
+	pm_runtime_put_sync(larb->smi_common_dev);
+	return 0;
+}
+
+static const struct dev_pm_ops smi_larb_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
+};
+
 static struct platform_driver mtk_smi_larb_driver = {
 	.probe	= mtk_smi_larb_probe,
 	.remove	= mtk_smi_larb_remove,
 	.driver	= {
 		.name = "mtk-smi-larb",
 		.of_match_table = mtk_smi_larb_of_ids,
+		.pm             = &smi_larb_pm_ops,
 	}
 };
 
@@ -481,12 +486,38 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused mtk_smi_common_resume(struct device *dev)
+{
+	struct mtk_smi *common = dev_get_drvdata(dev);
+	int ret;
+
+	ret = mtk_smi_clk_enable(common);
+	if (ret) {
+		dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
+{
+	struct mtk_smi *common = dev_get_drvdata(dev);
+
+	mtk_smi_clk_disable(common);
+	return 0;
+}
+
+static const struct dev_pm_ops smi_common_pm_ops = {
+	SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
+};
+
 static struct platform_driver mtk_smi_common_driver = {
 	.probe	= mtk_smi_common_probe,
 	.remove = mtk_smi_common_remove,
 	.driver	= {
 		.name = "mtk-smi-common",
 		.of_match_table = mtk_smi_common_of_ids,
+		.pm             = &smi_common_pm_ops,
 	}
 };
 
-- 
1.9.1

