Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE4CC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDEC2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfDHLzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:55:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51319 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726744AbfDHLzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:55:40 -0400
X-UUID: 17453927a45c4b618da3a1b821f749f1-20190408
X-UUID: 17453927a45c4b618da3a1b821f749f1-20190408
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1324486373; Mon, 08 Apr 2019 19:55:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 8 Apr 2019 19:55:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 8 Apr 2019 19:55:33 +0800
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Stu Hsieh <stu.hsieh@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 14/14] [media] mtk-mipicsi: add debugfs for mipicsi driver
Date:   Mon, 8 Apr 2019 19:55:05 +0800
Message-ID: <1554724505-19882-15-git-send-email-stu.hsieh@mediatek.com>
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

This patch add debugfs for mipicsi driver.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index 95d25db5e606..77aecadab6b7 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -49,6 +49,7 @@
 #include <soc/mediatek/smi.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <linux/debugfs.h>
 
 #ifdef CONFIG_VB2_MEDIATEK_DMA_SG
 #include "mtkbuf-dma-cache-sg.h"
@@ -87,6 +88,7 @@
 #define SENINF_NCSI2_INT_EN				0xB0
 #define SENINF_NCSI2_INT_STATUS				0xB4
 #define SENINF_NCSI2_DBG_SEL				0xB8
+#define SENINF_NCSI2_DBG_PORT				0xBC
 #define SENINF_NCSI2_HSRX_DBG				0xD8
 #define SENINF_NCSI2_DI					0xDC
 #define SENINF_NCSI2_DI_CTRL				0xE4
@@ -96,6 +98,7 @@
 #define SENINF_TOP_MUX					0x08
 
 #define SENINF_MUX_CTRL					0x00
+#define SENINF_MUX_DEBUG_2				0x14
 
 #define CAMSV_MODULE_EN					0x10
 #define CAMSV_FMT_SEL					0x14
@@ -118,6 +121,7 @@
 #define DMA_FRAME_HEADER_EN				0xE00
 
 #define SerDes_support 1
+#define CONFIG_DEBUG_FS 1
 
 static int mtk_mipicsi_dbg_level;
 #define mtk_mipicsi_dbg(level, fmt, args...)				 \
@@ -174,6 +178,9 @@ struct mtk_mipicsi_dev {
 	u32 width;
 	u32 height;
 	u32 bytesperline;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *mtk_mipicsi_debugfs;
+#endif
 };
 
 static const struct soc_mbus_lookup mtk_mipicsi_formats[] = {
@@ -229,6 +236,49 @@ static const struct soc_mbus_lookup mtk_mipicsi_formats[] = {
 		V4L2_MBUS_PCLK_SAMPLE_FALLING |	\
 		V4L2_MBUS_DATA_ACTIVE_HIGH)
 
+#ifdef CONFIG_DEBUG_FS
+static ssize_t mtk_mipicsi_debug_read(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct device *dev = file->private_data;
+	struct soc_camera_host *soc_host = to_soc_camera_host(dev);
+	struct mtk_mipicsi_dev *mipicsi = soc_host->priv;
+	u32 int_val;
+	u32 dbg_port;
+	u32 cnt_val;
+	u32 hcnt;
+	u32 vcnt;
+	char buf[256];
+	char cnt_info[150];
+	int i;
+
+	int_val = readl(mipicsi->seninf + SENINF_NCSI2_INT_STATUS);
+	dbg_port = readl(mipicsi->seninf + SENINF_NCSI2_DBG_PORT);
+	memset(buf, 0, sizeof(buf));
+	snprintf(buf, sizeof(buf), "%s\nSENINF_NCSI2_INT_STATUS: 0x%X\n"
+		"SENINF_NCSI2_DBG_PORT: 0x%X\n",
+		dev_name(dev), int_val, dbg_port);
+
+	for (i = 0; i < mipicsi->camsv_num; ++i) {
+		cnt_val = readl(mipicsi->seninf_mux[i] + SENINF_MUX_DEBUG_2);
+		hcnt = (cnt_val >> 16) & 0xFFFF;
+		vcnt = cnt_val & 0xFFFF;
+		memset(cnt_info, 0, sizeof(cnt_info));
+		snprintf(cnt_info, sizeof(cnt_info),
+			"HCNT[%d]: 0x%X\n"
+			"VCNT[%d]: 0x%X\n",
+			i, hcnt, i, vcnt);
+		strcat(buf, cnt_info);
+	}
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+}
+static const struct file_operations mtk_mipicsi_debug_fops = {
+	.open = simple_open,
+	.read = mtk_mipicsi_debug_read,
+};
+#endif /* CONFIG_DEBUG_FS */
+
 static void mtk_mipicsi_ana_clk_enable(void __iomem *base, bool enable)
 {
 	if (enable) {
@@ -1588,6 +1638,16 @@ static int mtk_mipicsi_probe(struct platform_device *pdev)
 		goto clean;
 	}
 
+#ifdef CONFIG_DEBUG_FS
+	mipicsi->mtk_mipicsi_debugfs =
+		debugfs_create_file(mipicsi->drv_name, 0444, NULL,
+			(void *)(&pdev->dev), &mtk_mipicsi_debug_fops);
+	if (mipicsi->mtk_mipicsi_debugfs == NULL) {
+		dev_err(&pdev->dev, "debugfs_create_file fail\n");
+		goto clean;
+	}
+#endif
+
 	dev_info(&pdev->dev, "probe done\n");
 	return ret;
 clean:
@@ -1600,6 +1660,11 @@ static int mtk_mipicsi_remove(struct platform_device *pdev)
 {
 	struct soc_camera_host *soc_host = to_soc_camera_host(&pdev->dev);
 
+#ifdef CONFIG_DEBUG_FS
+	struct mtk_mipicsi_dev *mipicsi = soc_host->priv;
+
+	debugfs_remove(mipicsi->mtk_mipicsi_debugfs);
+#endif
 	soc_camera_host_unregister(soc_host);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.18.0

