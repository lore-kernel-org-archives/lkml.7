Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F88DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61448206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbfC0GUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:20:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387513AbfC0GUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:20:03 -0400
X-UUID: 7dfe5b3bd31f4192a87ff2930c43c25a-20190327
X-UUID: 7dfe5b3bd31f4192a87ff2930c43c25a-20190327
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1540391883; Wed, 27 Mar 2019 14:19:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Mar 2019 14:19:52 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Mar 2019 14:19:51 +0800
From:   <yongqiang.niu@mediatek.com>
To:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>, Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2 18/25] drm/mediatek: add RDMA fifo size error handle
Date:   Wed, 27 Mar 2019 14:19:14 +0800
Message-ID: <1553667561-25447-19-git-send-email-yongqiang.niu@mediatek.com>
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

This patch add RDMA fifo size error handle
rdma fifo size will not always bigger than the calculated threshold
if that case happened, we need set fifo size as the threshold

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index b0a5cff..ead38ba 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -137,11 +137,14 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 {
 	unsigned int threshold;
 	unsigned int reg;
+	unsigned int rdma_fifo_size;
 	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
 
 	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_0, 0xfff, width);
 	rdma_update_bits(comp, DISP_REG_RDMA_SIZE_CON_1, 0xfffff, height);
 
+	rdma_fifo_size = RDMA_FIFO_SIZE(rdma);
+
 	/*
 	 * Enable FIFO underflow since DSI and DPI can't be blocked.
 	 * Keep the FIFO pseudo size reset default of 8 KiB. Set the
@@ -149,8 +152,12 @@ static void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
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
-- 
1.8.1.1.dirty

