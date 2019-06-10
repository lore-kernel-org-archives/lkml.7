Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0B7C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F349820859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560195564;
	bh=Yc63F9HkWkaur2zmRzaHvYzUSbn6hzEs6D1ov72qWGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sjVAC0Pc5WP7Wy3Z+OO8rGETClzaUtRU6ORGUqqJWiRLYgCE/LpbKScqopMb07yKW
	 4DtR6GVbHujR6nKkq+SS4Ql6iBHh0fVGshnyKkOz4/b0Xc9iBJq0ZBOOK9il0LV+NJ
	 /T5OkPCD+arBzC8AtNJyiJMZyoJrO+oq1qEMjTl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbfFJTjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbfFJTjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:39:22 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0130B207E0;
        Mon, 10 Jun 2019 19:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560195561;
        bh=Yc63F9HkWkaur2zmRzaHvYzUSbn6hzEs6D1ov72qWGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O65CO/TcJ5/PiPp67uiEOxDsBdkHzwiB79Q7AqgvRHktKbX5e4y7ZNwY+W1cWBBpf
         dA0eQQ8sqSpmU8TJEm5aSULsgHSz4gjh2h7m1XZ5Dz7gSpiksUYs43a9PvHRlJ5I4m
         eXu3Bxe1cUhNpRURnt3PUZ441wh07BSCWL695nAg=
Date:   Mon, 10 Jun 2019 12:39:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        deepa.kernel@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        syzbot <syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com>
Subject: Re: [PATCH] signal/ptrace: Don't leak unitialized kernel memory with
 PTRACE_PEEK_SIGINFO
Message-ID: <20190610193918.GJ63833@gmail.com>
References: <000000000000410d500588adf637@google.com>
 <87woia5vq3.fsf@xmission.com>
 <20190528124746.ac703cd668ca9409bb79100b@linux-foundation.org>
 <87pno23vim.fsf_-_@xmission.com>
 <CANaxB-ztx3-3cfsbK4rTnGAAcODJmgKHyhHF_0oBe+qqyf5Leg@mail.gmail.com>
 <87tvd5m928.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvd5m928.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 02:42:23PM -0500, Eric W. Biederman wrote:
> Andrei Vagin <avagin@gmail.com> writes:
> 
> > On Tue, May 28, 2019 at 6:22 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >>
> >> Recently syzbot in conjunction with KMSAN reported that
> >> ptrace_peek_siginfo can copy an uninitialized siginfo to userspace.
> >> Inspecting ptrace_peek_siginfo confirms this.
> >>
> >> The problem is that off when initialized from args.off can be
> >> initialized to a negaive value.  At which point the "if (off >= 0)"
> >> test to see if off became negative fails because off started off
> >> negative.
> >>
> >> Prevent the core problem by adding a variable found that is only true
> >> if a siginfo is found and copied to a temporary in preparation for
> >> being copied to userspace.
> >>
> >> Prevent args.off from being truncated when being assigned to off by
> >> testing that off is <= the maximum possible value of off.  Convert off
> >> to an unsigned long so that we should not have to truncate args.off,
> >> we have well defined overflow behavior so if we add another check we
> >> won't risk fighting undefined compiler behavior, and so that we have a
> >> type whose maximum value is easy to test for.
> >>
> >
> > Hello Eric,
> >
> > Thank you for fixing this issue. Sorry for the late response.
> > I thought it was fixed a few month ago, I remembered that we discussed it:
> > https://lkml.org/lkml/2018/10/10/251
> 
> I was looking for that conversation, and I couldn't find it so I just
> decided to write a test and fix it.
> 
> > Here are two inline comments.
> >
> >
> >> Cc: Andrei Vagin <avagin@gmail.com>
> >> Cc: stable@vger.kernel.org
> >> Reported-by: syzbot+0d602a1b0d8c95bdf299@syzkaller.appspotmail.com
> >> Fixes: 84c751bd4aeb ("ptrace: add ability to retrieve signals without removing from a queue (v4)")
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> ---
> >>
> >> Comments?
> >> Concerns?
> >>
> >> Otherwise I will queue this up and send it to Linus.
> >>
> >>  kernel/ptrace.c | 10 ++++++++--
> >>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> >> index 6f357f4fc859..4c2b24a885d3 100644
> >> --- a/kernel/ptrace.c
> >> +++ b/kernel/ptrace.c
> >> @@ -704,6 +704,10 @@ static int ptrace_peek_siginfo(struct task_struct *child,
> >>         if (arg.nr < 0)
> >>                 return -EINVAL;
> >>
> >> +       /* Ensure arg.off fits in an unsigned */
> >> +       if (arg.off > ULONG_MAX)
> >
> > if (arg.off > ULONG_MAX - arg.nr)
> >
> 
> The new variable found ensures that whatever we pass in we won't return
> an invalid value.  All this test does is guarantee we don't return a
> much lower entry in the queue.
> 
> We don't need to take arg.nr into account as we won't try
> entries that high as the queue will never get that long.  The maximum
> siqueue entries per user is about 2^24.
> 
> >> +               return 0;
> >
> > maybe we should return EINVAL in this case
> 
> But it is a huge request not an invalid request.  The request
> makes perfect sense.   For smaller values whose offset is
> greater than the length of the queue we just return 0 entries
> found.  So I think it makes more sense to just return 0 entries
> found in this case as well.
> 
> >> +
> >>         if (arg.flags & PTRACE_PEEKSIGINFO_SHARED)
> >>                 pending = &child->signal->shared_pending;
> >>         else
> >> @@ -711,18 +715,20 @@ static int ptrace_peek_siginfo(struct task_struct *child,
> >>
> >>         for (i = 0; i < arg.nr; ) {
> >>                 kernel_siginfo_t info;
> >> -               s32 off = arg.off + i;
> >> +               unsigned long off = arg.off + i;
> >> +               bool found = false;
> >>
> >>                 spin_lock_irq(&child->sighand->siglock);
> >>                 list_for_each_entry(q, &pending->list, list) {
> >>                         if (!off--) {
> >> +                               found = true;
> >>                                 copy_siginfo(&info, &q->info);
> >>                                 break;
> >>                         }
> >>                 }
> >>                 spin_unlock_irq(&child->sighand->siglock);
> >>
> >> -               if (off >= 0) /* beyond the end of the list */
> >> +               if (!found) /* beyond the end of the list */
> >>                         break;
> >>
> >>  #ifdef CONFIG_COMPAT
> >> --
> >> 2.21.0.dirty
> >>
> 

This patch looks fine to me.  Are you planning to queue this up?
It would be nice if we could fix this sort of bug in fewer than 8 months.

- Eric
