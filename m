Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83716C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56910206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbfDRJIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:08:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36159 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388394AbfDRJIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:08:16 -0400
X-UUID: 595c95a974654552a558d74eab67a375-20190418
X-UUID: 595c95a974654552a558d74eab67a375-20190418
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1589109885; Thu, 18 Apr 2019 17:08:05 +0800
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
Subject: [PATCH v1 2/4] Bluetooth: btmtksdio: Add a bit definition for CHLPCR
Date:   Thu, 18 Apr 2019 17:08:00 +0800
Message-ID: <59a2a29ece89c13ffc2c7cd32432c1731906f447.1555577565.git.sean.wang@mediatek.com>
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

Add a register bit definition about CHLPCR bit 8 because the bit is quite
different in the meaning between reading and writing that bit.

The patch adds a definition particularly for the bit read to avoid the
confusion about using write definition to read the bit.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 681e3e34977e..9c123a9de673 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -56,7 +56,8 @@ static const struct sdio_device_id btmtksdio_table[] = {
 #define MTK_REG_CHLPCR		0x4	/* W1S */
 #define C_INT_EN_SET		BIT(0)
 #define C_INT_EN_CLR		BIT(1)
-#define C_FW_OWN_REQ_SET	BIT(8)
+#define C_FW_OWN_REQ_SET	BIT(8)  /* For write */
+#define C_COM_DRV_OWN		BIT(8)  /* For read */
 #define C_FW_OWN_REQ_CLR	BIT(9)
 
 #define MTK_REG_CSDIOCSR	0x8
@@ -526,7 +527,7 @@ static int btmtksdio_open(struct hci_dev *hdev)
 		goto err_disable_func;
 
 	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
-				 status & C_FW_OWN_REQ_SET, 2000, 1000000);
+				 status & C_COM_DRV_OWN, 2000, 1000000);
 	if (err < 0) {
 		bt_dev_err(bdev->hdev, "Cannot get ownership from device");
 		goto err_disable_func;
@@ -606,7 +607,7 @@ static int btmtksdio_close(struct hci_dev *hdev)
 	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, NULL);
 
 	err = readx_poll_timeout(btmtksdio_drv_own_query, bdev, status,
-				 !(status & C_FW_OWN_REQ_SET), 2000, 1000000);
+				 !(status & C_COM_DRV_OWN), 2000, 1000000);
 	if (err < 0)
 		bt_dev_err(bdev->hdev, "Cannot return ownership to device");
 
-- 
2.18.0

