Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2158C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA669207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfCJHJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:09:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35382 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfCJHJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:09:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h2sZj-00033E-Tc; Sun, 10 Mar 2019 07:08:59 +0000
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
Subject: [PATCH 2/8] keep io_event in aio_kiocb
Date:   Sun, 10 Mar 2019 07:08:16 +0000
Message-Id: <20190310070822.11564-2-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 56 +++++++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 363d7d7c8bff..2249a7a1d6b3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -204,8 +204,7 @@ struct aio_kiocb {
 	struct kioctx		*ki_ctx;
 	kiocb_cancel_fn		*ki_cancel;
 
-	struct iocb __user	*ki_user_iocb;	/* user's aiocb */
-	__u64			ki_user_data;	/* user's data for completion */
+	struct io_event		ki_res;
 
 	struct list_head	ki_list;	/* the aio core uses this
 						 * for cancellation */
@@ -1087,10 +1086,9 @@ static inline void iocb_put(struct aio_kiocb *iocb)
 static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
 			   long res, long res2)
 {
-	ev->obj = (u64)(unsigned long)iocb->ki_user_iocb;
-	ev->data = iocb->ki_user_data;
-	ev->res = res;
-	ev->res2 = res2;
+	iocb->ki_res.res = res;
+	iocb->ki_res.res2 = res2;
+	*ev = iocb->ki_res;
 }
 
 /* aio_complete
@@ -1126,7 +1124,7 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 
 	pr_debug("%p[%u]: %p: %p %Lx %lx %lx\n",
-		 ctx, tail, iocb, iocb->ki_user_iocb, iocb->ki_user_data,
+		 ctx, tail, iocb, (void __user *)iocb->ki_res.obj, iocb->ki_res.data,
 		 res, res2);
 
 	/* after flagging the request as done, we
@@ -1674,13 +1672,13 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	__poll_t mask = key_to_poll(key);
 	unsigned long flags;
 
+	/* for instances that support it check for an event match first: */
+	if (mask && !(mask & req->events))
+		return 0;
+
 	req->woken = true;
 
-	/* for instances that support it check for an event match first: */
 	if (mask) {
-		if (!(mask & req->events))
-			return 0;
-
 		/*
 		 * Try to complete the iocb inline if we can. Use
 		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
@@ -1844,8 +1842,10 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		goto out_put_req;
 	}
 
-	req->ki_user_iocb = user_iocb;
-	req->ki_user_data = iocb->aio_data;
+	req->ki_res.obj = (u64)(unsigned long)user_iocb;
+	req->ki_res.data = iocb->aio_data;
+	req->ki_res.res = 0;
+	req->ki_res.res2 = 0;
 
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
@@ -2002,24 +2002,6 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 }
 #endif
 
-/* lookup_kiocb
- *	Finds a given iocb for cancellation.
- */
-static struct aio_kiocb *
-lookup_kiocb(struct kioctx *ctx, struct iocb __user *iocb)
-{
-	struct aio_kiocb *kiocb;
-
-	assert_spin_locked(&ctx->ctx_lock);
-
-	/* TODO: use a hash or array, this sucks. */
-	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
-		if (kiocb->ki_user_iocb == iocb)
-			return kiocb;
-	}
-	return NULL;
-}
-
 /* sys_io_cancel:
  *	Attempts to cancel an iocb previously passed to io_submit.  If
  *	the operation is successfully cancelled, the resulting event is
@@ -2037,6 +2019,7 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 	struct aio_kiocb *kiocb;
 	int ret = -EINVAL;
 	u32 key;
+	u64 obj = (u64)(unsigned long)iocb;
 
 	if (unlikely(get_user(key, &iocb->aio_key)))
 		return -EFAULT;
@@ -2048,10 +2031,13 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->ctx_lock);
-	kiocb = lookup_kiocb(ctx, iocb);
-	if (kiocb) {
-		ret = kiocb->ki_cancel(&kiocb->rw);
-		list_del_init(&kiocb->ki_list);
+	/* TODO: use a hash or array, this sucks. */
+	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
+		if (kiocb->ki_res.obj == obj) {
+			ret = kiocb->ki_cancel(&kiocb->rw);
+			list_del_init(&kiocb->ki_list);
+			break;
+		}
 	}
 	spin_unlock_irq(&ctx->ctx_lock);
 
-- 
2.11.0

