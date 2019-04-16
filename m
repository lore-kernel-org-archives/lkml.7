Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D33C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E926120857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfDPJb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:31:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7680 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728905AbfDPJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:30:23 -0400
X-UUID: 0d23a113ab294fb68a1db4c7304adc27-20190416
X-UUID: 0d23a113ab294fb68a1db4c7304adc27-20190416
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2102386616; Tue, 16 Apr 2019 17:30:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 17:30:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 17:30:18 +0800
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
Subject: [PATCH v2 06/15] [media] mtk-mipicsi: add function to support SerDes for link number
Date:   Tue, 16 Apr 2019 17:30:06 +0800
Message-ID: <1555407015-18130-7-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1555407015-18130-1-git-send-email-stu.hsieh@mediatek.com>
References: <1555407015-18130-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add function to support SerDes for link number.

Mt2712 can server at most four camera link for each mipicsi port.
Therefore, driver need to know how many camera link in SerDes and
set the mipicsi HW to serve.

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 .../media/platform/mtk-mipicsi/mtk_mipicsi.c  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
index 10782fccca79..ec05f3b38cc9 100644
--- a/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
+++ b/drivers/media/platform/mtk-mipicsi/mtk_mipicsi.c
@@ -56,12 +56,16 @@
 #define MIPICSI_COMMON_CLK 2
 #define MTK_CAMDMA_MAX_NUM 4U
 #define MIPICSI_CLK (MIPICSI_COMMON_CLK + MTK_CAMDMA_MAX_NUM)
+#define MAX_DES_LINK 4U
+#define SUBDEV_LINK_REG 0x49
 #define MTK_DATAWIDTH_8					(0x01U << 7U)
 #define MAX_SUPPORT_WIDTH             4096U
 #define MAX_SUPPORT_HEIGHT            4096U
 #define MAX_BUFFER_NUM			32U
 #define VID_LIMIT_BYTES			(100U * 1024U * 1024U)
 
+#define SerDes_support 1
+
 /* buffer for one video frame */
 struct mtk_mipicsi_buf {
 	struct list_head queue;
@@ -92,6 +96,7 @@ struct mtk_mipicsi_dev {
 	bool streamon;
 	unsigned long frame_cnt[MTK_CAMDMA_MAX_NUM];
 	unsigned int link;
+	u8 link_reg_val;
 	unsigned long enqueue_cnt;
 	unsigned long dequeue_cnt;
 	struct v4l2_ctrl_handler ctrl_hdl;
@@ -113,6 +118,64 @@ struct mtk_mipicsi_dev {
 		V4L2_MBUS_PCLK_SAMPLE_FALLING |	\
 		V4L2_MBUS_DATA_ACTIVE_HIGH)
 
+static int get_subdev_register(const struct soc_camera_device *icd,
+	struct v4l2_dbg_register *reg)
+{
+	struct v4l2_subdev *sd = soc_camera_to_subdev(icd);
+	int ret = 0;
+
+	reg->match.type = V4L2_CHIP_MATCH_SUBDEV;
+	reg->match.addr = 0;
+	ret = v4l2_subdev_call(sd, core, g_register, reg);
+	if (ret != 2) {
+		dev_err(icd->parent, "mipicsi get des register 0x%llx fail, ret=%d\n",
+			reg->reg, ret);
+		return -EIO;
+	}
+
+	dev_info(icd->parent, "read DES [reg/val/ret] is [0x%llx/0x%llx/%d]\n",
+		reg->reg, reg->val, ret);
+	return ret;
+}
+
+static int get_subdev_link(const struct soc_camera_device *icd,
+	unsigned int *link, u8 *link_reg_val)
+{
+	struct v4l2_dbg_register reg;
+	int ret = 0;
+	unsigned int index = 0U;
+	*link_reg_val = 0x0U;
+
+	if (SerDes_support == 0) {
+		*link = 1;
+		*link_reg_val = 0x1;
+		dev_info(icd->parent, "subdev not support SerDes\n");
+		return 0;
+	}
+
+	if (link == NULL)
+		return -EINVAL;
+
+	memset(&reg, 0, sizeof(reg));
+	/*get camera link number*/
+	reg.reg = SUBDEV_LINK_REG;
+	ret = get_subdev_register(icd, &reg);
+	if (ret < 0)
+		return ret;
+
+	*link = 0U;
+	for (index = 0U; index < MAX_DES_LINK; ++index) {
+		if ((reg.val & 0x01U) == 0x01U) {
+			*link += 1U;
+			*link_reg_val |= (0x01U << index);
+		}
+		reg.val >>= 1U;
+	}
+
+	dev_info(icd->parent, "%u camera linked to sub device\n", *link);
+	return 0;
+}
+
 static u32 get_bytesperline(const u32 fmt, const u32 width)
 {
 	u32 bytesperline = 0;
@@ -144,6 +207,7 @@ static int mtk_mipicsi_add_device(struct soc_camera_device *icd)
 	u32 height;
 	u32 fmt;
 
+	(void)get_subdev_link(icd, &mipicsi->link, &mipicsi->link_reg_val);
 	/* Get width/height info from subdev. Then use them to set register */
 	ret = v4l2_subdev_call(sd, pad, get_fmt, NULL, &format);
 	if (ret < 0) {
-- 
2.18.0

