Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9521DC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651FC20836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 15:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCCPS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 10:18:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34792 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCCPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 10:18:59 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h0St5-0002nQ-3n; Sun, 03 Mar 2019 15:18:47 +0000
Date:   Sun, 3 Mar 2019 15:18:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     davem@davemloft.net, jbaron@akamai.com, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com, hch@lst.de
Subject: [PATCH] aio: prevent the final fput() in the middle of vfs_poll()
 (Re: KASAN: use-after-free Read in unix_dgram_poll)
Message-ID: <20190303151846.GQ2217@ZenIV.linux.org.uk>
References: <000000000000f39c7b05832e0219@google.com>
 <20190303135502.GP2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303135502.GP2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 01:55:02PM +0000, Al Viro wrote:

> Maybe unrelated to this bug, but...  What's to prevent a wakeup
> that happens just after we'd been added to a waitqueue by ->poll()
> triggering aio_poll_wake(), which gets to aio_poll_complete()
> with its fput() *before* we'd reached the end of ->poll() instance?
> 
> I wonder if adding
> 	get_file(req->file);  // make sure that early completion is safe
> right after
>         req->file = fget(iocb->aio_fildes);
>         if (unlikely(!req->file))
>                 return -EBADF;
> paired with
> 	fput(req->file);
> right after out: in aio_poll() is needed...  Am I missing something
> obvious here?  Christoph?

In more details - normally IOCB_CMD_POLL handling looks so:

1) io_submit(2) allocates aio_kiocb instance and passes it to aio_poll()
2) aio_poll() resolves the descriptor to struct file by
	req->file = fget(iocb->aio_fildes)
3) aio_poll() sets ->woken to false and raises ->ki_refcnt of that
aio_kiocb to 2 (bumps by 1, that is).
4) aio_poll() calls vfs_poll().  After sanity checks (basically, "poll_wait()
had been called and only once") it locks the queue.  That's what the extra
reference to iocb had been for - we know we can safely access it.
5) With queue locked, we check if ->woken has already been set to true
(by aio_poll_wake()) and, if it had been, we unlock the queue, drop
a reference to aio_kiocb and bugger off - at that point it's
a responsibility to aio_poll_wake() and the stuff called/scheduled by
it.  That code will drop the reference to file in req->file, along
with the other reference to our aio_kiocb.
6) otherwise, we see whether we need to wait.  If we do, we unlock
the queue, drop one reference to aio_kiocb and go away - eventual
wakeup (or cancel) will deal with the reference to file and with the
other reference to aio_kiocb
7) otherwise we remove ourselves from waitqueue (still under the queue
lock), so that wakeup won't get us.  No async activity will be happening,
so we can safely drop req->file and iocb ourselves.

If wakeup happens while we are in vfs_poll(), we are fine - aio_kiocb
won't get freed under us, so we can do all the checks and locking safely.
And we don't touch ->file if we detect that case.

However, vfs_poll() most certainly *does* touch the file it had been
given.  So wakeup coming while we are still in ->poll() might end up
doing fput() on that file.  That case is not too rare, and usually
we are saved by the still present reference from descriptor table -
that fput() is not the final one.  But if another thread closes that
descriptor right after our fget() and wakeup does happen before
->poll() returns, we are in trouble - final fput() done while we
are in the middle of a method.

What we need is to hold on to the file reference the same way we do with
aio_kiocb.  No need to store the reference to what we'd got in a separate
variable - req->file is never reassigned and we'd already made sure that
req won't be freed under us, so dropping the extra reference with
fput(req->file) is fine in all cases.

Fixes: bfe4037e722ec
Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/aio.c b/fs/aio.c
index 3083180a54c8..7e88bfabdac2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1767,6 +1767,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 
 	/* one for removal from waitqueue, one for this function */
 	refcount_set(&aiocb->ki_refcnt, 2);
+	get_file(req->file);
 
 	mask = vfs_poll(req->file, &apt.pt) & req->events;
 	if (unlikely(!req->head)) {
@@ -1793,6 +1794,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 	spin_unlock_irq(&ctx->ctx_lock);
 
 out:
+	fput(req->file);
 	if (unlikely(apt.error)) {
 		fput(req->file);
 		return apt.error;
