Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B677FECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6D720659
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfJHPfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:35:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60722 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfJHPfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:35:40 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iHrWS-0004tt-B1; Tue, 08 Oct 2019 15:35:36 +0000
Date:   Tue, 8 Oct 2019 17:35:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, bsingharora@gmail.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] taskstats: fix data-race
Message-ID: <20191008153533.r43qyvasfqahmq6f@wittgenstein>
References: <20191007104039.GA16085@andrea.guest.corp.microsoft.com>
 <20191007110117.1096-1-christian.brauner@ubuntu.com>
 <20191007131804.GA19242@andrea.guest.corp.microsoft.com>
 <CACT4Y+YG23qbL16MYH3GTK4hOPsM9tDfbLzrTZ7k_ocR2ABa6A@mail.gmail.com>
 <20191007141432.GA22083@andrea.guest.corp.microsoft.com>
 <CACT4Y+avbYvtF9mHiX=R8Y2=YsP1_QsN6i_FpjLM7UxCKv6vxA@mail.gmail.com>
 <20191008142035.GA13564@andrea.guest.corp.microsoft.com>
 <20191008142413.h5kczta7jo4ado6u@wittgenstein>
 <20191008152659.GA16065@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008152659.GA16065@andrea>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:26:59PM +0200, Andrea Parri wrote:
> On Tue, Oct 08, 2019 at 04:24:14PM +0200, Christian Brauner wrote:
> > On Tue, Oct 08, 2019 at 04:20:35PM +0200, Andrea Parri wrote:
> > > On Mon, Oct 07, 2019 at 04:18:26PM +0200, Dmitry Vyukov wrote:
> > > > On Mon, Oct 7, 2019 at 4:14 PM Andrea Parri <parri.andrea@gmail.com> wrote:
> > > > >
> > > > > > > >  static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
> > > > > > > >  {
> > > > > > > >       struct signal_struct *sig = tsk->signal;
> > > > > > > > -     struct taskstats *stats;
> > > > > > > > +     struct taskstats *stats_new, *stats;
> > > > > > > >
> > > > > > > > -     if (sig->stats || thread_group_empty(tsk))
> > > > > > > > -             goto ret;
> > > > > > > > +     /* Pairs with smp_store_release() below. */
> > > > > > > > +     stats = READ_ONCE(sig->stats);
> > > > > > >
> > > > > > > This pairing suggests that the READ_ONCE() is heading an address
> > > > > > > dependency, but I fail to identify it: what is the target memory
> > > > > > > access of such a (putative) dependency?
> > > > > >
> > > > > > I would assume callers of this function access *stats. So the
> > > > > > dependency is between loading stats and accessing *stats.
> > > > >
> > > > > AFAICT, the only caller of the function in 5.4-rc2 is taskstats_exit(),
> > > > > which 'casts' the return value to a boolean (so I really don't see how
> > > > > any address dependency could be carried over/relied upon here).
> > > > 
> > > > This does not make sense.
> > > > 
> > > > But later taskstats_exit does:
> > > > 
> > > > memcpy(stats, tsk->signal->stats, sizeof(*stats));
> > > > 
> > > > Perhaps it's supposed to use stats returned by taskstats_tgid_alloc?
> > > 
> > > Seems reasonable to me.  If so, replacing the READ_ONCE() in question
> > > with an smp_load_acquire() might be the solution.  Thoughts?
> > 
> > I've done that already in my tree yesterday. I can resend for another
> > review if you'd prefer.
> 
> Oh nice!  No need to resend of course.  ;D FWIW, I can check it if you
> let me know the particular branch/commit (guessing that's somewhere in
> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git, yes?).

Oh ups, yeah of course :)
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=taskstats_syzbot

Thanks!
Christian
