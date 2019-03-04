Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E15C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146AA20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfCDCgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:36:35 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:43660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCDCgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:36:35 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h0dSk-00032K-A5; Mon, 04 Mar 2019 02:36:18 +0000
Date:   Mon, 4 Mar 2019 02:36:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] aio: prevent the final fput() in the middle of
 vfs_poll() (Re: KASAN: use-after-free Read in unix_dgram_poll)
Message-ID: <20190304023618.GS2217@ZenIV.linux.org.uk>
References: <000000000000f39c7b05832e0219@google.com>
 <20190303135502.GP2217@ZenIV.linux.org.uk>
 <20190303151846.GQ2217@ZenIV.linux.org.uk>
 <CAHk-=wiQ2YNB+2FT+jbdcC6qfYqvS2kLLAZbmPE_7sLfUPwFJg@mail.gmail.com>
 <20190303203011.GR2217@ZenIV.linux.org.uk>
 <CAHk-=widuz9QBY-Xhpc1YHf=EV1uRGyOv-v-BNSa1zW-nCCC6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=widuz9QBY-Xhpc1YHf=EV1uRGyOv-v-BNSa1zW-nCCC6Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 02:23:33PM -0800, Linus Torvalds wrote:

OK, having dug through the archives, the reasons were not strong.
So that part is OK...

> @@ -1060,6 +1071,8 @@ static inline void iocb_put(struct aio_kiocb *iocb)
>  {
>  	if (refcount_read(&iocb->ki_refcnt) == 0 ||
>  	    refcount_dec_and_test(&iocb->ki_refcnt)) {
> +		if (iocb->ki_filp)
> +			fput(iocb->ki_filp);
>  		percpu_ref_put(&iocb->ki_ctx->reqs);
>  		kmem_cache_free(kiocb_cachep, iocb);
>  	}

That reminds me - refcount_t here is rather ridiculous; what we
have is
	* everything other than aio_poll: ki_refcnt is 0 all along
	* aio_poll: originally 0, then set to 2, then two iocb_put()
are done (either both synchronous to aio_poll(), or one sync and one
async).

That's not a refcount at all.  It's a flag, set only for aio_poll ones.
And that test in iocb_put() is "if flag is set, clear it and bugger off".

What's worse, AFAICS the callers in aio_poll() are buggered (see below)

>  static inline void aio_poll_complete(struct aio_kiocb *iocb, __poll_t mask)
>  {
> -	struct file *file = iocb->poll.file;
> -
>  	aio_complete(iocb, mangle_poll(mask), 0);
> -	fput(file);
>  }

No reasons to keep that function at all now...

> -	if (unlikely(apt.error)) {
> -		fput(req->file);
> +	if (unlikely(apt.error))
>  		return apt.error;
> -	}
>  
>  	if (mask)
>  		aio_poll_complete(aiocb, mask);

Looking at that thing...  How does it manage to avoid leaks
when we try to use it on e.g. /dev/tty, which has
        poll_wait(file, &tty->read_wait, wait);
        poll_wait(file, &tty->write_wait, wait);
in n_tty_poll()?

AFAICS, we'll succeed adding it to the first queue, then have
aio_poll_queue_proc() fail and set apt.error to -EINVAL.
Suppose we are looking for EPOLLIN and there's nothing ready
to read.  We'll go
        mask = vfs_poll(req->file, &apt.pt) & req->events;
mask is 0.
        if (unlikely(!req->head)) {
nope - it's &tty->read_wait, not NULL
                /* we did not manage to set up a waitqueue, done */
                goto out;
        }

        spin_lock_irq(&ctx->ctx_lock);
        spin_lock(&req->head->lock);
        if (req->woken) {
nope - no wakeups so far
                /* wake_up context handles the rest */
                mask = 0;
                apt.error = 0;
        } else if (mask || apt.error) {
apt.error is non-zero
                /* if we get an error or a mask we are done */
                WARN_ON_ONCE(list_empty(&req->wait.entry));
                list_del_init(&req->wait.entry);
OK, removed from queue
        } else {
                /* actually waiting for an event */
                list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
                aiocb->ki_cancel = aio_poll_cancel;
        }
        spin_unlock(&req->head->lock);
        spin_unlock_irq(&ctx->ctx_lock);

out:
        if (unlikely(apt.error)) {
                fput(req->file);
                return apt.error;
... and we return -EINVAL to __io_submit_one(), where we hit
        /*
         * If ret is 0, we'd either done aio_complete() ourselves or have
         * arranged for that to be done asynchronously.  Anything non-zero
         * means that we need to destroy req ourselves.
         */
        if (ret)
                goto out_put_req;
        return 0;
out_put_req:
        if (req->ki_eventfd)
                eventfd_ctx_put(req->ki_eventfd);
        iocb_put(req);
out_put_reqs_available:
        put_reqs_available(ctx, 1);
        return ret;

and all knowledge of req is lost.  But we'd done only *one* iocb_put() in
that case, and ->ki_refcnt had been set to 2 by aio_poll().  How could it
avoid a leak?  The same goes for "->poll() returns something without
bothering to call poll_wait()" case, actually...

IOW, I would rather have aio_poll() (along with your fput-a-bit-later change)
do this -
out:
        if (mask && !apt.error)
                aio_complete(aiocb, mangle_poll(mask), 0);
        iocb_put(aiocb);
        return apt.error;

Comments?
