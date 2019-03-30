Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B5BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D406218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907104;
	bh=1E6rib1GvydoC8vExsOm1Nzk1+4f1NXN/SOA/9Hs0ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yo5OF86WV4dhpU2drGdvd2UmLB5SCs9NNF285jLKENKlOx3oH+6Q7W/dnhzaRgMkW
	 PNzk+PHpU34lr4axNm5NYsIYTwZ/Rb7tLhvpYFdyQxNoTcUommR9AU/3S4FBLGRqND
	 8dCTfUza8Bf7muBrNgyc4gArmkLb9rCXbCHNpFMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfC3Avn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730800AbfC3Avi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13566218D3;
        Sat, 30 Mar 2019 00:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907098;
        bh=1E6rib1GvydoC8vExsOm1Nzk1+4f1NXN/SOA/9Hs0ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uS/ALwtBVae9hVGF+tz8aFAJGaXVyf8E0qNHKUArDSUL3bAxsx4H0NEEza7O98Oc7
         seAnaNWYMO6LvNLezMMZuLzoGBtqFwa5e71IsxVMEgt7Ew/AdMMFJQkuncE+r0IxTA
         sBrIcSpKn+3B8EOp6Z2WEJgvZMnmsN05zYK9U0m4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 31/67] scsi: core: Also call destroy_rcu_head() for passthrough requests
Date:   Fri, 29 Mar 2019 20:50:11 -0400
Message-Id: <20190330005047.25998-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

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

