Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78867C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5782F206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbfIDHy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:54:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62607 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729125AbfIDHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:54:58 -0400
X-UUID: 3c934b3f09dd4918a237f385a8221a68-20190904
X-UUID: 3c934b3f09dd4918a237f385a8221a68-20190904
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 155241615; Wed, 04 Sep 2019 15:54:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Sep 2019 15:54:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Sep 2019 15:54:48 +0800
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>,
        Zachary Hays <zhays@lexmark.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 1/2] mmc: block: make the card_busy_detect() more generic
Date:   Wed, 4 Sep 2019 15:54:43 +0800
Message-ID: <20190904075444.2163-2-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190904075444.2163-1-chaotian.jing@mediatek.com>
References: <20190904075444.2163-1-chaotian.jing@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to use the card_busy_detect() to wait card levae the programming state,
there may be do not have the "struct request *" argument.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/block.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c71a434c915..aa7c19f7e298 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -981,7 +981,7 @@ static inline bool mmc_blk_in_tran_state(u32 status)
 }
 
 static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
-			    struct request *req, u32 *resp_errs)
+			    u32 *resp_errs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	int err = 0;
@@ -992,8 +992,8 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 
 		err = __mmc_send_status(card, &status, 5);
 		if (err) {
-			pr_err("%s: error %d requesting status\n",
-			       req->rq_disk->disk_name, err);
+			dev_err(mmc_dev(card->host),
+				"error %d requesting status\n", err);
 			return err;
 		}
 
@@ -1006,9 +1006,9 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 		 * leaves the program state.
 		 */
 		if (done) {
-			pr_err("%s: Card stuck in wrong state! %s %s status: %#x\n",
-				mmc_hostname(card->host),
-				req->rq_disk->disk_name, __func__, status);
+			dev_err(mmc_dev(card->host),
+				"Card stuck in wrong state! %s status: %#x\n",
+				 __func__, status);
 			return -ETIMEDOUT;
 		}
 
@@ -1671,7 +1671,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 	mmc_blk_send_stop(card, timeout);
 
-	err = card_busy_detect(card, timeout, req, NULL);
+	err = card_busy_detect(card, timeout, NULL);
 
 	mmc_retune_release(card->host);
 
@@ -1895,7 +1895,7 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
 		return 0;
 
-	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, req, &status);
+	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, &status);
 
 	/*
 	 * Do not assume data transferred correctly if there are any error bits
-- 
2.18.0

