Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F49C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CBA20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122842;
	bh=e6HrPHm9mHRsCTtvzt4/Np6paexRy6vP8uDN+UsN+Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X1YMOxRh4ahBEjAMxXEWI+4FVxzybXH0eWNeMMpH6oj0BCPLN3hixy0JVrQ7u/HUu
	 +0e/bP0Py81t5s8/vMN+EmHJ63wCw5Ee5maxgPSIb8TBvoKfn2Xl7YHE0Tnr6VOle7
	 6cLxCHkoW3ylV7Na1HTnm+CvhB7Ir8SPXrGoJcoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391388AbfJCROB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391321AbfJCQ16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:27:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603D921783;
        Thu,  3 Oct 2019 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120076;
        bh=e6HrPHm9mHRsCTtvzt4/Np6paexRy6vP8uDN+UsN+Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=heM1vrjFLl5r+0XolW/cQV6RNqFAip9nYs+TQfEpeyN2FtM1jwgOR0SHyltd4UpEq
         NrCOkKXvYCsPJmNvmsUvrjMFM3et0LOpGCHXiwBtU82/S1GmI1V1SvTvGB+QT4M1Wn
         fb+NpdNKUpVlbUkCtr+evbk7JPVQIleEJD1R1I0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhengbin <zhengbin13@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 089/313] blk-mq: Fix memory leak in blk_mq_init_allocated_queue error handling
Date:   Thu,  3 Oct 2019 17:51:07 +0200
Message-Id: <20191003154541.637813090@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 73d9c8d4c0017e21e1ff519474ceb1450484dc9a ]

If blk_mq_init_allocated_queue->elevator_init_mq fails, need to release
the previously requested resources.

Fixes: d34849913819 ("blk-mq-sched: allow setting of default IO scheduler")
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 68106a41f90d2..f934e8afe5b43 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2853,6 +2853,8 @@ static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
+	int ret = -ENOMEM;
+
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
@@ -2914,17 +2916,18 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_map_swqueue(q);
 
 	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
-		int ret;
-
 		ret = elevator_init_mq(q);
 		if (ret)
-			return ERR_PTR(ret);
+			goto err_tag_set;
 	}
 
 	return q;
 
+err_tag_set:
+	blk_mq_del_queue_tag_set(q);
 err_hctxs:
 	kfree(q->queue_hw_ctx);
+	q->nr_hw_queues = 0;
 err_sys_init:
 	blk_mq_sysfs_deinit(q);
 err_poll:
-- 
2.20.1



