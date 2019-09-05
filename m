Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06063C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26E921881
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbfIEHxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:53:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64645 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729366AbfIEHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:53:32 -0400
X-UUID: ad5199dbc8e74ece81fad612e5ac5a53-20190905
X-UUID: ad5199dbc8e74ece81fad612e5ac5a53-20190905
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 579310648; Thu, 05 Sep 2019 15:53:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Sep 2019 15:53:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Sep 2019 15:53:23 +0800
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
Subject: [PATCH v2 2/2] mmc: block: add CMD13 polling for ioctl() cmd with R1B response
Date:   Thu, 5 Sep 2019 15:53:18 +0800
Message-ID: <20190905075318.15554-3-chaotian.jing@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190905075318.15554-1-chaotian.jing@mediatek.com>
References: <20190905075318.15554-1-chaotian.jing@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently there is no CMD13 polling and other code to wait card
change to transfer state after R1B command completed. and this
polling operation cannot do in user space, because other request
may coming before the CMD13 from user space.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/block.c | 146 +++++++++++++++------------------------
 1 file changed, 55 insertions(+), 91 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index aa7c19f7e298..ee1fd7df4ec8 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -408,38 +408,6 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 	return 0;
 }
 
-static int ioctl_rpmb_card_status_poll(struct mmc_card *card, u32 *status,
-				       u32 retries_max)
-{
-	int err;
-	u32 retry_count = 0;
-
-	if (!status || !retries_max)
-		return -EINVAL;
-
-	do {
-		err = __mmc_send_status(card, status, 5);
-		if (err)
-			break;
-
-		if (!R1_STATUS(*status) &&
-				(R1_CURRENT_STATE(*status) != R1_STATE_PRG))
-			break; /* RPMB programming operation complete */
-
-		/*
-		 * Rechedule to give the MMC device a chance to continue
-		 * processing the previous command without being polled too
-		 * frequently.
-		 */
-		usleep_range(1000, 5000);
-	} while (++retry_count < retries_max);
-
-	if (retry_count == retries_max)
-		err = -EPERM;
-
-	return err;
-}
-
 static int ioctl_do_sanitize(struct mmc_card *card)
 {
 	int err;
@@ -468,6 +436,58 @@ static int ioctl_do_sanitize(struct mmc_card *card)
 	return err;
 }
 
+static inline bool mmc_blk_in_tran_state(u32 status)
+{
+	/*
+	 * Some cards mishandle the status bits, so make sure to check both the
+	 * busy indication and the card state.
+	 */
+	return status & R1_READY_FOR_DATA &&
+	       (R1_CURRENT_STATE(status) == R1_STATE_TRAN);
+}
+
+static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
+			    u32 *resp_errs)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	int err = 0;
+	u32 status;
+
+	do {
+		bool done = time_after(jiffies, timeout);
+
+		err = __mmc_send_status(card, &status, 5);
+		if (err) {
+			dev_err(mmc_dev(card->host),
+				"error %d requesting status\n", err);
+			return err;
+		}
+
+		/* Accumulate any response error bits seen */
+		if (resp_errs)
+			*resp_errs |= status;
+
+		/*
+		 * Timeout if the device never becomes ready for data and never
+		 * leaves the program state.
+		 */
+		if (done) {
+			dev_err(mmc_dev(card->host),
+				"Card stuck in wrong state! %s status: %#x\n",
+				 __func__, status);
+			return -ETIMEDOUT;
+		}
+
+		/*
+		 * Some cards mishandle the status bits,
+		 * so make sure to check both the busy
+		 * indication and the card state.
+		 */
+	} while (!mmc_blk_in_tran_state(status));
+
+	return err;
+}
+
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			       struct mmc_blk_ioc_data *idata)
 {
@@ -611,16 +631,12 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
 
-	if (idata->rpmb) {
+	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B)) {
 		/*
-		 * Ensure RPMB command has completed by polling CMD13
+		 * Ensure RPMB/R1B command has completed by polling CMD13
 		 * "Send Status".
 		 */
-		err = ioctl_rpmb_card_status_poll(card, &status, 5);
-		if (err)
-			dev_err(mmc_dev(card->host),
-					"%s: Card Status=0x%08X, error %d\n",
-					__func__, status, err);
+		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
 	}
 
 	return err;
@@ -970,58 +986,6 @@ static unsigned int mmc_blk_data_timeout_ms(struct mmc_host *host,
 	return ms;
 }
 
-static inline bool mmc_blk_in_tran_state(u32 status)
-{
-	/*
-	 * Some cards mishandle the status bits, so make sure to check both the
-	 * busy indication and the card state.
-	 */
-	return status & R1_READY_FOR_DATA &&
-	       (R1_CURRENT_STATE(status) == R1_STATE_TRAN);
-}
-
-static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
-			    u32 *resp_errs)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
-	int err = 0;
-	u32 status;
-
-	do {
-		bool done = time_after(jiffies, timeout);
-
-		err = __mmc_send_status(card, &status, 5);
-		if (err) {
-			dev_err(mmc_dev(card->host),
-				"error %d requesting status\n", err);
-			return err;
-		}
-
-		/* Accumulate any response error bits seen */
-		if (resp_errs)
-			*resp_errs |= status;
-
-		/*
-		 * Timeout if the device never becomes ready for data and never
-		 * leaves the program state.
-		 */
-		if (done) {
-			dev_err(mmc_dev(card->host),
-				"Card stuck in wrong state! %s status: %#x\n",
-				 __func__, status);
-			return -ETIMEDOUT;
-		}
-
-		/*
-		 * Some cards mishandle the status bits,
-		 * so make sure to check both the busy
-		 * indication and the card state.
-		 */
-	} while (!mmc_blk_in_tran_state(status));
-
-	return err;
-}
-
 static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 			 int type)
 {
-- 
2.18.0

