Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74008C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B135206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfCJHMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:12:34 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35566 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfCJHMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:12:33 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h2scS-0003Ex-U4; Sun, 10 Mar 2019 07:11:45 +0000
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
Subject: [PATCH 8/8] aio: move sanity checks and request allocation to io_submit_one()
Date:   Sun, 10 Mar 2019 07:08:22 +0000
Message-Id: <20190310070822.11564-8-viro@ZenIV.linux.org.uk>
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

makes for somewhat cleaner control flow in __io_submit_one()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 119 ++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 53 insertions(+), 66 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 66ca52c57cca..2d1db52b1268 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1780,35 +1780,12 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-			   struct iocb __user *user_iocb, bool compat)
+			   struct iocb __user *user_iocb, struct aio_kiocb *req,
+			   bool compat)
 {
-	struct aio_kiocb *req;
-	int ret;
-
-	/* enforce forwards compatibility on users */
-	if (unlikely(iocb->aio_reserved2)) {
-		pr_debug("EINVAL: reserve field set\n");
-		return -EINVAL;
-	}
-
-	/* prevent overflows */
-	if (unlikely(
-	    (iocb->aio_buf != (unsigned long)iocb->aio_buf) ||
-	    (iocb->aio_nbytes != (size_t)iocb->aio_nbytes) ||
-	    ((ssize_t)iocb->aio_nbytes < 0)
-	   )) {
-		pr_debug("EINVAL: overflow check\n");
-		return -EINVAL;
-	}
-
-	req = aio_get_req(ctx);
-	if (unlikely(!req))
-		return -EAGAIN;
-
 	req->ki_filp = fget(iocb->aio_fildes);
-	ret = -EBADF;
 	if (unlikely(!req->ki_filp))
-		goto out_put_req;
+		return -EBADF;
 
 	if (iocb->aio_flags & IOCB_FLAG_RESFD) {
 		struct eventfd_ctx *eventfd;
@@ -1819,17 +1796,15 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		 * event using the eventfd_signal() function.
 		 */
 		eventfd = eventfd_ctx_fdget((int) iocb->aio_resfd);
-		if (IS_ERR(eventfd)) {
-			ret = PTR_ERR(eventfd);
-			goto out_put_req;
-		}
+		if (IS_ERR(eventfd))
+			return PTR_ERR(req->ki_eventfd);
+
 		req->ki_eventfd = eventfd;
 	}
 
-	ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
-	if (unlikely(ret)) {
+	if (unlikely(put_user(KIOCB_KEY, &user_iocb->aio_key))) {
 		pr_debug("EFAULT: aio_key\n");
-		goto out_put_req;
+		return -EFAULT;
 	}
 
 	req->ki_res.obj = (u64)(unsigned long)user_iocb;
@@ -1839,58 +1814,70 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = aio_read(&req->rw, iocb, false, compat);
-		break;
+		return aio_read(&req->rw, iocb, false, compat);
 	case IOCB_CMD_PWRITE:
-		ret = aio_write(&req->rw, iocb, false, compat);
-		break;
+		return aio_write(&req->rw, iocb, false, compat);
 	case IOCB_CMD_PREADV:
-		ret = aio_read(&req->rw, iocb, true, compat);
-		break;
+		return aio_read(&req->rw, iocb, true, compat);
 	case IOCB_CMD_PWRITEV:
-		ret = aio_write(&req->rw, iocb, true, compat);
-		break;
+		return aio_write(&req->rw, iocb, true, compat);
 	case IOCB_CMD_FSYNC:
-		ret = aio_fsync(&req->fsync, iocb, false);
-		break;
+		return aio_fsync(&req->fsync, iocb, false);
 	case IOCB_CMD_FDSYNC:
-		ret = aio_fsync(&req->fsync, iocb, true);
-		break;
+		return aio_fsync(&req->fsync, iocb, true);
 	case IOCB_CMD_POLL:
-		ret = aio_poll(req, iocb);
-		break;
+		return aio_poll(req, iocb);
 	default:
 		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);
-		ret = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	/* Done with the synchronous reference */
-	iocb_put(req);
-
-	/*
-	 * If ret is 0, we'd either done aio_complete() ourselves or have
-	 * arranged for that to be done asynchronously.  Anything non-zero
-	 * means that we need to destroy req ourselves.
-	 */
-	if (!ret)
-		return 0;
-
-out_put_req:
-	iocb_destroy(req);
-	put_reqs_available(ctx, 1);
-	return ret;
 }
 
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 bool compat)
 {
+	struct aio_kiocb *req;
 	struct iocb iocb;
+	int err;
 
 	if (unlikely(copy_from_user(&iocb, user_iocb, sizeof(iocb))))
 		return -EFAULT;
 
-	return __io_submit_one(ctx, &iocb, user_iocb, compat);
+	/* enforce forwards compatibility on users */
+	if (unlikely(iocb.aio_reserved2)) {
+		pr_debug("EINVAL: reserve field set\n");
+		return -EINVAL;
+	}
+
+	/* prevent overflows */
+	if (unlikely(
+	    (iocb.aio_buf != (unsigned long)iocb.aio_buf) ||
+	    (iocb.aio_nbytes != (size_t)iocb.aio_nbytes) ||
+	    ((ssize_t)iocb.aio_nbytes < 0)
+	   )) {
+		pr_debug("EINVAL: overflow check\n");
+		return -EINVAL;
+	}
+
+	req = aio_get_req(ctx);
+	if (unlikely(!req))
+		return -EAGAIN;
+
+	err = __io_submit_one(ctx, &iocb, user_iocb, req, compat);
+
+	/* Done with the synchronous reference */
+	iocb_put(req);
+
+	/*
+	 * If err is 0, we'd either done aio_complete() ourselves or have
+	 * arranged for that to be done asynchronously.  Anything non-zero
+	 * means that we need to destroy req ourselves.
+	 */
+	if (unlikely(err)) {
+		iocb_destroy(req);
+		put_reqs_available(ctx, 1);
+	}
+	return err;
 }
 
 /* sys_io_submit:
-- 
2.11.0

