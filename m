Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827FEC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6FF20842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCCUaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:30:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39030 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfCCUaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:30:24 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h0XkR-0002Y3-7R; Sun, 03 Mar 2019 20:30:11 +0000
Date:   Sun, 3 Mar 2019 20:30:11 +0000
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
Message-ID: <20190303203011.GR2217@ZenIV.linux.org.uk>
References: <000000000000f39c7b05832e0219@google.com>
 <20190303135502.GP2217@ZenIV.linux.org.uk>
 <20190303151846.GQ2217@ZenIV.linux.org.uk>
 <CAHk-=wiQ2YNB+2FT+jbdcC6qfYqvS2kLLAZbmPE_7sLfUPwFJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiQ2YNB+2FT+jbdcC6qfYqvS2kLLAZbmPE_7sLfUPwFJg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 11:44:33AM -0800, Linus Torvalds wrote:
> On Sun, Mar 3, 2019 at 7:18 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > > Maybe unrelated to this bug, but...  What's to prevent a wakeup
> > > that happens just after we'd been added to a waitqueue by ->poll()
> > > triggering aio_poll_wake(), which gets to aio_poll_complete()
> > > with its fput() *before* we'd reached the end of ->poll() instance?
> 
> I'm assuming you're talking about the second vfs_poll() in
> aio_poll_complete_work()? The one we call before we check for
> "rew->cancelled" properly under the spinlock?

No.  The first one, right in aio_poll().

> But as far as I can tell, they *all* could do:
> 
>  - look up file in aio_submit() when allocating and creating the aio_kiocb
> 
>  - drop the filp in 'iocb_put()' (which happens whether things
> complete successfully or not).
>
> and we'd have avoided a lot of complexity, and we'd have avoided this bug.
> 
> Your patch fixes the poll() case, but it does so by just letting the
> existing complexity remain, and adding a second fget/fput pair in the
> poll logic.
> 
> It would seem like it would be much better to rip all the complexity
> out entirely, and replace it with sane, simple and obviously correct
> code.
> 
> Hmm?
> 
> In other words, why wouldn't something like the attached work instead?
 
I'll need to dig out the mail archive from last year, but IIRC this
had been considered and there'd been non-trivial problems.  Give me
an hour or so and I'll dig that out (there'd been many rounds of
review, with long threads involved, some private, some on fsdevel).

> @@ -1060,6 +1071,7 @@ static inline void iocb_put(struct aio_kiocb *iocb)
>  {
>  	if (refcount_read(&iocb->ki_refcnt) == 0 ||
>  	    refcount_dec_and_test(&iocb->ki_refcnt)) {
> +		fput(iocb->ki_filp);

Trivial oops here - it might be NULL.
