Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D67C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D1D21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="DbYe6a3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfDSXDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:03:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36171 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDSXDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:03:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so5738080ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74XqwghFus/0XuNWi7xO30qd5NLD9w11C0kTb2/JsR0=;
        b=DbYe6a3BNqrr5ML5r0LTWBLnVQ8Qyrx4gIhdSTROFwGGG2XEER5IlSrsnPbjpMCt4O
         e2R70uJ9Mb6HC+DyND8EIUfYWkuiPO21ln6OSE29uRTNjbvig+0weOyFVdpa5+tBgpGX
         UjCjlKcqG2scu0OnRJHYXDe1kIuL0dtsGMB+Xv/Diz8HfHlPuqkx5hmUpTRup2ExP+L3
         MYSYGdNOR7nTmfYFznjO6LfNyNwVdPRkRaUXU4KabYAAglTEzgIDSUiUmU/HQ7ygVvzj
         ao+mmyM6oE+RXzvU8+tJTaEdx39/QE13k5x8xsQHGCOlHSoVXVnTGcIeaWf41QMlqbWV
         UgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74XqwghFus/0XuNWi7xO30qd5NLD9w11C0kTb2/JsR0=;
        b=r083drOhJr6d6tmtYMfCwMpRjXVEKxGhJlxzmfgoWKLV68Lezy+ifa9pW+f+lng5jY
         w8zkLwtz/vouOYaBOVjSGNrg/uGVuuRHFMHWquzjZQY6YkBx0TU4vfuLOfHjMIQf6EoP
         +esAgtrLLVJjtpbpNaLJApZWmoLRR77EwxXcZNaOdb8G0ewxgZXe/ragU2DP1GjtG4wx
         IZB3w7WTayy8+01Env3VRHS7dCOJ3IGSdfuZAT49ZUId0I46uUeDJaaegtZ/l5ml1gFd
         Zy6C5/zk1Ohd+3YR1mjuTNaWVv+sRKkoFCR++5Z3QovsS6xTo+6xpskbmyuDKxJqBoWH
         WIwg==
X-Gm-Message-State: APjAAAWKWXKNxS80856ipFFFTx2ygeVvrGRcktwW4/DWK7zI9Kt0IZf7
        Ar+fCSQx/Xmx6kS6ANBKT0MYH9ov6U6Vbzwa+D3+Jg==
X-Google-Smtp-Source: APXvYqxdq6Ys3vmWDBUaJMCGwsCZ8GwPYCMWWJXFhpv4qUXukzDomgc+aIVrcc3z56XDg2EIgQllLTm/AoPbn5q+BAE=
X-Received: by 2002:a2e:978c:: with SMTP id y12mr3792477lji.70.1555714978115;
 Fri, 19 Apr 2019 16:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <CAKOZueuBTwyrLtpVQaoTAgjGSgeHY7392sKv5uAYdy4XKNHKHQ@mail.gmail.com>
 <CAHrFyr6f_CUP__818e1u6TaHd-XpWY6NOxri4yzzR6rNY5rk_w@mail.gmail.com> <CAKOZuetiqFx0qW9rdCVWsKQxwaYK2Vis8EXsDba6=F5dp=da6Q@mail.gmail.com>
In-Reply-To: <CAKOZuetiqFx0qW9rdCVWsKQxwaYK2Vis8EXsDba6=F5dp=da6Q@mail.gmail.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Sat, 20 Apr 2019 01:02:47 +0200
Message-ID: <CAHrFyr6FntUgsCRw2b1B9+pjLQ2+pJMTULywRC1woNW4PvtyiQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Daniel Colascione <dancol@google.com>
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

On Sat, Apr 20, 2019 at 12:35 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Fri, Apr 19, 2019 at 2:48 PM Christian Brauner <christian@brauner.io> wrote:
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
>
> Nothing in my post is Android-specific. Waiting for non-child
> processes is something that lots of people want to do, which is why
> patches to enable it have been getting posted every few years for many
> years (e.g., Andy's from 2011). I, too, want to make an API for all
> over userspace. Don't attribute to me arguments that I'm not actually
> making.
>
> > I hope this is clear. Service managers are quite important and systemd
> > is the largest one
> > and they can make good use of this feature.
>
> Service managers already have the tools they need to do their job. The

No they don't. Even if they quite often have kludges and run into a lot
of problems. That's why there's interest in these features as well.

> kind of monitoring you're talking about is a niche case and an
> improved API for this niche --- which amounts to a rethought ptrace
> --- can wait for a future date, when it can be done right. Nothing in
> the model I'm advocating precludes adding an event stream API in the
> future. I don't think we should gate the ability to wait for process
> exit via pidfd on pidfds providing an entire ptrace replacement
> facility.
>
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
>
> It really ought not to be controversial to say that process managers
> make up a small fraction of the programs that wait for child
> processes.

Well, daemons tend to do those things do. System managers and container
managers are just an example of a whole class. Even if you just consider system
managers like openrc, systemd you have gotten yourself quite a large userbase.

>
> > even argues that service managers are special cases and therefore not
> > really worth considering. I would like to be more open to other use cases.
>
> It's not my position that service managers are "not worth considering"
> and you know that, so I'd appreciate your not attributing to me views
> hat I don't hold. I *am* saying that an event-based process-monitoring

It very much sounded like it. Calling them a "niche" case didn't help
given that they run quite a lot of workloads everywhere.

> API is out of scope and that it should be separate work: the
> overwhelmingly majority of process manipulation (say, in libraries
> wanting private helper processes, which is something I thought we all
> agreed would be beneficial to support) is waiting for exit.
>
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
> >
> > > just make exit status information globally available, as FreeBSD seems
> > > to do. I think it would be broadly useful for something like pkill to
> >
> > From the pdfork() FreeBSD manpage:
> > "poll(2) and select(2) allow waiting for process state transitions;
> > currently only POLLHUP is defined, and will be raised when the process dies.
> > Process state transitions can also be monitored using kqueue(2) filter
> > EVFILT_PROCDESC; currently only NOTE_EXIT is implemented."
>
> I don't understand what you're trying to demonstrate by quoting that passage.

FreeBSD obviously has thought about being able to observe
more than just NOTE_EXIT in the future.

>
> > > wait for processes to exit and to retrieve their exit information.
> > >
> > > Speaking of pkill: AIUI, in your current patch set, one can get a
> > > pidfd *only* via clone. Joel indicated that he believes poll(2)
> > > shouldn't be supported on procfs pidfds. Is that your thinking as
> > > well? If that's the case, then we're in a state where non-parents
> >
> > Yes, it is.
>
> If reading process status information from a pidfd is destructive,
> it's dangerous to share pidfds between processes. If reading
> information *isn't* destructive, how are you supposed to use poll(2)
> to wait for the next transition? Is poll destructive? If you can only
> make a new pidfd via clone, you can't get two separate event streams
> for two different users. Sharing a single pidfd via dup or SCM_RIGHTS
> becomes dangerous, because if reading status is destructive, only one
> reader can observe each event. Your proposed edge-triggered design
> makes pidfds significantly less useful, because in your design, it's
> unsafe to share a single pidfd open file description *and* there's no
> way to create a new pidfd open file description for an existing
> process.
>
> I think we should make an API for all of userspace and not just for
> container managers and systemd.

I mean,  you can go and try making arguments based on syntactical
rearrangements of things I said but I'm going to pass.

My point simply was: There are more users that would be interested
in observing more state transitions in the future.
Your argument made it sound like they are not worth considering.
I disagree.

>
> > > can't wait for process exit, and providing this facility is an
> > > important goal of the whole project.
> >
> > That's your goal.
>
> I thought we all agreed on that months ago that it's reasonable to
> allow processes to wait for non-child processes to exit. Now, out of

Uhm, I can't remember being privy to that agreement but the threads get
so long that maybe I forgot what I wrote?

> the blue, you're saying that 1) actually, we want a rich API for all
> kinds of things that aren't process exit, because systemd, and 2)

- I'm not saying we have to. It just makes it more flexible and is something
we can at least consider.
- systemd is an example of another *huge* user of this api. That neither implies
this api is "because systemd" it simply makes it worth that we
consider this use-case.

> actually, non-parents shouldn't be able to wait for process death. I

I'm sorry, who has agreed that a non-parent should be able to wait for
process death?
I know you proposed that but has anyone ever substantially supported this?
I'm happy if you can gather the necessary support for this but I just
haven't seen that yet.
