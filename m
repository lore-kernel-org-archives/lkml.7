Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603BDC46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CEC2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154853;
	bh=jxET2lkC8axXa57NGv2c8LLSq54+oEHQi4BAnWts6Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WvQFU6f5qBVaTil1tD/aid4KJfU5mtu4BDTrEe8jsB+20oc50Tl3p4DQfHL1E1Ski
	 gpes5Ve7qHwKXwIAaO50n8riPW5KuVeUl9y0Qw11qaVjlO5HK1xNdfn87YY6s4vG58
	 gOVzMYj7MP1hHY9l9rsblOeZp1/yCGVUIm335Xtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfEFOl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbfEFOly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:41:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CEAC21019;
        Mon,  6 May 2019 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153713;
        bh=jxET2lkC8axXa57NGv2c8LLSq54+oEHQi4BAnWts6Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fuZXM7gLylJZnNholcJIFNCAS70XQnWfe5JCD22Ugy62Ji9v30SctKgRPHef7PlpU
         /qyHoquk2zH4xIdnuVAyeoTiz5x2Nv6LbKutyXadDEfFP/qrl+R7wTLX9d34veNOVH
         pHJStEykRtivmFT9vUa7m912RjLQE3JxK6NAEV8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>,
        syzbot <syzbot+ba2a929dcf8e704c180e@syzkaller.appspotmail.com>
Subject: [PATCH 4.19 69/99] block: pass no-op callback to INIT_WORK().
Date:   Mon,  6 May 2019 16:32:42 +0200
Message-Id: <20190506143100.414365876@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2e3c18d0ada16f145087b2687afcad1748c0827c ]

syzbot is hitting flush_work() warning caused by commit 4d43d395fed12463
("workqueue: Try to catch flush_work() without INIT_WORK().") [1].
Although that commit did not expect INIT_WORK(NULL) case, calling
flush_work() without setting a valid callback should be avoided anyway.
Fix this problem by setting a no-op callback instead of NULL.

[1] https://syzkaller.appspot.com/bug?id=e390366bc48bc82a7c668326e0663be3b91cbd29

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-and-tested-by: syzbot <syzbot+ba2a929dcf8e704c180e@syzkaller.appspotmail.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[sl: rename blk_timeout_work]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index eb8b52241453..33488b1426b7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -980,6 +980,10 @@ static void blk_rq_timed_out_timer(struct timer_list *t)
 	kblockd_schedule_work(&q->timeout_work);
 }
 
+static void blk_timeout_work_dummy(struct work_struct *work)
+{
+}
+
 /**
  * blk_alloc_queue_node - allocate a request queue
  * @gfp_mask: memory allocation flags
@@ -1034,7 +1038,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 	timer_setup(&q->backing_dev_info->laptop_mode_wb_timer,
 		    laptop_mode_timer_fn, 0);
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
-	INIT_WORK(&q->timeout_work, NULL);
+	INIT_WORK(&q->timeout_work, blk_timeout_work_dummy);
 	INIT_LIST_HEAD(&q->timeout_list);
 	INIT_LIST_HEAD(&q->icq_list);
 #ifdef CONFIG_BLK_CGROUP
-- 
2.20.1



