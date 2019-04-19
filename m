Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632BEC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09865208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Workixur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfDSVVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:21:17 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44375 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfDSVVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:21:17 -0400
Received: by mail-vs1-f66.google.com with SMTP id j184so3413168vsd.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YD3ro3dBkJgXvaLFB2ikEjNFYEYkV6p1e8OY3sDeVCs=;
        b=WorkixurkmyCuEP4N+0Kly9/LPit5nC/7TZkRR88eMhDaM2lGdRO3MB1Kfub9LQ6kW
         qzdnDIcvIFf3fiXglAhDx2KRx2gKEjwmwzQ6oiNrFxxoDjcASDK3ZoqqnuzyQUR83lnE
         RNPW7yoIkJXZE/wzgYZVOd3xdvfczITLTAb0uF4Ggf5fehhEGcyqJGG9YQk92nxLsfZL
         C+OMVeswatA15+moJmG52pquHEwuJ6Fw+rLKX1c2AJvmdtFO2oDxr7dleKMKPND9HV9N
         4HwqusppnWzYRCrAefIwk0uj94RtNMnyOJmwJzYeBBBgAOFqrtsRldwaBqs2X82SzxM5
         7V6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YD3ro3dBkJgXvaLFB2ikEjNFYEYkV6p1e8OY3sDeVCs=;
        b=mGAkK1nkh+1LkwABK48cWNAab2w1wsTNDlyJCoADPjjiZTNc++sKeD4UPEf9poY0FJ
         CJ84Z0RwoMnRJUvcNwpnWRQuadDP5vRIl/K0sLse8RNd1roUqqweD0NQAP5FMiCXiL0v
         I1jtjcMOXHKOkf2LF67jUwgPAwpOV4kFbLtmF476iy4US1EmofmpaBuGYgk6db0PHoWW
         QiqPAv7dbXJ9CooWWqGcsSLZl/MMkM4xZMr+ZheyPKcOeUmtnOYJom9pS7wpD57L3mY3
         Ph64wpn+ywUhGoZ0l7Hm8ih04qrZxNIeoOGqJ4sdi4FnMTTpo+P1kA/WT1bmizYjHcIG
         Q5MA==
X-Gm-Message-State: APjAAAUBQaC4dzbhSG6U+ZjAHi74mijJMVMjnOYYLG5Co/GZp8RGR2Ca
        dzKnKHLEX74uGii+BwyLWnKmIZXHaGliAk438pfp8w==
X-Google-Smtp-Source: APXvYqwrvsDIM4JnL1V0YYigFUmcIoqhzMEpDJhjraMf+lCXZ3sG2totRwADCT0MT4Dv31HHY1PDNu8nJ3uN/fRcnzU=
X-Received: by 2002:a67:bc01:: with SMTP id t1mr3429898vsn.149.1555708875346;
 Fri, 19 Apr 2019 14:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com> <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
In-Reply-To: <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 19 Apr 2019 14:21:03 -0700
Message-ID: <CAKOZueuBTwyrLtpVQaoTAgjGSgeHY7392sKv5uAYdy4XKNHKHQ@mail.gmail.com>
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

On Fri, Apr 19, 2019 at 1:57 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Fri, Apr 19, 2019 at 10:34 PM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Fri, Apr 19, 2019 at 12:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Fri, Apr 19, 2019 at 09:18:59PM +0200, Christian Brauner wrote:
> > > > On Fri, Apr 19, 2019 at 03:02:47PM -0400, Joel Fernandes wrote:
> > > > > On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> > > > > > On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> > > > > > >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > > > >> On 04/16, Joel Fernandes wrote:
> > > > > > >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > > > > >> > >
> > > > > > >> > > Could you explain when it should return POLLIN? When the whole
> > > > > > >process exits?
> > > > > > >> >
> > > > > > >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> > > > > > >or when it
> > > > > > >> > is in a zombie state and there's no other thread in the thread
> > > > > > >group.
> > > > > > >>
> > > > > > >> IOW, when the whole thread group exits, so it can't be used to
> > > > > > >monitor sub-threads.
> > > > > > >>
> > > > > > >> just in case... speaking of this patch it doesn't modify
> > > > > > >proc_tid_base_operations,
> > > > > > >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> > > > > > >going to use
> > > > > > >> the anonymous file returned by CLONE_PIDFD ?
> > > > > > >
> > > > > > >I don't think procfs works that way. /proc/sub-thread-tid has
> > > > > > >proc_tgid_base_operations despite not being a thread group leader.
> > > > > > >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> > > > > > >be hit trivially, and then the code will misbehave.
> > > > > > >
> > > > > > >@Joel: I think you'll have to either rewrite this to explicitly bail
> > > > > > >out if you're dealing with a thread group leader, or make the code
> > > > > > >work for threads, too.
> > > > > >
> > > > > > The latter case probably being preferred if this API is supposed to be
> > > > > > useable for thread management in userspace.
> > > > >
> > > > > At the moment, we are not planning to use this for sub-thread management. I
> > > > > am reworking this patch to only work on clone(2) pidfds which makes the above
> > > >
> > > > Indeed and agreed.
> > > >
> > > > > discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
> > > > > patches, CLONE_THREAD with pidfd is not supported.
> > > >
> > > > Yes. We have no one asking for it right now and we can easily add this
> > > > later.
> > > >
> > > > Admittedly I haven't gotten around to reviewing the patches here yet
> > > > completely. But one thing about using POLLIN. FreeBSD is using POLLHUP
> > > > on process exit which I think is nice as well. How about returning
> > > > POLLIN | POLLHUP on process exit?
> > > > We already do things like this. For example, when you proxy between
> > > > ttys. If the process that you're reading data from has exited and closed
> > > > it's end you still can't usually simply exit because it might have still
> > > > buffered data that you want to read.  The way one can deal with this
> > > > from  userspace is that you can observe a (POLLHUP | POLLIN) event and
> > > > you keep on reading until you only observe a POLLHUP without a POLLIN
> > > > event at which point you know you have read
> > > > all data.
> > > > I like the semantics for pidfds as well as it would indicate:
> > > > - POLLHUP -> process has exited
> > > > - POLLIN  -> information can be read
> > >
> > > Actually I think a bit different about this, in my opinion the pidfd should
> > > always be readable (we would store the exit status somewhere in the future
> > > which would be readable, even after task_struct is dead). So I was thinking
> > > we always return EPOLLIN.  If process has not exited, then it blocks.
> >
> > ITYM that a pidfd polls as readable *once a task exits* and stays
> > readable forever. Before a task exit, a poll on a pidfd should *not*
> > yield POLLIN and reading that pidfd should *not* complete immediately.
> > There's no way that, having observed POLLIN on a pidfd, you should
> > ever then *not* see POLLIN on that pidfd in the future --- it's a
> > one-way transition from not-ready-to-get-exit-status to
> > ready-to-get-exit-status.
>
> What do you consider interesting state transitions? A listener on a pidfd
> in epoll_wait() might be interested if the process execs for example.
> That's a very valid use-case for e.g. systemd.

Sure, but systemd is specialized.

There are two broad classes of programs that care about process exit
status: 1) those that just want to do something and wait for it to
complete, and 2) programs that want to perform detailed monitoring of
processes and intervention in their state. #1 is overwhelmingly more
common. The basic pidfd feature should take care of case #1 only, as
wait*() in file descriptor form. I definitely don't think we should be
complicating the interface and making it more error-prone (see below)
for the sake of that rare program that cares about non-exit
notification conditions. You're proposing a complicated combination of
poll bit flags that most users (the ones who just wait to wait for
processes) don't care about and that risk making the facility hard to
use with existing event loops, which generally recognize readability
and writability as the only properties that are worth monitoring.

> We can't use EPOLLIN for that too otherwise you'd need to to waitid(_WNOHANG)
> to check whether an exit status can be read which is not nice and then you
> multiplex different meanings on the same bit.
> I would prefer if the exit status can only be read from the parent which is
> clean and the least complicated semantics, i.e. Linus waitid() idea.

Exit status information should be *at least* as broadly available
through pidfds as it is through the last field of /proc/pid/stat
today, and probably more broadly. I've been saying for six months now
that we need to talk about *who* should have access to exit status
information. We haven't had that conversation yet. My preference is to
just make exit status information globally available, as FreeBSD seems
to do. I think it would be broadly useful for something like pkill to
wait for processes to exit and to retrieve their exit information.

Speaking of pkill: AIUI, in your current patch set, one can get a
pidfd *only* via clone. Joel indicated that he believes poll(2)
shouldn't be supported on procfs pidfds. Is that your thinking as
well? If that's the case, then we're in a state where non-parents
can't wait for process exit, and providing this facility is an
important goal of the whole project.

> EPOLLIN on a pidfd could very well mean that data can be read via
> a read() on the pidfd *other* than the exit status. The read could e.g.
> give you a lean struct that indicates the type of state transition: NOTIFY_EXIT,
> NOTIFY_EXEC, etc.. This way we are not bound to a specific poll event indicating
> a specific state.
> Though there's a case to be made that EPOLLHUP could indicate process exit
> and EPOLLIN a state change + read().

And do you imagine making read() destructive? Does that read() then
reset the POLLIN state? You're essentially proposing that a pidfd
provide an "event stream" interface, delivering notifications packets
that indicate state changes like "process exited" or "process stopped"
or "process execed". While this sort of interface is powerful and has
some nice properties that tools like debuggers and daemon monitors
might want to use, I think it's too complicated and error prone for
the overwhelmingly common case of wanting to monitor process lifetime.
I'd much rather pidfd provide a simple one-state-transition
level-triggered (not edge-triggered, as your suggestion implies)
facility. If we want to let sophisticated programs read a stream of
notification packets indicating changes in process state, we can
provide that as a separate interface in future work.

I like Linus' idea of just making waitid(2) (not waitpid(2), as I
mistakenly mentioned earlier) on a pidfd act *exactly* like a
waitid(2) on the corresponding process and making POLLIN just mean
"waitid will succeed". It's a nice simple model that's easy to reason
about and that makes it easy to port existing code to pidfds.

I am very much against signaling additional information on basic
pidfds using non-POLLIN poll flags.
