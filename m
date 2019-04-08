Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805932087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDHL4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:56:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51857 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726640AbfDHLzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:35 -0400
X-UUID: ad31f90e64314854aaaa129115d02d43-20190408
X-UUID: ad31f90e64314854aaaa129115d02d43-20190408
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 751106431; Mon, 08 Apr 2019 19:55:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:26 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 07/14] [media] mtk-mipicsi: enable/disable ana clk
Date:   Mon, 8 Apr 2019 19:54:58 +0800
Message-ID: <1554724505-19882-8-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
References: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable/disable ana clk when power on/off

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index c2f75d9b64b8..99991f698edf 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -164,6 +164,41 @@ struct mtk_mipicsi_dev {
 		V4L2_MBUS_PCLK_SAMPLE_FALLING |	\
 		V4L2_MBUS_DATA_ACTIVE_HIGH)
 
+static void mtk_mipicsi_ana_clk_enable(void __iomem *base, bool enable)
+{
+	if (enable) {
+		writel(1UL | readl(base + MIPI_RX_ANA00_CSI),
+			base + MIPI_RX_ANA00_CSI);
+		writel(1UL | readl(base + MIPI_RX_ANA04_CSI),
+			base + MIPI_RX_ANA04_CSI);
+		writel(1UL | readl(base + MIPI_RX_ANA08_CSI),
+			base + MIPI_RX_ANA08_CSI);
+		writel(1UL | readl(base + MIPI_RX_ANA0C_CSI),
+			base + MIPI_RX_ANA0C_CSI);
+		writel(1UL | readl(base + MIPI_RX_ANA10_CSI),
+			base + MIPI_RX_ANA10_CSI);
+		writel(1UL | readl(base + MIPI_RX_ANA20_CSI),
+			base + MIPI_RX_ANA20_CSI);
+		writel(1UL | readl(base + MIPI_RX_ANA24_CSI),
+			base + MIPI_RX_ANA24_CSI);
+	} else {
+		writel(~1UL & readl(base + MIPI_RX_ANA00_CSI),
+			base + MIPI_RX_ANA00_CSI);
+		writel(~1UL & readl(base + MIPI_RX_ANA04_CSI),
+			base + MIPI_RX_ANA04_CSI);
+		writel(~1UL & readl(base + MIPI_RX_ANA08_CSI),
+			base + MIPI_RX_ANA08_CSI);
+		writel(~1UL & readl(base + MIPI_RX_ANA0C_CSI),
+			base + MIPI_RX_ANA0C_CSI);
+		writel(~1UL & readl(base + MIPI_RX_ANA10_CSI),
+			base + MIPI_RX_ANA10_CSI);
+		writel(~1UL & readl(base + MIPI_RX_ANA20_CSI),
+			base + MIPI_RX_ANA20_CSI);
+		writel(~1UL & readl(base + MIPI_RX_ANA24_CSI),
+			base + MIPI_RX_ANA24_CSI);
+	}
+}
+
 static int get_subdev_register(const struct soc_camera_device *icd,
 	struct v4l2_dbg_register *reg)
 {
@@ -802,6 +837,8 @@ static int mtk_mipicsi_pm_suspend(struct device *dev)
 	for (i = 0; i < mipicsi->clk_num; ++i)
 		clk_disable_unprepare(mipicsi->clk[i]);
 
+	mtk_mipicsi_ana_clk_enable(mipicsi->ana, false);
+
 	if (mipicsi->larb_pdev != NULL)
 		mtk_smi_larb_put(mipicsi->larb_pdev);
 
@@ -839,6 +876,8 @@ static int mtk_mipicsi_pm_resume(struct device *dev)
 			return ret;
 	}
 
+	mtk_mipicsi_ana_clk_enable(mipicsi->ana, true);
+
 	/* enable digtal clock */
 	for (i = 0; i < mipicsi->clk_num; ++i)
 		(void)clk_prepare_enable(mipicsi->clk[i]);
-- 
2.18.0

