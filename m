Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2195C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64936217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N9msF5Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfDSWqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:46:25 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41023 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSWqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:46:24 -0400
Received: by mail-vs1-f67.google.com with SMTP id g187so3501929vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 15:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9BZNnXe85uskZFvz7dY6ivJpp0VMOQrQnMUIB7aytc=;
        b=N9msF5BctZCDYRQh6reDgjFREMWOTLJCoq+cOkbKvtoXHPVzJN6A5q3Ztgcj7zMBCf
         L5bX9Wcd+qRJ41ibbQ6gH2zkQoQQt5UN4WAJCaXqx1ROknaD4RUHyZJcKrXaCRz4EyrL
         EToNcPMQ2IlwhojCoOBLQw3Xl/YoVorc8bZK2bibFgDGHl6b2N8MWOFJvRtPv25DCsLP
         Wu4dg5oSOHEoXzmPrCaeF4dai9gBJVM7yPBuxW+OOEt1uo64wSgmJ2YIWrN6MsB/hNmo
         c1PAhBmrueHPN4PnSpRNA2dPDTvpA39GfN2R7/m4SdWaP0HB2PVJ4axqhTXVGPqG8ngC
         g2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9BZNnXe85uskZFvz7dY6ivJpp0VMOQrQnMUIB7aytc=;
        b=rW1S119Ohk5ivoyll8GcN2sO1eueeXD6GqyPK32alM8YzgnBuL1xbZvGFWAdMNb2tu
         MlQ/cfmdVE1EVjzaMxLsCqyBQb7D8iDiCc6Aj0RrXYZ5l4e596woGr3hDldPc4ZVoljZ
         Sp6Z2xcZeX4Mz2vtXFquFWld2a9y0WTI/BEWav7BizCmC4GmIzKRQs8MR9hXWqgmzlZ2
         gr6G5j4/BjHjbfagrWVXsV23O8aq6kHGkNxlErT8bS82+8mE3B2ahfn2bNLtW9KsApKe
         J7nxQPjRLG8KkEjzTzJD5LC98pYZslRqO0HIusc3fjI/PmDTTXw+YpszuqLDN8hh+vg5
         F16Q==
X-Gm-Message-State: APjAAAUJDuC9Q6cJL79ZyVT70BB/FZyVvL1BQZDLvc/2I1JgXPXj/MY6
        kvGDt+D3llfOcKpyl/RhMRlfznvEwWJ27VnhHCYw3w==
X-Google-Smtp-Source: APXvYqwFExF26xoQibDWcvVDeXykJ2BJt/rX5/X/ejlzJLCYFEDIZcFK3BXEh0mC5XV9HLZpgYW0XYPKZf8Az9rP8ps=
X-Received: by 2002:a67:ea0a:: with SMTP id g10mr3399212vso.77.1555713982564;
 Fri, 19 Apr 2019 15:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <CAKOZueuBTwyrLtpVQaoTAgjGSgeHY7392sKv5uAYdy4XKNHKHQ@mail.gmail.com>
 <CAHrFyr6f_CUP__818e1u6TaHd-XpWY6NOxri4yzzR6rNY5rk_w@mail.gmail.com> <CAHrFyr76KrgUwHz91fZbkvHD43KzVrcXndRKUJjG9-gT4ZFZuQ@mail.gmail.com>
In-Reply-To: <CAHrFyr76KrgUwHz91fZbkvHD43KzVrcXndRKUJjG9-gT4ZFZuQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 19 Apr 2019 15:46:09 -0700
Message-ID: <CAKOZueu_ouL_u17UKNNkDaSuP-_m_=fE8nLZGb9YAjonF=zVHg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Christian Brauner <christian@brauner.io>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 3:02 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Fri, Apr 19, 2019 at 11:48 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Fri, Apr 19, 2019 at 11:21 PM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > On Fri, Apr 19, 2019 at 1:57 PM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > On Fri, Apr 19, 2019 at 10:34 PM Daniel Colascione <dancol@google.com> wrote:
> > > > >
> > > > > On Fri, Apr 19, 2019 at 12:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > On Fri, Apr 19, 2019 at 09:18:59PM +0200, Christian Brauner wrote:
> > > > > > > On Fri, Apr 19, 2019 at 03:02:47PM -0400, Joel Fernandes wrote:
> > > > > > > > On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> > > > > > > > > On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> > > > > > > > > >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > > > > > > >> On 04/16, Joel Fernandes wrote:
> > > > > > > > > >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > > > > > > > >> > >
> > > > > > > > > >> > > Could you explain when it should return POLLIN? When the whole
> > > > > > > > > >process exits?
> > > > > > > > > >> >
> > > > > > > > > >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> > > > > > > > > >or when it
> > > > > > > > > >> > is in a zombie state and there's no other thread in the thread
> > > > > > > > > >group.
> > > > > > > > > >>
> > > > > > > > > >> IOW, when the whole thread group exits, so it can't be used to
> > > > > > > > > >monitor sub-threads.
> > > > > > > > > >>
> > > > > > > > > >> just in case... speaking of this patch it doesn't modify
> > > > > > > > > >proc_tid_base_operations,
> > > > > > > > > >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> > > > > > > > > >going to use
> > > > > > > > > >> the anonymous file returned by CLONE_PIDFD ?
> > > > > > > > > >
> > > > > > > > > >I don't think procfs works that way. /proc/sub-thread-tid has
> > > > > > > > > >proc_tgid_base_operations despite not being a thread group leader.
> > > > > > > > > >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> > > > > > > > > >be hit trivially, and then the code will misbehave.
> > > > > > > > > >
> > > > > > > > > >@Joel: I think you'll have to either rewrite this to explicitly bail
> > > > > > > > > >out if you're dealing with a thread group leader, or make the code
> > > > > > > > > >work for threads, too.
> > > > > > > > >
> > > > > > > > > The latter case probably being preferred if this API is supposed to be
> > > > > > > > > useable for thread management in userspace.
> > > > > > > >
> > > > > > > > At the moment, we are not planning to use this for sub-thread management. I
> > > > > > > > am reworking this patch to only work on clone(2) pidfds which makes the above
> > > > > > >
> > > > > > > Indeed and agreed.
> > > > > > >
> > > > > > > > discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
> > > > > > > > patches, CLONE_THREAD with pidfd is not supported.
> > > > > > >
> > > > > > > Yes. We have no one asking for it right now and we can easily add this
> > > > > > > later.
> > > > > > >
> > > > > > > Admittedly I haven't gotten around to reviewing the patches here yet
> > > > > > > completely. But one thing about using POLLIN. FreeBSD is using POLLHUP
> > > > > > > on process exit which I think is nice as well. How about returning
> > > > > > > POLLIN | POLLHUP on process exit?
> > > > > > > We already do things like this. For example, when you proxy between
> > > > > > > ttys. If the process that you're reading data from has exited and closed
> > > > > > > it's end you still can't usually simply exit because it might have still
> > > > > > > buffered data that you want to read.  The way one can deal with this
> > > > > > > from  userspace is that you can observe a (POLLHUP | POLLIN) event and
> > > > > > > you keep on reading until you only observe a POLLHUP without a POLLIN
> > > > > > > event at which point you know you have read
> > > > > > > all data.
> > > > > > > I like the semantics for pidfds as well as it would indicate:
> > > > > > > - POLLHUP -> process has exited
> > > > > > > - POLLIN  -> information can be read
> > > > > >
> > > > > > Actually I think a bit different about this, in my opinion the pidfd should
> > > > > > always be readable (we would store the exit status somewhere in the future
> > > > > > which would be readable, even after task_struct is dead). So I was thinking
> > > > > > we always return EPOLLIN.  If process has not exited, then it blocks.
> > > > >
> > > > > ITYM that a pidfd polls as readable *once a task exits* and stays
> > > > > readable forever. Before a task exit, a poll on a pidfd should *not*
> > > > > yield POLLIN and reading that pidfd should *not* complete immediately.
> > > > > There's no way that, having observed POLLIN on a pidfd, you should
> > > > > ever then *not* see POLLIN on that pidfd in the future --- it's a
> > > > > one-way transition from not-ready-to-get-exit-status to
> > > > > ready-to-get-exit-status.
> > > >
> > > > What do you consider interesting state transitions? A listener on a pidfd
> > > > in epoll_wait() might be interested if the process execs for example.
> > > > That's a very valid use-case for e.g. systemd.
> > >
> > > Sure, but systemd is specialized.
> >
> > So is Android and we're not designing an interface for Android but for
> > all of userspace.
> > I hope this is clear. Service managers are quite important and systemd
> > is the largest one
> > and they can make good use of this feature.
> >
> > >
> > > There are two broad classes of programs that care about process exit
> > > status: 1) those that just want to do something and wait for it to
> > > complete, and 2) programs that want to perform detailed monitoring of
> > > processes and intervention in their state. #1 is overwhelmingly more
> > > common. The basic pidfd feature should take care of case #1 only, as
> > > wait*() in file descriptor form. I definitely don't think we should be
> > > complicating the interface and making it more error-prone (see below)
> > > for the sake of that rare program that cares about non-exit
> > > notification conditions. You're proposing a complicated combination of
> > > poll bit flags that most users (the ones who just wait to wait for
> > > processes) don't care about and that risk making the facility hard to
> > > use with existing event loops, which generally recognize readability
> > > and writability as the only properties that are worth monitoring.
> >
> > That whole pargraph is about dismissing a range of valid use-cases based on
> > assumptions such as "way more common" and
> > even argues that service managers are special cases and therefore not
> > really worth considering. I would like to be more open to other use cases.
> >
> > >
> > > > We can't use EPOLLIN for that too otherwise you'd need to to waitid(_WNOHANG)
> > > > to check whether an exit status can be read which is not nice and then you
> > > > multiplex different meanings on the same bit.
> > > > I would prefer if the exit status can only be read from the parent which is
> > > > clean and the least complicated semantics, i.e. Linus waitid() idea.
> > >
> > > Exit status information should be *at least* as broadly available
> > > through pidfds as it is through the last field of /proc/pid/stat
> > > today, and probably more broadly. I've been saying for six months now
> > > that we need to talk about *who* should have access to exit status
> > > information. We haven't had that conversation yet. My preference is to
> > > just make exit status information globally available, as FreeBSD seems
>
> Totally aside from whether or not this is a good idea but since you
> keep bringing
> this up and I'm really curious about this where is this documented and how
> does this work, please?

According to the kqueue FreeBSD man page [1] (I'm reading the FreeBSD
12 version), it's possible to register in a kqueue instead a PID of
interest via EVFILT_PROC and receive a NOTE_EXIT notification when
that process dies. NOTE_EXIT comes with the exit status of the process
that died. I don't see any requirement that EVFILT_PROC work only on
child processes of the waiter: on the contrary, the man page states
that "if a process can normally see another
process, it can attach an event to it.". This documentation reads to
me like on FreeBSD process exit status is much more widely available
than it is on Linux. Am I missing something?

[1] https://www.freebsd.org/cgi/man.cgi?query=kqueue&apropos=0&sektion=0&manpath=FreeBSD+12.0-RELEASE+and+Ports&arch=default&format=html
