Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FBAC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88DC2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfCKT6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:58:55 -0400
Received: from verein.lst.de ([213.95.11.211]:43316 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728881AbfCKT6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E268968C7B; Mon, 11 Mar 2019 20:58:31 +0100 (CET)
Date:   Mon, 11 Mar 2019 20:58:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
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
Subject: Re: [PATCH 4/8] Fix aio_poll() races
Message-ID: <20190311195831.GA12807@lst.de>
References: <20190310070606.GA10138@ZenIV.linux.org.uk> <20190310070822.11564-1-viro@ZenIV.linux.org.uk> <20190310070822.11564-4-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310070822.11564-4-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where do we put the second iocb reference in case we return from
vfs_poll without ever being woken?

Also it seems like the complete code would still benefit from a little
helper, something like:

diff --git a/fs/aio.c b/fs/aio.c
index b2a5c7b3a1fe..8415e5e484ce 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1611,6 +1611,13 @@ static int aio_fsync(struct fsync_iocb *req, const struct iocb *iocb,
 	return 0;
 }
 
+static void aio_poll_finish(struct aio_kiocb *iocb, __poll_t mask)
+{
+	list_del_init(&iocb->ki_list);
+	iocb->ki_res.res = mangle_poll(mask);
+	iocb->poll.done = true;
+}
+
 static void aio_poll_complete_work(struct work_struct *work)
 {
 	struct poll_iocb *req = container_of(work, struct poll_iocb, work);
@@ -1635,9 +1642,7 @@ static void aio_poll_complete_work(struct work_struct *work)
 		spin_unlock_irq(&ctx->ctx_lock);
 		return;
 	}
-	list_del_init(&iocb->ki_list);
-	iocb->ki_res.res = mangle_poll(mask);
-	req->done = true;
+	aio_poll_finish(iocb, mask);
 	spin_unlock_irq(&ctx->ctx_lock);
 
 	iocb_put(iocb);
@@ -1674,24 +1679,20 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	list_del_init(&req->wait.entry);
 
-	if (mask) {
+	if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
 		/*
 		 * Try to complete the iocb inline if we can. Use
 		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
 		 * call this function with IRQs disabled and because IRQs
 		 * have to be disabled before ctx_lock is obtained.
 		 */
-		if (spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
-			list_del(&iocb->ki_list);
-			iocb->ki_res.res = mangle_poll(mask);
-			req->done = true;
-			spin_unlock_irqrestore(&iocb->ki_ctx->ctx_lock, flags);
-			iocb_put(iocb);
-			return 1;
-		}
+		aio_poll_finish(iocb, mask);
+		spin_unlock_irqrestore(&iocb->ki_ctx->ctx_lock, flags);
+		iocb_put(iocb);
+	} else {
+		schedule_work(&req->work);
 	}
 
-	schedule_work(&req->work);
 	return 1;
 }
 
