Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54669C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AD4206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCGADg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:03:36 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40004 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfCGADf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:03:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h1gVJ-000874-He; Thu, 07 Mar 2019 00:03:17 +0000
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
Subject: [PATCH 6/8] move dropping ->ki_eventfd into iocb_put()
Date:   Thu,  7 Mar 2019 00:03:14 +0000
Message-Id: <20190307000316.31133-6-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5dd5f35d054c..5837a29e63fe 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1066,6 +1066,8 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 
 static inline void iocb_put(struct aio_kiocb *iocb)
 {
+	if (iocb->ki_eventfd)
+		eventfd_ctx_put(iocb->ki_eventfd);
 	if (iocb->ki_filp)
 		fput(iocb->ki_filp);
 	percpu_ref_put(&iocb->ki_ctx->reqs);
@@ -1142,10 +1144,8 @@ static void aio_complete(struct aio_kiocb *iocb, long res, long res2)
 	 * eventfd. The eventfd_signal() function is safe to be called
 	 * from IRQ context.
 	 */
-	if (iocb->ki_eventfd) {
+	if (iocb->ki_eventfd)
 		eventfd_signal(iocb->ki_eventfd, 1);
-		eventfd_ctx_put(iocb->ki_eventfd);
-	}
 
 	/*
 	 * We have to order our ring_info tail store above and test
@@ -1819,18 +1819,19 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		goto out_put_req;
 
 	if (iocb->aio_flags & IOCB_FLAG_RESFD) {
+		struct eventfd_ctx *eventfd;
 		/*
 		 * If the IOCB_FLAG_RESFD flag of aio_flags is set, get an
 		 * instance of the file* now. The file descriptor must be
 		 * an eventfd() fd, and will be signaled for each completed
 		 * event using the eventfd_signal() function.
 		 */
-		req->ki_eventfd = eventfd_ctx_fdget((int) iocb->aio_resfd);
-		if (IS_ERR(req->ki_eventfd)) {
-			ret = PTR_ERR(req->ki_eventfd);
-			req->ki_eventfd = NULL;
+		eventfd = eventfd_ctx_fdget((int) iocb->aio_resfd);
+		if (IS_ERR(eventfd)) {
+			ret = PTR_ERR(eventfd);
 			goto out_put_req;
 		}
+		req->ki_eventfd = eventfd;
 	}
 
 	ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
@@ -1881,8 +1882,6 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		goto out_put_req;
 	return 0;
 out_put_req:
-	if (req->ki_eventfd)
-		eventfd_ctx_put(req->ki_eventfd);
 	iocb_put(req);
 out_put_reqs_available:
 	put_reqs_available(ctx, 1);
-- 
2.11.0

