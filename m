Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9651AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4743120836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 07:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="baw8bB96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCDHxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 02:53:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33537 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfCDHxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 02:53:51 -0500
Received: by mail-io1-f65.google.com with SMTP id e186so3280523ioa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 23:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msh7YqiKS/fRVJNhsbb63U3FsaJnzdhSSk/hwYP3QCI=;
        b=baw8bB96YRwyACNZvBrJDd5eDRXgXPcUII9TGuJjSPZ1jlKA62KJiSFnzl/Yl6AJJa
         SLTx7E+eDfY0tp5FO2uJw1toOpQgZ829p0IaFlZICgw7+YbB8e/GqkdAKrMeTpSrxDes
         T6F224SEi4ifaMatTsZhbXI73WcoJMhYTYpjCVqbdRHzhgMZBgYCTAxPNIHgd40UEv0G
         ruIjbcvIhLyDDInBRCes2m1IpEdgPxAKpOYSzTfrptV3Jd+OG0b5h6TpFtPIZPJdvkC5
         jf/u7lWqiQfwzRX9qMLs25O3hrUx/mvyNV/NmclTBHZRWPPR2+40e7UUIbRZXerzfOGx
         mG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msh7YqiKS/fRVJNhsbb63U3FsaJnzdhSSk/hwYP3QCI=;
        b=Ggxl3VLzz27lpvSELlRLqM+Iwr/k1NAvWHmbWfEmeymR0GIhMvNHV7Y3FMhBnSBCQ/
         +dR3N5LW08jSbK5g4r7YZcbYm0R3BRxn0WqzUG/32lqsemFqn9AMETHRS1IO2A3z++lO
         TZDejBO7L7JJGWWaVE6FwAzF3R6I+kYMEOpEZtDenW0DNMDO9l0/o0ow/j0yf7tCL0Qe
         HjgYu3pMAtra5PkWugnJ0ToriU0LPQD0wVNXG0nMnoiOH4InTf4b+r1dF+bwM4JYnZtV
         lUfu9iW6lqyc3Zrqo1aNM5Z3I+QN4WQtGCDKsOc5MV8+lTVgM4hm/FbXONZVcJCZFyBY
         /Fyg==
X-Gm-Message-State: APjAAAVAB80o5XWe7G4tjuD+6YFfKxbrFU9yKcrl9/cClUHyGqy91oUZ
        p6wceAH3hrRomt0r/2aVDRJOQmra7nPbGe3dRqxAqQ==
X-Google-Smtp-Source: APXvYqzKJ7b06RtpWGvsM7ULrRBCPTCQeWVlFWmYiMUj8rBFLzDLAHlLjnYbk6bbalqN4mYtPh/uURtvvNial8gFzbo=
X-Received: by 2002:a5d:84c3:: with SMTP id z3mr9183596ior.11.1551686029868;
 Sun, 03 Mar 2019 23:53:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f39c7b05832e0219@google.com> <20190303135502.GP2217@ZenIV.linux.org.uk>
 <20190303151846.GQ2217@ZenIV.linux.org.uk>
In-Reply-To: <20190303151846.GQ2217@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Mar 2019 08:53:38 +0100
Message-ID: <CACT4Y+ZquWnN+8OOxFobnr-371evgnvgQvfJzhFZg4ZP+Gd-wQ@mail.gmail.com>
Subject: Re: [PATCH] aio: prevent the final fput() in the middle of vfs_poll()
 (Re: KASAN: use-after-free Read in unix_dgram_poll)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        kyeongdon kim <kyeongdon.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 4:19 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Mar 03, 2019 at 01:55:02PM +0000, Al Viro wrote:
>
> > Maybe unrelated to this bug, but...  What's to prevent a wakeup
> > that happens just after we'd been added to a waitqueue by ->poll()
> > triggering aio_poll_wake(), which gets to aio_poll_complete()
> > with its fput() *before* we'd reached the end of ->poll() instance?
> >
> > I wonder if adding
> >       get_file(req->file);  // make sure that early completion is safe
> > right after
> >         req->file = fget(iocb->aio_fildes);
> >         if (unlikely(!req->file))
> >                 return -EBADF;
> > paired with
> >       fput(req->file);
> > right after out: in aio_poll() is needed...  Am I missing something
> > obvious here?  Christoph?
>
> In more details - normally IOCB_CMD_POLL handling looks so:
>
> 1) io_submit(2) allocates aio_kiocb instance and passes it to aio_poll()
> 2) aio_poll() resolves the descriptor to struct file by
>         req->file = fget(iocb->aio_fildes)
> 3) aio_poll() sets ->woken to false and raises ->ki_refcnt of that
> aio_kiocb to 2 (bumps by 1, that is).
> 4) aio_poll() calls vfs_poll().  After sanity checks (basically, "poll_wait()
> had been called and only once") it locks the queue.  That's what the extra
> reference to iocb had been for - we know we can safely access it.
> 5) With queue locked, we check if ->woken has already been set to true
> (by aio_poll_wake()) and, if it had been, we unlock the queue, drop
> a reference to aio_kiocb and bugger off - at that point it's
> a responsibility to aio_poll_wake() and the stuff called/scheduled by
> it.  That code will drop the reference to file in req->file, along
> with the other reference to our aio_kiocb.
> 6) otherwise, we see whether we need to wait.  If we do, we unlock
> the queue, drop one reference to aio_kiocb and go away - eventual
> wakeup (or cancel) will deal with the reference to file and with the
> other reference to aio_kiocb
> 7) otherwise we remove ourselves from waitqueue (still under the queue
> lock), so that wakeup won't get us.  No async activity will be happening,
> so we can safely drop req->file and iocb ourselves.
>
> If wakeup happens while we are in vfs_poll(), we are fine - aio_kiocb
> won't get freed under us, so we can do all the checks and locking safely.
> And we don't touch ->file if we detect that case.
>
> However, vfs_poll() most certainly *does* touch the file it had been
> given.  So wakeup coming while we are still in ->poll() might end up
> doing fput() on that file.  That case is not too rare, and usually
> we are saved by the still present reference from descriptor table -
> that fput() is not the final one.  But if another thread closes that
> descriptor right after our fget() and wakeup does happen before
> ->poll() returns, we are in trouble - final fput() done while we
> are in the middle of a method.
>
> What we need is to hold on to the file reference the same way we do with
> aio_kiocb.  No need to store the reference to what we'd got in a separate
> variable - req->file is never reassigned and we'd already made sure that
> req won't be freed under us, so dropping the extra reference with
> fput(req->file) is fine in all cases.
>
> Fixes: bfe4037e722ec
> Cc: stable@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Please add the Reported-by tag from the report.
If you don't add it, then either:
1. somebody (you) will need to remember to later go and associate fix
the the report with "#syz fix" command
2. or the bug will stay open and syzbot will never report
use-after-frees in unix_dgram_poll again (it's still the same already
reported bug)
3. or worse somebody will spend time re-debugging this bug just to
find that you already fixed it but did not include the tag

Thanks

> ---
> diff --git a/fs/aio.c b/fs/aio.c
> index 3083180a54c8..7e88bfabdac2 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1767,6 +1767,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
>
>         /* one for removal from waitqueue, one for this function */
>         refcount_set(&aiocb->ki_refcnt, 2);
> +       get_file(req->file);
>
>         mask = vfs_poll(req->file, &apt.pt) & req->events;
>         if (unlikely(!req->head)) {
> @@ -1793,6 +1794,7 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
>         spin_unlock_irq(&ctx->ctx_lock);
>
>  out:
> +       fput(req->file);
>         if (unlikely(apt.error)) {
>                 fput(req->file);
>                 return apt.error;
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190303151846.GQ2217%40ZenIV.linux.org.uk.
> For more options, visit https://groups.google.com/d/optout.
