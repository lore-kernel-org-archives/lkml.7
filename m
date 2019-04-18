Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD23DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE3A2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbfDRJIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:08:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60465 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388303AbfDRJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:08:14 -0400
X-UUID: 0d444f95a246432192204ce05d600cbd-20190418
X-UUID: 0d444f95a246432192204ce05d600cbd-20190418
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 478835297; Thu, 18 Apr 2019 17:08:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Apr 2019 17:08:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Apr 2019 17:08:04 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <ulf.hansson@linaro.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 3/4] Bluetooth: btmtksdio: Fix hdev->stat.byte_rx accumulation
Date:   Thu, 18 Apr 2019 17:08:01 +0800
Message-ID: <ea8d491b7e737a51a6cfbc6d9078ba98012b0e66.1555577565.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1555577565.git.sean.wang@mediatek.com>
References: <cover.1555577565.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Accumulate hdev->stat.byte_rx only for valid packets as btmtkuart doing.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 9c123a9de673..877c0a831775 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -391,8 +391,6 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
 	if (err < 0)
 		goto err_kfree_skb;
 
-	bdev->hdev->stat.byte_rx += rx_size;
-
 	sdio_hdr = (void *)skb->data;
 
 	/* We assume the default error as -EILSEQ simply to make the error path
@@ -457,6 +455,8 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
 	/* Complete frame */
 	(&pkts[i])->recv(bdev->hdev, skb);
 
+	bdev->hdev->stat.byte_rx += rx_size;
+
 	return 0;
 
 err_kfree_skb:
-- 
2.18.0

