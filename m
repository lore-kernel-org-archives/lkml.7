Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB98C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4083024010
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZ59KD1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE2R66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:58:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45008 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2R65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:58:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so325957pgp.11;
        Wed, 29 May 2019 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BxwrAqO9UAXV6UenFSJjDbgaMZFeylmamm3RqPV+N2k=;
        b=tZ59KD1wTs2TjPkbXAhQzJkB5G/NBo1yGQ1cYu4X+m4W4fIUbT2O4NgcHvqQwUE/h1
         ro0tS9OZi7F/oKAmx2a3DDICMaCM6X3+19xizHqFbXsM4RNtrXCcZv8FzDadAQHWAPhX
         wGFT8p4BvITfHOdjr2jIfyuOvLBtsdsU9FZQuNngBPq+oCLIG+YEwq4HjCsEMP7pIr/3
         TYWbQJuqbtih6HAdGmswWyWn36aK9CgrbrEOXmKRDRUM3kxCGoh9ZhOgSnCyTX9HD6zk
         XSBj2wRzYTCV4tHRIOQRRMq7MZla8qhN2JrpSgbIEuPIltRArLNriYMX0EQac+kmvVEM
         oZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BxwrAqO9UAXV6UenFSJjDbgaMZFeylmamm3RqPV+N2k=;
        b=MnZSxpJ0R2vEHVH6MkAQg2yv74NHThLbbyTWIIGIQbn0XpDrs8RDLsLWNprmJO33qo
         /KY2Xo2H5edAlul6S0Zr6Mw2sw3bCYVPpDvtdUCkIoWQJniTSl2UJMlz4z5v0B4LPH9m
         h39ukSrEeyaEw7TS16QOQVvQp6wxCbfQgrDRf3lPl52in3Hl6+mTuUPMVb4Coz/Cw8Ju
         vGhzUl98IgnxwpybXC1YzTSkDMtTirICn/RWgytMMJuosZI67UiYNPfC6GrE73KPCHfZ
         xOEUPCAjuPMR6DQyxXSErmxb8syPoAiTSj9xfMCd5Lqwe+pCBYE1KDnDpC+p7ThaYIXf
         98yw==
X-Gm-Message-State: APjAAAXgaMo9mUUza8TXyL2BN7S3durYz7aD+4nI4G2rJ7vQqxsnOXyN
        6yvwVV8ywkgU+J8AKhwuey8=
X-Google-Smtp-Source: APXvYqxnHXl1GtRPFmBDheP9IOj8tKjdq/3R7VfecrJbmSjAECrjur1LnsM86N//7eZ+M1MWrihhOw==
X-Received: by 2002:aa7:8acb:: with SMTP id b11mr150551391pfd.115.1559152737270;
        Wed, 29 May 2019 10:58:57 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id l38sm182909pje.12.2019.05.29.10.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 10:58:56 -0700 (PDT)
Date:   Wed, 29 May 2019 23:28:51 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] wd719x: pass GFP_ATOMIC instead of GFP_KERNEL
Message-ID: <20190529175851.GA10760@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dont acquire lock before calling wd719x_chip_init.

Issue identified by coccicheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
-----
changes in v1: Replace GFP_KERNEL with GFP_ATOMIC.
changes in v2: Call wd719x_chip_init  without lock as suggested
		in review
----
---
 drivers/scsi/wd719x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index c2f4006..340ec92 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -505,11 +505,9 @@ static int wd719x_host_reset(struct scsi_cmnd *cmd)
 {
 	struct wd719x *wd = shost_priv(cmd->device->host);
 	struct wd719x_scb *scb, *tmp;
-	unsigned long flags;
 	int result;
 
 	dev_info(&wd->pdev->dev, "host reset requested\n");
-	spin_lock_irqsave(wd->sh->host_lock, flags);
 	/* Try to reinit the RISC */
 	if (wd719x_chip_init(wd) == 0)
 		result = SUCCESS;
@@ -519,7 +517,6 @@ static int wd719x_host_reset(struct scsi_cmnd *cmd)
 	/* flush all SCBs */
 	list_for_each_entry_safe(scb, tmp, &wd->active_scbs, list)
 		wd719x_finish_cmd(scb, result);
-	spin_unlock_irqrestore(wd->sh->host_lock, flags);
 
 	return result;
 }
-- 
2.7.4

