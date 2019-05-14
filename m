Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC3C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2F02147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfENGOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 02:14:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37599 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725866AbfENGOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 02:14:00 -0400
X-UUID: 5e4998ecda3b4556ba454c41d1017f4d-20190514
X-UUID: 5e4998ecda3b4556ba454c41d1017f4d-20190514
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 372259514; Tue, 14 May 2019 14:13:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v3 05/13] [media] mtk-mipicsi: get the w/h/bytepwerline for mtk_mipicsi
Date:   Tue, 14 May 2019 14:13:42 +0800
Message-ID: <1557814430-9675-6-git-send-email-stu.hsieh@mediatek.com>
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

This patch get the w/h/bytepwerline to save in mtk_mipicsi.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index 9c65b96456c4..920848e965e3 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -132,6 +132,9 @@ struct mtk_mipicsi_dev {
 	u32 id;
 	int clk_num;
 	struct clk		*clk[MIPICSI_CLK];
+	u32 width;
+	u32 height;
+	u32 bytesperline;
 };
 
 #define MTK_MIPICSI_BUS_PARAM (V4L2_MBUS_MASTER |	\
@@ -143,13 +146,36 @@ struct mtk_mipicsi_dev {
 		V4L2_MBUS_PCLK_SAMPLE_FALLING |	\
 		V4L2_MBUS_DATA_ACTIVE_HIGH)
 
+static u32 get_bytesperline(const u32 fmt, const u32 width)
+{
+	u32 bytesperline = 0;
+
+	switch (fmt) {
+	case MEDIA_BUS_FMT_UYVY8_2X8:
+	case MEDIA_BUS_FMT_VYUY8_2X8:
+	case MEDIA_BUS_FMT_YUYV8_2X8:
+	case MEDIA_BUS_FMT_YVYU8_2X8:
+		bytesperline = width * 2U;
+		break;
+	default:
+		break;
+	}
+
+	return bytesperline;
+}
+
 static int mtk_mipicsi_add_device(struct soc_camera_device *icd)
 {
+	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+	struct mtk_mipicsi_dev *mipicsi = ici->priv;
 	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
 	struct v4l2_subdev_format format = {
 		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
 	};
 	int ret;
+	u32 width;
+	u32 height;
+	u32 fmt;
 
 	/* Get width/height info from subdev. Then use them to set register */
 	ret = v4l2_subdev_call(sd, pad, get_fmt, NULL, &format);
@@ -158,6 +184,21 @@ static int mtk_mipicsi_add_device(struct soc_camera_device *icd)
 		return ret;
 	}
 
+	width = format.format.width;
+	height = format.format.height;
+	fmt = format.format.code;
+	mipicsi->bytesperline = get_bytesperline(fmt, width);
+	if ((width == 0U) || (width > MAX_SUPPORT_WIDTH) ||
+	    (height == 0U) || (height > MAX_SUPPORT_HEIGHT) ||
+	    (mipicsi->bytesperline == 0U)) {
+		dev_err(icd->parent, "invalid sub device width/height/bytesperline %d/%d/%d\n",
+			width, height, mipicsi->bytesperline);
+		return -EINVAL;
+	}
+
+	mipicsi->width = width;
+	mipicsi->height = height;
+
 	/*
 	 * If power domain was closed before, it will be open.
 	 * Then clock will be open and register will be set
-- 
2.18.0

