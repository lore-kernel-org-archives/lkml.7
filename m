Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86DAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B2720657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369726;
	bh=pKNb7uard65pXCYf0qv+hJ2OEIG/OAhQ+qMJfUDW0G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XQ8AD+KGyztN+cjIJ10RjFdjFoHf6d2p/7NZsKp/VJjvchy+bm2rs1iE3vV9xbUjl
	 YLcy3KAOl0zF/w+tlKxZxaN0TsMNQTs2HESC2FxHUnmji5a8QlVLwOXjcFgCK8waDl
	 rCPFXV7SltePBptobk4Rp66MIDzYYZZmImzWcsZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbfDDJQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387808AbfDDJQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F2992054F;
        Thu,  4 Apr 2019 09:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369379;
        bh=pKNb7uard65pXCYf0qv+hJ2OEIG/OAhQ+qMJfUDW0G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XszFQLGfTfU/f+i8ETr1wI/Y17ARrHvStn9I9UKJrb6TIw8DoL1dmDRlobYS6dR/R
         d5nLBOUHnb5iPB/xAWQ6pxE7bbHV+CEd9p/jZTwvgsIqvbZNHrSnb4NInN2j+Ox14F
         NHcPnZjaFzS+vJ6iPrHLnxNlvVct/mP6oT28CiOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 186/246] block, bfq: fix in-service-queue check for queue merging
Date:   Thu,  4 Apr 2019 10:48:06 +0200
Message-Id: <20190404084625.695115719@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 058fdecc6de7cdecbf4c59b851e80eb2d6c5295f ]

When a new I/O request arrives for a bfq_queue, say Q, bfq checks
whether that request is close to
(a) the head request of some other queue waiting to be served, or
(b) the last request dispatched for the in-service queue (in case Q
itself is not the in-service queue)

If a queue, say Q2, is found for which the above condition holds, then
bfq merges Q and Q2, to hopefully get a more sequential I/O in the
resulting merged queue, and thus a possibly higher throughput.

Case (b) is checked by comparing the new request for Q with the last
request dispatched, assuming that the latter necessarily belonged to the
in-service queue. Unfortunately, this assumption is no longer always
correct, since commit d0edc2473be9 ("block, bfq: inject other-queue I/O
into seeky idle queues on NCQ flash").

When the assumption does not hold, queues that must not be merged may be
merged, causing unexpected loss of control on per-queue service
guarantees.

This commit solves this problem by adding an extra field, which stores
the actual last request dispatched for the in-service queue, and by
using this new field to correctly check case (b).

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 5 ++++-
 block/bfq-iosched.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index cd307767a134..f010810c095f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2224,7 +2224,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (in_service_bfqq && in_service_bfqq != bfqq &&
 	    likely(in_service_bfqq != &bfqd->oom_bfqq) &&
-	    bfq_rq_close_to_sector(io_struct, request, bfqd->last_position) &&
+	    bfq_rq_close_to_sector(io_struct, request,
+				   bfqd->in_serv_last_pos) &&
 	    bfqq->entity.parent == in_service_bfqq->entity.parent &&
 	    bfq_may_be_close_cooperator(bfqq, in_service_bfqq)) {
 		new_bfqq = bfq_setup_merge(bfqq, in_service_bfqq);
@@ -2764,6 +2765,8 @@ update_rate_and_reset:
 	bfq_update_rate_reset(bfqd, rq);
 update_last_values:
 	bfqd->last_position = blk_rq_pos(rq) + blk_rq_sectors(rq);
+	if (RQ_BFQQ(rq) == bfqd->in_service_queue)
+		bfqd->in_serv_last_pos = bfqd->last_position;
 	bfqd->last_dispatch = now_ns;
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 0b02bf302de0..746bd570b85a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -537,6 +537,9 @@ struct bfq_data {
 	/* on-disk position of the last served request */
 	sector_t last_position;
 
+	/* position of the last served request for the in-service queue */
+	sector_t in_serv_last_pos;
+
 	/* time of last request completion (ns) */
 	u64 last_completion;
 
-- 
2.19.1



