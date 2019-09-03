Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8323C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E0222D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfICJj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:39:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10777 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728429AbfICJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:39:25 -0400
X-UUID: fe8ed8aa7d7d49848c4dedee6bfe9a95-20190903
X-UUID: fe8ed8aa7d7d49848c4dedee6bfe9a95-20190903
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 597752774; Tue, 03 Sep 2019 17:39:20 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Sep 2019 17:39:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Sep 2019 17:39:14 +0800
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
        <ming-fan.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Subject: [PATCH v3 07/14] media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
Date:   Tue, 3 Sep 2019 17:37:29 +0800
Message-ID: <1567503456-24725-8-git-send-email-yong.wu@mediatek.com>
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

MediaTek IOMMU has already added the device_link between the consumer
and smi-larb device. If the vcodec device call the pm_runtime_get_sync,
the smi-larb's pm_runtime_get_sync also be called automatically.

CC: Tiffany Lin <tiffany.lin@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c  | 22 ----------
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h |  3 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |  1 -
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 47 ----------------------
 4 files changed, 73 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
index 5a6ec8f..eb82d87 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
@@ -8,7 +8,6 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_vcodec_dec_pm.h"
 #include "mtk_vcodec_util.h"
@@ -16,7 +15,6 @@
 
 int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
 {
-	struct device_node *node;
 	struct platform_device *pdev;
 	struct mtk_vcodec_pm *pm;
 	struct mtk_vcodec_clk *dec_clk;
@@ -27,19 +25,6 @@ int mtk_vcodec_init_dec_pm(struct mtk_vcodec_dev *mtkdev)
 	pm = &mtkdev->pm;
 	pm->mtkdev = mtkdev;
 	dec_clk = &pm->vdec_clk;
-	node = of_parse_phandle(pdev->dev.of_node, "mediatek,larb", 0);
-	if (!node) {
-		mtk_v4l2_err("of_parse_phandle mediatek,larb fail!");
-		return -1;
-	}
-
-	pdev = of_find_device_by_node(node);
-	of_node_put(node);
-	if (WARN_ON(!pdev)) {
-		return -1;
-	}
-	pm->larbvdec = &pdev->dev;
-	pdev = mtkdev->plat_dev;
 	pm->dev = &pdev->dev;
 
 	dec_clk->clk_num =
@@ -113,12 +98,6 @@ void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
 			goto error;
 		}
 	}
-
-	ret = mtk_smi_larb_get(pm->larbvdec);
-	if (ret) {
-		mtk_v4l2_err("mtk_smi_larb_get larbvdec fail %d", ret);
-		goto error;
-	}
 	return;
 
 error:
@@ -131,7 +110,6 @@ void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
 	struct mtk_vcodec_clk *dec_clk = &pm->vdec_clk;
 	int i = 0;
 
-	mtk_smi_larb_put(pm->larbvdec);
 	for (i = dec_clk->clk_num - 1; i >= 0; i--)
 		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
 }
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index c95de5d..61fefa1 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -188,11 +188,8 @@ struct mtk_vcodec_clk {
  */
 struct mtk_vcodec_pm {
 	struct mtk_vcodec_clk	vdec_clk;
-	struct device	*larbvdec;
 
 	struct mtk_vcodec_clk	venc_clk;
-	struct device	*larbvenc;
-	struct device	*larbvenclt;
 	struct device	*dev;
 	struct mtk_vcodec_dev	*mtkdev;
 };
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index fd8de02..75e0e85 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -8,7 +8,6 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_vcodec_drv.h"
 #include "mtk_vcodec_enc.h"
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
index 3e2bfde..f484ac7 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
@@ -8,7 +8,6 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_util.h"
@@ -17,49 +16,18 @@
 
 int mtk_vcodec_init_enc_pm(struct mtk_vcodec_dev *mtkdev)
 {
-	struct device_node *node;
 	struct platform_device *pdev;
 	struct mtk_vcodec_pm *pm;
 	struct mtk_vcodec_clk *enc_clk;
 	struct mtk_vcodec_clk_info *clk_info;
 	int ret = 0, i = 0;
-	struct device *dev;
 
 	pdev = mtkdev->plat_dev;
 	pm = &mtkdev->pm;
 	memset(pm, 0, sizeof(struct mtk_vcodec_pm));
 	pm->mtkdev = mtkdev;
 	pm->dev = &pdev->dev;
-	dev = &pdev->dev;
 	enc_clk = &pm->venc_clk;
-
-	node = of_parse_phandle(dev->of_node, "mediatek,larb", 0);
-	if (!node) {
-		mtk_v4l2_err("no mediatek,larb found");
-		return -ENODEV;
-	}
-	pdev = of_find_device_by_node(node);
-	of_node_put(node);
-	if (!pdev) {
-		mtk_v4l2_err("no mediatek,larb device found");
-		return -ENODEV;
-	}
-	pm->larbvenc = &pdev->dev;
-
-	node = of_parse_phandle(dev->of_node, "mediatek,larb", 1);
-	if (!node) {
-		mtk_v4l2_err("no mediatek,larb found");
-		return -ENODEV;
-	}
-
-	pdev = of_find_device_by_node(node);
-	of_node_put(node);
-	if (!pdev) {
-		mtk_v4l2_err("no mediatek,larb device found");
-		return -ENODEV;
-	}
-
-	pm->larbvenclt = &pdev->dev;
 	pdev = mtkdev->plat_dev;
 	pm->dev = &pdev->dev;
 
@@ -115,21 +83,8 @@ void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm)
 		}
 	}
 
-	ret = mtk_smi_larb_get(pm->larbvenc);
-	if (ret) {
-		mtk_v4l2_err("mtk_smi_larb_get larb3 fail %d", ret);
-		goto larbvencerr;
-	}
-	ret = mtk_smi_larb_get(pm->larbvenclt);
-	if (ret) {
-		mtk_v4l2_err("mtk_smi_larb_get larb4 fail %d", ret);
-		goto larbvenclterr;
-	}
 	return;
 
-larbvenclterr:
-	mtk_smi_larb_put(pm->larbvenc);
-larbvencerr:
 clkerr:
 	for (i -= 1; i >= 0; i--)
 		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
@@ -140,8 +95,6 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm)
 	struct mtk_vcodec_clk *enc_clk = &pm->venc_clk;
 	int i = 0;
 
-	mtk_smi_larb_put(pm->larbvenc);
-	mtk_smi_larb_put(pm->larbvenclt);
 	for (i = enc_clk->clk_num - 1; i >= 0; i--)
 		clk_disable_unprepare(enc_clk->clk_info[i].vcodec_clk);
 }
-- 
1.9.1

