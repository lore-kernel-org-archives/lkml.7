Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70A0C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DA021848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 06:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfHVGr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:47:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4502 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730847AbfHVGr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 02:47:56 -0400
X-UUID: a74640b5860348139aa514829cad0918-20190822
X-UUID: a74640b5860348139aa514829cad0918-20190822
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1104521508; Thu, 22 Aug 2019 14:47:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 22 Aug 2019 14:47:45 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 22 Aug 2019 14:47:44 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 2/2] mmc: mediatek: support 24bits segment size
Date:   Thu, 22 Aug 2019 14:47:41 +0800
Message-ID: <20190822064741.11196-3-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190822064741.11196-1-chaotian.jing@mediatek.com>
References: <20190822064741.11196-1-chaotian.jing@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSDC IP which support 64G DRAM will support 24bits BDMA buffer length,
so add support it.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5cc422e5db69..4c72c5b73e87 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -328,6 +328,7 @@ struct mt_bdma_desc {
 	u32 ptr;
 	u32 bd_data_len;
 #define BDMA_DESC_BUFLEN	(0xffff) /* bit0 ~ bit15 */
+#define BDMA_DESC_BUFLEN_EXT	(0xffffff) /* bit0 ~ bit23 */
 };
 
 struct msdc_dma {
@@ -641,8 +642,14 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 			bd[j].bd_info |= (upper_32_bits(dma_address) & 0xf)
 					 << 28;
 		}
-		bd[j].bd_data_len &= ~BDMA_DESC_BUFLEN;
-		bd[j].bd_data_len |= (dma_len & BDMA_DESC_BUFLEN);
+
+		if (host->dev_comp->support_64g) {
+			bd[j].bd_data_len &= ~BDMA_DESC_BUFLEN_EXT;
+			bd[j].bd_data_len |= (dma_len & BDMA_DESC_BUFLEN_EXT);
+		} else {
+			bd[j].bd_data_len &= ~BDMA_DESC_BUFLEN;
+			bd[j].bd_data_len |= (dma_len & BDMA_DESC_BUFLEN);
+		}
 
 		if (j == data->sg_count - 1) /* the last bd */
 			bd[j].bd_info |= BDMA_DESC_EOL;
@@ -2277,7 +2284,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs = MAX_BD_NUM;
-	mmc->max_seg_size = BDMA_DESC_BUFLEN;
+	if (host->dev_comp->support_64g)
+		mmc->max_seg_size = BDMA_DESC_BUFLEN_EXT;
+	else
+		mmc->max_seg_size = BDMA_DESC_BUFLEN;
 	mmc->max_blk_size = 2048;
 	mmc->max_req_size = 512 * 1024;
 	mmc->max_blk_count = mmc->max_req_size / 512;
-- 
2.18.0

