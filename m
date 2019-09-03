Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53CFC41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77E7206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfICJjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:39:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5868 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728426AbfICJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:39:47 -0400
X-UUID: 5f42c20f73a84f319014eb9f77e3288d-20190903
X-UUID: 5f42c20f73a84f319014eb9f77e3288d-20190903
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 428583172; Tue, 03 Sep 2019 17:39:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Sep 2019 17:39:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Sep 2019 17:39:38 +0800
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
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v3 10/14] iommu/mediatek: Use builtin_platform_driver
Date:   Tue, 3 Sep 2019 17:37:32 +0800
Message-ID: <1567503456-24725-11-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567503456-24725-1-git-send-email-yong.wu@mediatek.com>
References: <1567503456-24725-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU should wait for smi larb which need wait for the
power domain(mtk-scpsys.c) and the multimedia ccf who both are
module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
Switch to builtin_platform_driver.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    | 31 +------------------------------
 drivers/iommu/mtk_iommu_v1.c | 24 +-----------------------
 2 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 2511b3c..109c3f2 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -735,22 +735,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
-{
-	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-
-	iommu_device_sysfs_remove(&data->iommu);
-	iommu_device_unregister(&data->iommu);
-
-	if (iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, NULL);
-
-	clk_disable_unprepare(data->bclk);
-	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-	return 0;
-}
-
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -831,23 +815,10 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu",
 		.of_match_table = of_match_ptr(mtk_iommu_of_ids),
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
-
-static int __init mtk_iommu_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&mtk_iommu_driver);
-	if (ret != 0)
-		pr_err("Failed to register MTK IOMMU driver\n");
-
-	return ret;
-}
-
-subsys_initcall(mtk_iommu_init)
+builtin_platform_driver(mtk_iommu_driver);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index a7f22a2..821d483 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -660,22 +660,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
-{
-	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-
-	iommu_device_sysfs_remove(&data->iommu);
-	iommu_device_unregister(&data->iommu);
-
-	if (iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, NULL);
-
-	clk_disable_unprepare(data->bclk);
-	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-	return 0;
-}
-
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -712,16 +696,10 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu-v1",
 		.of_match_table = mtk_iommu_of_ids,
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
-
-static int __init m4u_init(void)
-{
-	return platform_driver_register(&mtk_iommu_driver);
-}
-subsys_initcall(m4u_init);
+builtin_platform_driver(mtk_iommu_driver);
-- 
1.9.1

