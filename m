Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20EBC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65C420644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443155;
	bh=9INB2P2iUkV83KaFw/Gx+3oZz2B6MAhwPwEHjvtXxvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHugQIRLrKt+t0xBzDZIcxKVEq6YzPMg+fHcdvivpLi7slYqeUu9YO4EebPNIfp7g
	 Zls27AMPKhMH5+01p5RpHFXYRYEJh0dXFmN6zAXklLIISdt9h5J69Lh96Pps2ajzmP
	 Yzn7l/zRpUXq80cTJQzTm2qDKewAd9JC9zhRgZ2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392275AbfFMQZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbfFMIg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:36:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8932A2147A;
        Thu, 13 Jun 2019 08:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560414986;
        bh=9INB2P2iUkV83KaFw/Gx+3oZz2B6MAhwPwEHjvtXxvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2wVDZxat0S7CrJxZmRmRoYVWT7tDak3LRuZ1E5gxUVtFomndnwwKBDVxqd3BoCB8
         xacgMxwQXflitx/SS0exiIjBXPAaEuhyp2eTBSHnfM/Q7z+Ja7uQ/owpy0gYMT/fz4
         uC0quXkyVpPgfK05sURNS5JRZ98p4JXldudBxNww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Subject: [PATCH 4.14 37/81] blk-mq: move cancel of requeue_work into blk_mq_release
Date:   Thu, 13 Jun 2019 10:33:20 +0200
Message-Id: <20190613075652.080492893@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit fbc2a15e3433058582e5635aabe48a3011a644a8 ]

With holding queue's kobject refcount, it is safe for driver
to schedule requeue. However, blk_mq_kick_requeue_list() may
be called after blk_sync_queue() is done because of concurrent
requeue activities, then requeue work may not be completed when
freeing queue, and kernel oops is triggered.

So moving the cancel of requeue_work into blk_mq_release() for
avoiding race between requeue and freeing queue.

Cc: Dongli Zhang <dongli.zhang@oracle.com>
Cc: James Smart <james.smart@broadcom.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-scsi@vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen@oracle.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c | 1 -
 block/blk-mq.c   | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0b14aebfd1a8..4e04c79aa2c2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -339,7 +339,6 @@ void blk_sync_queue(struct request_queue *q)
 		struct blk_mq_hw_ctx *hctx;
 		int i;
 
-		cancel_delayed_work_sync(&q->requeue_work);
 		queue_for_each_hw_ctx(q, hctx, i)
 			cancel_delayed_work_sync(&hctx->run_work);
 	} else {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index eac444804736..55139d2fca3e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2294,6 +2294,8 @@ void blk_mq_release(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
+	cancel_delayed_work_sync(&q->requeue_work);
+
 	/* hctx kobj stays in hctx */
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx)
-- 
2.20.1



