Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB6C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A02A2171F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfGHWek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:34:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1853 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727148AbfGHWeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:34:37 -0400
X-UUID: c18f634b1b7142d981c8ea0f21f7ebcf-20190709
X-UUID: c18f634b1b7142d981c8ea0f21f7ebcf-20190709
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 28589370; Tue, 09 Jul 2019 06:34:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Jul 2019 06:34:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Jul 2019 06:34:29 +0800
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
Subject: [PATCH v4, 11/33] drm/mediatek: add mutex sof register offset into ddp private data
Date:   Tue, 9 Jul 2019 06:33:51 +0800
Message-ID: <1562625253-29254-12-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 25D013CBC098E4F25D16063E609256FF211591908FFB3C9F5D02110E520910982000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

mutex sof register offset will be private data of ddp

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index ab396ee..d015c1a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -42,12 +42,13 @@
 #define DISP_REG_CONFIG_DPI_SEL			0x064
 
 #define MT2701_DISP_MUTEX0_MOD0			0x2c
+#define MT2701_DISP_MUTEX0_SOF0			0x30
 
 #define DISP_REG_MUTEX_EN(n)			(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)			(0x24 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)			(0x28 + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD(mutex_mod_reg, n)	(mutex_mod_reg + 0x20 * (n))
-#define DISP_REG_MUTEX_SOF(n)			(0x30 + 0x20 * (n))
+#define DISP_REG_MUTEX_SOF(mutex_sof_reg, n)	(mutex_sof_reg + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD2(n)			(0x34 + 0x20 * (n))
 
 #define INT_MUTEX				BIT(1)
@@ -163,6 +164,7 @@ struct mtk_ddp_data {
 	const unsigned int *mutex_mod;
 	const unsigned int *mutex_sof;
 	const unsigned int mutex_mod_reg;
+	const unsigned int mutex_sof_reg;
 };
 
 struct mtk_ddp {
@@ -234,18 +236,21 @@ struct mtk_ddp {
 	.mutex_mod = mt2701_mutex_mod,
 	.mutex_sof = mt2712_mutex_sof,
 	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
 };
 
 static const struct mtk_ddp_data mt2712_ddp_driver_data = {
 	.mutex_mod = mt2712_mutex_mod,
 	.mutex_sof = mt2712_mutex_sof,
 	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
 };
 
 static const struct mtk_ddp_data mt8173_ddp_driver_data = {
 	.mutex_mod = mt8173_mutex_mod,
 	.mutex_sof = mt2712_mutex_sof,
 	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
 };
 
 static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
@@ -527,7 +532,8 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 	}
 
 	writel_relaxed(ddp->data->mutex_sof[sof_id],
-		       ddp->regs + DISP_REG_MUTEX_SOF(mutex->id));
+		       ddp->regs +
+		       DISP_REG_MUTEX_SOF(ddp->data->mutex_sof_reg, mutex->id));
 }
 
 void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
@@ -549,7 +555,8 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 	case DDP_COMPONENT_DPI1:
 		writel_relaxed(MUTEX_SOF_SINGLE_MODE,
 			       ddp->regs +
-			       DISP_REG_MUTEX_SOF(mutex->id));
+			       DISP_REG_MUTEX_SOF(ddp->data->mutex_sof_reg,
+						  mutex->id));
 		break;
 	default:
 		if (ddp->data->mutex_mod[id] < 32) {
-- 
1.8.1.1.dirty

