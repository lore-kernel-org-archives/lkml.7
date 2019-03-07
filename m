Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE25C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7230120663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbfCGADc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:03:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39972 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfCGAD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:03:29 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h1gVJ-00087C-N4; Thu, 07 Mar 2019 00:03:17 +0000
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
Date:   Thu,  7 Mar 2019 00:03:16 +0000
Message-Id: <20190307000316.31133-8-viro@ZenIV.linux.org.uk>
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

makes for somewhat cleaner control flow in __io_submit_one()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 86 +++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index af51b1360305..6993581b77b2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1788,36 +1788,15 @@ static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-			   struct iocb __user *user_iocb, bool compat)
+			   struct iocb __user *user_iocb, struct aio_kiocb *req,
+			   bool compat)
 {
-	struct aio_kiocb *req;
 	struct file *file;
 	int ret;
 
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
@@ -1828,17 +1807,15 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
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
 
 	req->ki_user_iocb = user_iocb;
@@ -1873,30 +1850,51 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		break;
 	}
 	fput(file);
-
-	/*
-	 * If ret is 0, we'd either done aio_complete() ourselves or have
-	 * arranged for that to be done asynchronously.  Anything non-zero
-	 * means that we need to destroy req ourselves.
-	 */
-	if (ret)
-		goto out_put_req;
-	return 0;
-out_put_req:
-	iocb_put(req);
-	put_reqs_available(ctx, 1);
 	return ret;
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
+	/*
+	 * If err is 0, we'd either done aio_complete() ourselves or have
+	 * arranged for that to be done asynchronously.  Anything non-zero
+	 * means that we need to destroy req ourselves.
+	 */
+	if (unlikely(err)) {
+		iocb_put(req);
+		put_reqs_available(ctx, 1);
+	}
+	return err;
 }
 
 /* sys_io_submit:
-- 
2.11.0

