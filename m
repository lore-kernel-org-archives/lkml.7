Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5393C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54A62075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255295;
	bh=dfGsP1vD+3UJkHJ5TNLlkbLeEKUphVben6NydD50yeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fzs6zghrsJw6omXQ41n/+9qjwVnZcp9YAopo4/gjsx/QMmjZx4ZDlil0W32SAzgZz
	 vAVDRN+ulLshKT1vCTaPu+36ZxpLpUc2K3KLEqOMWjfj9sQFCeIqH34iwqHPQvJkG8
	 E53IpSoW8whT04yMDx6Tewywe5xtvuDYuFat7/0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbfCVLsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732271AbfCVLsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:48:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BECF2075E;
        Fri, 22 Mar 2019 11:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255289;
        bh=dfGsP1vD+3UJkHJ5TNLlkbLeEKUphVben6NydD50yeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=me90DT86T0QFfsBwosvEnlsi1Pi8Uivg6jju86kH1WQ8195QHkxo86GyRRhPUHs7b
         Pg1i0OcVir50KTh6DoIuRK96IbXqVBlDgBILPJjePdxz7av57OeI0NNQNZFDTf/nDa
         uSFwE0m7wHcyw6fS05sM16p6eROs+GHueZsLJU0c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anoob Soman <anoob.soman@citrix.com>,
        Bob Liu <bob.liu@oracle.com>, Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 044/183] scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_task
Date:   Fri, 22 Mar 2019 12:14:32 +0100
Message-Id: <20190322111244.924081714@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 79edd00dc6a96644d76b4a1cb97d94d49e026768 ]

When a target sends Check Condition, whilst initiator is busy xmiting
re-queued data, could lead to race between iscsi_complete_task() and
iscsi_xmit_task() and eventually crashing with the following kernel
backtrace.

[3326150.987523] ALERT: BUG: unable to handle kernel NULL pointer dereference at 0000000000000078
[3326150.987549] ALERT: IP: [<ffffffffa05ce70d>] iscsi_xmit_task+0x2d/0xc0 [libiscsi]
[3326150.987571] WARN: PGD 569c8067 PUD 569c9067 PMD 0
[3326150.987582] WARN: Oops: 0002 [#1] SMP
[3326150.987593] WARN: Modules linked in: tun nfsv3 nfs fscache dm_round_robin
[3326150.987762] WARN: CPU: 2 PID: 8399 Comm: kworker/u32:1 Tainted: G O 4.4.0+2 #1
[3326150.987774] WARN: Hardware name: Dell Inc. PowerEdge R720/0W7JN5, BIOS 2.5.4 01/22/2016
[3326150.987790] WARN: Workqueue: iscsi_q_13 iscsi_xmitworker [libiscsi]
[3326150.987799] WARN: task: ffff8801d50f3800 ti: ffff8801f5458000 task.ti: ffff8801f5458000
[3326150.987810] WARN: RIP: e030:[<ffffffffa05ce70d>] [<ffffffffa05ce70d>] iscsi_xmit_task+0x2d/0xc0 [libiscsi]
[3326150.987825] WARN: RSP: e02b:ffff8801f545bdb0 EFLAGS: 00010246
[3326150.987831] WARN: RAX: 00000000ffffffc3 RBX: ffff880282d2ab20 RCX: ffff88026b6ac480
[3326150.987842] WARN: RDX: 0000000000000000 RSI: 00000000fffffe01 RDI: ffff880282d2ab20
[3326150.987852] WARN: RBP: ffff8801f545bdc8 R08: 0000000000000000 R09: 0000000000000008
[3326150.987862] WARN: R10: 0000000000000000 R11: 000000000000fe88 R12: 0000000000000000
[3326150.987872] WARN: R13: ffff880282d2abe8 R14: ffff880282d2abd8 R15: ffff880282d2ac08
[3326150.987890] WARN: FS: 00007f5a866b4840(0000) GS:ffff88028a640000(0000) knlGS:0000000000000000
[3326150.987900] WARN: CS: e033 DS: 0000 ES: 0000 CR0: 0000000080050033
[3326150.987907] WARN: CR2: 0000000000000078 CR3: 0000000070244000 CR4: 0000000000042660
[3326150.987918] WARN: Stack:
[3326150.987924] WARN: ffff880282d2ad58 ffff880282d2ab20 ffff880282d2abe8 ffff8801f545be18
[3326150.987938] WARN: ffffffffa05cea90 ffff880282d2abf8 ffff88026b59cc80 ffff88026b59cc00
[3326150.987951] WARN: ffff88022acf32c0 ffff880289491800 ffff880255a80800 0000000000000400
[3326150.987964] WARN: Call Trace:
[3326150.987975] WARN: [<ffffffffa05cea90>] iscsi_xmitworker+0x2f0/0x360 [libiscsi]
[3326150.987988] WARN: [<ffffffff8108862c>] process_one_work+0x1fc/0x3b0
[3326150.987997] WARN: [<ffffffff81088f95>] worker_thread+0x2a5/0x470
[3326150.988006] WARN: [<ffffffff8159cad8>] ? __schedule+0x648/0x870
[3326150.988015] WARN: [<ffffffff81088cf0>] ? rescuer_thread+0x300/0x300
[3326150.988023] WARN: [<ffffffff8108ddf5>] kthread+0xd5/0xe0
[3326150.988031] WARN: [<ffffffff8108dd20>] ? kthread_stop+0x110/0x110
[3326150.988040] WARN: [<ffffffff815a0bcf>] ret_from_fork+0x3f/0x70
[3326150.988048] WARN: [<ffffffff8108dd20>] ? kthread_stop+0x110/0x110
[3326150.988127] ALERT: RIP [<ffffffffa05ce70d>] iscsi_xmit_task+0x2d/0xc0 [libiscsi]
[3326150.988138] WARN: RSP <ffff8801f545bdb0>
[3326150.988144] WARN: CR2: 0000000000000078
[3326151.020366] WARN: ---[ end trace 1c60974d4678d81b ]---

Commit 6f8830f5bbab ("scsi: libiscsi: add lock around task lists to fix
list corruption regression") introduced "taskqueuelock" to fix list
corruption during the race, but this wasn't enough.

Re-setting of conn->task to NULL, could race with iscsi_xmit_task().
iscsi_complete_task()
{
    ....
    if (conn->task == task)
        conn->task = NULL;
}

conn->task in iscsi_xmit_task() could be NULL and so will be task.
__iscsi_get_task(task) will crash (NullPtr de-ref), trying to access
refcount.

iscsi_xmit_task()
{
    struct iscsi_task *task = conn->task;

    __iscsi_get_task(task);
}

This commit will take extra conn->session->back_lock in iscsi_xmit_task()
to ensure iscsi_xmit_task() waits for iscsi_complete_task(), if
iscsi_complete_task() wins the race.  If iscsi_xmit_task() wins the race,
iscsi_xmit_task() increments task->refcount
(__iscsi_get_task) ensuring iscsi_complete_task() will not iscsi_free_task().

Signed-off-by: Anoob Soman <anoob.soman@citrix.com>
Signed-off-by: Bob Liu <bob.liu@oracle.com>
Acked-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libiscsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 3ff536b350a1..5ea5d42bac76 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1449,7 +1449,13 @@ static int iscsi_xmit_task(struct iscsi_conn *conn)
 	if (test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx))
 		return -ENODATA;
 
+	spin_lock_bh(&conn->session->back_lock);
+	if (conn->task == NULL) {
+		spin_unlock_bh(&conn->session->back_lock);
+		return -ENODATA;
+	}
 	__iscsi_get_task(task);
+	spin_unlock_bh(&conn->session->back_lock);
 	spin_unlock_bh(&conn->session->frwd_lock);
 	rc = conn->session->tt->xmit_task(task);
 	spin_lock_bh(&conn->session->frwd_lock);
-- 
2.19.1



