Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE19CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD7F21738
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715277;
	bh=EqAt9wqbcqinpkaJowxvbHufQC33dS0DuB+CTucMt1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O0WgFII8zCwKkQ1kqsyAcyFrIQgjV8C+SDWW87vGeMenTzZkaG0HipQ7oHX76kJNM
	 +h4mSx4X3TTU1W6SGZuoDJh1Xq4MsVrITTiyUKpzNudPUGeyXZRyfNikhJYsM/2p79
	 gcfVi0ZpRpIDBLxZ6B44Wsvylx5qumngktWt+FMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfC0Tef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfC0SCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57102146F;
        Wed, 27 Mar 2019 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709722;
        bh=EqAt9wqbcqinpkaJowxvbHufQC33dS0DuB+CTucMt1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBCRQzYey6dB849Ar/4N53lNHFhe2lVJ1COoQoFUSU+0GQ615vEBvpIV06Kz8Q62R
         N321xQ9RElemBlDLkZTyXh+eYQhPnbsQrWAN1fVdJV4UTgb60WBXFflSfKkn6WHniE
         uiI9R9vM0vZ+tT/aeHinqnqw9I8yMv1PnzOPinM4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yufen Yu <yuyufen@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 003/262] nvme-loop: init nvmet_ctrl fatal_err_work when allocate
Date:   Wed, 27 Mar 2019 13:57:38 -0400
Message-Id: <20190327180158.10245-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yufen Yu <yuyufen@huawei.com>

[ Upstream commit d11de63f2b519f0a162b834013b6d3a46dbf3886 ]

After commit 4d43d395fe (workqueue: Try to catch flush_work() without
INIT_WORK()), it can cause warning when delete nvme-loop device, trace
like:

[   76.601272] Call Trace:
[   76.601646]  ? del_timer+0x72/0xa0
[   76.602156]  __cancel_work_timer+0x1ae/0x270
[   76.602791]  cancel_work_sync+0x14/0x20
[   76.603407]  nvmet_ctrl_free+0x1b7/0x2f0 [nvmet]
[   76.604091]  ? free_percpu+0x168/0x300
[   76.604652]  nvmet_sq_destroy+0x106/0x240 [nvmet]
[   76.605346]  nvme_loop_destroy_admin_queue+0x30/0x60 [nvme_loop]
[   76.606220]  nvme_loop_shutdown_ctrl+0xc3/0xf0 [nvme_loop]
[   76.607026]  nvme_loop_delete_ctrl_host+0x19/0x30 [nvme_loop]
[   76.607871]  nvme_do_delete_ctrl+0x75/0xb0
[   76.608477]  nvme_sysfs_delete+0x7d/0xc0
[   76.609057]  dev_attr_store+0x24/0x40
[   76.609603]  sysfs_kf_write+0x4c/0x60
[   76.610144]  kernfs_fop_write+0x19a/0x260
[   76.610742]  __vfs_write+0x1c/0x60
[   76.611246]  vfs_write+0xfa/0x280
[   76.611739]  ksys_write+0x6e/0x120
[   76.612238]  __x64_sys_write+0x1e/0x30
[   76.612787]  do_syscall_64+0xbf/0x3a0
[   76.613329]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

We fix it by moving fatal_err_work init to nvmet_alloc_ctrl(), which may
more reasonable.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 88d260f31835..02c63c463222 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1171,6 +1171,15 @@ static void nvmet_release_p2p_ns_map(struct nvmet_ctrl *ctrl)
 	put_device(ctrl->p2p_client);
 }
 
+static void nvmet_fatal_error_handler(struct work_struct *work)
+{
+	struct nvmet_ctrl *ctrl =
+			container_of(work, struct nvmet_ctrl, fatal_err_work);
+
+	pr_err("ctrl %d fatal error occurred!\n", ctrl->cntlid);
+	ctrl->ops->delete_ctrl(ctrl);
+}
+
 u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
 {
@@ -1213,6 +1222,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
+	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 
 	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
@@ -1316,21 +1326,11 @@ void nvmet_ctrl_put(struct nvmet_ctrl *ctrl)
 	kref_put(&ctrl->ref, nvmet_ctrl_free);
 }
 
-static void nvmet_fatal_error_handler(struct work_struct *work)
-{
-	struct nvmet_ctrl *ctrl =
-			container_of(work, struct nvmet_ctrl, fatal_err_work);
-
-	pr_err("ctrl %d fatal error occurred!\n", ctrl->cntlid);
-	ctrl->ops->delete_ctrl(ctrl);
-}
-
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 {
 	mutex_lock(&ctrl->lock);
 	if (!(ctrl->csts & NVME_CSTS_CFS)) {
 		ctrl->csts |= NVME_CSTS_CFS;
-		INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 		schedule_work(&ctrl->fatal_err_work);
 	}
 	mutex_unlock(&ctrl->lock);
-- 
2.19.1

