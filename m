Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8EBC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0358D2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfCMVCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:02:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22703 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727053AbfCMVCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:02:11 -0400
X-UUID: df365853464e4ac583d7f624e544b023-20190314
X-UUID: df365853464e4ac583d7f624e544b023-20190314
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1420528183; Thu, 14 Mar 2019 05:02:05 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 05:02:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01dr.mediatek.inc (172.21.101.111) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 05:02:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 05:02:02 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 2/3] Bluetooth: mediatek: Use module_sdio_driver helper
Date:   Thu, 14 Mar 2019 05:01:59 +0800
Message-ID: <97430233d791cf69398e6a5f568a61ad42077249.1552510141.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1552510141.git.sean.wang@mediatek.com>
References: <cover.1552510141.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-TM-SNTS-SMTP: F6112C37EDFCC92A8D27299F254CEB6AC4F3E204492C4CE66884824D96311BD32000:8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Macro module_sdio_driver is used for drivers whose init and exit paths
only register and unregister to SDIO API. So remove boilerplate code to
make code simpler by using module_sdio_driver.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 23cf63888bac..ca7f28f439da 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -956,20 +956,7 @@ static struct sdio_driver btmtksdio_driver = {
 	.id_table	= btmtksdio_table,
 };
 
-static int __init btmtksdio_init(void)
-{
-	BT_INFO("MediaTek Bluetooth SDIO driver ver %s", VERSION);
-
-	return sdio_register_driver(&btmtksdio_driver);
-}
-
-static void __exit btmtksdio_exit(void)
-{
-	sdio_unregister_driver(&btmtksdio_driver);
-}
-
-module_init(btmtksdio_init);
-module_exit(btmtksdio_exit);
+module_sdio_driver(btmtksdio_driver);
 
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek Bluetooth SDIO driver ver " VERSION);
-- 
2.18.0

