Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB2CC46460
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F820665
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 22:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfFDWYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 18:24:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38310 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfFDWYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 18:24:42 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 907961F462;
        Tue,  4 Jun 2019 22:24:41 +0000 (UTC)
Date:   Tue, 4 Jun 2019 22:24:41 +0000
From:   Eric Wong <e@80x24.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, omar.kilani@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] signal: remove the wrong signal_pending() check in
 restore_user_sigmask()
Message-ID: <20190604222441.tndh2rljrfoaytkr@dcvr>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <20190604134117.GA29963@redhat.com>
 <CAHk-=wjSOh5zmApq2qsNjmY-GMn4CWe9YwdcKPjT+nVoGiDKOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjSOh5zmApq2qsNjmY-GMn4CWe9YwdcKPjT+nVoGiDKOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Jun 4, 2019 at 6:41 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > This is the minimal fix for stable, I'll send cleanups later.
> 
> Ugh. I htink this is correct, but I wish we had a better and more
> intuitive interface.

I had the same thoughts, but am not a regular kernel hacker,
so I didn't say anything earlier.

> In particular, since restore_user_sigmask() basically wants to check
> for "signal_pending()" anyway (to decide if the mask should be
> restored by signal handling or by that function), I really get the
> feeling that a lot of these patterns like
> 
> > -       restore_user_sigmask(ksig.sigmask, &sigsaved);
> > -       if (signal_pending(current) && !ret)
> > +
> > +       interrupted = signal_pending(current);
> > +       restore_user_sigmask(ksig.sigmask, &sigsaved, interrupted);
> > +       if (interrupted && !ret)
> >                 ret = -ERESTARTNOHAND;
> 
> are wrong to begin with, and we really should aim for an interface
> which says "tell me whether you completed the system call, and I'll
> give you an error return if not".
> 
> How about we make restore_user_sigmask() take two return codes: the
> 'ret' we already have, and the return we would get if there is a
> signal pending and w're currently returning zero.
> 
> IOW, I think the above could become
> 
>         ret = restore_user_sigmask(ksig.sigmask, &sigsaved, ret, -ERESTARTHAND);
> 
> instead if we just made the right interface decision.

But that falls down if ret were ever expected to match several
similar error codes (not sure if it happens)

When I was considering fixing this on my own a few weeks ago, I
was looking for an inline that could quickly tell if `ret' was
any of the EINTR-like error codes; but couldn't find one...

It'd probably end up being switch/case statement so I'm not sure
if it'd be too big and slow or not...

The caller would just do:

	ret = restore_user_sigmask(ksig.sigmask, &sigsaved, ret);

And restore_user_sigmask would call some "was_interrupted(ret)"
inline which could return true if `ret' matched any of the
too-many-to-keep-track-of EINTR-like codes.  But I figured
there's probably a good reason it did not exist, already *shrug*

/me goes back to the wonderful world of userspace...
