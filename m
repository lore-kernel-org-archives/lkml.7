Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF140C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6FC20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfCGAD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:03:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39968 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfCGADa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:03:30 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h1gVJ-00086w-Bj; Thu, 07 Mar 2019 00:03:17 +0000
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
Subject: [PATCH 4/8] aio_poll(): get rid of weird refcounting
Date:   Thu,  7 Mar 2019 00:03:12 +0000
Message-Id: <20190307000316.31133-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The only reason for taking the extra ref to iocb is that we want
to access it after vfs_poll() and an early wakeup could have it
already completed by the time vfs_poll() returns.

That's very easy to avoid, though - we need to know which lock
to grab and, having grabbed it, we need to check if an early
wakeup has already happened.  So let's just copy the reference
to waitqueue into aio_poll_table and instead of having the
"woken" flag in iocb, move it to aio_poll() stack frame and
put its address into iocb (and make sure it's cleared, so
aio_poll_wake() won't step onto it after aio_poll() exits).

That's enough to get rid of the refcount.  In async case freeing
is done by aio_poll_complete() (and aio_poll() will only touch
the iocb past the vfs_poll() if it's guaranteed that aio_poll_complete()
has not happened yet), in all other cases we make sure that wakeups
hadn't and won't happen and deal with disposal of iocb ourselves.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 55 +++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 22b288997441..ee062253e303 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -180,8 +180,8 @@ struct fsync_iocb {
 struct poll_iocb {
 	struct file		*file;
 	struct wait_queue_head	*head;
+	bool			*taken;
 	__poll_t		events;
-	bool			woken;
 	bool			cancelled;
 	struct wait_queue_entry	wait;
 	struct work_struct	work;
@@ -209,8 +209,6 @@ struct aio_kiocb {
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
-	refcount_t		ki_refcnt;
-
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
 	 * this is the underlying eventfd context to deliver events to.
@@ -1034,7 +1032,6 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	percpu_ref_get(&ctx->reqs);
 	req->ki_ctx = ctx;
 	INIT_LIST_HEAD(&req->ki_list);
-	refcount_set(&req->ki_refcnt, 0);
 	req->ki_eventfd = NULL;
 	return req;
 }
@@ -1069,13 +1066,10 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 
 static inline void iocb_put(struct aio_kiocb *iocb)
 {
-	if (refcount_read(&iocb->ki_refcnt) == 0 ||
-	    refcount_dec_and_test(&iocb->ki_refcnt)) {
-		if (iocb->ki_filp)
-			fput(iocb->ki_filp);
-		percpu_ref_put(&iocb->ki_ctx->reqs);
-		kmem_cache_free(kiocb_cachep, iocb);
-	}
+	if (iocb->ki_filp)
+		fput(iocb->ki_filp);
+	percpu_ref_put(&iocb->ki_ctx->reqs);
+	kmem_cache_free(kiocb_cachep, iocb);
 }
 
 static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
@@ -1672,8 +1666,10 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	if (mask && !(mask & req->events))
 		return 0;
 
-	req->woken = true;
-
+	if (unlikely(req->taken)) {
+		*req->taken = true;
+		req->taken = NULL;
+	}
 	if (mask) {
 		/*
 		 * Try to complete the iocb inline if we can. Use
@@ -1698,6 +1694,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 struct aio_poll_table {
 	struct poll_table_struct	pt;
+	struct wait_queue_head		*head;
 	struct aio_kiocb		*iocb;
 	int				error;
 };
@@ -1715,7 +1712,7 @@ aio_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 	}
 
 	pt->error = 0;
-	pt->iocb->poll.head = head;
+	pt->head = pt->iocb->poll.head = head;
 	add_wait_queue(head, &pt->iocb->poll.wait);
 }
 
@@ -1738,7 +1735,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	req->events = demangle_poll(iocb->aio_buf) | EPOLLERR | EPOLLHUP;
 
 	req->head = NULL;
-	req->woken = false;
+	req->taken = &async;
 	req->cancelled = false;
 
 	apt.pt._qproc = aio_poll_queue_proc;
@@ -1750,36 +1747,38 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	INIT_LIST_HEAD(&req->wait.entry);
 	init_waitqueue_func_entry(&req->wait, aio_poll_wake);
 
-	/* one for removal from waitqueue, one for this function */
-	refcount_set(&aiocb->ki_refcnt, 2);
-
-	mask = vfs_poll(req->file, &apt.pt) & req->events;
-	if (unlikely(!req->head)) {
+	mask = req->events;
+	mask &= vfs_poll(req->file, &apt.pt);
+	/*
+	 * Careful: we might've been put into waitqueue *and* already
+	 * woken up before vfs_poll() returns.  The caller is holding
+	 * a reference to file, so it couldn't have been killed under
+	 * us, no matter what.  However, in case of early wakeup, @req
+	 * might be already gone by now.
+	 */
+	if (unlikely(!apt.head)) {
 		/* we did not manage to set up a waitqueue, done */
 		goto out;
 	}
-
 	spin_lock_irq(&ctx->ctx_lock);
-	spin_lock(&req->head->lock);
-	if (req->woken) { /* already taken up by aio_poll_wake() */
-		async = true;
+	spin_lock(&apt.head->lock);
+	if (async) { /* already taken up by aio_poll_wake() */
 		apt.error = 0;
 	} else if (!mask && !apt.error) { /* actually waiting for an event */
 		list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
 		aiocb->ki_cancel = aio_poll_cancel;
+		req->taken = NULL;
 		async = true;
 	} else { /* if we get an error or a mask we are done */
 		WARN_ON_ONCE(list_empty(&req->wait.entry));
 		list_del_init(&req->wait.entry);
 		/* no wakeup in the future either; aiocb is ours to dispose of */
 	}
-	spin_unlock(&req->head->lock);
+	spin_unlock(&apt.head->lock);
 	spin_unlock_irq(&ctx->ctx_lock);
-
 out:
-	if (async && !apt.error)
+	if (!async && !apt.error)
 		aio_poll_complete(aiocb, mask);
-	iocb_put(aiocb);
 	return apt.error;
 }
 
-- 
2.11.0

