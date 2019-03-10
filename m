Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B3EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3633D207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfCJHKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:10:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35416 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfCJHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:10:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h2sa6-000354-Hz; Sun, 10 Mar 2019 07:09:21 +0000
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
Subject: [PATCH 3/8] aio: store event at final iocb_put()
Date:   Sun, 10 Mar 2019 07:08:17 +0000
Message-Id: <20190310070822.11564-3-viro@ZenIV.linux.org.uk>
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

Instead of having aio_complete() set ->ki_res.{res,res2}, do that
explicitly in its callers, drop the reference (as aio_complete()
used to do) and delay the rest until the final iocb_put().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 2249a7a1d6b3..b9c4c1894020 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1077,24 +1077,10 @@ static inline void iocb_destroy(struct aio_kiocb *iocb)
 	kmem_cache_free(kiocb_cachep, iocb);
 }
 
-static inline void iocb_put(struct aio_kiocb *iocb)
-{
-	if (refcount_dec_and_test(&iocb->ki_refcnt))
-		iocb_destroy(iocb);
-}
-
-static void aio_fill_event(struct io_event *ev, struct aio_kiocb *iocb,
-			   long res, long res2)
-{
-	iocb->ki_res.res = res;
-	iocb->ki_res.res2 = res2;
-	*ev = iocb->ki_res;
-}
-
 /* aio_complete
  *	Called when the io request on the given iocb is complete.
  */
-static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
+static void aio_complete(struct aio_kiocb *iocb)
 {
 	struct kioctx	*ctx = iocb->ki_ctx;
 	struct aio_ring	*ring;
@@ -1118,14 +1104,14 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	ev_page = kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 	event = ev_page + pos % AIO_EVENTS_PER_PAGE;
 
-	aio_fill_event(event, iocb, res, res2);
+	*event = iocb->ki_res;
 
 	kunmap_atomic(ev_page);
 	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
 
-	pr_debug("%p[%u]: %p: %p %Lx %lx %lx\n",
+	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n",
 		 ctx, tail, iocb, (void __user *)iocb->ki_res.obj, iocb->ki_res.data,
-		 res, res2);
+		 iocb->ki_res.res, iocb->ki_res.res2);
 
 	/* after flagging the request as done, we
 	 * must never even look at it again
@@ -1167,7 +1153,14 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 
 	if (waitqueue_active(&ctx->wait))
 		wake_up(&ctx->wait);
-	iocb_put(iocb);
+}
+
+static inline void iocb_put(struct aio_kiocb *iocb)
+{
+	if (refcount_dec_and_test(&iocb->ki_refcnt)) {
+		aio_complete(iocb);
+		iocb_destroy(iocb);
+	}
 }
 
 /* aio_read_events_ring
@@ -1441,7 +1434,9 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
 		file_end_write(kiocb->ki_filp);
 	}
 
-	aio_complete(iocb, res, res2);
+	iocb->ki_res.res = res;
+	iocb->ki_res.res2 = res2;
+	iocb_put(iocb);
 }
 
 static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
@@ -1589,11 +1584,10 @@ static ssize_t aio_write(struct kiocb *req, const struct iocb *iocb,
 
 static void aio_fsync_work(struct work_struct *work)
 {
-	struct fsync_iocb *req = container_of(work, struct fsync_iocb, work);
-	int ret;
+	struct aio_kiocb *iocb = container_of(work, struct aio_kiocb, fsync.work);
 
-	ret = vfs_fsync(req->file, req->datasync);
-	aio_complete(container_of(req, struct aio_kiocb, fsync), ret, 0);
+	iocb->ki_res.res = vfs_fsync(iocb->fsync.file, iocb->fsync.datasync);
+	iocb_put(iocb);
 }
 
 static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
@@ -1614,7 +1608,8 @@ static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
 
 static inline void aio_poll_complete(struct aio_kiocb *iocb, __poll_t mask)
 {
-	aio_complete(iocb, mangle_poll(mask), 0);
+	iocb->ki_res.res = mangle_poll(mask);
+	iocb_put(iocb);
 }
 
 static void aio_poll_complete_work(struct work_struct *work)
-- 
2.11.0

