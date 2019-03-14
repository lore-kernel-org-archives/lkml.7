Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA892C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D5321852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfCNMpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:45:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20704 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727619AbfCNMo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:44:57 -0400
X-UUID: fafc7060b93d4c82b9614cf2a7de5f2f-20190314
X-UUID: fafc7060b93d4c82b9614cf2a7de5f2f-20190314
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1580531767; Thu, 14 Mar 2019 20:44:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 20:44:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 20:44:45 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v1 13/18] drm/mediatek: add ddp write register common api
Date:   Thu, 14 Mar 2019 20:05:15 +0800
Message-ID: <1552565120-24329-14-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1552565120-24329-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1552565120-24329-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 00DAB276FC411775B75B0BFD7956D8F010D9EFFCA05D8C98D71C2E0F59C1644A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add ddp write register common api

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index a97e27b..1c0f9cc 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -84,6 +84,30 @@
 #define DITHER_ADD_LSHIFT_G(x)			(((x) & 0x7) << 4)
 #define DITHER_ADD_RSHIFT_G(x)			(((x) & 0x7) << 0)
 
+void mtk_ddp_write(unsigned int value, struct mtk_ddp_comp *comp,
+		   unsigned int offset)
+{
+	writel(value, comp->regs + offset);
+}
+
+void mtk_ddp_write_relaxed(unsigned int value,
+			   struct mtk_ddp_comp *comp,
+			   unsigned int offset)
+{
+	writel_relaxed(value, comp->regs + offset);
+}
+
+void mtk_ddp_write_mask(unsigned int value,
+			struct mtk_ddp_comp *comp,
+			unsigned int offset,
+			unsigned int mask)
+{
+	unsigned int tmp = readl(comp->regs + offset);
+
+	tmp = (tmp & ~mask) | (value & mask);
+	writel(tmp, comp->regs + offset);
+}
+
 void mtk_dither_set(struct mtk_ddp_comp *comp, unsigned int bpc,
 		    unsigned int CFG)
 {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index f2ab0b3..b908172 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -189,5 +189,14 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node,
 void mtk_ddp_comp_unregister(struct drm_device *drm, struct mtk_ddp_comp *comp);
 void mtk_dither_set(struct mtk_ddp_comp *comp, unsigned int bpc,
 		    unsigned int CFG);
+void mtk_ddp_write(unsigned int value, struct mtk_ddp_comp *comp,
+		   unsigned int offset);
+void mtk_ddp_write_relaxed(unsigned int value,
+			   struct mtk_ddp_comp *comp,
+			   unsigned int offset);
+void mtk_ddp_write_mask(unsigned int value,
+			struct mtk_ddp_comp *comp,
+			unsigned int offset,
+			unsigned int mask);
 
 #endif /* MTK_DRM_DDP_COMP_H */
-- 
1.8.1.1.dirty

