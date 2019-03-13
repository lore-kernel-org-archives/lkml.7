Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FFFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63EC2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfCMVCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:02:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60998 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727411AbfCMVCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:02:11 -0400
X-UUID: 2ab71b10a60948c39ff39828b95cc6d4-20190314
X-UUID: 2ab71b10a60948c39ff39828b95cc6d4-20190314
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 659138195; Thu, 14 Mar 2019 05:02:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 05:02:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 05:02:03 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 3/3] Bluetooth: btsdio: Use module_sdio_driver helper
Date:   Thu, 14 Mar 2019 05:02:00 +0800
Message-ID: <38ca0408d4c189cb8a01820749c10077450c4465.1552510141.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1552510141.git.sean.wang@mediatek.com>
References: <cover.1552510141.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Macro module_sdio_driver is used for drivers whose init and exit paths
only register and unregister to SDIO API. So remove boilerplate code to
make code simpler by using module_sdio_driver.

Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btsdio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 282d1af1d3ba..4cfa9abe03c8 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -376,20 +376,7 @@ static struct sdio_driver btsdio_driver = {
 	.id_table	= btsdio_table,
 };
 
-static int __init btsdio_init(void)
-{
-	BT_INFO("Generic Bluetooth SDIO driver ver %s", VERSION);
-
-	return sdio_register_driver(&btsdio_driver);
-}
-
-static void __exit btsdio_exit(void)
-{
-	sdio_unregister_driver(&btsdio_driver);
-}
-
-module_init(btsdio_init);
-module_exit(btsdio_exit);
+module_sdio_driver(btsdio_driver);
 
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Generic Bluetooth SDIO driver ver " VERSION);
-- 
2.18.0

