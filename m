Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075F2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D294B2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739807;
	bh=PcsQo1hXT6MNMUhxrEhQkhYoGRVZHbiC+jN1cSetfSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gOKh9as943TbWzNosmDXnlEi2BrwJy5L9eTfC1U/uZtVnQdSTUo61RZw3/lNsd1A+
	 JMZJnsXAY9DLQ81FbhdUKa45Zl9q2rs06R9pU9LpHwWjEkNaONfbfjXn2YBmHQ8UmG
	 ICO0tDThrojqGjriq0gmW7tdI4F6n50xf3c7kSWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406780AbfHBJ4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406761AbfHBJ4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:56:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B953B2067D;
        Fri,  2 Aug 2019 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739800;
        bh=PcsQo1hXT6MNMUhxrEhQkhYoGRVZHbiC+jN1cSetfSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R7VckPrmFJP85NiRtk/dQxRFazcqOtvt03Dd7+WjN4HMM3c+Mua+tXh43rHYU5E57
         yue+XTtmOKsRD0WOQhgIsKffp2LjORcc4jD+LgZnTR9ni/NB9trpFO5nWOascU37RE
         0oOCQk+xm14U/a3QeBky+E1Aa1SKo84aQpcmhAPE=
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
Subject: [PATCH 4.19 32/32] scsi: core: Avoid that a kernel warning appears during system resume
Date:   Fri,  2 Aug 2019 11:40:06 +0200
Message-Id: <20190802092111.551503666@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092101.913646560@linuxfoundation.org>
References: <20190802092101.913646560@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
@@ -3102,8 +3102,10 @@ void scsi_device_resume(struct scsi_devi
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


