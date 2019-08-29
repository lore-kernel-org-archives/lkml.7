Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B61FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C7323404
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfH2OwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:52:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47521 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728462AbfH2Ovr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:51:47 -0400
X-UUID: 6ec99c8b412f4fda9161c5af4b577bbb-20190829
X-UUID: 6ec99c8b412f4fda9161c5af4b577bbb-20190829
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 890832243; Thu, 29 Aug 2019 22:51:41 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 22:51:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 22:51:45 +0800
From:   <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5, 28/32] drm/mediatek: add connection from OVL_2L0 to RDMA0
Date:   Thu, 29 Aug 2019 22:50:50 +0800
Message-ID: <1567090254-15566-29-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

this patch add add connection from OVL_2L0 to RDMA0

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index aa6173b..943e114 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -33,6 +33,12 @@
 #define DISP_REG_CONFIG_DSI_SEL			0x050
 #define DISP_REG_CONFIG_DPI_SEL			0x064
 
+#define MT8183_DISP_OVL0_2L_MOUT_EN		0xf04
+#define MT8183_DISP_PATH0_SEL_IN		0xf24
+
+#define OVL0_2L_MOUT_EN_DISP_PATH0			BIT(0)
+#define DISP_PATH0_SEL_IN_OVL0_2L			0x1
+
 #define MT2701_DISP_MUTEX0_MOD0			0x2c
 #define MT2701_DISP_MUTEX0_SOF0			0x30
 
@@ -307,6 +313,10 @@ static unsigned int mtk_ddp_mout_en(const struct mtk_mmsys_reg_data *data,
 	} else if (cur == DDP_COMPONENT_OVL0 && next == DDP_COMPONENT_OVL_2L0) {
 		*addr = data->ovl0_mout_en;
 		value = OVL0_MOUT_EN_OVL0_2L;
+	} else if (cur == DDP_COMPONENT_OVL_2L0 &&
+		   next == DDP_COMPONENT_RDMA0) {
+		*addr = MT8183_DISP_OVL0_2L_MOUT_EN;
+		value = OVL0_2L_MOUT_EN_DISP_PATH0;
 	} else {
 		value = 0;
 	}
@@ -366,6 +376,10 @@ static unsigned int mtk_ddp_sel_in(const struct mtk_mmsys_reg_data *data,
 	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
 		*addr = DISP_REG_CONFIG_DSI_SEL;
 		value = DSI_SEL_IN_BLS;
+	} else if (cur == DDP_COMPONENT_OVL_2L0 &&
+		   next == DDP_COMPONENT_RDMA0) {
+		*addr = MT8183_DISP_PATH0_SEL_IN;
+		value = DISP_PATH0_SEL_IN_OVL0_2L;
 	} else {
 		value = 0;
 	}
-- 
1.8.1.1.dirty

