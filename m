Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF0DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF9E2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfHXDFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 23:05:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65515 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726982AbfHXDFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 23:05:44 -0400
X-UUID: 36d7e59e6af44fc68f549b6bfe15b9e3-20190824
X-UUID: 36d7e59e6af44fc68f549b6bfe15b9e3-20190824
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 630864807; Sat, 24 Aug 2019 11:04:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 24 Aug 2019 11:04:46 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 24 Aug 2019 11:04:45 +0800
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
Subject: [PATCH v11 11/23] iommu/mediatek: Add bclk can be supported optionally
Date:   Sat, 24 Aug 2019 11:01:56 +0800
Message-ID: <1566615728-26388-12-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
References: <1566615728-26388-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some SoCs, M4U doesn't have its "bclk", it will use the EMI
clock instead which has always been enabled when entering kernel.

Currently mt2712 and mt8173 have this bclk while mt8183 doesn't.

This also is a preparing patch for mt8183.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/iommu/mtk_iommu.c | 10 +++++++---
 drivers/iommu/mtk_iommu.h |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b5a40a4..4df3cb4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -633,9 +633,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (data->irq < 0)
 		return data->irq;
 
-	data->bclk = devm_clk_get(dev, "bclk");
-	if (IS_ERR(data->bclk))
-		return PTR_ERR(data->bclk);
+	if (data->plat_data->has_bclk) {
+		data->bclk = devm_clk_get(dev, "bclk");
+		if (IS_ERR(data->bclk))
+			return PTR_ERR(data->bclk);
+	}
 
 	larb_nr = of_count_phandle_with_args(dev->of_node,
 					     "mediatek,larbs", NULL);
@@ -763,11 +765,13 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
 	.has_4gb_mode = true,
+	.has_bclk     = true,
 };
 
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.has_4gb_mode = true,
+	.has_bclk     = true,
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index c281c01..821172b 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -35,6 +35,9 @@ enum mtk_iommu_plat {
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat m4u_plat;
 	bool                has_4gb_mode;
+
+	/* HW will use the EMI clock if there isn't the "bclk". */
+	bool                has_bclk;
 };
 
 struct mtk_iommu_domain;
-- 
1.9.1

