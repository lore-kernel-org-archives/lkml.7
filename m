Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FDAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31C12075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbfC0GUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:20:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27443 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387502AbfC0GUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:20:02 -0400
X-UUID: 01f4001dc321445d9d54049e5c79c3e6-20190327
X-UUID: 01f4001dc321445d9d54049e5c79c3e6-20190327
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1555085926; Wed, 27 Mar 2019 14:19:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Mar 2019 14:19:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Mar 2019 14:19:52 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2 19/25] drm/mediatek: add function mtk_ddp_comp_get_type
Date:   Wed, 27 Mar 2019 14:19:15 +0800
Message-ID: <1553667561-25447-20-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9D958F785A31F336DBD18C01EA560D5FF6BE742892CD9009E35CBD23027FE8102000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add function mtk_ddp_comp_get_type

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 8 ++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 72288b4..193cdb7a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -338,6 +338,14 @@ int mtk_ddp_comp_get_id(struct device_node *node,
 	return -EINVAL;
 }
 
+enum mtk_ddp_comp_type mtk_ddp_comp_get_type(enum mtk_ddp_comp_id comp_id)
+{
+	if (comp_id < DDP_COMPONENT_ID_MAX)
+		return mtk_ddp_matches[comp_id].type;
+
+	return MTK_DDP_COMP_TYPE_MAX;
+}
+
 int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 		      struct mtk_ddp_comp *comp, enum mtk_ddp_comp_id comp_id,
 		      const struct mtk_ddp_comp_funcs *funcs)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index ed715ff..6bf46d1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -202,5 +202,6 @@ void mtk_ddp_write_mask(unsigned int value,
 			struct mtk_ddp_comp *comp,
 			unsigned int offset,
 			unsigned int mask);
+enum mtk_ddp_comp_type mtk_ddp_comp_get_type(enum mtk_ddp_comp_id comp_id);
 
 #endif /* MTK_DRM_DDP_COMP_H */
-- 
1.8.1.1.dirty

