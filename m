Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5B2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D902070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570122159;
	bh=PXGyuAPnXiAbwagSHmuY/DyLAwPdHDjmxWdSWUh6/3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pdgJjpVYJjPuJUhuKkYT/MwYGyoHyxrOsGgAfsLLwdxkHH6oy1xg/xiAOP+APkPuL
	 ti0pYJyYUxNdooT3/i2B8O1Uw2/ToWjGB2bv18vtgVo91lLqq12Z6Hut/fGulIxO3X
	 FvktkVJ2yDGmZm+6+FKvRiCmYpcJpxkJgCPj2Fws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405797AbfJCRCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405084AbfJCQmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:42:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02773206BB;
        Thu,  3 Oct 2019 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120963;
        bh=PXGyuAPnXiAbwagSHmuY/DyLAwPdHDjmxWdSWUh6/3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6OwT2cn7ugn1w/TJNks+G+mzZ+/cp75FBOJrzvTJ1sv+tJybO+mytow1G5LfUcXV
         273TEMf0o8StaUDe+bVIwidQ3QdDhv51P6cPj4xbImM8VM5+vVNnyQgPKOhgpsytau
         L64Y42excqif5S1NjZYiiVfi/tV6T9ve0+KXCdOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhengbin <zhengbin13@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 102/344] blk-mq: Fix memory leak in blk_mq_init_allocated_queue error handling
Date:   Thu,  3 Oct 2019 17:51:07 +0200
Message-Id: <20191003154550.266019544@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
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
index 0835f4d8d42e7..a38ebb2a380c2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2841,6 +2841,8 @@ static unsigned int nr_hw_queues(struct blk_mq_tag_set *set)
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
+	int ret = -ENOMEM;
+
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
@@ -2902,17 +2904,18 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
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



