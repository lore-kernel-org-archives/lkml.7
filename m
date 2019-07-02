Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A0C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317802184B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562055019;
	bh=JZqU6SbEu1G9od63bFj+X/LVOZySTd08frXzcfvf4FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T6bQmZzoHah+8Axn91jpx38C9+evGOyMEdg2Ld40FnIpMJyE8pfdYAf3YalAbyWy6
	 HCtg0hEH/sOc1t5bczG0w9phZfRhA7u8Wy3/fcY2//ap6UlZDyRUkwC0Vgp7/wV9bZ
	 8KwypfZzdNEKLDFdJEJ+plCFBI9oTEbnoP23SPU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfGBIKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbfGBIKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:10:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45952064A;
        Tue,  2 Jul 2019 08:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562055015;
        bh=JZqU6SbEu1G9od63bFj+X/LVOZySTd08frXzcfvf4FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lg/UaI7oXrqm7D7XuaVfnF2lGYzWmqPV3eIs3q0nq4EFgJPzqKtcNk+bDjBM5ebKr
         w5yMzA6gCObSv3rHwlGfHumf5RaeHStiuJi97kYHuvl9wUA9J8VJGtiPqNwyy21+5Z
         KpMIaAV0wb9lYrKmk+gZJz18B7+dE/jlEzVNZwzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Ewan D. Milne" <emilne@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 21/43] scsi: vmw_pscsi: Fix use-after-free in pvscsi_queue_lck()
Date:   Tue,  2 Jul 2019 10:02:01 +0200
Message-Id: <20190702080124.907127322@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080123.904399496@linuxfoundation.org>
References: <20190702080123.904399496@linuxfoundation.org>
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
@@ -763,6 +763,7 @@ static int pvscsi_queue_lck(struct scsi_
 	struct pvscsi_adapter *adapter = shost_priv(host);
 	struct pvscsi_ctx *ctx;
 	unsigned long flags;
+	unsigned char op;
 
 	spin_lock_irqsave(&adapter->hw_lock, flags);
 
@@ -775,13 +776,14 @@ static int pvscsi_queue_lck(struct scsi_
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


