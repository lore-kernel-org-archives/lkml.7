Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93843C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D973207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCJHKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:10:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35442 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfCJHKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:10:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h2sai-00037R-4R; Sun, 10 Mar 2019 07:09:59 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        zhengbin <zhengbin13@huawei.com>, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        houtao1@huawei.com, yi.zhang@huawei.com
Subject: [PATCH 4/8] Fix aio_poll() races
Date:   Sun, 10 Mar 2019 07:08:18 +0000
Message-Id: <20190310070822.11564-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310070822.11564-1-viro@ZenIV.linux.org.uk>
References: <20190310070606.GA10138@ZenIV.linux.org.uk>
 <20190310070822.11564-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

aio_poll() has to cope with several unpleasant problems:
	* requests that might stay around indefinitely need to
be made visible for io_cancel(2); that must not be done to
a request already completed, though.
	* in cases when ->poll() has placed us on a waitqueue,
wakeup might have happened (and request completed) before ->poll()
returns.
	* worse, in some early wakeup cases request might end
up re-added into the queue later - we can't treat "woken up and
currently not in the queue" as "it's not going to stick around
indefinitely"
	* ... moreover, ->poll() might have decided not to
put it on any queues to start with, and that needs to be distinguished
from the previous case
	* ->poll() might have tried to put us on more than one queue.
Only the first will succeed for aio poll, so we might end up missing
wakeups.  OTOH, we might very well notice that only after the
wakeup hits and request gets completed (all before ->poll() gets
around to the second poll_wait()).  In that case it's too late to
decide that we have an error.

req->woken was an attempt to deal with that.  Unfortunately, it was
broken.  What we need to keep track of is not that wakeup has happened -
the thing might come back after that.  It's that async reference is
already gone and won't come back, so we can't (and needn't) put the
request on the list of cancellables.

The easiest case is "request hadn't been put on any waitqueues"; we
can tell by seeing NULL apt.head, and in that case there won't be
anything async.  We should either complete the request ourselves
(if vfs_poll() reports anything of interest) or return an error.

In all other cases we get exclusion with wakeups by grabbing the
queue lock.

If request is currently on queue and we have something interesting
from vfs_poll(), we can steal it and complete the request ourselves.

If it's on queue and vfs_poll() has not reported anything interesting,
we either put it on the cancellable list, or, if we know that it
hadn't been put on all queues ->poll() wanted it on, we steal it and
return an error.

If it's _not_ on queue, it's either been already dealt with (in which
case we do nothing), or there's aio_poll_complete_work() about to be
executed.  In that case we either put it on the cancellable list,
or, if we know it hadn't been put on all queues ->poll() wanted it on,
simulate what cancel would've done.

It's a lot more convoluted than I'd like it to be.  Single-consumer APIs
suck, and unfortunately aio is not an exception...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 71 +++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index b9c4c1894020..f47a29f7f201 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -181,7 +181,7 @@ struct poll_iocb {
 	struct file		*file;
 	struct wait_queue_head	*head;
 	__poll_t		events;
-	bool			woken;
+	bool			done;
 	bool			cancelled;
 	struct wait_queue_entry	wait;
 	struct work_struct	work;
@@ -1606,12 +1606,6 @@ static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
 	return 0;
 }
 
-static inline void aio_poll_complete(struct aio_kiocb *iocb, __poll_t mask)
-{
-	iocb->ki_res.res = mangle_poll(mask);
-	iocb_put(iocb);
-}
-
 static void aio_poll_complete_work(struct work_struct *work)
 {
 	struct poll_iocb *req = container_of(work, struct poll_iocb, work);
@@ -1637,9 +1631,11 @@ static void aio_poll_complete_work(struct work_struct *work)
 		return;
 	}
 	list_del_init(&iocb->ki_list);
+	iocb->ki_res.res = mangle_poll(mask);
+	req->done = true;
 	spin_unlock_irq(&ctx->ctx_lock);
 
-	aio_poll_complete(iocb, mask);
+	iocb_put(iocb);
 }
 
 /* assumes we are called with irqs disabled */
@@ -1671,7 +1667,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	if (mask && !(mask & req->events))
 		return 0;
 
-	req->woken = true;
+	list_del_init(&req->wait.entry);
 
 	if (mask) {
 		/*
@@ -1682,15 +1678,14 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		 */
 		if (spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
 			list_del(&iocb->ki_list);
+			iocb->ki_res.res = mangle_poll(mask);
+			req->done = true;
 			spin_unlock_irqrestore(&iocb->ki_ctx->ctx_lock, flags);
-
-			list_del_init(&req->wait.entry);
-			aio_poll_complete(iocb, mask);
+			iocb_put(iocb);
 			return 1;
 		}
 	}
 
-	list_del_init(&req->wait.entry);
 	schedule_work(&req->work);
 	return 1;
 }
@@ -1723,6 +1718,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	struct kioctx *ctx = aiocb->ki_ctx;
 	struct poll_iocb *req = &aiocb->poll;
 	struct aio_poll_table apt;
+	bool cancel = false;
 	__poll_t mask;
 
 	/* reject any unknown events outside the normal event mask. */
@@ -1736,7 +1732,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	req->events = demangle_poll(iocb->aio_buf) | EPOLLERR | EPOLLHUP;
 
 	req->head = NULL;
-	req->woken = false;
+	req->done = false;
 	req->cancelled = false;
 
 	apt.pt._qproc = aio_poll_queue_proc;
@@ -1749,36 +1745,33 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	init_waitqueue_func_entry(&req->wait, aio_poll_wake);
 
 	mask = vfs_poll(req->file, &apt.pt) & req->events;
-	if (unlikely(!req->head)) {
-		/* we did not manage to set up a waitqueue, done */
-		goto out;
-	}
-
 	spin_lock_irq(&ctx->ctx_lock);
-	spin_lock(&req->head->lock);
-	if (req->woken) {
-		/* wake_up context handles the rest */
-		mask = 0;
+	if (likely(req->head)) {
+		spin_lock(&req->head->lock);
+		if (unlikely(list_empty(&req->wait.entry))) {
+			if (apt.error)
+				cancel = true;
+			apt.error = 0;
+			mask = 0;
+		}
+		if (mask || apt.error) {
+			list_del_init(&req->wait.entry);
+		} else if (cancel) {
+			WRITE_ONCE(req->cancelled, true);
+		} else if (!req->done) { /* actually waiting for an event */
+			list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
+			aiocb->ki_cancel = aio_poll_cancel;
+		}
+		spin_unlock(&req->head->lock);
+	}
+	if (mask) { /* no async, we'd stolen it */
+		aiocb->ki_res.res = mangle_poll(mask);
 		apt.error = 0;
-	} else if (mask || apt.error) {
-		/* if we get an error or a mask we are done */
-		WARN_ON_ONCE(list_empty(&req->wait.entry));
-		list_del_init(&req->wait.entry);
-	} else {
-		/* actually waiting for an event */
-		list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
-		aiocb->ki_cancel = aio_poll_cancel;
 	}
-	spin_unlock(&req->head->lock);
 	spin_unlock_irq(&ctx->ctx_lock);
-
-out:
-	if (unlikely(apt.error))
-		return apt.error;
-
 	if (mask)
-		aio_poll_complete(aiocb, mask);
-	return 0;
+		iocb_put(aiocb);
+	return apt.error;
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-- 
2.11.0

