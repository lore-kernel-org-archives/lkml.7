Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0E7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EC920651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfDPJbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:31:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46852 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728193AbfDPJaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:30:25 -0400
X-UUID: 037ff4b089d344439448c5ddd8d8440b-20190416
X-UUID: 037ff4b089d344439448c5ddd8d8440b-20190416
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1631183566; Tue, 16 Apr 2019 17:30:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 17:30:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 17:30:17 +0800
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
Subject: [PATCH v2 03/15] [media] mtk-mipicsi: add pm function
Date:   Tue, 16 Apr 2019 17:30:03 +0800
Message-ID: <1555407015-18130-4-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1555407015-18130-1-git-send-email-stu.hsieh@mediatek.com>
References: <1555407015-18130-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 48967CEB63FF91E327FD0A2DCBA22904CA4C750A69FB2313E50D2B42E8D872CA2000:8
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
index e26bebe17fe5..ec4f6b503b32 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -464,6 +464,85 @@ static struct soc_camera_host_ops mtk_soc_camera_host_ops = {
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
@@ -756,6 +835,7 @@ static const struct of_device_id mtk_mipicsi_of_match[] = {
 static struct platform_driver mtk_mipicsi_driver = {
 	.driver		= {
 		.name	= MTK_MIPICSI_DRV_NAME,
+		.pm	= &mtk_mipicsi_pm,
 		.of_match_table = of_match_ptr(mtk_mipicsi_of_match),
 	},
 	.probe		= mtk_mipicsi_probe,
-- 
2.18.0

