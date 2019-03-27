Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1E6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F3B206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbfC0GUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:20:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15146 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387474AbfC0GT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:19:59 -0400
X-UUID: eff7b8fdb7d046f2852efc1a80e90747-20190327
X-UUID: eff7b8fdb7d046f2852efc1a80e90747-20190327
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 485538325; Wed, 27 Mar 2019 14:19:55 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Mar 2019 14:19:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Mar 2019 14:19:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Mar 2019 14:19:53 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2 20/25] drm/mediatek: add ovl0/ovl0_2l usecase
Date:   Wed, 27 Mar 2019 14:19:16 +0800
Message-ID: <1553667561-25447-21-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add ovl0/ovl0_2l usecase
in ovl->ovl0_2l direct link usecase:
1. the crtc support layer number will 4+2
2. ovl0_2l background color input select ovl0 when crtc init
and disable it when crtc finish
3. config ovl0_2l layer, if crtc config layer number is
bigger than ovl0 support layers(max is 4)

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 38 +++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 11e3404..0f97ee3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -283,6 +283,13 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
+		enum mtk_ddp_comp_id prev;
+
+		if (i > 0)
+			prev = mtk_crtc->ddp_comp[i - 1]->id;
+		else
+			prev = DDP_COMPONENT_ID_MAX;
+		mtk_ddp_comp_bgclr_in_on(comp, prev);
 
 		mtk_ddp_comp_config(comp, width, height, vrefresh, bpc);
 		mtk_ddp_comp_start(comp);
@@ -292,9 +299,18 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 	for (i = 0; i < mtk_crtc->layer_nr; i++) {
 		struct drm_plane *plane = &mtk_crtc->planes[i];
 		struct mtk_plane_state *plane_state;
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
+		unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
+		unsigned int local_layer;
 
 		plane_state = to_mtk_plane_state(plane->state);
-		mtk_ddp_comp_layer_config(mtk_crtc->ddp_comp[0], i,
+
+		if (i >= comp_layer_nr) {
+			comp = mtk_crtc->ddp_comp[1];
+			local_layer = i - comp_layer_nr;
+                } else
+			local_layer = i;
+		mtk_ddp_comp_layer_config(comp , local_layer,
 					  plane_state);
 	}
 
@@ -320,6 +336,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
 					   mtk_crtc->ddp_comp[i]->id);
 	mtk_disp_mutex_disable(mtk_crtc->mutex);
 	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
+		mtk_ddp_comp_bgclr_in_off(mtk_crtc->ddp_comp[i]);
 		mtk_ddp_remove_comp_from_path(mtk_crtc->config_regs,
 					      mtk_crtc->mmsys_reg_data,
 					      mtk_crtc->ddp_comp[i]->id,
@@ -340,6 +357,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
 	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
 	unsigned int i;
+	unsigned int comp_layer_nr = mtk_ddp_comp_layer_nr(comp);
+	unsigned int local_layer;
 
 	/*
 	 * TODO: instead of updating the registers here, we should prepare
@@ -362,7 +381,14 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
 			plane_state = to_mtk_plane_state(plane->state);
 
 			if (plane_state->pending.config) {
-				mtk_ddp_comp_layer_config(comp, i, plane_state);
+				if (i >= comp_layer_nr) {
+					comp = mtk_crtc->ddp_comp[1];
+					local_layer = i - comp_layer_nr;
+                                } else
+					local_layer = i;
+
+				mtk_ddp_comp_layer_config(comp, local_layer,
+							  plane_state);
 				plane_state->pending.config = false;
 			}
 		}
@@ -604,6 +630,14 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	}
 
 	mtk_crtc->layer_nr = mtk_ddp_comp_layer_nr(mtk_crtc->ddp_comp[0]);
+        if (mtk_crtc->ddp_comp_nr > 1) {
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[1];
+		enum mtk_ddp_comp_type comp_type;
+
+		comp_type = mtk_ddp_comp_get_type(comp->id);
+		if (comp_type == MTK_DISP_OVL || comp_type == MTK_DISP_OVL_2L)
+			mtk_crtc->layer_nr += mtk_ddp_comp_layer_nr(comp);
+        }
 	mtk_crtc->planes = devm_kcalloc(dev, mtk_crtc->layer_nr,
 					sizeof(struct drm_plane),
 					GFP_KERNEL);
-- 
1.8.1.1.dirty

