Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAA7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25D52084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbfJUMvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:51:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58704 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfJUMvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:51:13 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iMX9L-00069c-Du; Mon, 21 Oct 2019 12:51:03 +0000
Date:   Mon, 21 Oct 2019 14:51:02 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     syzbot <syzbot+492a4acccd8fc75ddfd0@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, arnd@arndb.de, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, elver@google.com,
        guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Subject: Re: KCSAN: data-race in exit_signals / prepare_signal
Message-ID: <20191021125101.x7omk7xa2kyc7hue@wittgenstein>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021111920.frmc3njkha4c3a72@wittgenstein>
 <20191021120029.GA24935@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191021120029.GA24935@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 02:00:30PM +0200, Oleg Nesterov wrote:
> On 10/21, Christian Brauner wrote:
> >
> > This traces back to Oleg fixing a race between a group stop and a thread
> > exiting before it notices that it has a pending signal or is in the middle of
> > do_exit() already, causing group stop to get wacky.
> > The original commit to fix this race is
> > commit d12619b5ff56 ("fix group stop with exit race") which took sighand
> > lock before setting PF_EXITING on the thread.
> 
> Not really... sig_task_ignored() didn't check task->flags until the recent
> 33da8e7c81 ("signal: Allow cifs and drbd to receive their terminating signals").
> But I think this doesn't matter, see below.
> 
> > If the race really matters and given how tsk->flags is currently accessed
> > everywhere the simple fix for now might be:
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index c4da1ef56fdf..cf61e044c4cc 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2819,7 +2819,9 @@ void exit_signals(struct task_struct *tsk)
> >         cgroup_threadgroup_change_begin(tsk);
> >
> >         if (thread_group_empty(tsk) || signal_group_exit(tsk->signal)) {
> > +               spin_lock_irq(&tsk->sighand->siglock);
> >                 tsk->flags |= PF_EXITING;
> > +               spin_unlock_irq(&tsk->sighand->siglock);
> 
> Well, exit_signals() tries to avoid ->siglock in this case....
> 
> But this doesn't matter. IIUC the problem is not that exit_signals() sets
> PF_EXITING, the problem is that it writes to tsk->flags and kasan detects
> the data race.

Right, that's the reason I said "If the race really matters". I thought
that other writers/readers always take sighand lock. So the easy fix
would have been to take sighand lock too.
The alternative is that we need to fiddle with task_struct itself and
replace flags with an atomic_t or sm which is more invasive and probably
more controversial.

Christian
