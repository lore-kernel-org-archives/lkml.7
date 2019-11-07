Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86523C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362622178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi0XaNGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbfKGKjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:39:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33883 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387728AbfKGKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:39:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id e4so1942806pgs.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yVZyZ4lG/hWKQqQ9Al6ts9d5fWNAp7LkZkuvD0qBvdY=;
        b=Zi0XaNGq1uk0v7ijouWs04pOoWSVMUjha7KWTTt+ndku7XLniDXFEL4CofJc2LhAke
         IKUX4kYLuIXsihq5liRbr1s9WWwWp+bxDPy8UbxZFInE8O0aK0ZIigzNmrsWBuJltXLA
         2LoY/PFDnawGJqr8zPL7PRt3EcQyfHyw9IXlp02TkFroqGRvu+obUUlu00tARCAPjLYX
         ny3a6/aat+832+6tz0+4UKXvePFVmXORe9JHiXnVL4d/7BDT0r5SNotdTY+UbnpjbQjX
         TKD/eyij1hT5Wv88kUFbCIDlIR2s9e8Hm+agKIw2EgadScM2/RT1ISbQEX/w9G1sj2Bo
         2EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVZyZ4lG/hWKQqQ9Al6ts9d5fWNAp7LkZkuvD0qBvdY=;
        b=BAxWbZkdpsDgp9snXG09V84EtYKYCj/ZsDI6UFHnMvmyDHlEYBCQu/KwMRyC8vxRpM
         2xjgw3NWyYReVALqYZnBnVoYWXfjZ0hzbGt6XBXK7LxHzDi6HWDlI39B4VviIQpwwoBh
         +qMMTugCO7lYzD/QCt93j9VGH5UlX1tU+8AMT6itCadcXtVCDSgXSZmvWrwHmT4C6MXV
         WNA29EPuGHeZYeI+EGxsKLkCJ5ZkeVOdf7XrdMApihugNfWJiGrvkoUZnBBUSoqpVDx8
         gUc3EwO43zkJvbDYP0hf7hgfb7dS2NolVFvsqR9NZLho9fWzEUNX4sjD36GMwl4LtwPf
         KA0Q==
X-Gm-Message-State: APjAAAUu4ZO11py3cr/pDwkZg3UlkVKwXX8p+ZexOXT4/NVgXxKglNxp
        hORFTc4gixpXkhmVPEsHWc8=
X-Google-Smtp-Source: APXvYqxcFJNtPZogCZYeV6k9jKAhsKMnRJrQxd8hpOg0RTKc0tCNnShoIf5l0qWnxtl+FYjwFr502g==
X-Received: by 2002:a63:e84d:: with SMTP id a13mr3572250pgk.226.1573123177901;
        Thu, 07 Nov 2019 02:39:37 -0800 (PST)
Received: from localhost ([61.69.148.113])
        by smtp.gmail.com with ESMTPSA id o7sm4611201pjo.7.2019.11.07.02.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 02:39:37 -0800 (PST)
Date:   Thu, 7 Nov 2019 21:39:34 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KCSAN: data-race in taskstats_exit / taskstats_exit
Message-ID: <20191107103934.GA9122@balbir-desktop>
References: <0000000000009b403005942237bf@google.com>
 <27b57b11aadf1bd41ad8326101713ca0be7b8edf.camel@gmail.com>
 <CANpmjNPUc0nzo87zZJ_GE3+29m+SNt0c-+H7T5xUVskXxaun8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPUc0nzo87zZJ_GE3+29m+SNt0c-+H7T5xUVskXxaun8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 11:23:52AM +0100, Marco Elver wrote:
> On Wed, 6 Nov 2019 at 01:10, Balbir Singh <bsingharora@gmail.com> wrote:
> >
> > On Fri, 2019-10-04 at 21:26 -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    b4bd9343 x86, kcsan: Enable KCSAN for x86
> > > git tree:       https://github.com/google/ktsan.git kcsan
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=125329db600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c5d03165a1bd1dead0c1
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in taskstats_exit / taskstats_exit
> > >
> > > write to 0xffff8881157bbe10 of 8 bytes by task 7951 on cpu 0:
> > >   taskstats_tgid_alloc kernel/taskstats.c:567 [inline]
> > >   taskstats_exit+0x6b7/0x717 kernel/taskstats.c:596
> > >   do_exit+0x2c2/0x18e0 kernel/exit.c:864
> > >   do_group_exit+0xb4/0x1c0 kernel/exit.c:983
> > >   get_signal+0x2a2/0x1320 kernel/signal.c:2734
> > >   do_signal+0x3b/0xc00 arch/x86/kernel/signal.c:815
> > >   exit_to_usermode_loop+0x250/0x2c0 arch/x86/entry/common.c:159
> > >   prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
> > >   syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
> > >   do_syscall_64+0x2d7/0x2f0 arch/x86/entry/common.c:299
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > read to 0xffff8881157bbe10 of 8 bytes by task 7949 on cpu 1:
> > >   taskstats_tgid_alloc kernel/taskstats.c:559 [inline]
> > >   taskstats_exit+0xb2/0x717 kernel/taskstats.c:596
> > >   do_exit+0x2c2/0x18e0 kernel/exit.c:864
> > >   do_group_exit+0xb4/0x1c0 kernel/exit.c:983
> > >   __do_sys_exit_group kernel/exit.c:994 [inline]
> > >   __se_sys_exit_group kernel/exit.c:992 [inline]
> > >   __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:992
> > >   do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> >
> > Sorry I've been away and just catching up with email
> >
> > I don't think this is a bug, if I interpret the report correctly it shows a
> > race
> >
> > static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
> > {
> >         struct signal_struct *sig = tsk->signal;
> >         struct taskstats *stats;
> >
> > #1      if (sig->stats || thread_group_empty(tsk)) <- the check of sig->stats
> >                 goto ret;
> >
> >         /* No problem if kmem_cache_zalloc() fails */
> >         stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
> >
> >         spin_lock_irq(&tsk->sighand->siglock);
> >         if (!sig->stats) {
> > #2              sig->stats = stats; <- here in setting sig->stats
> >                 stats = NULL;
> >         }
> >         spin_unlock_irq(&tsk->sighand->siglock);
> >
> >         if (stats)
> >                 kmem_cache_free(taskstats_cache, stats);
> > ret:
> >         return sig->stats;
> > }
> >
> > The worst case scenario is that we might see sig->stats as being NULL when two
> > threads belonging to the same tgid. We do free up stats if we got that wrong
> >
> > Am I misinterpreting the report?
> >
> > Balbir Singh.
> 
> The plain concurrent reads/writes are a data race, which may manifest
> in various undefined behaviour due to compiler optimizations [1, 2].
> Note that, "data race" does not necessarily imply "race condition";
> some data races are race conditions (usually the more interesting
> bugs) -- but not *all* data races are race conditions (sometimes
> referred to as "benign races"). KCSAN reports data races according to
> the LKMM.
> [1] https://lwn.net/Articles/793253/
> [2] https://lwn.net/Articles/799218/
> 
> If there is no race condition here that warrants heavier
> synchronization (locking etc.), we still have the data race which
> needs fixing by using marked atomic operations (READ_ONCE, WRITE_ONCE,
> atomic_t, etc.). We also need to consider memory ordering requirements
> (do we need smp_*mb(), smp_load_acquire/smp_store_release, ..)?
> 
> In the case here, the pattern is double-checked locking, which is
> incorrect without atomic operations and the correct memory ordering.
> There is a lengthy discussion here:
> https://lore.kernel.org/lkml/20191021113327.22365-1-christian.brauner@ubuntu.com/
> 

Thanks for the explanation

I presume or presumed that accessing a pointer is atomic, in this case
sig->stats, I'll double check my assumption

Balbir

