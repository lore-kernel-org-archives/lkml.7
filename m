Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19872206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCGADa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:03:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39962 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCGAD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:03:29 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h1gVJ-00086s-8T; Thu, 07 Mar 2019 00:03:17 +0000
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
Subject: [PATCH 3/8] aio_poll(): sanitize the logics after vfs_poll(), get rid of leak on error
Date:   Thu,  7 Mar 2019 00:03:11 +0000
Message-Id: <20190307000316.31133-3-viro@ZenIV.linux.org.uk>
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

We want iocb_put() happening on errors, to balance the extra reference
we'd taken.  As it is, we end up with a leak.  The rules should be
	* error: iocb_put() to deal with the extra ref, return error,
let the caller do another iocb_put().
	* async: iocb_put() to deal with the extra ref, return 0.
	* no error, event present immediately: aio_poll_complete() to
report it, iocb_put() to deal with the extra ref, return 0.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 3a8b894378e0..22b288997441 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1724,6 +1724,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	struct kioctx *ctx = aiocb->ki_ctx;
 	struct poll_iocb *req = &aiocb->poll;
 	struct aio_poll_table apt;
+	bool async = false;
 	__poll_t mask;
 
 	/* reject any unknown events outside the normal event mask. */
@@ -1760,30 +1761,26 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
 	spin_lock_irq(&ctx->ctx_lock);
 	spin_lock(&req->head->lock);
-	if (req->woken) {
-		/* wake_up context handles the rest */
-		mask = 0;
+	if (req->woken) { /* already taken up by aio_poll_wake() */
+		async = true;
 		apt.error = 0;
-	} else if (mask || apt.error) {
-		/* if we get an error or a mask we are done */
-		WARN_ON_ONCE(list_empty(&req->wait.entry));
-		list_del_init(&req->wait.entry);
-	} else {
-		/* actually waiting for an event */
+	} else if (!mask && !apt.error) { /* actually waiting for an event */
 		list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
 		aiocb->ki_cancel = aio_poll_cancel;
+		async = true;
+	} else { /* if we get an error or a mask we are done */
+		WARN_ON_ONCE(list_empty(&req->wait.entry));
+		list_del_init(&req->wait.entry);
+		/* no wakeup in the future either; aiocb is ours to dispose of */
 	}
 	spin_unlock(&req->head->lock);
 	spin_unlock_irq(&ctx->ctx_lock);
 
 out:
-	if (unlikely(apt.error))
-		return apt.error;
-
-	if (mask)
+	if (async && !apt.error)
 		aio_poll_complete(aiocb, mask);
 	iocb_put(aiocb);
-	return 0;
+	return apt.error;
 }
 
 static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
-- 
2.11.0

