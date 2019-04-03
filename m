Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462FCC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECED02084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="CaOlw1U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDCMgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:36:01 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:45580 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfDCMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1554294958; x=1585830958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wWexbtwssZ6TPHhznN/dWn01xe9EGWt0kxwFH6VzumA=;
  b=CaOlw1U1e06Bgn4CVAh7IJBgqNQNMhb4DWvDQ5W87b9/kmQ8aAq3ac1p
   YEK4+fjrEplIGyMSFL0IJHbPtKkvjKGPZUlEuVS3MYwzAzElpd7/psBW8
   QNfa25o4bzvrrLGFmbPLTavPlDv46tQ7xIB2f2GUeCDCriCPcTpoNSVeN
   c=;
X-IronPort-AV: E=Sophos;i="5.60,304,1549929600"; 
   d="scan'208";a="394516401"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Apr 2019 12:35:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x33CZqmY130012
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 3 Apr 2019 12:35:55 GMT
Received: from EX13D08EUB002.ant.amazon.com (10.43.166.232) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Apr 2019 12:35:45 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D08EUB002.ant.amazon.com (10.43.166.232) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Apr 2019 12:35:43 +0000
Received: from dev-dsk-mheyne-60001.pdx1.corp.amazon.com (10.184.85.242) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 3 Apr 2019 12:35:42 +0000
Received: by dev-dsk-mheyne-60001.pdx1.corp.amazon.com (Postfix, from userid 5466572)
        id 4B5BC29783; Wed,  3 Apr 2019 12:35:42 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     David Woodhouse <dwmw2@infradead.org>, Amit Shah <aams@amazon.de>,
        Maximilian Heyne <mheyne@amazon.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] nvme: add per-controller io and admin timeouts
Date:   Wed, 3 Apr 2019 12:35:05 +0000
Message-ID: <20190403123506.122904-2-mheyne@amazon.de>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20190403123506.122904-1-mheyne@amazon.de>
References: <20190403123506.122904-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NVMe controller require specific io and admin timeouts that are
different from the default, for instance local vs. remote storage.

This patch adds per-controller admin and io timeouts to the nvme_ctrl
structure and replaces all usages of the module parameters in the NVMe
drivers with the per-device timeouts.

Original-patch-by: Milan Pandurov <milanpa@amazon.com>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
v2: use per-controller timeout in other nvme drivers too

 drivers/nvme/host/core.c     | 11 +++++++----
 drivers/nvme/host/fc.c       |  2 +-
 drivers/nvme/host/lightnvm.c |  2 +-
 drivers/nvme/host/nvme.h     |  2 ++
 drivers/nvme/host/pci.c      | 13 +++++++------
 drivers/nvme/host/rdma.c     |  4 ++--
 drivers/nvme/host/tcp.c      |  4 ++--
 drivers/nvme/target/loop.c   |  4 ++--
 8 files changed, 24 insertions(+), 18 deletions(-)

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
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f3b9d91ba0df..09614a214bed 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2431,7 +2431,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 			    ctrl->lport->ops->fcprqst_priv_sz);
 	ctrl->tag_set.driver_data = ctrl;
 	ctrl->tag_set.nr_hw_queues = ctrl->ctrl.queue_count - 1;
-	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
+	ctrl->tag_set.timeout = ctrl->ctrl.io_timeout;
 
 	ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
 	if (ret)
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 949e29e1d782..b9160123b53c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -789,7 +789,7 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		goto err_cmd;
 	}
 
-	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	rq->timeout = timeout ? timeout : ns->ctrl->admin_timeout;
 
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
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
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 11a5ecae78c8..a81049fd3896 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -724,7 +724,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 			SG_CHUNK_SIZE * sizeof(struct scatterlist);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
-		set->timeout = ADMIN_TIMEOUT;
+		set->timeout = nctrl->admin_timeout;
 		set->flags = BLK_MQ_F_NO_SCHED;
 	} else {
 		set = &ctrl->tag_set;
@@ -738,7 +738,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 			SG_CHUNK_SIZE * sizeof(struct scatterlist);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
-		set->timeout = NVME_IO_TIMEOUT;
+		set->timeout = nctrl->io_timeout;
 		set->nr_maps = nctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
 	}
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 68c49dd67210..dede067e339b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1449,7 +1449,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->cmd_size = sizeof(struct nvme_tcp_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = 1;
-		set->timeout = ADMIN_TIMEOUT;
+		set->timeout = nctrl->admin_timeout;
 	} else {
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
@@ -1461,7 +1461,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->cmd_size = sizeof(struct nvme_tcp_request);
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
-		set->timeout = NVME_IO_TIMEOUT;
+		set->timeout = nctrl->io_timeout;
 		set->nr_maps = 2 /* default + read */;
 	}
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index b9f623ab01f3..7fbefca5c6cb 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -359,7 +359,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 		SG_CHUNK_SIZE * sizeof(struct scatterlist);
 	ctrl->admin_tag_set.driver_data = ctrl;
 	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
+	ctrl->admin_tag_set.timeout = ctrl->ctrl.admin_timeout;
 	ctrl->admin_tag_set.flags = BLK_MQ_F_NO_SCHED;
 
 	ctrl->queues[0].ctrl = ctrl;
@@ -532,7 +532,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 		SG_CHUNK_SIZE * sizeof(struct scatterlist);
 	ctrl->tag_set.driver_data = ctrl;
 	ctrl->tag_set.nr_hw_queues = ctrl->ctrl.queue_count - 1;
-	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
+	ctrl->tag_set.timeout = ctrl->ctrl.io_timeout;
 	ctrl->ctrl.tagset = &ctrl->tag_set;
 
 	ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
-- 
2.16.5




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B


