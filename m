Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AA8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234B52087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfDHLzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:55:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22670 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726638AbfDHLzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:33 -0400
X-UUID: 99a3c86eb47748768ae0f97fdedd92cb-20190408
X-UUID: 99a3c86eb47748768ae0f97fdedd92cb-20190408
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 926207; Mon, 08 Apr 2019 19:55:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:29 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 11/14] [media] mtk-mipicsi: add function to get the format
Date:   Mon, 8 Apr 2019 19:55:02 +0800
Message-ID: <1554724505-19882-12-git-send-email-stu.hsieh@mediatek.com>
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

This patch add function to get the format

This function can get the subdev format and host format.
Calculate the number of format which intersection of subdev and host.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index 2098e3e30de6..9361cc4c77ac 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -164,6 +164,50 @@ struct mtk_mipicsi_dev {
 	u32 bytesperline;
 };
 
+static const struct soc_mbus_lookup mtk_mipicsi_formats[] = {
+{
+	.code = MEDIA_BUS_FMT_YUYV8_2X8,
+	.fmt = {
+		.fourcc			= V4L2_PIX_FMT_YUYV,
+		.name			= "YUYV",
+		.bits_per_sample	= 8,
+		.packing		= SOC_MBUS_PACKING_2X8_PADHI,
+		.order			= SOC_MBUS_ORDER_LE,
+		.layout			= SOC_MBUS_LAYOUT_PACKED,
+	},
+}, {
+	.code = MEDIA_BUS_FMT_YVYU8_2X8,
+	.fmt = {
+		.fourcc			= V4L2_PIX_FMT_YVYU,
+		.name			= "YVYU",
+		.bits_per_sample	= 8,
+		.packing		= SOC_MBUS_PACKING_2X8_PADHI,
+		.order			= SOC_MBUS_ORDER_LE,
+		.layout			= SOC_MBUS_LAYOUT_PACKED,
+	},
+}, {
+	.code = MEDIA_BUS_FMT_UYVY8_2X8,
+	.fmt = {
+		.fourcc			= V4L2_PIX_FMT_UYVY,
+		.name			= "UYVY",
+		.bits_per_sample	= 8,
+		.packing		= SOC_MBUS_PACKING_2X8_PADHI,
+		.order			= SOC_MBUS_ORDER_LE,
+		.layout			= SOC_MBUS_LAYOUT_PACKED,
+	},
+}, {
+	.code = MEDIA_BUS_FMT_VYUY8_2X8,
+	.fmt = {
+		.fourcc			= V4L2_PIX_FMT_VYUY,
+		.name			= "VYUY",
+		.bits_per_sample	= 8,
+		.packing		= SOC_MBUS_PACKING_2X8_PADHI,
+		.order			= SOC_MBUS_ORDER_LE,
+		.layout			= SOC_MBUS_LAYOUT_PACKED,
+	},
+},
+};
+
 #define MTK_MIPICSI_BUS_PARAM (V4L2_MBUS_MASTER |	\
 		V4L2_MBUS_HSYNC_ACTIVE_HIGH |	\
 		V4L2_MBUS_HSYNC_ACTIVE_LOW |	\
@@ -208,6 +252,43 @@ static void mtk_mipicsi_ana_clk_enable(void __iomem *base, bool enable)
 	}
 }
 
+static int mtk_mipicsi_try_bus_param(struct soc_camera_device *icd,
+					    unsigned char buswidth)
+{
+	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
+	struct soc_camera_host *ici = to_soc_camera_host(icd->parent);
+	struct mtk_mipicsi_dev *mipicsi = ici->priv;
+	struct v4l2_mbus_config cfg = {.type = V4L2_MBUS_CSI2_DPHY,};
+	unsigned long common_flags = 0;
+	int ret = 0;
+
+	ret = v4l2_subdev_call(sd, video, g_mbus_config, &cfg);
+	if (ret == 0) {
+		common_flags = soc_mbus_config_compatible(&cfg,
+				MTK_MIPICSI_BUS_PARAM);
+		if (common_flags == 0U) {
+			dev_warn(icd->parent, "Flags incompatible: camera 0x%x\n",
+				cfg.flags);
+			return -EINVAL;
+		}
+	} else {
+		if (ret != -ENOIOCTLCMD)
+			return ret;
+	}
+
+	if ((((u16)1U << (buswidth - 1U)) & mipicsi->width_flags) != 0U)
+		return 0;
+
+	return -EINVAL;
+}
+
+static bool mtk_mipicsi_packing_supported(const struct soc_mbus_pixelfmt *fmt)
+{
+	return	fmt->packing == SOC_MBUS_PACKING_NONE ||
+		(fmt->bits_per_sample == 8U &&
+		 fmt->packing == SOC_MBUS_PACKING_2X8_PADHI);
+}
+
 static int get_subdev_register(const struct soc_camera_device *icd,
 	struct v4l2_dbg_register *reg)
 {
@@ -331,6 +412,72 @@ static void mtk_mipicsi_remove_device(struct soc_camera_device *icd)
 	(void)pm_runtime_put_sync(icd->parent);
 }
 
+static int mtk_mipicsi_get_formats(struct soc_camera_device *icd,
+		unsigned int idx, struct soc_camera_format_xlate *xlate)
+{
+	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
+	int formats = 0, ret, i;
+	int n = ARRAY_SIZE(mtk_mipicsi_formats);
+
+	struct v4l2_subdev_mbus_code_enum mbus_code = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.index = idx,
+	};
+	/* subdev format */
+	const struct soc_mbus_pixelfmt *fmt;
+
+	ret = v4l2_subdev_call(sd, pad, enum_mbus_code, NULL, &mbus_code);
+	if (ret < 0)
+		/* No more formats */
+		return 0;
+
+	/* get subdev support format */
+	fmt = soc_mbus_get_fmtdesc(mbus_code.code);
+	if (fmt == NULL) {
+		dev_err(icd->parent, "Invalid format code #%u: %d",
+			idx, mbus_code.code);
+		return 0;
+	}
+
+	/* This also checks support for the requested bits-per-sample */
+	ret = mtk_mipicsi_try_bus_param(icd, fmt->bits_per_sample);
+	if (ret < 0) {
+		dev_err(icd->parent, "Fail to try the bus parameters.\n");
+		return 0;
+	}
+
+	switch (mbus_code.code) {
+	case MEDIA_BUS_FMT_UYVY8_2X8:
+	case MEDIA_BUS_FMT_VYUY8_2X8:
+	case MEDIA_BUS_FMT_YUYV8_2X8:
+	case MEDIA_BUS_FMT_YVYU8_2X8:
+			dev_dbg(icd->parent, "Providing format %s using code %d\n",
+				fmt->name, mbus_code.code);
+		break;
+	default:
+		if (!mtk_mipicsi_packing_supported(fmt))
+			return 0;
+		if (xlate != NULL)
+			dev_dbg(icd->parent,
+				"Providing format %s in pass-through mode\n",
+				fmt->name);
+		break;
+	}
+
+	/* get camera host and subdev format intersection */
+	for (i = 0; i < n; ++i)
+		if (mtk_mipicsi_formats[i].fmt.fourcc == fmt->fourcc) {
+			++formats;
+			if (xlate != NULL) {
+				xlate->host_fmt = &mtk_mipicsi_formats[i].fmt;
+				xlate->code = mbus_code.code;
+				xlate++;
+			}
+		}
+
+	return formats;
+}
+
 static bool is_supported(struct soc_camera_device *icd, const u32 pixformat)
 {
 	bool ret = false;
@@ -736,6 +883,7 @@ static struct soc_camera_host_ops mtk_soc_camera_host_ops = {
 	.owner			= THIS_MODULE,
 	.add			= mtk_mipicsi_add_device,
 	.remove			= mtk_mipicsi_remove_device,
+	.get_formats            = mtk_mipicsi_get_formats,
 	.set_fmt		= mtk_mipicsi_set_fmt,
 	.try_fmt		= mtk_mipicsi_try_fmt,
 	.init_videobuf2	= mtk_mipicsi_init_videobuf2,
-- 
2.18.0

