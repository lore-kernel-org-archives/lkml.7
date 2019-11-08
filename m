Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6A2C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4392084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnyc/x8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfKHAyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:54:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45538 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKHAyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:54:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so3546415pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 16:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RwwCfPj9kkXT/tgPNBKXIQ7hGpqfevKBcJxOL853a+o=;
        b=Bnyc/x8RgDN22tHTNccOzxXcbeqyCFSZEudqb044t0pCgqzb6m4VsO8rEqeq0Ilipa
         xi62vOifeZH0Jais2ka51HXOWAR3B+NKDPcQ47d23MZ4pEtm0VOWh4yVIC5TWg9NTOZB
         LhWk26/+e3lLVNI39BL0DX9a+bBm+MDdyPHSpUczQTtgVpwg2T0HukTWuozC06qMt+Ap
         YU+d67FubOqnkC3T4aT9cvik5rLCPIibktuI04o9tiHkUYe3IEOBy8DIPhYqonslsoLc
         9vJLmD/1lighvX/5L2bpt/O9e/M9tcTY2EKUWUu2MP8sKJjJiFI+Cn/+72RkjOAduHho
         SMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RwwCfPj9kkXT/tgPNBKXIQ7hGpqfevKBcJxOL853a+o=;
        b=qHCFziVVhOK3h63mwnMBhSEk7sGx5yrvswCaaQLT7LU2sYXB7ZY22LdBMShhBq+fsF
         lix1GpJBevRCBrWUNyrRZ7prQ75i5q3YGFJCsnLKrghB0LKvlSDuRghhoO+gNooSCBRc
         D1bp6viNnTwRYH89MIjzOWNHAzZdHJ8CYk5qTpzdhGAJcY3lgOn3B862Q0gc/oZc0GQ0
         fOyk9h+3+48enpVCCgvX3o4iGFm1TtLn/8DB5Hw8dIymJbnQ7p1O8UibTs+nR9ite9lr
         Jh7GnzQKoKhFwGXYpZ5AAu1dVXosdgSyF4mBhfa5gDRMCwBb8qN83HWZhSf4lIuUsYUG
         BwsA==
X-Gm-Message-State: APjAAAV10JSJ/R4LBz94ERcxGjLrTOxIT9E+X8UEI74xQqDAXFt5sIAe
        zEweCNzg9zDVACy6FFecoZQ=
X-Google-Smtp-Source: APXvYqwbwdUvkn0aiqWIkFptXc7o8wUplF9P7eaHrcBHFY6F3XtojjOGk6duBwebyy7kMRcqO7B1rA==
X-Received: by 2002:a62:2a14:: with SMTP id q20mr8118766pfq.148.1573174482785;
        Thu, 07 Nov 2019 16:54:42 -0800 (PST)
Received: from u2f459ca2e0dd5b.ant.amazon.com ([61.69.148.113])
        by smtp.googlemail.com with ESMTPSA id z18sm3894528pgv.90.2019.11.07.16.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Nov 2019 16:54:41 -0800 (PST)
Message-ID: <acd6b0d98a7ebcb4ead9b263ec5c568c5a747166.camel@gmail.com>
Subject: Re: KCSAN: data-race in taskstats_exit / taskstats_exit
From:   Balbir Singh <bsingharora@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Date:   Fri, 08 Nov 2019 11:54:36 +1100
In-Reply-To: <CANpmjNPUc0nzo87zZJ_GE3+29m+SNt0c-+H7T5xUVskXxaun8Q@mail.gmail.com>
References: <0000000000009b403005942237bf@google.com>
         <27b57b11aadf1bd41ad8326101713ca0be7b8edf.camel@gmail.com>
         <CANpmjNPUc0nzo87zZJ_GE3+29m+SNt0c-+H7T5xUVskXxaun8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 11:23 +0100, Marco Elver wrote:
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
> > > kernel config:  
> > > https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> > > dashboard link: 
> > > https://syzkaller.appspot.com/bug?extid=c5d03165a1bd1dead0c1
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > 
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the
> > > commit:
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
> > I don't think this is a bug, if I interpret the report correctly it shows
> > a
> > race
> > 
> > static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
> > {
> >         struct signal_struct *sig = tsk->signal;
> >         struct taskstats *stats;
> > 
> > #1      if (sig->stats || thread_group_empty(tsk)) <- the check of sig-
> > >stats
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
> > The worst case scenario is that we might see sig->stats as being NULL when
> > two
> > threads belonging to the same tgid. We do free up stats if we got that
> > wrong
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
> 
https://lore.kernel.org/lkml/20191021113327.22365-1-christian.brauner@ubuntu.com/
> 
> 

I am still not convinced unless someone can prove that unsigned long reads are
non-atomic, acquire/release and barriers semantics don't matter because the
code deals with the race inside of a lock if the read was spurious, The
assumption is based on the face that sig->stats can be NULL or the kzalloc'ed
value in all cases.

Balbir Singh.

