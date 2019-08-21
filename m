Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B58C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26C222CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfHUN5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:57:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12969 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728608AbfHUN5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:57:49 -0400
X-UUID: 706f111d285045c2b0588a1c6c804fa0-20190821
X-UUID: 706f111d285045c2b0588a1c6c804fa0-20190821
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1541045567; Wed, 21 Aug 2019 21:57:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 21 Aug 2019 21:57:38 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 21 Aug 2019 21:57:37 +0800
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
Subject: [PATCH v10 23/23] iommu/mediatek: Clean up struct mtk_smi_iommu
Date:   Wed, 21 Aug 2019 21:53:26 +0800
Message-ID: <1566395606-7975-24-git-send-email-yong.wu@mediatek.com>
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

Remove the "struct mtk_smi_iommu" to simplify the code since it has only
one item in it right now.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    | 4 ++--
 drivers/iommu/mtk_iommu.h    | 6 +++---
 drivers/iommu/mtk_iommu_v1.c | 4 ++--
 drivers/memory/mtk-smi.c     | 6 +++---
 include/soc/mediatek/smi.h   | 4 ----
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index cc81de2..400066d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -278,7 +278,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	for (i = 0; i < fwspec->num_ids; ++i) {
 		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
 		portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
-		larb_mmu = &data->smi_imu.larb_imu[larbid];
+		larb_mmu = &data->larb_imu[larbid];
 
 		dev_dbg(dev, "%s iommu port: %d\n",
 			enable ? "enable" : "disable", portid);
@@ -680,7 +680,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			of_node_put(larbnode);
 			return -EPROBE_DEFER;
 		}
-		data->smi_imu.larb_imu[id].dev = &plarbdev->dev;
+		data->larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, &match, release_of,
 					    compare_of, larbnode);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 56b579c..fc0f16e 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -56,7 +56,6 @@ struct mtk_iommu_data {
 	struct mtk_iommu_suspend_reg	reg;
 	struct mtk_iommu_domain		*m4u_dom;
 	struct iommu_group		*m4u_group;
-	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
 	bool                            enable_4GB;
 	bool				tlb_flush_active;
 
@@ -64,6 +63,7 @@ struct mtk_iommu_data {
 	const struct mtk_iommu_plat_data *plat_data;
 
 	struct list_head		list;
+	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
 
 static inline int compare_of(struct device *dev, void *data)
@@ -80,14 +80,14 @@ static inline int mtk_iommu_bind(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 
-	return component_bind_all(dev, &data->smi_imu);
+	return component_bind_all(dev, &data->larb_imu);
 }
 
 static inline void mtk_iommu_unbind(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 
-	component_unbind_all(dev, &data->smi_imu);
+	component_unbind_all(dev, &data->larb_imu);
 }
 
 #endif
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 3922358..860926c 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -206,7 +206,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	for (i = 0; i < fwspec->num_ids; ++i) {
 		larbid = mt2701_m4u_to_larb(fwspec->ids[i]);
 		portid = mt2701_m4u_to_port(fwspec->ids[i]);
-		larb_mmu = &data->smi_imu.larb_imu[larbid];
+		larb_mmu = &data->larb_imu[larbid];
 
 		dev_dbg(dev, "%s iommu port: %d\n",
 			enable ? "enable" : "disable", portid);
@@ -610,7 +610,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			}
 		}
 
-		data->smi_imu.larb_imu[larb_nr].dev = &plarbdev->dev;
+		data->larb_imu[larb_nr].dev = &plarbdev->dev;
 		component_match_add_release(dev, &match, release_of,
 					    compare_of, larb_spec.np);
 		larb_nr++;
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index d6dc62f..439d7d8 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -143,13 +143,13 @@ void mtk_smi_larb_put(struct device *larbdev)
 mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-	struct mtk_smi_iommu *smi_iommu = data;
+	struct mtk_smi_larb_iommu *larb_mmu = data;
 	unsigned int         i;
 
 	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
-		if (dev == smi_iommu->larb_imu[i].dev) {
+		if (dev == larb_mmu[i].dev) {
 			larb->larbid = i;
-			larb->mmu = &smi_iommu->larb_imu[i].mmu;
+			larb->mmu = &larb_mmu[i].mmu;
 			return 0;
 		}
 	}
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 6f0b00c..5a34b87 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -20,10 +20,6 @@ struct mtk_smi_larb_iommu {
 	unsigned int   mmu;
 };
 
-struct mtk_smi_iommu {
-	struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
-};
-
 /*
  * mtk_smi_larb_get: Enable the power domain and clocks for this local arbiter.
  *                   It also initialize some basic setting(like iommu).
-- 
1.9.1

