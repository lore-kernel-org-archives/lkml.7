Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E66C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275A820693
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="bIxOqVgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfC2Jjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:39:45 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:28100 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfC2Jjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1553852383; x=1585388383;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=yAs+tXB5i6T1zACWoXeoXpvBwJnGdYOQH/rLXT+z40s=;
  b=bIxOqVgKplOyHfx0MbjIgoPLWLP48B0mdSpWYG7lsiu8DxgSjMGLF/2U
   ze10C/wzKX/gfRhC9SD49LmYsbHIt4kyh88cBvYZgCxqkteyjSo2XaF6Q
   YJZNtIF5CRjBng3swoO4xdj2Os6B3J0Z/UiymhSLxA5U2k1GWYXhzzmQK
   o=;
X-IronPort-AV: E=Sophos;i="5.60,284,1549929600"; 
   d="scan'208";a="796424881"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Mar 2019 09:39:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2T9dbVX058150
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 29 Mar 2019 09:39:39 GMT
Received: from EX13D18EUA001.ant.amazon.com (10.43.165.58) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Mar 2019 09:39:39 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D18EUA001.ant.amazon.com (10.43.165.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 29 Mar 2019 09:39:37 +0000
Received: from dev-dsk-mheyne-60001.pdx1.corp.amazon.com (10.184.85.242) by
 mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 29 Mar 2019 09:39:37 +0000
Received: by dev-dsk-mheyne-60001.pdx1.corp.amazon.com (Postfix, from userid 5466572)
        id 5EBCF247D4; Fri, 29 Mar 2019 09:39:36 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     David Woodhouse <dwmw2@infradead.org>, Amit Shah <aams@amazon.de>,
        Maximilian Heyne <mheyne@amazon.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] nvme: add per-device io and admin timeouts
Date:   Fri, 29 Mar 2019 09:39:20 +0000
Message-ID: <20190329093921.95710-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NVMe devices require specific io and admin timeouts that are
different from the default, for instance local vs. remote storage.

This patch adds per-device admin and io timeouts to the nvme_ctrl
structure and replaces all usages of the module parameters in the PCI
NVMe driver with the per-device timeouts.

Original-patch-by: Milan Pandurov <milanpa@amazon.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/core.c | 11 +++++++----
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  | 13 +++++++------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 470601980794..d0530bf7a677 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -779,7 +779,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->timeout = timeout ? timeout : q->rq_timeout;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -862,7 +862,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->timeout = timeout ? timeout : q->rq_timeout;
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
@@ -1800,7 +1800,8 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
+				      ctrl->admin_timeout, NVME_QID_ANY, 1, 0,
+				      false);
 }
 EXPORT_SYMBOL_GPL(nvme_sec_submit);
 #endif /* CONFIG_BLK_SED_OPAL */
@@ -3575,7 +3576,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 				msecs_to_jiffies(ctrl->mtfa * 100);
 	else
 		fw_act_timeout = jiffies +
-				msecs_to_jiffies(admin_timeout * 1000);
+		    msecs_to_jiffies((ctrl->admin_timeout / HZ) * 1000);
 
 	nvme_stop_queues(ctrl);
 	while (nvme_ctrl_pp_status(ctrl)) {
@@ -3721,6 +3722,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
+	ctrl->io_timeout = NVME_IO_TIMEOUT;
+	ctrl->admin_timeout = ADMIN_TIMEOUT;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 527d64545023..1397650edfda 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -201,6 +201,8 @@ struct nvme_ctrl {
 	u32 aen_result;
 	u32 ctratt;
 	unsigned int shutdown_timeout;
+	unsigned int io_timeout;
+	unsigned int admin_timeout;
 	unsigned int kato;
 	bool subsystem;
 	unsigned long quirks;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a90cf5d63aac..16d7a00fecf0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1357,7 +1357,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		return BLK_EH_RESET_TIMER;
 	}
 
-	abort_req->timeout = ADMIN_TIMEOUT;
+	abort_req->timeout = dev->ctrl.admin_timeout;
 	abort_req->end_io_data = NULL;
 	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
 
@@ -1637,7 +1637,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.nr_hw_queues = 1;
 
 		dev->admin_tagset.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
-		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
+		dev->admin_tagset.timeout = dev->ctrl.admin_timeout;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = nvme_pci_cmd_size(dev, false);
 		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
@@ -2226,7 +2226,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	req->timeout = ADMIN_TIMEOUT;
+	req->timeout = nvmeq->dev->ctrl.admin_timeout;
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
@@ -2242,7 +2242,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 	unsigned long timeout;
 
  retry:
-	timeout = ADMIN_TIMEOUT;
+	timeout = dev->ctrl.admin_timeout;
 	while (nr_queues > 0) {
 		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
 			break;
@@ -2282,7 +2282,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.nr_maps = 2; /* default + read */
 		if (dev->io_queues[HCTX_TYPE_POLL])
 			dev->tagset.nr_maps++;
-		dev->tagset.timeout = NVME_IO_TIMEOUT;
+		dev->tagset.timeout = dev->ctrl.io_timeout;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
@@ -2417,7 +2417,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 */
 	if (!dead) {
 		if (shutdown)
-			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+			nvme_wait_freeze_timeout(&dev->ctrl,
+						 dev->ctrl.io_timeout);
 	}
 
 	nvme_stop_queues(&dev->ctrl);
-- 
2.16.5




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B


