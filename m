Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81901C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D65E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfENGPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 02:15:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60154 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726357AbfENGOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 02:14:09 -0400
X-UUID: d96cabae677348a59eab058c683aa192-20190514
X-UUID: d96cabae677348a59eab058c683aa192-20190514
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1032790830; Tue, 14 May 2019 14:13:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 14 May 2019 14:13:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 May 2019 14:13:54 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v3 07/13] [media] mtk-mipicsi: enable/disable ana clk
Date:   Tue, 14 May 2019 14:13:44 +0800
Message-ID: <1557814430-9675-8-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557814430-9675-1-git-send-email-stu.hsieh@mediatek.com>
References: <1557814430-9675-1-git-send-email-stu.hsieh@mediatek.com>
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
index 117eb1939014..f9123765ebbd 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -152,6 +152,41 @@ struct mtk_mipicsi_dev {
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
@@ -776,6 +811,8 @@ static int mtk_mipicsi_pm_suspend(struct device *dev)
 	for (i = 0; i < mipicsi->clk_num; ++i)
 		clk_disable_unprepare(mipicsi->clk[i]);
 
+	mtk_mipicsi_ana_clk_enable(mipicsi->ana, false);
+
 	if (mipicsi->larb_pdev != NULL)
 		mtk_smi_larb_put(mipicsi->larb_pdev);
 
@@ -811,6 +848,8 @@ static int mtk_mipicsi_pm_resume(struct device *dev)
 			return ret;
 	}
 
+	mtk_mipicsi_ana_clk_enable(mipicsi->ana, true);
+
 	/* enable digtal clock */
 	for (i = 0; i < mipicsi->clk_num; ++i)
 		(void)clk_prepare_enable(mipicsi->clk[i]);
-- 
2.18.0

