Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A1C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A77F2063F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDHLzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:55:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41863 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725983AbfDHLz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:29 -0400
X-UUID: 29105d88cf4f49d7b348c5aeaae82fa4-20190408
X-UUID: 29105d88cf4f49d7b348c5aeaae82fa4-20190408
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1387754250; Mon, 08 Apr 2019 19:55:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:21 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 02/14] [media] mtk-mipicsi: add pm function
Date:   Mon, 8 Apr 2019 19:54:53 +0800
Message-ID: <1554724505-19882-3-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
References: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FB59758C98CE6819ADDFF1D50DAAE8C7381E8E342FB07C671B408C9B57CAD6A42000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add PM function to enable/disable clk and larb.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index 2e6c3073c064..a5ed720df900 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -465,6 +465,85 @@ static struct soc_camera_host_ops mtk_soc_camera_host_ops = {
 	.set_bus_param		= mtk_mipicsi_set_bus_param,
 };
 
+static int mtk_mipicsi_pm_suspend(struct device *dev)
+{
+	struct soc_camera_host *ici = to_soc_camera_host(dev);
+	struct mtk_mipicsi_dev *mipicsi = NULL;
+	int ret = 0;
+	int i = 0;
+
+	mipicsi = container_of(ici, struct mtk_mipicsi_dev, soc_host);
+	if (mipicsi->soc_host.icd != NULL) {
+		struct v4l2_subdev *sd =
+			soc_camera_to_subdev(mipicsi->soc_host.icd);
+
+		ret = v4l2_subdev_call(sd, core, s_power, 0);
+		if (ret == -ENOIOCTLCMD)
+			ret = 0;
+	}
+
+	/* close digtal and analog clock */
+	for (i = 0; i < mipicsi->clk_num; ++i)
+		clk_disable_unprepare(mipicsi->clk[i]);
+
+	if (mipicsi->larb_pdev != NULL)
+		mtk_smi_larb_put(mipicsi->larb_pdev);
+
+	return ret;
+}
+
+static int mtk_mipicsi_suspend(struct device *dev)
+{
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return mtk_mipicsi_pm_suspend(dev);
+}
+
+static int mtk_mipicsi_pm_resume(struct device *dev)
+{
+	struct soc_camera_host *ici = to_soc_camera_host(dev);
+	struct mtk_mipicsi_dev *mipicsi =
+		container_of(ici, struct mtk_mipicsi_dev, soc_host);
+	int ret = 0;
+	int i = 0;
+
+	if (mipicsi->soc_host.icd != NULL) {
+		struct v4l2_subdev *sd =
+			soc_camera_to_subdev(mipicsi->soc_host.icd);
+
+		ret = v4l2_subdev_call(sd, core, s_power, 1);
+		if (ret == -ENOIOCTLCMD)
+			ret = 0;
+	}
+
+	if (mipicsi->larb_pdev != NULL) {
+		ret = mtk_smi_larb_get(mipicsi->larb_pdev);
+		if (ret != 0)
+			return ret;
+	}
+
+	/* enable digtal clock */
+	for (i = 0; i < mipicsi->clk_num; ++i)
+		(void)clk_prepare_enable(mipicsi->clk[i]);
+
+	return ret;
+}
+
+static int mtk_mipicsi_resume(struct device *dev)
+{
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return mtk_mipicsi_pm_resume(dev);
+}
+
+static const struct dev_pm_ops mtk_mipicsi_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(mtk_mipicsi_suspend, mtk_mipicsi_resume)
+	SET_RUNTIME_PM_OPS(mtk_mipicsi_pm_suspend,
+		mtk_mipicsi_pm_resume, NULL)
+};
+
 static int seninf_mux_camsv_node_parse(struct mtk_mipicsi_dev *mipicsi,
 		int index)
 {
@@ -757,6 +836,7 @@ static const struct of_device_id mtk_mipicsi_of_match[] = {
 static struct platform_driver mtk_mipicsi_driver = {
 	.driver		= {
 		.name	= MTK_MIPICSI_DRV_NAME,
+		.pm	= &mtk_mipicsi_pm,
 		.of_match_table = of_match_ptr(mtk_mipicsi_of_match),
 	},
 	.probe		= mtk_mipicsi_probe,
-- 
2.18.0

