Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69D1C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98A92186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611120;
	bh=Ncp2/h1kQzdBhWbJQxxcy4It+rI93OTMLtf1GZTw62A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kr2OcLp8vZ5gzyOihhH1FYN7t0jTsvZauSdMmZXPc46vMy7oRi0oDii1QMvaYK+kh
	 KiHDK/64vAhVazpvGXKgISf5ToewjAzUS7tQYZ56mYO4jhSne2tlWYO8wVyQz5IeJB
	 RInEQGZV8zpiiPNQZF7jgoBcb2dsCnY236/r9ePM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbfDRSL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403960AbfDRSL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:11:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D1F5206B6;
        Thu, 18 Apr 2019 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611115;
        bh=Ncp2/h1kQzdBhWbJQxxcy4It+rI93OTMLtf1GZTw62A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSgMTnVjz0Y9DCSv61MJEDurnqIDv+GBdyladsngnKwcAwrnut3vUivCTffuCL9SE
         DyykpKKWuOifIGuJ967mkY4jsliRAE1E6azRZjD1rOUlJZD1s5rJfHhjDp65DghK7z
         SNhhwhUITHBqJFtIMqNHNmHPHYETfhOPue1uFUtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 31/93] scsi: core: Also call destroy_rcu_head() for passthrough requests
Date:   Thu, 18 Apr 2019 19:57:09 +0200
Message-Id: <20190418160440.135727816@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit db983f6eef57a9d78af79bc32389b7e60eb3c47d ]

cmd->rcu is initialized by scsi_initialize_rq(). For passthrough
requests, blk_get_request() calls scsi_initialize_rq(). For filesystem
requests, scsi_init_command() calls scsi_initialize_rq(). Make sure
that destroy_rcu_head() is called for passthrough requests.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_lib.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5a6e8e12701a..655ad26106e4 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -598,9 +598,16 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 	if (!blk_rq_is_scsi(req)) {
 		WARN_ON_ONCE(!(cmd->flags & SCMD_INITIALIZED));
 		cmd->flags &= ~SCMD_INITIALIZED;
-		destroy_rcu_head(&cmd->rcu);
 	}
 
+	/*
+	 * Calling rcu_barrier() is not necessary here because the
+	 * SCSI error handler guarantees that the function called by
+	 * call_rcu() has been called before scsi_end_request() is
+	 * called.
+	 */
+	destroy_rcu_head(&cmd->rcu);
+
 	/*
 	 * In the MQ case the command gets freed by __blk_mq_end_request,
 	 * so we have to do all cleanup that depends on it earlier.
-- 
2.19.1



