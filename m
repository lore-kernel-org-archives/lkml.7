Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9AEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C8020880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140115;
	bh=wsP+D3owxejks0dTtpyhKlaNKgKGstPEcA4gvo5O50A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VetXuKr+LDPz4Ac1IsJxW7gI3itxKDcCsvZ3KkpkmfLLKReTr9IR1Cen3Mkada45j
	 XYxIClSxTdjC5N1YVLIRZFCkJIr7pOWWrulzSuWLgDCiAD6HzBiC+/l5M2+jZ1Skv0
	 yXKgR6sP5xcY8KrJXI85Hg/KQp6mrHpFxKhTdZxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbfDARfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387870AbfDARfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4338E2070B;
        Mon,  1 Apr 2019 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140108;
        bh=wsP+D3owxejks0dTtpyhKlaNKgKGstPEcA4gvo5O50A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSLi18Lj21Pi1LavgNuhGSjBF5dgATP56BTSntd6G72vw08gL6s17tNzv9ywh4P07
         Rh4dRXsTqS/idtFe70s9TfzbmHCSBTc3zU+jwjElKqtuIJ2k4yNpKc67qY9pmYsyOJ
         wioipkfg2ixCTs3UB4aca8vZU6K31XJSwIKNJO3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jason Yan <yanaijie@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 108/131] scsi: sd: Fix a race between closing an sd device and sd I/O
Date:   Mon,  1 Apr 2019 19:02:58 +0200
Message-Id: <20190401170100.786950601@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit c14a57264399efd39514a2329c591a4b954246d8 upstream.

The scsi_end_request() function calls scsi_cmd_to_driver() indirectly and
hence needs the disk->private_data pointer. Avoid that that pointer is
cleared before all affected I/O requests have finished. This patch avoids
that the following crash occurs:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Call trace:
 scsi_mq_uninit_cmd+0x1c/0x30
 scsi_end_request+0x7c/0x1b8
 scsi_io_completion+0x464/0x668
 scsi_finish_command+0xbc/0x160
 scsi_eh_flush_done_q+0x10c/0x170
 sas_scsi_recover_host+0x84c/0xa98 [libsas]
 scsi_error_handler+0x140/0x5b0
 kthread+0x100/0x12c
 ret_from_fork+0x10/0x18

Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jason Yan <yanaijie@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reported-by: Jason Yan <yanaijie@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1276,11 +1276,6 @@ static void sd_release(struct gendisk *d
 			scsi_set_medium_removal(sdev, SCSI_REMOVAL_ALLOW);
 	}
 
-	/*
-	 * XXX and what if there are packets in flight and this close()
-	 * XXX is followed by a "rmmod sd_mod"?
-	 */
-
 	scsi_disk_put(sdkp);
 }
 
@@ -3227,11 +3222,23 @@ static void scsi_disk_release(struct dev
 {
 	struct scsi_disk *sdkp = to_scsi_disk(dev);
 	struct gendisk *disk = sdkp->disk;
-	
+	struct request_queue *q = disk->queue;
+
 	spin_lock(&sd_index_lock);
 	ida_remove(&sd_index_ida, sdkp->index);
 	spin_unlock(&sd_index_lock);
 
+	/*
+	 * Wait until all requests that are in progress have completed.
+	 * This is necessary to avoid that e.g. scsi_end_request() crashes
+	 * due to clearing the disk->private_data pointer. Wait from inside
+	 * scsi_disk_release() instead of from sd_release() to avoid that
+	 * freezing and unfreezing the request queue affects user space I/O
+	 * in case multiple processes open a /dev/sd... node concurrently.
+	 */
+	blk_mq_freeze_queue(q);
+	blk_mq_unfreeze_queue(q);
+
 	disk->private_data = NULL;
 	put_disk(disk);
 	put_device(&sdkp->device->sdev_gendev);


