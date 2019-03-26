Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B7FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41C320879
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582387;
	bh=CYxVQ+lTLIAg9lqpY9P95eGnNhYxNR8D5P6ZSpCyOKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=btwoiA8v6BltO9ETDM5zJmiJN6BqMnnalJRSPbR53PWKErNuKv9mSJVvZfRLTQDNp
	 KVaeRbXlgb/FC2+xlC5/2IrO2E5TtQ3pqKaE88wBmbzKvOC68xnZ01qNTqhVDq3aQg
	 lPAHxWtG7YGrHZzuEwJyhX/KqA9Bsl1vFemmy8L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfCZGjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732743AbfCZGjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:43 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306A820863;
        Tue, 26 Mar 2019 06:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582382;
        bh=CYxVQ+lTLIAg9lqpY9P95eGnNhYxNR8D5P6ZSpCyOKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lF0XnXB5ZZEH4xJRg7taMRnfLsDSqXsprzNLlBAGmezdcy+0/gUOMzv1jWwMSVUbt
         DzA5mqc4kNP8jWSxISjm2eN6r8gC9yoH9nMJGU8Ej2jsARyjIk5YBScUtYmD8pUJTt
         5bxhiiZYwx3+Y3fei5zQkW159nehudIocM2hMkT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.0 20/52] scsi: core: Avoid that a kernel warning appears during system resume
Date:   Tue, 26 Mar 2019 15:30:07 +0900
Message-Id: <20190326042701.932953227@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit 17605afaae825b0291f80c62a7f6565879edaa8a upstream.

Since scsi_device_quiesce() skips SCSI devices that have another state than
RUNNING, OFFLINE or TRANSPORT_OFFLINE, scsi_device_resume() should not
complain about SCSI devices that have been skipped. Hence this patch.  This
patch avoids that the following warning appears during resume:

WARNING: CPU: 3 PID: 1039 at blk_clear_pm_only+0x2a/0x30
CPU: 3 PID: 1039 Comm: kworker/u8:49 Not tainted 5.0.0+ #1
Hardware name: LENOVO 4180F42/4180F42, BIOS 83ET75WW (1.45 ) 05/10/2013
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:blk_clear_pm_only+0x2a/0x30
Call Trace:
 ? scsi_device_resume+0x28/0x50
 ? scsi_dev_type_resume+0x2b/0x80
 ? async_run_entry_fn+0x2c/0xd0
 ? process_one_work+0x1f0/0x3f0
 ? worker_thread+0x28/0x3c0
 ? process_one_work+0x3f0/0x3f0
 ? kthread+0x10c/0x130
 ? __kthread_create_on_node+0x150/0x150
 ? ret_from_fork+0x1f/0x30

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Martin Steigerwald <martin@lichtvoll.de>
Cc: <stable@vger.kernel.org>
Reported-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Tested-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Fixes: 3a0a529971ec ("block, scsi: Make SCSI quiesce and resume work reliably") # v4.15
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_lib.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2598,8 +2598,10 @@ void scsi_device_resume(struct scsi_devi
 	 * device deleted during suspend)
 	 */
 	mutex_lock(&sdev->state_mutex);
-	sdev->quiesced_by = NULL;
-	blk_clear_pm_only(sdev->request_queue);
+	if (sdev->quiesced_by) {
+		sdev->quiesced_by = NULL;
+		blk_clear_pm_only(sdev->request_queue);
+	}
 	if (sdev->sdev_state == SDEV_QUIESCE)
 		scsi_device_set_state(sdev, SDEV_RUNNING);
 	mutex_unlock(&sdev->state_mutex);


