Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412EBC606D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E43C2171F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfGHWey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:34:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9799 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727582AbfGHWer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:34:47 -0400
X-UUID: bd3f856997fe48aab6c83952cb9ab09a-20190709
X-UUID: bd3f856997fe48aab6c83952cb9ab09a-20190709
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2018052162; Tue, 09 Jul 2019 06:34:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 9 Jul 2019 06:34:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 9 Jul 2019 06:34:39 +0800
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
Subject: [PATCH v4, 22/33] drm/mediatek: add background color input select function for ovl/ovl_2l
Date:   Tue, 9 Jul 2019 06:34:02 +0800
Message-ID: <1562625253-29254-23-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1562625253-29254-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add background color input select function for ovl/ovl_2l

ovl include 4 DRAM layer and 1 background color layer
ovl_2l include 4 DRAM layer and 1 background color layer
DRAM layer frame buffer data from render hardware, GPU for example.
backgournd color layer is embed in ovl/ovl_2l, we can only set
it color, but not support DRAM frame buffer.

for ovl0->ovl0_2l direct link usecase,
we need set ovl0_2l background color intput select from ovl0
if render send DRAM buffer layer number <=4, all these layer read
by ovl.
layer0 is at the bottom of all layers.
layer3 is at the top of all layers.
if render send DRAM buffer layer numbfer >=4 && <=6
ovl0 read layer0~3
ovl0_2l read layer4~5
layer5 is at the top ot all these layers.

the decision of how to setting ovl0/ovl0_2l read these layer data
is controlled in mtk crtc, which will be another patch

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index a0ab760..8ca4965 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -27,6 +27,8 @@
 #define DISP_REG_OVL_EN				0x000c
 #define DISP_REG_OVL_RST			0x0014
 #define DISP_REG_OVL_ROI_SIZE			0x0020
+#define DISP_REG_OVL_DATAPATH_CON		0x0024
+#define OVL_BGCLR_SEL_IN				BIT(2)
 #define DISP_REG_OVL_ROI_BGCLR			0x0028
 #define DISP_REG_OVL_SRC_CON			0x002c
 #define DISP_REG_OVL_CON(n)			(0x0030 + 0x20 * (n))
@@ -245,6 +247,24 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 		mtk_ovl_layer_on(comp, idx);
 }
 
+static void mtk_ovl_bgclr_in_on(struct mtk_ddp_comp *comp)
+{
+	unsigned int reg;
+
+	reg = readl(comp->regs + DISP_REG_OVL_DATAPATH_CON);
+	reg = reg | OVL_BGCLR_SEL_IN;
+	writel(reg, comp->regs + DISP_REG_OVL_DATAPATH_CON);
+}
+
+static void mtk_ovl_bgclr_in_off(struct mtk_ddp_comp *comp)
+{
+	unsigned int reg;
+
+	reg = readl(comp->regs + DISP_REG_OVL_DATAPATH_CON);
+	reg = reg & ~OVL_BGCLR_SEL_IN;
+	writel(reg, comp->regs + DISP_REG_OVL_DATAPATH_CON);
+}
+
 static const struct mtk_ddp_comp_funcs mtk_disp_ovl_funcs = {
 	.config = mtk_ovl_config,
 	.start = mtk_ovl_start,
@@ -255,6 +275,8 @@ static void mtk_ovl_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
 	.layer_on = mtk_ovl_layer_on,
 	.layer_off = mtk_ovl_layer_off,
 	.layer_config = mtk_ovl_layer_config,
+	.bgclr_in_on = mtk_ovl_bgclr_in_on,
+	.bgclr_in_off = mtk_ovl_bgclr_in_off,
 };
 
 static int mtk_disp_ovl_bind(struct device *dev, struct device *master,
-- 
1.8.1.1.dirty

