Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A29C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488F120657
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033770;
	bh=D1K8Ip+UqvaY6ipT/LuQzAQY4HCUQRu+dh6QqBx6EYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fm4VZoikoE80/KW+lIB/4t3CrehOnkFN9D55Q3MACWfqtWDHg4cYjnuli9Yk8rc2o
	 Hm3XxquptcN6+xuJPrOJnEnBYok6sLFoY4lf0HmQaWcGXwpf0pRudP5+B2L3suiRuy
	 y+lbd5tHEdm72aQdvaUQrasPp/Un8Mfc7elx4o78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfGYFt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391245AbfGYFoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:44:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A837221880;
        Thu, 25 Jul 2019 05:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033462;
        bh=D1K8Ip+UqvaY6ipT/LuQzAQY4HCUQRu+dh6QqBx6EYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uF7jgyeTAwHGOeaQw805ST86LMc8WZnOqP+HEyq4LAeqR+ZGODkCcUUVUVBZOigBR
         tADlPRu74utcblj3YaMWEU6PhugUQ+UPoj1eSPICn34ro8XPCXXiocT51TsmmLUNKa
         HiM2ezkcMn7d002EWPYBnYvJx7fTKNHHybKGxJLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Stan Johnson <userm57@yahoo.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 166/271] scsi: NCR5380: Always re-enable reselection interrupt
Date:   Wed, 24 Jul 2019 21:20:35 +0200
Message-Id: <20190724191709.396504053@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

commit 57f31326518e98ee4cabf9a04efe00ed57c54147 upstream.

The reselection interrupt gets disabled during selection and must be
re-enabled when hostdata->connected becomes NULL. If it isn't re-enabled a
disconnected command may time-out or the target may wedge the bus while
trying to reselect the host. This can happen after a command is aborted.

Fix this by enabling the reselection interrupt in NCR5380_main() after
calls to NCR5380_select() and NCR5380_information_transfer() return.

Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: stable@vger.kernel.org # v4.9+
Fixes: 8b00c3d5d40d ("ncr5380: Implement new eh_abort_handler")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/NCR5380.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -710,6 +710,8 @@ static void NCR5380_main(struct work_str
 			NCR5380_information_transfer(instance);
 			done = 0;
 		}
+		if (!hostdata->connected)
+			NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
 		spin_unlock_irq(&hostdata->lock);
 		if (!done)
 			cond_resched();
@@ -1106,8 +1108,6 @@ static struct scsi_cmnd *NCR5380_select(
 		spin_lock_irq(&hostdata->lock);
 		NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
 		NCR5380_reselect(instance);
-		if (!hostdata->connected)
-			NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
 		shost_printk(KERN_ERR, instance, "reselection after won arbitration?\n");
 		goto out;
 	}
@@ -1115,7 +1115,6 @@ static struct scsi_cmnd *NCR5380_select(
 	if (err < 0) {
 		spin_lock_irq(&hostdata->lock);
 		NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
-		NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
 
 		/* Can't touch cmd if it has been reclaimed by the scsi ML */
 		if (!hostdata->selecting)
@@ -1153,7 +1152,6 @@ static struct scsi_cmnd *NCR5380_select(
 	if (err < 0) {
 		shost_printk(KERN_ERR, instance, "select: REQ timeout\n");
 		NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
-		NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
 		goto out;
 	}
 	if (!hostdata->selecting) {
@@ -1820,9 +1818,6 @@ static void NCR5380_information_transfer
 					 */
 					NCR5380_write(TARGET_COMMAND_REG, 0);
 
-					/* Enable reselect interrupts */
-					NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
-
 					maybe_release_dma_irq(instance);
 					return;
 				case MESSAGE_REJECT:
@@ -1854,8 +1849,6 @@ static void NCR5380_information_transfer
 					 */
 					NCR5380_write(TARGET_COMMAND_REG, 0);
 
-					/* Enable reselect interrupts */
-					NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
 #ifdef SUN3_SCSI_VME
 					dregs->csr |= CSR_DMA_ENABLE;
 #endif
@@ -1957,7 +1950,6 @@ static void NCR5380_information_transfer
 					cmd->result = DID_ERROR << 16;
 					complete_cmd(instance, cmd);
 					maybe_release_dma_irq(instance);
-					NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
 					return;
 				}
 				msgout = NOP;


