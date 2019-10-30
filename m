Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCE9CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEE520679
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfJ3PYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:24:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:56766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726246AbfJ3PYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:24:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B3A57AE87;
        Wed, 30 Oct 2019 15:24:20 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC] nvmet: Always remove processed AER elements from list
Date:   Wed, 30 Oct 2019 16:24:18 +0100
Message-Id: <20191030152418.23753-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All async events are enqueued via nvmet_add_async_event() which
updates the ctrl->async_event_cmds[] array and additionally an struct
nvmet_async_event is added to the ctrl->async_events list.

Under normal operations the nvmet_async_event_work() updates again the
ctrl->async_event_cmds and removes the corresponding struct
nvmet_async_event from the list again. Though nvmet_sq_destroy() could
be called which calles nvmet_async_events_free() which only updates
the ctrl->async_event_cmds[] array.

Add a new function nvmet_async_events_process() which processes the
async events and updates both array and the list. With this we avoid
having two places where the array and list are modified.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

I've got following oops:

PID: 79413  TASK: ffff92f03a814ec0  CPU: 19  COMMAND: "kworker/19:2"
#0 [ffffa5308b8c3c58] machine_kexec at ffffffff8e05dd02
#1 [ffffa5308b8c3ca8] __crash_kexec at ffffffff8e12102a
#2 [ffffa5308b8c3d68] crash_kexec at ffffffff8e122019
#3 [ffffa5308b8c3d80] oops_end at ffffffff8e02e091
#4 [ffffa5308b8c3da0] general_protection at ffffffff8e8015c5
    [exception RIP: nvmet_async_event_work+94]
    RIP: ffffffffc0d9a80e  RSP: ffffa5308b8c3e58  RFLAGS: 00010202
    RAX: dead000000000100  RBX: ffff92dcbc7464b0  RCX: 0000000000000002
    RDX: 0000000000040002  RSI: 38ffff92dc9814cf  RDI: ffff92f217722f20
    RBP: ffff92dcbc746418   R8: 0000000000000000   R9: 0000000000000000
    R10: 000000000000035b  R11: ffff92efb8dd2091  R12: ffff92dcbc7464a0
    R13: ffff92dbe03a5f29  R14: 0000000000000000  R15: 0ffff92f92f26864
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#5 [ffffa5308b8c3e78] process_one_work at ffffffff8e0a3b0c
#6 [ffffa5308b8c3eb8] worker_thread at ffffffff8e0a41e7
#7 [ffffa5308b8c3f10] kthread at ffffffff8e0a93af
#8 [ffffa5308b8c3f50] ret_from_fork at ffffffff8e800235

this maps to nvmet_async_event_results. So it looks like this function
access a stale aen pointer:

static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
{
        return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
}

The test which is executed removes during operation one of the nodes.

The only odd thing I could figure out so far is that the list is not
updated in sync with the array in all cases. I suppose this could be
the source of the crash. Not verified yet.

Johannes though it makes sense to post this as question.

Thanks,
Daniel

 drivers/nvme/target/core.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3a67e244e568..9d9efd585847 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -129,27 +129,8 @@ static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
 	return aen->event_type | (aen->event_info << 8) | (aen->log_page << 16);
 }
 
-static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
+static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 {
-	struct nvmet_req *req;
-
-	while (1) {
-		mutex_lock(&ctrl->lock);
-		if (!ctrl->nr_async_event_cmds) {
-			mutex_unlock(&ctrl->lock);
-			return;
-		}
-
-		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
-		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
-	}
-}
-
-static void nvmet_async_event_work(struct work_struct *work)
-{
-	struct nvmet_ctrl *ctrl =
-		container_of(work, struct nvmet_ctrl, async_event_work);
 	struct nvmet_async_event *aen;
 	struct nvmet_req *req;
 
@@ -163,16 +144,30 @@ static void nvmet_async_event_work(struct work_struct *work)
 		}
 
 		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
-		nvmet_set_result(req, nvmet_async_event_result(aen));
+		if (status == 0)
+			nvmet_set_result(req, nvmet_async_event_result(aen));
 
 		list_del(&aen->entry);
 		kfree(aen);
 
 		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, 0);
+		nvmet_req_complete(req, status);
 	}
 }
 
+static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
+{
+	nvmet_async_events_process(ctrl, NVME_SC_INTERNAL | NVME_SC_DNR);
+}
+
+static void nvmet_async_event_work(struct work_struct *work)
+{
+	struct nvmet_ctrl *ctrl =
+		container_of(work, struct nvmet_ctrl, async_event_work);
+
+	nvmet_async_events_process(ctrl, 0);
+}
+
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
-- 
2.16.4

