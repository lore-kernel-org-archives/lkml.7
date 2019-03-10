Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339D4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A72207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCJHMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:12:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35534 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfCJHMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:12:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h2sc1-0003D7-Dq; Sun, 10 Mar 2019 07:11:17 +0000
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
Subject: [PATCH 7/8] deal with get_reqs_available() in aio_get_req() itself
Date:   Sun, 10 Mar 2019 07:08:21 +0000
Message-Id: <20190310070822.11564-7-viro@ZenIV.linux.org.uk>
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

simplifies the caller

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 595c19965a8b..66ca52c57cca 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1033,6 +1033,11 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	if (unlikely(!req))
 		return NULL;
 
+	if (unlikely(!get_reqs_available(ctx))) {
+		kfree(req);
+		return NULL;
+	}
+
 	percpu_ref_get(&ctx->reqs);
 	req->ki_ctx = ctx;
 	INIT_LIST_HEAD(&req->ki_list);
@@ -1796,13 +1801,9 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 		return -EINVAL;
 	}
 
-	if (!get_reqs_available(ctx))
-		return -EAGAIN;
-
-	ret = -EAGAIN;
 	req = aio_get_req(ctx);
 	if (unlikely(!req))
-		goto out_put_reqs_available;
+		return -EAGAIN;
 
 	req->ki_filp = fget(iocb->aio_fildes);
 	ret = -EBADF;
@@ -1877,7 +1878,6 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 
 out_put_req:
 	iocb_destroy(req);
-out_put_reqs_available:
 	put_reqs_available(ctx, 1);
 	return ret;
 }
-- 
2.11.0

