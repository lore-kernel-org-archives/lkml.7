Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DD2C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E0A20693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391310AbfGHPsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:48:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388947AbfGHPrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:47:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EB79CFC;
        Mon,  8 Jul 2019 08:47:42 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BF583F59C;
        Mon,  8 Jul 2019 08:47:41 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 01/11] firmware: arm_scmi: Reorder some functions to avoid forward declarations
Date:   Mon,  8 Jul 2019 16:47:20 +0100
Message-Id: <20190708154730.16643-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708154730.16643-1-sudeep.holla@arm.com>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-shuffling few functions to keep definitions and their usages close.
This is also needed to avoid too many unnecessary forward declarations
while adding new features(delayed response and notifications).

Keeping this separate to avoid mixing up of these trivial change that
doesn't affect functionality into the ones that does.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 180 ++++++++++++++---------------
 1 file changed, 90 insertions(+), 90 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 765573756987..0bd2af0a008f 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -197,44 +197,6 @@ static void scmi_fetch_response(struct scmi_xfer *xfer,
 	memcpy_fromio(xfer->rx.buf, mem->msg_payload + 4, xfer->rx.len);
 }
 
-/**
- * scmi_rx_callback() - mailbox client callback for receive messages
- *
- * @cl: client pointer
- * @m: mailbox message
- *
- * Processes one received message to appropriate transfer information and
- * signals completion of the transfer.
- *
- * NOTE: This function will be invoked in IRQ context, hence should be
- * as optimal as possible.
- */
-static void scmi_rx_callback(struct mbox_client *cl, void *m)
-{
-	u16 xfer_id;
-	struct scmi_xfer *xfer;
-	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
-	struct device *dev = cinfo->dev;
-	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
-	struct scmi_xfers_info *minfo = &info->minfo;
-	struct scmi_shared_mem __iomem *mem = cinfo->payload;
-
-	xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
-
-	/* Are we even expecting this? */
-	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
-		dev_err(dev, "message for %d is not expected!\n", xfer_id);
-		return;
-	}
-
-	xfer = &minfo->xfer_block[xfer_id];
-
-	scmi_dump_header_dbg(dev, &xfer->hdr);
-
-	scmi_fetch_response(xfer, mem);
-	complete(&xfer->done);
-}
-
 /**
  * pack_scmi_header() - packs and returns 32-bit header
  *
@@ -349,6 +311,44 @@ void scmi_xfer_put(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
 }
 
+/**
+ * scmi_rx_callback() - mailbox client callback for receive messages
+ *
+ * @cl: client pointer
+ * @m: mailbox message
+ *
+ * Processes one received message to appropriate transfer information and
+ * signals completion of the transfer.
+ *
+ * NOTE: This function will be invoked in IRQ context, hence should be
+ * as optimal as possible.
+ */
+static void scmi_rx_callback(struct mbox_client *cl, void *m)
+{
+	u16 xfer_id;
+	struct scmi_xfer *xfer;
+	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
+	struct device *dev = cinfo->dev;
+	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
+	struct scmi_xfers_info *minfo = &info->minfo;
+	struct scmi_shared_mem __iomem *mem = cinfo->payload;
+
+	xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
+
+	/* Are we even expecting this? */
+	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
+		dev_err(dev, "message for %d is not expected!\n", xfer_id);
+		return;
+	}
+
+	xfer = &minfo->xfer_block[xfer_id];
+
+	scmi_dump_header_dbg(dev, &xfer->hdr);
+
+	scmi_fetch_response(xfer, mem);
+	complete(&xfer->done);
+}
+
 static bool
 scmi_xfer_poll_done(const struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
 {
@@ -599,20 +599,6 @@ int scmi_handle_put(const struct scmi_handle *handle)
 	return 0;
 }
 
-static const struct scmi_desc scmi_generic_desc = {
-	.max_rx_timeout_ms = 30,	/* We may increase this if required */
-	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
-	.max_msg_size = 128,
-};
-
-/* Each compatible listed below must have descriptor associated with it */
-static const struct of_device_id scmi_of_match[] = {
-	{ .compatible = "arm,scmi", .data = &scmi_generic_desc },
-	{ /* Sentinel */ },
-};
-
-MODULE_DEVICE_TABLE(of, scmi_of_match);
-
 static int scmi_xfer_info_init(struct scmi_info *sinfo)
 {
 	int i;
@@ -659,44 +645,6 @@ static int scmi_mailbox_check(struct device_node *np)
 	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, NULL);
 }
 
-static int scmi_mbox_free_channel(int id, void *p, void *data)
-{
-	struct scmi_chan_info *cinfo = p;
-	struct idr *idr = data;
-
-	if (!IS_ERR_OR_NULL(cinfo->chan)) {
-		mbox_free_channel(cinfo->chan);
-		cinfo->chan = NULL;
-	}
-
-	idr_remove(idr, id);
-
-	return 0;
-}
-
-static int scmi_remove(struct platform_device *pdev)
-{
-	int ret = 0;
-	struct scmi_info *info = platform_get_drvdata(pdev);
-	struct idr *idr = &info->tx_idr;
-
-	mutex_lock(&scmi_list_mutex);
-	if (info->users)
-		ret = -EBUSY;
-	else
-		list_del(&info->node);
-	mutex_unlock(&scmi_list_mutex);
-
-	if (ret)
-		return ret;
-
-	/* Safe to free channels since no more users */
-	ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
-	idr_destroy(&info->tx_idr);
-
-	return ret;
-}
-
 static inline int
 scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
 {
@@ -856,6 +804,58 @@ static int scmi_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int scmi_mbox_free_channel(int id, void *p, void *data)
+{
+	struct scmi_chan_info *cinfo = p;
+	struct idr *idr = data;
+
+	if (!IS_ERR_OR_NULL(cinfo->chan)) {
+		mbox_free_channel(cinfo->chan);
+		cinfo->chan = NULL;
+	}
+
+	idr_remove(idr, id);
+
+	return 0;
+}
+
+static int scmi_remove(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct scmi_info *info = platform_get_drvdata(pdev);
+	struct idr *idr = &info->tx_idr;
+
+	mutex_lock(&scmi_list_mutex);
+	if (info->users)
+		ret = -EBUSY;
+	else
+		list_del(&info->node);
+	mutex_unlock(&scmi_list_mutex);
+
+	if (ret)
+		return ret;
+
+	/* Safe to free channels since no more users */
+	ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
+	idr_destroy(&info->tx_idr);
+
+	return ret;
+}
+
+static const struct scmi_desc scmi_generic_desc = {
+	.max_rx_timeout_ms = 30,	/* We may increase this if required */
+	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
+	.max_msg_size = 128,
+};
+
+/* Each compatible listed below must have descriptor associated with it */
+static const struct of_device_id scmi_of_match[] = {
+	{ .compatible = "arm,scmi", .data = &scmi_generic_desc },
+	{ /* Sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, scmi_of_match);
+
 static struct platform_driver scmi_driver = {
 	.driver = {
 		   .name = "arm-scmi",
-- 
2.17.1

