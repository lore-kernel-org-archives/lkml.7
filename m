Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4609C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E3623B7A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE2PFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:05:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17607 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbfE2PFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:05:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5B4D2DBC006830ABF8D4;
        Wed, 29 May 2019 23:05:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 29 May 2019
 23:04:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <kaichieh.chuang@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <alsa-devel@alsa-project.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: mediatek: Make some symbols static
Date:   Wed, 29 May 2019 23:04:37 +0800
Message-ID: <20190529150437.19004-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

sound/soc/mediatek/common/mtk-btcvsd.c:410:5: warning: symbol 'mtk_btcvsd_write_to_bt' was not declared. Should it be static?
sound/soc/mediatek/common/mtk-btcvsd.c:698:9: warning: symbol 'mtk_btcvsd_snd_read' was not declared. Should it be static?
sound/soc/mediatek/common/mtk-btcvsd.c:779:9: warning: symbol 'mtk_btcvsd_snd_write' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index bd55c546e790..c7a81c4be068 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -407,11 +407,11 @@ static int mtk_btcvsd_read_from_bt(struct mtk_btcvsd_snd *bt,
 	return 0;
 }
 
-int mtk_btcvsd_write_to_bt(struct mtk_btcvsd_snd *bt,
-			   enum bt_sco_packet_len packet_type,
-			   unsigned int packet_length,
-			   unsigned int packet_num,
-			   unsigned int blk_size)
+static int mtk_btcvsd_write_to_bt(struct mtk_btcvsd_snd *bt,
+				  enum bt_sco_packet_len packet_type,
+				  unsigned int packet_length,
+				  unsigned int packet_num,
+				  unsigned int blk_size)
 {
 	unsigned int i;
 	unsigned long flags;
@@ -695,9 +695,9 @@ static int wait_for_bt_irq(struct mtk_btcvsd_snd *bt,
 	return 0;
 }
 
-ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
-			    char __user *buf,
-			    size_t count)
+static ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
+				   char __user *buf,
+				   size_t count)
 {
 	ssize_t read_size = 0, read_count = 0, cur_read_idx, cont;
 	unsigned int cur_buf_ofs = 0;
@@ -776,9 +776,9 @@ ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
 	return read_count;
 }
 
-ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
-			     char __user *buf,
-			     size_t count)
+static ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
+				    char __user *buf,
+				    size_t count)
 {
 	int written_size = count, avail = 0, cur_write_idx, write_size, cont;
 	unsigned int cur_buf_ofs = 0;
-- 
2.17.1


