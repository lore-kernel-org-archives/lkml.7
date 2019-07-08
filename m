Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E9FC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9B620665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600713;
	bh=mfKQpapypipZR6ClWL2quh0/8skpbU5O50lJWuBLQoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mXOp+mBIWe0gT8D9CYF6JZNa76pntv510+ohBF9Mb1Zr6Di/4iVIL37MdiFRDzkuJ
	 6EY0ewh0R880+pl/1dXU+RKsr3836rkV9r3C+yQEX/PgQZjebupiNo49K7B9yeSLrG
	 nwndzhZ0aYmGEZjMqkSb56VNyEdURECFvtYUBehE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbfGHPWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbfGHPWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:22:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4211A2166E;
        Mon,  8 Jul 2019 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599357;
        bh=mfKQpapypipZR6ClWL2quh0/8skpbU5O50lJWuBLQoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6GUsWEyGio7fclNUJkgtekooyes16mE7zc6ehjJHIQ8GaRAnuVfuHOmSvUgacy7r
         tdCLqdKZZ91un6by3IHc9ldi54SRDCUrOGKVrgu3GYILnR1PRFXsRRavjQTjm8vwYY
         2sLmWaBJn9FCAWsTxgNMVVlOgqG6xWSAfo7yJtS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 048/102] scsi: vmw_pscsi: Fix use-after-free in pvscsi_queue_lck()
Date:   Mon,  8 Jul 2019 17:12:41 +0200
Message-Id: <20190708150528.920230298@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 240b4cc8fd5db138b675297d4226ec46594d9b3b upstream.

Once we unlock adapter->hw_lock in pvscsi_queue_lck() nothing prevents just
queued scsi_cmnd from completing and freeing the request. Thus cmd->cmnd[0]
dereference can dereference already freed request leading to kernel crashes
or other issues (which one of our customers observed). Store cmd->cmnd[0]
in a local variable before unlocking adapter->hw_lock to fix the issue.

CC: <stable@vger.kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/vmw_pvscsi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -766,6 +766,7 @@ static int pvscsi_queue_lck(struct scsi_
 	struct pvscsi_adapter *adapter = shost_priv(host);
 	struct pvscsi_ctx *ctx;
 	unsigned long flags;
+	unsigned char op;
 
 	spin_lock_irqsave(&adapter->hw_lock, flags);
 
@@ -778,13 +779,14 @@ static int pvscsi_queue_lck(struct scsi_
 	}
 
 	cmd->scsi_done = done;
+	op = cmd->cmnd[0];
 
 	dev_dbg(&cmd->device->sdev_gendev,
-		"queued cmd %p, ctx %p, op=%x\n", cmd, ctx, cmd->cmnd[0]);
+		"queued cmd %p, ctx %p, op=%x\n", cmd, ctx, op);
 
 	spin_unlock_irqrestore(&adapter->hw_lock, flags);
 
-	pvscsi_kick_io(adapter, cmd->cmnd[0]);
+	pvscsi_kick_io(adapter, op);
 
 	return 0;
 }


