Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03FAC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3B42085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfCNMps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:45:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47617 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727539AbfCNMo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:44:56 -0400
X-UUID: 67765ed4c4a64d96b8778a79df2e9526-20190314
X-UUID: 67765ed4c4a64d96b8778a79df2e9526-20190314
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 479020447; Thu, 14 Mar 2019 20:44:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 20:44:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 20:44:47 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND PATCH v1 15/18] drm/mediatek: add RDMA1 fifo size into RDMA private data
Date:   Thu, 14 Mar 2019 20:05:17 +0800
Message-ID: <1552565120-24329-16-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1552565120-24329-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1552565120-24329-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

This patch add RDMA1 fifo size into RDMA private data

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index b0a5cff..3f9b4d4 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -53,12 +53,14 @@
 #define RDMA_FIFO_PSEUDO_SIZE(bytes)			(((bytes) / 16) << 16)
 #define RDMA_OUTPUT_VALID_FIFO_THRESHOLD(bytes)		((bytes) / 16)
 #define RDMA_FIFO_SIZE(rdma)			((rdma)->data->fifo_size)
+#define RDMA_FIFO_SIZE1(rdma)			((rdma)->data->fifo_size1)
 #define DISP_RDMA_MEM_START_ADDR		0x0f00
 
 #define RDMA_MEM_GMC				0x40402020
 
 struct mtk_disp_rdma_data {
 	unsigned int fifo_size;
+	unsigned int fifo_size1;
 };
 
 /**
@@ -137,11 +139,17 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 {
 	unsigned int threshold;
 	unsigned int reg;
+	unsigned int rdma_fifo_size;
 	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
 
 	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
 	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
 
+	if (comp->id == DDP_COMPONENT_RDMA1)
+		rdma_fifo_size = RDMA_FIFO_SIZE1(rdma);
+	else
+		rdma_fifo_size = RDMA_FIFO_SIZE(rdma);
+
 	/*
 	 * Enable FIFO underflow since DSI and DPI can't be blocked.
 	 * Keep the FIFO pseudo size reset default of 8 KiB. Set the
@@ -149,8 +157,12 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 	 * account for blanking, and with a pixel depth of 4 bytes:
 	 */
 	threshold = width * height * vrefresh * 4 * 7 / 1000000;
+
+	if (threshold > rdma_fifo_size)
+		threshold = rdma_fifo_size;
+
 	reg = RDMA_FIFO_UNDERFLOW_EN |
-	      RDMA_FIFO_PSEUDO_SIZE(RDMA_FIFO_SIZE(rdma)) |
+	      RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
 	      RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
 	writel(reg, comp->regs + DISP_REG_RDMA_FIFO_CON);
 }
@@ -330,10 +342,12 @@ static int mtk_disp_rdma_remove(struct platform_device *pdev)
 
 static const struct mtk_disp_rdma_data mt2701_rdma_driver_data = {
 	.fifo_size = SZ_4K,
+	.fifo_size1 = SZ_4K,
 };
 
 static const struct mtk_disp_rdma_data mt8173_rdma_driver_data = {
 	.fifo_size = SZ_8K,
+	.fifo_size1 = SZ_8K,
 };
 
 static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
-- 
1.8.1.1.dirty

