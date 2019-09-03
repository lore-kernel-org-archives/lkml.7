Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE94C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C4D206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfICJkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:40:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47511 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728426AbfICJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:40:01 -0400
X-UUID: cb6a366d39bd4e8fa62f4b3972d6e544-20190903
X-UUID: cb6a366d39bd4e8fa62f4b3972d6e544-20190903
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 695586970; Tue, 03 Sep 2019 17:39:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Sep 2019 17:39:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Sep 2019 17:39:53 +0800
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
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v3 12/14] drm/mediatek: Add pm runtime support for ovl and rdma
Date:   Tue, 3 Sep 2019 17:37:34 +0800
Message-ID: <1567503456-24725-13-git-send-email-yong.wu@mediatek.com>
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

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Display use the dispsys device to call pm_rumtime_get_sync before.
This patch add pm_runtime_xx with ovl and rdma device which has linked
with larb0, then it will enable the correpsonding larb0 clock
automatically by the device link.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  5 +++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |  5 +++++
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 18 ++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  9 +++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  1 +
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index c4f07c2..51958cf 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -9,6 +9,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "mtk_drm_crtc.h"
 #include "mtk_drm_ddp_comp.h"
@@ -300,6 +301,8 @@ static int mtk_disp_ovl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_enable(dev);
+
 	ret = component_add(dev, &mtk_disp_ovl_component_ops);
 	if (ret)
 		dev_err(dev, "Failed to add component: %d\n", ret);
@@ -311,6 +314,8 @@ static int mtk_disp_ovl_remove(struct platform_device *pdev)
 {
 	component_del(&pdev->dev, &mtk_disp_ovl_component_ops);
 
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 9a6f0a2..15e5c3a 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -9,6 +9,7 @@
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "mtk_drm_crtc.h"
 #include "mtk_drm_ddp_comp.h"
@@ -306,6 +307,8 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	pm_runtime_enable(dev);
+
 	ret = component_add(dev, &mtk_disp_rdma_component_ops);
 	if (ret)
 		dev_err(dev, "Failed to add component: %d\n", ret);
@@ -317,6 +320,8 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
 {
 	component_del(&pdev->dev, &mtk_disp_rdma_component_ops);
 
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index c1e891e..daf002e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -358,13 +358,21 @@ static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
 				       struct drm_crtc_state *old_state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
 	int ret;
 
 	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
 
+	ret = pm_runtime_get_sync(comp->dev);
+	if (ret < 0)
+		DRM_DEV_ERROR(comp->dev, "Failed to enable power domain: %d\n",
+			      ret);
+
 	ret = mtk_crtc_ddp_hw_init(mtk_crtc);
-	if (ret)
+	if (ret) {
+		pm_runtime_put(comp->dev);
 		return;
+	}
 
 	drm_crtc_vblank_on(crtc);
 	mtk_crtc->enabled = true;
@@ -374,7 +382,8 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 					struct drm_crtc_state *old_state)
 {
 	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	int i;
+	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
+	int i, ret;
 
 	DRM_DEBUG_DRIVER("%s %d\n", __func__, crtc->base.id);
 	if (!mtk_crtc->enabled)
@@ -398,6 +407,11 @@ static void mtk_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 	mtk_crtc_ddp_hw_fini(mtk_crtc);
 
 	mtk_crtc->enabled = false;
+
+	ret = pm_runtime_put(comp->dev);
+	if (ret < 0)
+		DRM_DEV_ERROR(comp->dev, "Failed to disable power domain: %d\n",
+			      ret);
 }
 
 static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 7dc8496..c45e1f0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -256,6 +256,8 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 		      struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id comp_id,
 		      const struct mtk_ddp_comp_funcs *funcs)
 {
+	struct platform_device *comp_pdev;
+
 	if (comp_id < 0 || comp_id >= DDP_COMPONENT_ID_MAX)
 		return -EINVAL;
 
@@ -282,6 +284,13 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	if (IS_ERR(comp->clk))
 		return PTR_ERR(comp->clk);
 
+	comp_pdev = of_find_device_by_node(node);
+	if (!comp_pdev) {
+		dev_err(dev, "Waiting for device %s\n", node->full_name);
+		return -EPROBE_DEFER;
+	}
+	comp->dev = &comp_pdev->dev;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 108de60..d1838a8 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -83,6 +83,7 @@ struct mtk_ddp_comp {
 	struct clk *clk;
 	void __iomem *regs;
 	int irq;
+	struct device *dev;
 	enum mtk_ddp_comp_id id;
 	const struct mtk_ddp_comp_funcs *funcs;
 };
-- 
1.9.1

