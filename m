Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A6BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A342063F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDHL4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:56:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39326 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726536AbfDHLze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:34 -0400
X-UUID: 282d5287239b4718a3e1c09dac08486f-20190408
X-UUID: 282d5287239b4718a3e1c09dac08486f-20190408
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1230906536; Mon, 08 Apr 2019 19:55:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:23 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 03/14] [media] mtk-mipicsi: add color format support for mt2712
Date:   Mon, 8 Apr 2019 19:54:54 +0800
Message-ID: <1554724505-19882-4-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
References: <1554724505-19882-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 18EDCA312253150C541D4119A181E5C8EA8AC171CBF65635722FC11C2DBE24A52000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add color format support for mt2712

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index a5ed720df900..ccf2d18a3e74 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -139,6 +139,25 @@ static void mtk_mipicsi_remove_device(struct soc_camera_device *icd)
 	(void)pm_runtime_put_sync(icd->parent);
 }
 
+static bool is_supported(struct soc_camera_device *icd, const u32 pixformat)
+{
+	bool ret = false;
+
+	switch (pixformat) {
+	/* YUV422 */
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_UYVY:
+	case V4L2_PIX_FMT_YVYU:
+	case V4L2_PIX_FMT_VYUY:
+		ret = true;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static int mtk_mipicsi_set_fmt(struct soc_camera_device *icd,
 				struct v4l2_format *f)
 {
@@ -154,6 +173,12 @@ static int mtk_mipicsi_set_fmt(struct soc_camera_device *icd,
 	struct v4l2_mbus_framefmt *mf = &format.format;
 	int ret = 0;
 
+	if (!is_supported(icd, pix->pixelformat)) {
+		dev_err(dev, "Format %x not support. set V4L2_PIX_FMT_YUYV as default\n",
+			pix->pixelformat);
+		pix->pixelformat = V4L2_PIX_FMT_YUYV;
+	}
+
 	xlate = soc_camera_xlate_by_fourcc(icd, pix->pixelformat);
 	if (xlate == NULL) {
 		dev_err(dev, "Format 0x%x not found\n", pix->pixelformat);
-- 
2.18.0

