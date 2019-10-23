Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1796CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D222F2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbfJWHGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:06:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727574AbfJWHGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:06:40 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 83A6368F26DAF8233C58;
        Wed, 23 Oct 2019 15:06:36 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 15:06:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <varkabhadram@gmail.com>, <alex.aring@gmail.com>,
        <stefan@datenfreihafen.org>, <davem@davemloft.net>
CC:     <linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ieee802154: remove set but not used variable 'status'
Date:   Wed, 23 Oct 2019 15:06:18 +0800
Message-ID: <20191023070618.30044-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/net/ieee802154/cc2520.c:221:5: warning:
 variable status set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ieee802154/cc2520.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 4350694..89c046b 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -218,7 +218,6 @@ static int
 cc2520_cmd_strobe(struct cc2520_private *priv, u8 cmd)
 {
 	int ret;
-	u8 status = 0xff;
 	struct spi_message msg;
 	struct spi_transfer xfer = {
 		.len = 0,
@@ -236,8 +235,6 @@ cc2520_cmd_strobe(struct cc2520_private *priv, u8 cmd)
 		 priv->buf[0]);
 
 	ret = spi_sync(priv->spi, &msg);
-	if (!ret)
-		status = priv->buf[0];
 	dev_vdbg(&priv->spi->dev,
 		 "buf[0] = %02x\n", priv->buf[0]);
 	mutex_unlock(&priv->buffer_mutex);
-- 
2.7.4


