Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B06C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEC921019
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 03:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcaAEX9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfKIDmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 22:42:52 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38787 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfKIDmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 22:42:52 -0500
Received: by mail-yw1-f68.google.com with SMTP id s6so3034809ywe.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 19:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEQk7sFAoN8CWP8jvTuW+bl0ja9oHBLlsIXGwrkQBgw=;
        b=pcaAEX9THRPG51rpy1I+pgw0cWw+N8IrYBja/ek9sUwGb+zm7wMEoheVy1nBpfraFe
         kZsq5tNPZaXWJ4lBkGt36OiNdQUGyngdmEwuFWlQW9Ujr08CScd696vQNGGdmXBXLonP
         43W6dDloj+a/N+u+QQ59R32kZlvA2BucQtP9wwUdvuB8qAAOR0AffLaktMhLFEkzRmiJ
         K7FeUS8BgQ2S4wp5wN+0/27s9GqWc/rVTaBdTgVVrcyxv/HZCzhQpoPIVCLshKDoBCh0
         geeLon2l6kMQt2PijHYEUBxT553RDPqRncquLtmwbAloQ9TPOBS2S95wKpKQakre2c9f
         HdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEQk7sFAoN8CWP8jvTuW+bl0ja9oHBLlsIXGwrkQBgw=;
        b=WtAPXukRVAnRQ2YLu7nCYaw6ZigPhINfc6OvgkgAQ+LuPhiSK3hwsgugAtCyNWyvBY
         3qPq65qzMP5AljmMGbtSpE4c6pka9x2AemiUWcdin0A5MFcvl/ZhxST2SRzbzvS8X7wY
         jlRlMabjn5G5vTzY+q3XGuFrKKANXR+ANBwmEF/hKCuWSnZwAfrtcZAENrS/8LNKDari
         gDPUHQUp5IL8b+Yq10TvKYwNGmirOCUT/zbKPLGfg6xMsxJlluwUtxsXwtxuaW78430g
         bmx5VHjARLd8N2ooAOfwiGgeeWpGPoemZLv/sVRAgguHik7QGLmrxbK+XnN7aWisklpk
         Bzaw==
X-Gm-Message-State: APjAAAVXjNyovxUPH/slrHRulJ28dcxdp0SbTxrntrhrOkt80GjnLQwh
        b88Cy28Jhc1a3nLhIYsJTFuA2S1g3/FtbgXDEKc=
X-Google-Smtp-Source: APXvYqzGkkeTMB3qmgYiGSfd6/0k0jCXQ9rZvvxElwuOEjwo6Q8RNPceNRI9F+uK9A3p9BsnZqCKG3wB5gjDuIXVtew=
X-Received: by 2002:a81:1881:: with SMTP id 123mr9470290ywy.287.1573270970767;
 Fri, 08 Nov 2019 19:42:50 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009b403005942237bf@google.com> <27b57b11aadf1bd41ad8326101713ca0be7b8edf.camel@gmail.com>
 <CANpmjNPUc0nzo87zZJ_GE3+29m+SNt0c-+H7T5xUVskXxaun8Q@mail.gmail.com>
 <acd6b0d98a7ebcb4ead9b263ec5c568c5a747166.camel@gmail.com> <CACT4Y+Yb93ZFW-SJhN1fza2eDxyrnYVnwdBjYuVP+vY8DhNfJg@mail.gmail.com>
In-Reply-To: <CACT4Y+Yb93ZFW-SJhN1fza2eDxyrnYVnwdBjYuVP+vY8DhNfJg@mail.gmail.com>
From:   Balbir Singh <bsingharora@gmail.com>
Date:   Sat, 9 Nov 2019 14:42:39 +1100
Message-ID: <CAKTCnznC6sK3Wm7ccNo5EyCMkze9V1g_gTJEc7UMd-rMH2Lf9w@mail.gmail.com>
Subject: Re: KCSAN: data-race in taskstats_exit / taskstats_exit
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:55 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Nov 8, 2019 at 1:54 AM Balbir Singh <bsingharora@gmail.com> wrote:
> >
> > On Wed, 2019-11-06 at 11:23 +0100, Marco Elver wrote:
> > > On Wed, 6 Nov 2019 at 01:10, Balbir Singh <bsingharora@gmail.com> wrote:
> > > >
> > > > On Fri, 2019-10-04 at 21:26 -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    b4bd9343 x86, kcsan: Enable KCSAN for x86
> > > > > git tree:       https://github.com/google/ktsan.git kcsan
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=125329db600000
> > > > > kernel config:
> > > > > https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> > > > > dashboard link:
> > > > > https://syzkaller.appspot.com/bug?extid=c5d03165a1bd1dead0c1
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > >
> > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the
> > > > > commit:
> > > > > Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> > > > >
> > > > > ==================================================================
> > > > > BUG: KCSAN: data-race in taskstats_exit / taskstats_exit
> > > > >
> > > > > write to 0xffff8881157bbe10 of 8 bytes by task 7951 on cpu 0:
> > > > >   taskstats_tgid_alloc kernel/taskstats.c:567 [inline]
> > > > >   taskstats_exit+0x6b7/0x717 kernel/taskstats.c:596
> > > > >   do_exit+0x2c2/0x18e0 kernel/exit.c:864
> > > > >   do_group_exit+0xb4/0x1c0 kernel/exit.c:983
> > > > >   get_signal+0x2a2/0x1320 kernel/signal.c:2734
> > > > >   do_signal+0x3b/0xc00 arch/x86/kernel/signal.c:815
> > > > >   exit_to_usermode_loop+0x250/0x2c0 arch/x86/entry/common.c:159
> > > > >   prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
> > > > >   syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
> > > > >   do_syscall_64+0x2d7/0x2f0 arch/x86/entry/common.c:299
> > > > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > >
> > > > > read to 0xffff8881157bbe10 of 8 bytes by task 7949 on cpu 1:
> > > > >   taskstats_tgid_alloc kernel/taskstats.c:559 [inline]
> > > > >   taskstats_exit+0xb2/0x717 kernel/taskstats.c:596
> > > > >   do_exit+0x2c2/0x18e0 kernel/exit.c:864
> > > > >   do_group_exit+0xb4/0x1c0 kernel/exit.c:983
> > > > >   __do_sys_exit_group kernel/exit.c:994 [inline]
> > > > >   __se_sys_exit_group kernel/exit.c:992 [inline]
> > > > >   __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:992
> > > > >   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
> > > > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > >
> > > >
> > > > Sorry I've been away and just catching up with email
> > > >
> > > > I don't think this is a bug, if I interpret the report correctly it shows
> > > > a
> > > > race
> > > >
> > > > static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
> > > > {
> > > >         struct signal_struct *sig = tsk->signal;
> > > >         struct taskstats *stats;
> > > >
> > > > #1      if (sig->stats || thread_group_empty(tsk)) <- the check of sig-
> > > > >stats
> > > >                 goto ret;
> > > >
> > > >         /* No problem if kmem_cache_zalloc() fails */
> > > >         stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> > > >
> > > >         spin_lock_irq(&tsk->sighand->siglock);
> > > >         if (!sig->stats) {
> > > > #2              sig->stats = stats; <- here in setting sig->stats
> > > >                 stats = NULL;
> > > >         }
> > > >         spin_unlock_irq(&tsk->sighand->siglock);
> > > >
> > > >         if (stats)
> > > >                 kmem_cache_free(taskstats_cache, stats);
> > > > ret:
> > > >         return sig->stats;
> > > > }
> > > >
> > > > The worst case scenario is that we might see sig->stats as being NULL when
> > > > two
> > > > threads belonging to the same tgid. We do free up stats if we got that
> > > > wrong
> > > >
> > > > Am I misinterpreting the report?
> > > >
> > > > Balbir Singh.
> > >
> > > The plain concurrent reads/writes are a data race, which may manifest
> > > in various undefined behaviour due to compiler optimizations [1, 2].
> > > Note that, "data race" does not necessarily imply "race condition";
> > > some data races are race conditions (usually the more interesting
> > > bugs) -- but not *all* data races are race conditions (sometimes
> > > referred to as "benign races"). KCSAN reports data races according to
> > > the LKMM.
> > > [1] https://lwn.net/Articles/793253/
> > > [2] https://lwn.net/Articles/799218/
> > >
> > > If there is no race condition here that warrants heavier
> > > synchronization (locking etc.), we still have the data race which
> > > needs fixing by using marked atomic operations (READ_ONCE, WRITE_ONCE,
> > > atomic_t, etc.). We also need to consider memory ordering requirements
> > > (do we need smp_*mb(), smp_load_acquire/smp_store_release, ..)?
> > >
> > > In the case here, the pattern is double-checked locking, which is
> > > incorrect without atomic operations and the correct memory ordering.
> > > There is a lengthy discussion here:
> > >
> > https://lore.kernel.org/lkml/20191021113327.22365-1-christian.brauner@ubuntu.com/
> > >
> > >
> >
> > I am still not convinced unless someone can prove that unsigned long reads are
> > non-atomic,
>
> None of the relevant standards guarantee this. C standard very
> explicitly states the opposite - any data race renders behavior of the
> program as undefined. LKMM does not give any defined behavior to data
> races either. QED ;)
>

Fair enough! I am going to have a read the specification, in the
meanwhile, I agree changes are needed based on what you've just stated
above

Balbir

> > acquire/release and barriers semantics don't matter because the
> > code deals with the race inside of a lock if the read was spurious, The
> > assumption is based on the face that sig->stats can be NULL or the kzalloc'ed
> > value in all cases.
> >
> > Balbir Singh.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/acd6b0d98a7ebcb4ead9b263ec5c568c5a747166.camel%40gmail.com.
