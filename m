Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4355EC28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E13E26AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEaOdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:33:46 -0400
Received: from foss.arm.com ([217.140.101.70]:52484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfEaOdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:33:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AE08341;
        Fri, 31 May 2019 07:33:44 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE21A3F5AF;
        Fri, 31 May 2019 07:33:42 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 4/6] mailbox: arm_mhu: migrate to threaded irq handler
Date:   Fri, 31 May 2019 15:33:18 +0100
Message-Id: <20190531143320.8895-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531143320.8895-1-sudeep.holla@arm.com>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to introduce support for doorbells which require the
interrupt handlers to be threaded, this patch moves the existing
interrupt handler to threaded handler.

Also it moves out the registering and freeing of the handlers from
the mailbox startup and shutdown methods. This also is required to
support doorbells.

Cc: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/arm_mhu.c | 46 +++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 747cab1090ff..98838d5ae108 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -84,33 +84,16 @@ static int mhu_startup(struct mbox_chan *chan)
 {
 	struct mhu_link *mlink = chan->con_priv;
 	u32 val;
-	int ret;
 
 	val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
 	writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
 
-	ret = request_irq(mlink->irq, mhu_rx_interrupt,
-			  IRQF_SHARED, "mhu_link", chan);
-	if (ret) {
-		dev_err(chan->mbox->dev,
-			"Unable to acquire IRQ %d\n", mlink->irq);
-		return ret;
-	}
-
 	return 0;
 }
 
-static void mhu_shutdown(struct mbox_chan *chan)
-{
-	struct mhu_link *mlink = chan->con_priv;
-
-	free_irq(mlink->irq, chan);
-}
-
 static const struct mbox_chan_ops mhu_ops = {
 	.send_data = mhu_send_data,
 	.startup = mhu_startup,
-	.shutdown = mhu_shutdown,
 	.last_tx_done = mhu_last_tx_done,
 };
 
@@ -132,13 +115,6 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(mhu->base);
 	}
 
-	for (i = 0; i < MHU_CHANS; i++) {
-		mhu->chan[i].con_priv = &mhu->mlink[i];
-		mhu->mlink[i].irq = adev->irq[i];
-		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
-		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
-	}
-
 	mhu->mbox.dev = dev;
 	mhu->mbox.chans = &mhu->chan[0];
 	mhu->mbox.num_chans = MHU_CHANS;
@@ -155,6 +131,28 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 		return err;
 	}
 
+	for (i = 0; i < MHU_CHANS; i++) {
+		int irq = mhu->mlink[i].irq = adev->irq[i];
+
+		if (irq <= 0) {
+			dev_dbg(dev, "No IRQ found for Channel %d\n", i);
+			continue;
+		}
+
+		mhu->chan[i].con_priv = &mhu->mlink[i];
+		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
+		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
+
+		err = devm_request_threaded_irq(dev, irq, NULL,
+						mhu_rx_interrupt, IRQF_ONESHOT,
+						"mhu_link", &mhu->chan[i]);
+		if (err) {
+			dev_err(dev, "Can't claim IRQ %d\n", irq);
+			mbox_controller_unregister(&mhu->mbox);
+			return err;
+		}
+	}
+
 	dev_info(dev, "ARM MHU Mailbox registered\n");
 	return 0;
 }
-- 
2.17.1

