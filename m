Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B913EC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6C621019
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 17:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rafsCdSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfDFRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 13:53:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45485 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDFRxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 13:53:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so4796103pgk.12;
        Sat, 06 Apr 2019 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aD2HjI9W9IwT9IWFkRrNIUc8XeEIECdZY1AjG2eNveM=;
        b=rafsCdSIVAbCXLDRanlnwv5F7m1VT8xTIjE+zOsADENewYrpxKbd/6xQf2oWsDTEWE
         /37bsy9CP2zZqLHLBDFyATi5EPze4NxtpUlQXXc9UcLYFh7ktnUxVji3eTmCW+GzV842
         9fUmWDFlp8vJ726ockRtVlUcTk9FBlI69Duh4zhWGqlIbuYK7IO87mcWotv5dSl0ynPg
         vkY3uqiaHETrsEtzoXzo1ovCwaeFMr5ZLM0J/LUpBKrhf8uiWFn0ttHjRY9S7zUxto1H
         /p/tTP8LN/fmwDktqPyGnCBkzaxYiZTAF5Ymlb+ruRLrKikm6caCE21ienDCpIg0XDIy
         Aw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aD2HjI9W9IwT9IWFkRrNIUc8XeEIECdZY1AjG2eNveM=;
        b=tAIMOPCXdmNJ8/+BRHhI1wFTk6i5djhNEdQvYyfr4t8ne8ylE6YeSGD3tbxp9GxhjX
         QlGHmOz3cN/LKzamb9gn5KOHyBvOARyu89gPf/m6wv/zT4ztJwT1OpB7pbfUq/Y7v03M
         rG6k/Jqvuz0kyt/8kfMW83FWXZc4dgB8Gflt52g7QU27RvNX1+UU1WvMYy9MDDoQIORT
         K0sTSpVCePQzRSCl/QiTW8Bf3KmziiWd/aKdUFYENFKwO2+zrRveIuwY2WQvJvDV6r6Y
         dqqkf8mhb0VwMm6LYXq40g5vx9e/Q3jmqpfIMmyBGJ4TUyNs0YV7V/5RROIOLMhUhm4F
         DYYg==
X-Gm-Message-State: APjAAAUwB3+k2+8LyjRqOsIsTYn7YUSrrOgM5MiY7W64x6tLicAkUzLe
        HnGoxybIFqMMQ412SOTcTdk=
X-Google-Smtp-Source: APXvYqzdwxxkJ8fbemR7zrbUPEDW3cS/uL7Rnby8cCkaY23Br8lS5Ebp2jZZAsvLX0lacBoO8+k5lQ==
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr18271670pfv.10.1554573216314;
        Sat, 06 Apr 2019 10:53:36 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id n21sm30033458pfb.42.2019.04.06.10.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 10:53:35 -0700 (PDT)
Date:   Sat, 6 Apr 2019 23:23:31 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mvumi: fix warning Using plain integer as NULL pointer
Message-ID: <20190406175331.GA22504@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed "0 to NULL" to avoid below sparse warnings

drivers/scsi/mvumi.c:755:58: warning: Using plain integer as NULL
pointer
drivers/scsi/mvumi.c:1797:48: warning: Using plain integer as NULL
pointer
drivers/scsi/mvumi.c:2142:50: warning: Using plain integer as NULL
pointer

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/scsi/mvumi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index 3df0269..a541061 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -752,7 +752,7 @@ static int mvumi_issue_blocked_cmd(struct mvumi_hba *mhba,
 		spin_lock_irqsave(mhba->shost->host_lock, flags);
 		atomic_dec(&cmd->sync_cmd);
 		if (mhba->tag_cmd[cmd->frame->tag]) {
-			mhba->tag_cmd[cmd->frame->tag] = 0;
+			mhba->tag_cmd[cmd->frame->tag] = NULL;
 			dev_warn(&mhba->pdev->dev, "TIMEOUT:release tag [%d]\n",
 							cmd->frame->tag);
 			tag_release_one(mhba, &mhba->tag_pool, cmd->frame->tag);
@@ -1794,7 +1794,7 @@ static void mvumi_handle_clob(struct mvumi_hba *mhba)
 		cmd = mhba->tag_cmd[ob_frame->tag];
 
 		atomic_dec(&mhba->fw_outstanding);
-		mhba->tag_cmd[ob_frame->tag] = 0;
+		mhba->tag_cmd[ob_frame->tag] = NULL;
 		tag_release_one(mhba, &mhba->tag_pool, ob_frame->tag);
 		if (cmd->scmd)
 			mvumi_complete_cmd(mhba, cmd, ob_frame);
@@ -2139,7 +2139,7 @@ static enum blk_eh_timer_return mvumi_timed_out(struct scsi_cmnd *scmd)
 	spin_lock_irqsave(mhba->shost->host_lock, flags);
 
 	if (mhba->tag_cmd[cmd->frame->tag]) {
-		mhba->tag_cmd[cmd->frame->tag] = 0;
+		mhba->tag_cmd[cmd->frame->tag] = NULL;
 		tag_release_one(mhba, &mhba->tag_pool, cmd->frame->tag);
 	}
 	if (!list_empty(&cmd->queue_pointer))
-- 
2.7.4

