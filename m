Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D0CC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594452075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfFELoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:44:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3903 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727763AbfFELn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:43:59 -0400
X-UUID: 1821765d9ed045aebf01f57ddda453c0-20190605
X-UUID: 1821765d9ed045aebf01f57ddda453c0-20190605
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 985871829; Wed, 05 Jun 2019 19:43:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Jun 2019 19:43:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 19:43:42 +0800
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
Subject: [PATCH v3, 07/27] drm/mediatek: add mutex mod register offset into ddp private data
Date:   Wed, 5 Jun 2019 19:42:46 +0800
Message-ID: <1559734986-7379-8-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 48601DB269F65FAEFC1C49303F9239FAB7DC8461D5EECD2BC6C07EF2F365449E2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

mutex mod register offset will be private data of ddp.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index ae94d44..8bde2cf 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -41,10 +41,12 @@
 #define DISP_REG_CONFIG_DSI_SEL			0x050
 #define DISP_REG_CONFIG_DPI_SEL			0x064
 
+#define MT2701_DISP_MUTEX0_MOD0			0x2c
+
 #define DISP_REG_MUTEX_EN(n)			(0x20 + 0x20 * (n))
 #define DISP_REG_MUTEX(n)			(0x24 + 0x20 * (n))
 #define DISP_REG_MUTEX_RST(n)			(0x28 + 0x20 * (n))
-#define DISP_REG_MUTEX_MOD(n)			(0x2c + 0x20 * (n))
+#define DISP_REG_MUTEX_MOD(mutex_mod_reg, n)	(mutex_mod_reg + 0x20 * (n))
 #define DISP_REG_MUTEX_SOF(n)			(0x30 + 0x20 * (n))
 #define DISP_REG_MUTEX_MOD2(n)			(0x34 + 0x20 * (n))
 
@@ -149,6 +151,7 @@ struct mtk_disp_mutex {
 
 struct mtk_ddp_data {
 	const unsigned int *mutex_mod;
+	const unsigned int mutex_mod_reg;
 };
 
 struct mtk_ddp {
@@ -208,14 +211,17 @@ struct mtk_ddp {
 
 static const struct mtk_ddp_data mt2701_ddp_driver_data = {
 	.mutex_mod = mt2701_mutex_mod,
+	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
 };
 
 static const struct mtk_ddp_data mt2712_ddp_driver_data = {
 	.mutex_mod = mt2712_mutex_mod,
+	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
 };
 
 static const struct mtk_ddp_data mt8173_ddp_driver_data = {
 	.mutex_mod = mt8173_mutex_mod,
+	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
 };
 
 static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
@@ -481,7 +487,8 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
 		break;
 	default:
 		if (ddp->data->mutex_mod[id] < 32) {
-			offset = DISP_REG_MUTEX_MOD(mutex->id);
+			offset = DISP_REG_MUTEX_MOD(ddp->data->mutex_mod_reg,
+						    mutex->id);
 			reg = readl_relaxed(ddp->regs + offset);
 			reg |= 1 << ddp->data->mutex_mod[id];
 			writel_relaxed(reg, ddp->regs + offset);
@@ -519,7 +526,8 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
 		break;
 	default:
 		if (ddp->data->mutex_mod[id] < 32) {
-			offset = DISP_REG_MUTEX_MOD(mutex->id);
+			offset = DISP_REG_MUTEX_MOD(ddp->data->mutex_mod_reg,
+						    mutex->id);
 			reg = readl_relaxed(ddp->regs + offset);
 			reg &= ~(1 << ddp->data->mutex_mod[id]);
 			writel_relaxed(reg, ddp->regs + offset);
-- 
1.8.1.1.dirty

