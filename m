Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB291CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD48205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjdyHa19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfJUMPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:15:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37462 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfJUMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:15:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so10818452oie.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lI93YNTuV9z0QswEaOR/XuZAwGw+CRQ58pTCQCCBVA=;
        b=ZjdyHa190eojc7Vs3ciDRMhe2DzSUghJPm7Juo02qFoKR8IEtGsOVE8gw1inVDqw4s
         QybrcvyBD/VQbFJnXIo0T9ILSsGxoqHLJFW/UdUY53njccNqdE2GMgz1Dg4IY7raUnou
         7AYKUqPaZxtgALSyUiFDUfP1nUpQa2uUrve98ve01kZmfCjTNg7DykYBI/64LSlxYVv0
         ncVxPq/UAk821MxREnI9SUedNPsgSeE4YT6NUsyvPobRT+jfkwDkQHh71O45q6DDuJqs
         uQu3czaRDDKQ9koMGngUYzRmVE9j8VmsSTkg6P/WHh+BBxkYmlFA+9YK/j2VB3qS3B+5
         ru/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lI93YNTuV9z0QswEaOR/XuZAwGw+CRQ58pTCQCCBVA=;
        b=cF8I+N3Hkb8xVl/hvuhi0jvEmjV1NmHwI44Dk41WRfQgslhk8X1PSa/gGcUBWQ53ry
         BrgPa0HnbpP3922JBWi9o4ZbLkHHdkFfc4d1hrGO6I79FUGiY4wtZ6TAtiODZNhz5/LW
         ZG1thnW+XT0xPxfh2uFwEXnfn2oHVmCwjCEJCHA55dg6vySZhHRVZ9nntB41mT15dlVT
         12WeekXN4AceORi6c2zT935RCC5l9DJxRYvHInPIdd0S7GlueOrfvShuAi8rf5Ub/267
         04WLsHTKYnwVasNo9O18C/f4D4GAoeV9xu/9EelNxmJjU2+o++KmEtmp7W3blnEkWAge
         Q02g==
X-Gm-Message-State: APjAAAWooTEmPb7nQXf5AV2qDHCqjjHdDPTBQHxcAAIsN4jA7BN/3jb/
        NzLdzrpj5oNvM507CYLjAYUp/BLyl4g2OQIFOI/7sQ==
X-Google-Smtp-Source: APXvYqzwJhH5YWW3SKrFdWanRjSMoGnIycjT9b8iyNsYkd7MemkP4K0kJxYkKoCAm++aj1mIcGuUlf7FmkifEsB0+No=
X-Received: by 2002:a05:6808:4b:: with SMTP id v11mr18996250oic.70.1571660127086;
 Mon, 21 Oct 2019 05:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003b1e8005956939f1@google.com> <20191021111920.frmc3njkha4c3a72@wittgenstein>
 <20191021120029.GA24935@redhat.com>
In-Reply-To: <20191021120029.GA24935@redhat.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Oct 2019 14:15:15 +0200
Message-ID: <CANpmjNMfCK99DoUuR2qRBTLLhrGsYVcpKdtXW7S559tNJ-MO7A@mail.gmail.com>
Subject: Re: KCSAN: data-race in exit_signals / prepare_signal
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        syzbot <syzbot+492a4acccd8fc75ddfd0@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, guro@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 at 14:00, Oleg Nesterov <oleg@redhat.com> wrote:
>
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
>
> For example, freezable_schedule() which sets PF_FREEZER_SKIP can equally
> "race" with sig_task_ignored() or with ANY other code which checks this
> task's flags.
>
> I think this is WONTFIX.

If taking the spinlock is unnecessary (which AFAIK it probably is) and
there are no other writers to this flag, you will still need a
WRITE_ONCE(tsk->flags, tsk->flags | PF_EXITING) to avoid the
data-race.

However, if it is possible that there are concurrent writers setting
other bits in flags, you need to ensure that the bits are set
atomically (unless it's ok to lose some bits here). This can only be
done via 1) taking siglock, or 2) via e.g. atomic_or(...), however,
flags is not atomic_t ...

-- Marco
