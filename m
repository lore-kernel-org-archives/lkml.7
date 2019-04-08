Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C3E2063F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfDHLzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:55:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19802 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726784AbfDHLzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:44 -0400
X-UUID: 8f81f9d405414ca7a1a78a2b13a2cb2f-20190408
X-UUID: 8f81f9d405414ca7a1a78a2b13a2cb2f-20190408
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1152854071; Mon, 08 Apr 2019 19:55:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:30 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 12/14] [media] mtk-mipicsi: add the function for Get/Set PARM for application
Date:   Mon, 8 Apr 2019 19:55:03 +0800
Message-ID: <1554724505-19882-13-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
References: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 25D1DC7844124F8F09A5AECF193AC9E8E793571B9851CC0D816D8B62C8BC80B12000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add the function for Get/Set PARM for application.

Application can get the information about number of link.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index 9361cc4c77ac..faf9a94d5157 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -347,6 +347,38 @@ static int get_subdev_link(const struct soc_camera_device *icd,
 	return 0;
 }
 
+static int mtk_mipicsi_get_parm(struct soc_camera_device *icd,
+	struct v4l2_streamparm *a)
+{
+	unsigned int link = 0U;
+	u8 link_reg_val = 0x0U;
+	int ret = 0;
+
+	/*get camera link number*/
+	ret = get_subdev_link(icd, &link, &link_reg_val);
+	if (ret < 0)
+		return ret;
+
+	a->parm.capture.timeperframe.numerator = 1;
+	a->parm.capture.timeperframe.denominator = 30;
+	a->parm.capture.reserved[0] = link_reg_val;
+	a->parm.capture.reserved[1] = (u32)(icd->use_count);
+	dev_info(icd->parent, "use count %d\n", icd->use_count);
+
+	return 0;
+}
+
+static int mtk_mipicsi_set_param(struct soc_camera_device *icd,
+	struct v4l2_streamparm *a)
+{
+	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+
+	if (ici->ops->get_parm == NULL)
+		return ici->ops->get_parm(icd, a);
+
+	return 0;
+}
+
 static u32 get_bytesperline(const u32 fmt, const u32 width)
 {
 	u32 bytesperline = 0;
@@ -890,6 +922,8 @@ static struct soc_camera_host_ops mtk_soc_camera_host_ops = {
 	.poll			= vb2_fop_poll,
 	.querycap		= mtk_mipicsi_querycap,
 	.set_bus_param		= mtk_mipicsi_set_bus_param,
+	.get_parm		= mtk_mipicsi_get_parm,
+	.set_parm		= mtk_mipicsi_set_param,
 };
 
 static void mtk_mipicsi_ana_init(void __iomem *base)
-- 
2.18.0

