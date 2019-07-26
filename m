Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7FFC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E3B22CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfGZNv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:51:58 -0400
Received: from foss.arm.com ([217.140.110.172]:44460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbfGZNvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:51:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53AB1337;
        Fri, 26 Jul 2019 06:51:51 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19ABE3F694;
        Fri, 26 Jul 2019 06:51:49 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 03/10] firmware: arm_scmi: Add receive channel support for notifications
Date:   Fri, 26 Jul 2019 14:51:31 +0100
Message-Id: <20190726135138.9858-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726135138.9858-1-sudeep.holla@arm.com>
References: <20190726135138.9858-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With scmi_mbox_chan_setup enabled to identify and setup both Tx and Rx,
let's consolidate setting up of both the channels under the function
scmi_mbox_txrx_setup.

Since some platforms may opt not to support notifications or delayed
response, they may not need support for Rx. Hence Rx is optional and
failure of setting one up is not considered fatal.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 336673afd6ef..5a8c015bf233 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -113,6 +113,7 @@ struct scmi_chan_info {
  *	implementation version and (sub-)vendor identification.
  * @minfo: Message info
  * @tx_idr: IDR object to map protocol id to Tx channel info pointer
+ * @rx_idr: IDR object to map protocol id to Rx channel info pointer
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: List head
@@ -125,6 +126,7 @@ struct scmi_info {
 	struct scmi_handle handle;
 	struct scmi_xfers_info minfo;
 	struct idr tx_idr;
+	struct idr rx_idr;
 	u8 *protocols_imp;
 	struct list_head node;
 	int users;
@@ -655,13 +657,17 @@ static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev,
 	struct device_node *shmem, *np = dev->of_node;
 	struct scmi_chan_info *cinfo;
 	struct mbox_client *cl;
+	struct idr *idr;
 	const char *desc = tx ? "Tx" : "Rx";
 
 	/* Transmit channel is first entry i.e. index 0 */
 	idx = tx ? 0 : 1;
+	idr = tx ? &info->tx_idr : &info->rx_idr;
 
 	if (scmi_mailbox_check(np, idx)) {
-		cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
+		cinfo = idr_find(idr, SCMI_PROTOCOL_BASE);
+		if (unlikely(!cinfo)) /* Possible only if platform has no Rx */
+			return -EINVAL;
 		goto idr_alloc;
 	}
 
@@ -703,7 +709,7 @@ static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev,
 	}
 
 idr_alloc:
-	ret = idr_alloc(&info->tx_idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
+	ret = idr_alloc(idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL);
 	if (ret != prot_id) {
 		dev_err(dev, "unable to allocate SCMI idr slot err %d\n", ret);
 		return ret;
@@ -713,6 +719,17 @@ static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev,
 	return 0;
 }
 
+static inline int
+scmi_mbox_txrx_setup(struct scmi_info *info, struct device *dev, int prot_id)
+{
+	int ret = scmi_mbox_chan_setup(info, dev, prot_id, true);
+
+	if (!ret) /* Rx is optional, hence no error check */
+		scmi_mbox_chan_setup(info, dev, prot_id, false);
+
+	return ret;
+}
+
 static inline void
 scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
 			    int prot_id)
@@ -726,7 +743,7 @@ scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
 		return;
 	}
 
-	if (scmi_mbox_chan_setup(info, &sdev->dev, prot_id, true)) {
+	if (scmi_mbox_txrx_setup(info, &sdev->dev, prot_id)) {
 		dev_err(&sdev->dev, "failed to setup transport\n");
 		scmi_device_destroy(sdev);
 		return;
@@ -769,12 +786,13 @@ static int scmi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 	idr_init(&info->tx_idr);
+	idr_init(&info->rx_idr);
 
 	handle = &info->handle;
 	handle->dev = info->dev;
 	handle->version = &info->version;
 
-	ret = scmi_mbox_chan_setup(info, dev, SCMI_PROTOCOL_BASE, true);
+	ret = scmi_mbox_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
 	if (ret)
 		return ret;
 
@@ -844,6 +862,10 @@ static int scmi_remove(struct platform_device *pdev)
 	ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
 	idr_destroy(&info->tx_idr);
 
+	idr = &info->rx_idr;
+	ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
+	idr_destroy(&info->rx_idr);
+
 	return ret;
 }
 
-- 
2.17.1

