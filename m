Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6572C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8905922CB8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033323;
	bh=LBngP+SYDecVYiJm+t3k/6UP2RSu5ScY0G4AkJwtVNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQngi8bLvGedk51DRW3ZrK0OKQzasZxDto76LqCnnBZstMWCCBZKp45j+JdsIYhzN
	 I81ywkJosgkqQNshkxvdGDCdIbNWeFXr9EiprS41FKzcEMNJgdRjVhRv6R68DAmLuh
	 pEPYRNXMYDRVCUCcIc/+WfJ+nJouioz2udw59MYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404804AbfGYFmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404736AbfGYFl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:41:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C052075C;
        Thu, 25 Jul 2019 05:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033318;
        bh=LBngP+SYDecVYiJm+t3k/6UP2RSu5ScY0G4AkJwtVNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDmI++poRkEFSX8ic7mbyaJsZA+E3ZyLx+TFzCkgtX0Ly/jX0GstxBDDMOsBLh2iu
         B1+rKmBa6t4H66lsJOzxYal4iME15p3tjFI/1vAS/+jE6RMgCAsa/ByTEnz/7RDLBC
         g0J3f+oWtxl8vpYYdPheXN29AXELTjGg2+J2gUYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 165/271] scsi: NCR5380: Reduce goto statements in NCR5380_select()
Date:   Wed, 24 Jul 2019 21:20:34 +0200
Message-Id: <20190724191709.320954138@linuxfoundation.org>
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

commit 6a162836997c10bbefb7c7ca772201cc45c0e4a6 upstream.

Replace a 'goto' statement with a simple 'return' where possible.  This
improves readability. No functional change.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/NCR5380.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -984,7 +984,7 @@ static struct scsi_cmnd *NCR5380_select(
 	if (!hostdata->selecting) {
 		/* Command was aborted */
 		NCR5380_write(MODE_REG, MR_BASE);
-		goto out;
+		return NULL;
 	}
 	if (err < 0) {
 		NCR5380_write(MODE_REG, MR_BASE);
@@ -1033,7 +1033,7 @@ static struct scsi_cmnd *NCR5380_select(
 	if (!hostdata->selecting) {
 		NCR5380_write(MODE_REG, MR_BASE);
 		NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
-		goto out;
+		return NULL;
 	}
 
 	dsprintk(NDEBUG_ARBITRATION, instance, "won arbitration\n");
@@ -1116,13 +1116,16 @@ static struct scsi_cmnd *NCR5380_select(
 		spin_lock_irq(&hostdata->lock);
 		NCR5380_write(INITIATOR_COMMAND_REG, ICR_BASE);
 		NCR5380_write(SELECT_ENABLE_REG, hostdata->id_mask);
+
 		/* Can't touch cmd if it has been reclaimed by the scsi ML */
-		if (hostdata->selecting) {
-			cmd->result = DID_BAD_TARGET << 16;
-			complete_cmd(instance, cmd);
-			dsprintk(NDEBUG_SELECTION, instance, "target did not respond within 250ms\n");
-			cmd = NULL;
-		}
+		if (!hostdata->selecting)
+			return NULL;
+
+		cmd->result = DID_BAD_TARGET << 16;
+		complete_cmd(instance, cmd);
+		dsprintk(NDEBUG_SELECTION, instance,
+			"target did not respond within 250ms\n");
+		cmd = NULL;
 		goto out;
 	}
 
@@ -1155,7 +1158,7 @@ static struct scsi_cmnd *NCR5380_select(
 	}
 	if (!hostdata->selecting) {
 		do_abort(instance);
-		goto out;
+		return NULL;
 	}
 
 	dsprintk(NDEBUG_SELECTION, instance, "target %d selected, going into MESSAGE OUT phase.\n",


