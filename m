Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8308EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D422183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfDRJIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:08:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63039 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388323AbfDRJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:08:15 -0400
X-UUID: dc404390ff544b44a6b5d2f2808bcbdd-20190418
X-UUID: dc404390ff544b44a6b5d2f2808bcbdd-20190418
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 549511622; Thu, 18 Apr 2019 17:08:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Apr 2019 17:08:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Apr 2019 17:08:04 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <ulf.hansson@linaro.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 1/4] Bluetooth: btmtksdio: Drop newline with bt_dev logging macros
Date:   Thu, 18 Apr 2019 17:07:59 +0800
Message-ID: <ca617836b66cb11f5c7a1131bd3f55d81cf6380b.1555577565.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1555577565.git.sean.wang@mediatek.com>
References: <cover.1555577565.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A75B78FB8E75C462A55038F593A5395F79D92548085D17BDF2D06D07CDFE12CC2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

bt_dev logging macros already include a newline at each output
so drop these unnecessary additional newlines in the driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 7d0d1cb93b0e..681e3e34977e 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -487,15 +487,15 @@ static void btmtksdio_interrupt(struct sdio_func *func)
 	sdio_writel(func, int_status, MTK_REG_CHISR, NULL);
 
 	if (unlikely(!int_status))
-		bt_dev_err(bdev->hdev, "CHISR is 0\n");
+		bt_dev_err(bdev->hdev, "CHISR is 0");
 
 	if (int_status & FW_OWN_BACK_INT)
-		bt_dev_dbg(bdev->hdev, "Get fw own back\n");
+		bt_dev_dbg(bdev->hdev, "Get fw own back");
 
 	if (int_status & TX_EMPTY)
 		schedule_work(&bdev->tx_work);
 	else if (unlikely(int_status & TX_FIFO_OVERFLOW))
-		bt_dev_warn(bdev->hdev, "Tx fifo overflow\n");
+		bt_dev_warn(bdev->hdev, "Tx fifo overflow");
 
 	if (int_status & RX_DONE_INT) {
 		rx_size = (int_status & RX_PKT_LEN) >> 16;
-- 
2.18.0

