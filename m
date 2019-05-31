Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFDBC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FE426ABA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfEaOdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:33:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52514 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfEaOdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:33:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B12E6341;
        Fri, 31 May 2019 07:33:48 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E467B3F5AF;
        Fri, 31 May 2019 07:33:46 -0700 (PDT)
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
Subject: [PATCH 6/6] mailbox: arm_mhu: add full support for the doorbells
Date:   Fri, 31 May 2019 15:33:20 +0100
Message-Id: <20190531143320.8895-7-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531143320.8895-1-sudeep.holla@arm.com>
References: <20190531143320.8895-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now have the basic infrastructure and binding to support doorbells
on ARM MHU controller.

This patch adds all the necessary mailbox operations to add support for
the doorbells. Maximum of 32 doorbells are supported on each physical
channel, however the total number of doorbells is restricted to 20
in order to save memory. It can increased if required in future.

Cc: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/arm_mhu.c | 129 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index c944ca121e9e..ba48d2281dca 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -94,6 +95,14 @@ mhu_mbox_to_channel(struct mbox_controller *mbox,
 	return NULL;
 }
 
+static void mhu_mbox_clear_irq(struct mbox_chan *chan)
+{
+	struct mhu_channel *chan_info = chan->con_priv;
+	void __iomem *base = chan_info->mhu->mlink[chan_info->pchan].rx_reg;
+
+	writel_relaxed(BIT(chan_info->doorbell), base + INTR_CLR_OFS);
+}
+
 static unsigned int mhu_mbox_irq_to_pchan_num(struct arm_mhu *mhu, int irq)
 {
 	unsigned int pchan;
@@ -105,6 +114,95 @@ static unsigned int mhu_mbox_irq_to_pchan_num(struct arm_mhu *mhu, int irq)
 	return pchan;
 }
 
+static struct mbox_chan *mhu_mbox_irq_to_channel(struct arm_mhu *mhu,
+						 unsigned int pchan)
+{
+	unsigned long bits;
+	unsigned int doorbell;
+	struct mbox_chan *chan = NULL;
+	struct mbox_controller *mbox = &mhu->mbox;
+	void __iomem *base = mhu->mlink[pchan].rx_reg;
+
+	bits = readl_relaxed(base + INTR_STAT_OFS);
+	if (!bits)
+		/* No IRQs fired in specified physical channel */
+		return NULL;
+
+	/* An IRQ has fired, find the associated channel */
+	for (doorbell = 0; bits; doorbell++) {
+		if (!test_and_clear_bit(doorbell, &bits))
+			continue;
+
+		chan = mhu_mbox_to_channel(mbox, pchan, doorbell);
+		if (chan)
+			break;
+	}
+
+	return chan;
+}
+
+static irqreturn_t mhu_mbox_thread_handler(int irq, void *data)
+{
+	struct mbox_chan *chan;
+	struct arm_mhu *mhu = data;
+	unsigned int pchan = mhu_mbox_irq_to_pchan_num(mhu, irq);
+
+	while (NULL != (chan = mhu_mbox_irq_to_channel(mhu, pchan))) {
+		mbox_chan_received_data(chan, NULL);
+		mhu_mbox_clear_irq(chan);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static bool mhu_doorbell_last_tx_done(struct mbox_chan *chan)
+{
+	struct mhu_channel *chan_info = chan->con_priv;
+	void __iomem *base = chan_info->mhu->mlink[chan_info->pchan].tx_reg;
+
+	if (readl_relaxed(base + INTR_STAT_OFS) & BIT(chan_info->doorbell))
+		return false;
+
+	return true;
+}
+
+static int mhu_doorbell_send_signal(struct mbox_chan *chan)
+{
+	struct mhu_channel *chan_info = chan->con_priv;
+	void __iomem *base = chan_info->mhu->mlink[chan_info->pchan].tx_reg;
+
+	/* Send event to co-processor */
+	writel_relaxed(BIT(chan_info->doorbell), base + INTR_SET_OFS);
+
+	return 0;
+}
+
+static int mhu_doorbell_startup(struct mbox_chan *chan)
+{
+	mhu_mbox_clear_irq(chan);
+	return 0;
+}
+
+static void mhu_doorbell_shutdown(struct mbox_chan *chan)
+{
+	struct mhu_channel *chan_info = chan->con_priv;
+	struct mbox_controller *mbox = &chan_info->mhu->mbox;
+	int i;
+
+	for (i = 0; i < mbox->num_chans; i++)
+		if (chan == &mbox->chans[i])
+			break;
+
+	if (mbox->num_chans == i) {
+		dev_warn(mbox->dev, "Request to free non-existent channel\n");
+		return;
+	}
+
+	/* Reset channel */
+	mhu_mbox_clear_irq(chan);
+	chan->con_priv = NULL;
+}
+
 static struct mbox_chan *mhu_mbox_xlate(struct mbox_controller *mbox,
 					const struct of_phandle_args *spec)
 {
@@ -222,16 +320,30 @@ static const struct mbox_chan_ops mhu_ops = {
 	.last_tx_done = mhu_last_tx_done,
 };
 
+static const struct mbox_chan_ops mhu_doorbell_ops = {
+	.send_signal = mhu_doorbell_send_signal,
+	.startup = mhu_doorbell_startup,
+	.shutdown = mhu_doorbell_shutdown,
+	.last_tx_done = mhu_doorbell_last_tx_done,
+};
+
 static const struct mhu_mbox_pdata arm_mhu_pdata = {
 	.num_pchans = 3,
 	.num_doorbells = 1,
 	.support_doorbells = false,
 };
 
+static const struct mhu_mbox_pdata arm_mhu_doorbell_pdata = {
+	.num_pchans = 2,	/* Secure can't be used */
+	.num_doorbells = 32,
+	.support_doorbells = true,
+};
+
 static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	u32 cell_count;
 	int i, err, max_chans;
+	irq_handler_t handler;
 	struct arm_mhu *mhu;
 	struct mbox_chan *chans;
 	struct mhu_mbox_pdata *pdata;
@@ -251,6 +363,9 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (cell_count == 1) {
 		max_chans = MHU_NUM_PCHANS;
 		pdata = (struct mhu_mbox_pdata *)&arm_mhu_pdata;
+	} else if (cell_count == 2) {
+		max_chans = MHU_CHAN_MAX;
+		pdata = (struct mhu_mbox_pdata *)&arm_mhu_doorbell_pdata;
 	} else {
 		dev_err(dev, "incorrect value of #mbox-cells in %s\n",
 			np->full_name);
@@ -283,7 +398,6 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 	mhu->mbox.dev = dev;
 	mhu->mbox.chans = chans;
 	mhu->mbox.num_chans = max_chans;
-	mhu->mbox.ops = &mhu_ops;
 	mhu->mbox.txdone_irq = false;
 	mhu->mbox.txdone_poll = true;
 	mhu->mbox.txpoll_period = 1;
@@ -291,6 +405,14 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 	mhu->mbox.of_xlate = mhu_mbox_xlate;
 	amba_set_drvdata(adev, mhu);
 
+	if (pdata->support_doorbells) {
+		mhu->mbox.ops = &mhu_doorbell_ops;
+		handler = mhu_mbox_thread_handler;
+	} else {
+		mhu->mbox.ops = &mhu_ops;
+		handler = mhu_rx_interrupt;
+	}
+
 	err = devm_mbox_controller_register(dev, &mhu->mbox);
 	if (err) {
 		dev_err(dev, "Failed to register mailboxes %d\n", err);
@@ -308,9 +430,8 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 		mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
 		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
 
-		err = devm_request_threaded_irq(dev, irq, NULL,
-						mhu_rx_interrupt, IRQF_ONESHOT,
-						"mhu_link", mhu);
+		err = devm_request_threaded_irq(dev, irq, NULL, handler,
+						IRQF_ONESHOT, "mhu_link", mhu);
 		if (err) {
 			dev_err(dev, "Can't claim IRQ %d\n", irq);
 			mbox_controller_unregister(&mhu->mbox);
-- 
2.17.1

