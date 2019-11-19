Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F83C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560AC21783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142965;
	bh=a0Ur+5kxtgHPxEjJZ9sSIDYPySqFtWB6JXtylGDi0lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P2yG7llWRmgTOstwxE4/c4KvMEsvDDeAxKVIt0HQs9sbuezDFv8KoSppNmrk7Gc+o
	 2noOCNV/k6gdDuf08mzjLzN/7Zaxd4mdf0xfrBL7Km4HT5J8YMJk0IOUVsmJ312MSY
	 0Qoo9vJg9sPrhMEk9JNlZWVTYW+MVKAgypkhSfO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfKSFyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:54:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731535AbfKSFyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:54:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E472084D;
        Tue, 19 Nov 2019 05:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142852;
        bh=a0Ur+5kxtgHPxEjJZ9sSIDYPySqFtWB6JXtylGDi0lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6XQl543/6WhYzzVKbWYRtWfke50msTIfURbY+6blIVPwVVCtZh5LGaQhIecQ3KFj
         I+s97G6RkG81bLF1UX0orFkSfsNYsT4q+Tf/upUh/QSTY8AJiKhZXW6E6b4TExVcas
         /YPuwGY+VEV4H2RaVlDCeIrsIH+1+FbbaL7gHwNg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 223/239] scsi: NCR5380: Use DRIVER_SENSE to indicate valid sense data
Date:   Tue, 19 Nov 2019 06:20:23 +0100
Message-Id: <20191119051339.614175121@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 070356513963be6196142acff56acc8359069fa1 ]

When sense data is valid, call set_driver_byte(cmd, DRIVER_SENSE).  Otherwise
some callers of scsi_execute() will ignore sense data.  Don't set DID_ERROR or
DID_RESET just because sense data is missing.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/NCR5380.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index 5f26aa2875bd9..00397e89d652d 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -513,11 +513,12 @@ static void complete_cmd(struct Scsi_Host *instance,
 
 	if (hostdata->sensing == cmd) {
 		/* Autosense processing ends here */
-		if ((cmd->result & 0xff) != SAM_STAT_GOOD) {
+		if (status_byte(cmd->result) != GOOD) {
 			scsi_eh_restore_cmnd(cmd, &hostdata->ses);
-			set_host_byte(cmd, DID_ERROR);
-		} else
+		} else {
 			scsi_eh_restore_cmnd(cmd, &hostdata->ses);
+			set_driver_byte(cmd, DRIVER_SENSE);
+		}
 		hostdata->sensing = NULL;
 	}
 
@@ -2271,7 +2272,6 @@ static int NCR5380_abort(struct scsi_cmnd *cmd)
 	if (list_del_cmd(&hostdata->autosense, cmd)) {
 		dsprintk(NDEBUG_ABORT, instance,
 		         "abort: removed %p from sense queue\n", cmd);
-		set_host_byte(cmd, DID_ERROR);
 		complete_cmd(instance, cmd);
 	}
 
@@ -2350,7 +2350,6 @@ static int NCR5380_host_reset(struct scsi_cmnd *cmd)
 	list_for_each_entry(ncmd, &hostdata->autosense, list) {
 		struct scsi_cmnd *cmd = NCR5380_to_scmd(ncmd);
 
-		set_host_byte(cmd, DID_RESET);
 		cmd->scsi_done(cmd);
 	}
 	INIT_LIST_HEAD(&hostdata->autosense);
-- 
2.20.1



