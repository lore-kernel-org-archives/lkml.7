Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B64BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF9A22CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfGZNv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:51:57 -0400
Received: from foss.arm.com ([217.140.110.172]:44444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfGZNvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:51:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8C5515A2;
        Fri, 26 Jul 2019 06:51:49 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A0AC43F694;
        Fri, 26 Jul 2019 06:51:48 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 02/10] firmware: arm_scmi: Segregate tx channel handling and prepare to add rx
Date:   Fri, 26 Jul 2019 14:51:30 +0100
Message-Id: <20190726135138.9858-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726135138.9858-1-sudeep.holla@arm.com>
References: <20190726135138.9858-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The transmit(Tx) channels are specified as the first entry and the
receive(Rx) channels are the second entry as per the device tree
bindings. Since we currently just support Tx, index 0 is hardcoded at
all required callsites.

In order to prepare for adding Rx support, let's remove those hardcoded
index and add boolean parameter to identify Tx/Rx channels when setting
them up.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 41 +++++++++++++++++-------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 0bd2af0a008f..336673afd6ef 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -112,7 +112,7 @@ struct scmi_chan_info {
  * @version: SCMI revision information containing protocol version,
  *	implementation version and (sub-)vendor identification.
  * @minfo: Message info
- * @tx_idr: IDR object to map protocol id to channel info pointer
+ * @tx_idr: IDR object to map protocol id to Tx channel info pointer
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: List head
@@ -640,22 +640,27 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
 	return 0;
 }
 
-static int scmi_mailbox_check(struct device_node *np)
+static int scmi_mailbox_check(struct device_node *np, int idx)
 {
-	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells", 0, NULL);
+	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells",
+					  idx, NULL);
 }
 
-static inline int
-scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
+static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev,
+				int prot_id, bool tx)
 {
-	int ret;
+	int ret, idx;
 	struct resource res;
 	resource_size_t size;
 	struct device_node *shmem, *np = dev->of_node;
 	struct scmi_chan_info *cinfo;
 	struct mbox_client *cl;
+	const char *desc = tx ? "Tx" : "Rx";
+
+	/* Transmit channel is first entry i.e. index 0 */
+	idx = tx ? 0 : 1;
 
-	if (scmi_mailbox_check(np)) {
+	if (scmi_mailbox_check(np, idx)) {
 		cinfo = idr_find(&info->tx_idr, SCMI_PROTOCOL_BASE);
 		goto idr_alloc;
 	}
@@ -669,31 +674,31 @@ scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev, int prot_id)
 	cl = &cinfo->cl;
 	cl->dev = dev;
 	cl->rx_callback = scmi_rx_callback;
-	cl->tx_prepare = scmi_tx_prepare;
+	cl->tx_prepare = tx ? scmi_tx_prepare : NULL;
 	cl->tx_block = false;
-	cl->knows_txdone = true;
+	cl->knows_txdone = tx;
 
-	shmem = of_parse_phandle(np, "shmem", 0);
+	shmem = of_parse_phandle(np, "shmem", idx);
 	ret = of_address_to_resource(shmem, 0, &res);
 	of_node_put(shmem);
 	if (ret) {
-		dev_err(dev, "failed to get SCMI Tx payload mem resource\n");
+		dev_err(dev, "failed to get SCMI %s payload memory\n", desc);
 		return ret;
 	}
 
 	size = resource_size(&res);
 	cinfo->payload = devm_ioremap(info->dev, res.start, size);
 	if (!cinfo->payload) {
-		dev_err(dev, "failed to ioremap SCMI Tx payload\n");
+		dev_err(dev, "failed to ioremap SCMI %s payload\n", desc);
 		return -EADDRNOTAVAIL;
 	}
 
-	/* Transmit channel is first entry i.e. index 0 */
-	cinfo->chan = mbox_request_channel(cl, 0);
+	cinfo->chan = mbox_request_channel(cl, idx);
 	if (IS_ERR(cinfo->chan)) {
 		ret = PTR_ERR(cinfo->chan);
 		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to request SCMI Tx mailbox\n");
+			dev_err(dev, "failed to request SCMI %s mailbox\n",
+				desc);
 		return ret;
 	}
 
@@ -721,7 +726,7 @@ scmi_create_protocol_device(struct device_node *np, struct scmi_info *info,
 		return;
 	}
 
-	if (scmi_mbox_chan_setup(info, &sdev->dev, prot_id)) {
+	if (scmi_mbox_chan_setup(info, &sdev->dev, prot_id, true)) {
 		dev_err(&sdev->dev, "failed to setup transport\n");
 		scmi_device_destroy(sdev);
 		return;
@@ -741,7 +746,7 @@ static int scmi_probe(struct platform_device *pdev)
 	struct device_node *child, *np = dev->of_node;
 
 	/* Only mailbox method supported, check for the presence of one */
-	if (scmi_mailbox_check(np)) {
+	if (scmi_mailbox_check(np, 0)) {
 		dev_err(dev, "no mailbox found in %pOF\n", np);
 		return -EINVAL;
 	}
@@ -769,7 +774,7 @@ static int scmi_probe(struct platform_device *pdev)
 	handle->dev = info->dev;
 	handle->version = &info->version;
 
-	ret = scmi_mbox_chan_setup(info, dev, SCMI_PROTOCOL_BASE);
+	ret = scmi_mbox_chan_setup(info, dev, SCMI_PROTOCOL_BASE, true);
 	if (ret)
 		return ret;
 
-- 
2.17.1

