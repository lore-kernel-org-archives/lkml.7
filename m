Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE7CC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A992173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391598AbfGRWvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 18:51:54 -0400
Received: from ale.deltatee.com ([207.54.116.67]:47542 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbfGRWvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 18:51:53 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hoFFf-0001tp-Bh; Thu, 18 Jul 2019 16:51:52 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hoFFc-0001XM-FE; Thu, 18 Jul 2019 16:51:48 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 18 Jul 2019 16:51:32 -0600
Message-Id: <20190718225132.5865-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190718225132.5865-1-logang@deltatee.com>
References: <20190718225132.5865-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while scanning
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With multipath enabled, nvme_scan_work() can read from the
device (through nvme_mpath_add_disk()). However, with fabrics,
once ctrl->state is set to NVME_CTRL_DELETING, the reads will hang
(see nvmf_check_ready()).

After setting the state to deleting, nvme_remove_namespaces() will
hang waiting for scan_work to flush and these tasks will hang.

To fix this, ensure we take scan_lock before changing the ctrl-state.
Also, ensure the state is checked while the lock is held
in nvme_scan_lock_work().

  INFO: task kworker/u4:3:166 blocked for more than 120 seconds.
        Not tainted 5.2.0-rc6-vmlocalyes-00005-g808c8c2dc0cf #316
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  kworker/u4:3    D    0   166      2 0x80004000
  Workqueue: nvme-wq nvme_scan_work
  Call Trace:
   __schedule+0x851/0x1400
   schedule+0x99/0x210
   io_schedule+0x21/0x70
   do_read_cache_page+0xa57/0x1330
   read_cache_page+0x4a/0x70
   read_dev_sector+0xbf/0x380
   amiga_partition+0xc4/0x1230
   check_partition+0x30f/0x630
   rescan_partitions+0x19a/0x980
   __blkdev_get+0x85a/0x12f0
   blkdev_get+0x2a5/0x790
   __device_add_disk+0xe25/0x1250
   device_add_disk+0x13/0x20
   nvme_mpath_set_live+0x172/0x2b0
   nvme_update_ns_ana_state+0x130/0x180
   nvme_set_ns_ana_state+0x9a/0xb0
   nvme_parse_ana_log+0x1c3/0x4a0
   nvme_mpath_add_disk+0x157/0x290
   nvme_validate_ns+0x1017/0x1bd0
   nvme_scan_work+0x44d/0x6a0
   process_one_work+0x7d7/0x1240
   worker_thread+0x8e/0xff0
   kthread+0x2c3/0x3b0
   ret_from_fork+0x35/0x40

   INFO: task kworker/u4:1:1034 blocked for more than 120 seconds.
        Not tainted 5.2.0-rc6-vmlocalyes-00005-g808c8c2dc0cf #316
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  kworker/u4:1    D    0  1034      2 0x80004000
  Workqueue: nvme-delete-wq nvme_delete_ctrl_work
  Call Trace:
   __schedule+0x851/0x1400
   schedule+0x99/0x210
   schedule_timeout+0x390/0x830
   wait_for_completion+0x1a7/0x310
   __flush_work+0x241/0x5d0
   flush_work+0x10/0x20
   nvme_remove_namespaces+0x85/0x3d0
   nvme_do_delete_ctrl+0xb4/0x1e0
   nvme_delete_ctrl_work+0x15/0x20
   process_one_work+0x7d7/0x1240
   worker_thread+0x8e/0xff0
   kthread+0x2c3/0x3b0
   ret_from_fork+0x35/0x40

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ca33a2714e5..0a7b46066fe3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -301,6 +301,9 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	unsigned long flags;
 	bool changed = false;
 
+	/* Ensure a scan isn't in progress when we change the state */
+	mutex_lock(&ctrl->scan_lock);
+
 	spin_lock_irqsave(&ctrl->lock, flags);
 
 	old_state = ctrl->state;
@@ -375,6 +378,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		ctrl->state = new_state;
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
+	mutex_unlock(&ctrl->scan_lock);
+
 	if (changed && ctrl->state == NVME_CTRL_LIVE)
 		nvme_kick_requeue_lists(ctrl);
 	return changed;
@@ -3534,6 +3539,8 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
+	mutex_lock(&ctrl->scan_lock);
+
 	if (ctrl->state != NVME_CTRL_LIVE)
 		return;
 
@@ -3547,7 +3554,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
-	mutex_lock(&ctrl->scan_lock);
 	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
-- 
2.20.1

