Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DAB207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfCJHJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:09:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35358 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfCJHJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:09:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h2sZK-000318-AA; Sun, 10 Mar 2019 07:08:29 +0000
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
Subject: [PATCH 1/8] pin iocb through aio.
Date:   Sun, 10 Mar 2019 07:08:15 +0000
Message-Id: <20190310070822.11564-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190310070606.GA10138@ZenIV.linux.org.uk>
References: <20190310070606.GA10138@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

aio_poll() is not the only case that needs file pinned; worse, while
aio_read()/aio_write() can live without pinning iocb itself, the
proof is rather brittle and can easily break on later changes.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3d9669d011b9..363d7d7c8bff 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1022,6 +1022,9 @@ static bool get_reqs_available(struct kioctx *ctx)
 /* aio_get_req
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
+ *
+ * The refcount is initialized to 2 - one for the async op completion,
+ * one for the synchronous code that does this.
  */
 static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 {
@@ -1034,7 +1037,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	percpu_ref_get(&ctx->reqs);
 	req->ki_ctx = ctx;
 	INIT_LIST_HEAD(&req->ki_list);
-	refcount_set(&req->ki_refcnt, 0);
+	refcount_set(&req->ki_refcnt, 2);
 	req->ki_eventfd = NULL;
 	return req;
 }
@@ -1067,15 +1070,18 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	return ret;
 }
 
+static inline void iocb_destroy(struct aio_kiocb *iocb)
+{
+	if (iocb->ki_filp)
+		fput(iocb->ki_filp);
+	percpu_ref_put(&iocb->ki_ctx->reqs);
+	kmem_cache_free(kiocb_cachep, iocb);
+}
+
 static inline void iocb_put(struct aio_kiocb *iocb)
 {
-	if (refcount_read(&iocb->ki_refcnt) == 0 ||
-	    refcount_dec_and_test(&iocb->ki_refcnt)) {
-		if (iocb->ki_filp)
-			fput(iocb->ki_filp);
-		percpu_ref_put(&iocb->ki_ctx->reqs);
-		kmem_cache_free(kiocb_cachep, iocb);
-	}
+	if (refcount_dec_and_test(&iocb->ki_refcnt))
+		iocb_destroy(iocb);
 }
 
 static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
@@ -1749,9 +1755,6 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	INIT_LIST_HEAD(&req->wait.entry);
 	init_waitqueue_func_entry(&req->wait, aio_poll_wake);
 
-	/* one for removal from waitqueue, one for this function */
-	refcount_set(&aiocb->ki_refcnt, 2);
-
 	mask = vfs_poll(req->file, &apt.pt) & req->events;
 	if (unlikely(!req->head)) {
 		/* we did not manage to set up a waitqueue, done */
@@ -1782,7 +1785,6 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
 	if (mask)
 		aio_poll_complete(aiocb, mask);
-	iocb_put(aiocb);
 	return 0;
 }
 
@@ -1873,18 +1875,21 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		break;
 	}
 
+	/* Done with the synchronous reference */
+	iocb_put(req);
+
 	/*
 	 * If ret is 0, we'd either done aio_complete() ourselves or have
 	 * arranged for that to be done asynchronously.  Anything non-zero
 	 * means that we need to destroy req ourselves.
 	 */
-	if (ret)
-		goto out_put_req;
-	return 0;
+	if (!ret)
+		return 0;
+
 out_put_req:
 	if (req->ki_eventfd)
 		eventfd_ctx_put(req->ki_eventfd);
-	iocb_put(req);
+	iocb_destroy(req);
 out_put_reqs_available:
 	put_reqs_available(ctx, 1);
 	return ret;
-- 
2.11.0

