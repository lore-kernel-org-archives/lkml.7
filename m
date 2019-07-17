Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A4C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC722173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfGQOhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:37:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfGQOhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:37:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9EEAA6409E109A8FCEDC;
        Wed, 17 Jul 2019 22:37:35 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 17 Jul 2019
 22:37:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <himadri18.07@gmail.com>,
        <colin.king@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] staging: rtl8192e: remove set but not used variable 'payload '
Date:   Wed, 17 Jul 2019 22:35:51 +0800
Message-ID: <20190717143551.29200-1-yuehaibing@huawei.com>
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

drivers/staging/rtl8192e/rtllib_rx.c: In function rtllib_rx_InfraAdhoc:
drivers/staging/rtl8192e/rtllib_rx.c:1303:6: warning:
 variable payload set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 0c19ac2..0bae0a0 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -1300,7 +1300,6 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 	struct rx_ts_record *pTS = NULL;
 	u16 fc, sc, SeqNum = 0;
 	u8 type, stype, multicast = 0, unicast = 0, nr_subframes = 0, TID = 0;
-	u8 *payload;
 	u8 dst[ETH_ALEN];
 	u8 src[ETH_ALEN];
 	u8 bssid[ETH_ALEN] = {0};
@@ -1412,7 +1411,6 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
 
 	/* Parse rx data frame (For AMSDU) */
 	/* skb: hdr + (possible reassembled) full plaintext payload */
-	payload = skb->data + hdrlen;
 	rxb = kmalloc(sizeof(struct rtllib_rxb), GFP_ATOMIC);
 	if (!rxb)
 		goto rx_dropped;
-- 
2.7.4


