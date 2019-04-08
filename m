Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F64EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC12208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDHLzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:55:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46273 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbfDHLzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:32 -0400
X-UUID: 9f66060c3e2a4549bc5113c4906cb91d-20190408
X-UUID: 9f66060c3e2a4549bc5113c4906cb91d-20190408
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1300803878; Mon, 08 Apr 2019 19:55:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:24 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 04/14] [media] mtk-mipicsi: get the w/h/bytepwerline for mtk_mipicsi
Date:   Mon, 8 Apr 2019 19:54:55 +0800
Message-ID: <1554724505-19882-5-git-send-email-stu.hsieh@mediatek.com>
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

This patch get the w/h/bytepwerline to save in mtk_mipicsi.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index ccf2d18a3e74..f9deff1e5a9f 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -100,6 +100,9 @@ struct mtk_mipicsi_dev {
 	u32 id;
 	int clk_num;
 	struct clk		*clk[MIPICSI_CLK];
+	u32 width;
+	u32 height;
+	u32 bytesperline;
 };
 
 #define MTK_MIPICSI_BUS_PARAM (V4L2_MBUS_MASTER |	\
@@ -111,13 +114,36 @@ struct mtk_mipicsi_dev {
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
@@ -126,6 +152,19 @@ static int mtk_mipicsi_add_device(struct soc_camera_device *icd)
 		return ret;
 	}
 
+	width = format.format.width;
+	height = format.format.height;
+	fmt = format.format.code;
+	mipicsi->bytesperline = get_bytesperline(fmt, width);
+	if ((width == 0U) || (height == 0U) || (mipicsi->bytesperline == 0U)) {
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

