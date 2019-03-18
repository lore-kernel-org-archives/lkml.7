Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F362133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfCRU6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:58:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37104 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726944AbfCRU6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:58:42 -0400
X-UUID: c5318549fbdd484099700d7b3d543ff9-20190319
X-UUID: c5318549fbdd484099700d7b3d543ff9-20190319
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1711926507; Tue, 19 Mar 2019 04:58:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Mar 2019 04:58:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Mar 2019 04:58:33 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2] Bluetooth: btmtksdio: fix uninitialized symbol errors in btmtksdio_rx_packet
Date:   Tue, 19 Mar 2019 04:58:33 +0800
Message-ID: <741bf172b7d0b77e664e7edeab1bd798c955cc5b.1552942432.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-TM-SNTS-SMTP: 0F17E529B19880F66F5DD48C42861FFE95E7862658AB986D9949304E5BF6F5182000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fixed all the below warnings. They would probably cause the following
error handling path would use the uninitialized value and then produce
unexpected behavior.

drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_len’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          old_data, old_len, true);
          ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btmtksdio.c:376:15: note: ‘old_len’ was declared here
  unsigned int old_len;
               ^~~~~~~
drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_data’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          old_data, old_len, true);
          ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btmtksdio.c:375:17: note: ‘old_data’ was declared here
  unsigned char *old_data;
                 ^~~~~~~~

v2: Remove old_len and old_data because the error path for sdio_readsb also
    seems wrong. And change the prefix from "mediatek" to "btmtksdio".

Fixes: d74eef2834b5 ("Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDIO devices")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index befe43f9a34a..7d0d1cb93b0e 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -372,8 +372,6 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
 	const struct h4_recv_pkt *pkts = mtk_recv_pkts;
 	int pkts_count = ARRAY_SIZE(mtk_recv_pkts);
 	struct mtkbtsdio_hdr *sdio_hdr;
-	unsigned char *old_data;
-	unsigned int old_len;
 	int err, i, pad_size;
 	struct sk_buff *skb;
 	u16 dlen;
@@ -392,12 +390,6 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
 	if (err < 0)
 		goto err_kfree_skb;
 
-	/* Keep old data for dump the content in case of some error is
-	 * caught in the following packet parsing.
-	 */
-	old_data = skb->data;
-	old_len = skb->len;
-
 	bdev->hdev->stat.byte_rx += rx_size;
 
 	sdio_hdr = (void *)skb->data;
@@ -467,8 +459,6 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
 	return 0;
 
 err_kfree_skb:
-	print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
-		       old_data, old_len, true);
 	kfree_skb(skb);
 
 	return err;
-- 
2.18.0

