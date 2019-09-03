Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A626C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569C2206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfICJjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:39:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23106 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728129AbfICJjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:39:03 -0400
X-UUID: 9d95ffdfe38d406598732577f6d3d164-20190903
X-UUID: 9d95ffdfe38d406598732577f6d3d164-20190903
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 481907305; Tue, 03 Sep 2019 17:38:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Sep 2019 17:38:55 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Sep 2019 17:38:54 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, Rick Chang <rick.chang@mediatek.com>
Subject: [PATCH v3 05/14] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
Date:   Tue, 3 Sep 2019 17:37:27 +0800
Message-ID: <1567503456-24725-6-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567503456-24725-1-git-send-email-yong.wu@mediatek.com>
References: <1567503456-24725-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU has already added device_link between the consumer
and smi-larb device. If the jpg device call the pm_runtime_get_sync,
the smi-larb's pm_runtime_get_sync also be called automatically.

CC: Rick Chang <rick.chang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 22 ----------------------
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h |  2 --
 2 files changed, 24 deletions(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index ee802fc..3242a8d 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -21,7 +21,6 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-core.h>
 #include <media/videobuf2-dma-contig.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_jpeg_hw.h"
 #include "mtk_jpeg_core.h"
@@ -893,11 +892,6 @@ static int mtk_jpeg_queue_init(void *priv, struct vb2_queue *src_vq,
 
 static void mtk_jpeg_clk_on(struct mtk_jpeg_dev *jpeg)
 {
-	int ret;
-
-	ret = mtk_smi_larb_get(jpeg->larb);
-	if (ret)
-		dev_err(jpeg->dev, "mtk_smi_larb_get larbvdec fail %d\n", ret);
 	clk_prepare_enable(jpeg->clk_jdec_smi);
 	clk_prepare_enable(jpeg->clk_jdec);
 }
@@ -906,7 +900,6 @@ static void mtk_jpeg_clk_off(struct mtk_jpeg_dev *jpeg)
 {
 	clk_disable_unprepare(jpeg->clk_jdec);
 	clk_disable_unprepare(jpeg->clk_jdec_smi);
-	mtk_smi_larb_put(jpeg->larb);
 }
 
 static irqreturn_t mtk_jpeg_dec_irq(int irq, void *priv)
@@ -1051,21 +1044,6 @@ static int mtk_jpeg_release(struct file *file)
 
 static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
 {
-	struct device_node *node;
-	struct platform_device *pdev;
-
-	node = of_parse_phandle(jpeg->dev->of_node, "mediatek,larb", 0);
-	if (!node)
-		return -EINVAL;
-	pdev = of_find_device_by_node(node);
-	if (WARN_ON(!pdev)) {
-		of_node_put(node);
-		return -EINVAL;
-	}
-	of_node_put(node);
-
-	jpeg->larb = &pdev->dev;
-
 	jpeg->clk_jdec = devm_clk_get(jpeg->dev, "jpgdec");
 	if (IS_ERR(jpeg->clk_jdec))
 		return PTR_ERR(jpeg->clk_jdec);
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
index 999bd14..8579494 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
@@ -47,7 +47,6 @@ enum mtk_jpeg_ctx_state {
  * @dec_reg_base:	JPEG registers mapping
  * @clk_jdec:		JPEG hw working clock
  * @clk_jdec_smi:	JPEG SMI bus clock
- * @larb:		SMI device
  */
 struct mtk_jpeg_dev {
 	struct mutex		lock;
@@ -61,7 +60,6 @@ struct mtk_jpeg_dev {
 	void __iomem		*dec_reg_base;
 	struct clk		*clk_jdec;
 	struct clk		*clk_jdec_smi;
-	struct device		*larb;
 };
 
 /**
-- 
1.9.1

