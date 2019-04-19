Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D412C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB872171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APwnfOen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfDSWhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:37:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43130 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfDSWhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:37:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id u15so5330954otq.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PnVnx2mP0gLL40JJMcQTtoT+dpugBKSZkWpUUtxjfs=;
        b=APwnfOenzr+Xc6/hHw08TaVZXefoHbikLb/EqPv6Lp81WSmfsEotkUq1FrRBwmwNZI
         7nhka3jVVb1vUYaZ2ddzD37xB3OvTLhq8PBy45CpmAzeLBPNT0bLv2QBHUJLJjSDgbY8
         G7KgRa0bN9eRignGWL3Zrn95KxG4itAObOFLPO6NsRas+/wE9sNQbyha8rN0E2pKhXP+
         J1IU4+KF9uLOluThveyMfvFuEO4OH56XJdgn+SpR7pQ2pCARD3CmwtFlGbKabdLDeAyQ
         qdklz9ZmCwdUIvalmxxfFD3MUxs0BwgcLMKY1EYujZaZORJPRwUsc42rSxtIRNVf6Sxk
         zTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PnVnx2mP0gLL40JJMcQTtoT+dpugBKSZkWpUUtxjfs=;
        b=DhuYKQSTwZekB74WoxLXIrVPoZtRDsbT16A7PdlQAkwq9g06rrb0Og6MZeWlBWCduv
         XsWwWtO7/D1asDcS4+7KNfxr93ttW04dRHb7hVQ9ierUS9guCV2y+QpH4kzKMv9D6Exk
         6xkPIjFovhm/p3Y0rbaeQ3XtbKrcXk0rxsbjNR2oWkCCCvGAzfiQAodtNE6PXOMvMQeN
         Xbr2eaw0YSVuwnlhINyBS5NPV6E1me33hLUwk1vNt/3V6JsudzTokSP0JsJf8/A8VVII
         qzivGfuDEVx/w2GhrHWyXyyEU+JPoNfXAUFZC0OSDKQcM8mTcRIan0MhNELkOlTv+PpG
         BhgQ==
X-Gm-Message-State: APjAAAUSPDtc63CcYj5Vd5yEyawK8Gj5q7Kmsudkr6KSSq5UxIBz+ys+
        ZlA5xIheZ9Br4guzyYGNWmUM7kNQprS15ReYd9+ezQ==
X-Google-Smtp-Source: APXvYqzCu/rLWC0BUTCOhNzON1kYFBstfEaINbMzoesss8JF6jz0yv5uWeV5mscts9/5qM4uBrg73CZbwBDXaO18hB0=
X-Received: by 2002:a9d:76d5:: with SMTP id p21mr3681196otl.308.1555713452671;
 Fri, 19 Apr 2019 15:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <20190419212002.GB44851@google.com> <CAKOZuetkF4zPm-oKMjnoJtvUi4iTnY-ORzPd-JpfpseMXY4yhw@mail.gmail.com>
 <20190419214506.GF251571@google.com> <CAKOZuevm2Tk+O+hUA6Fn5U_cTQ8hKwr6bv29C6RxwZXid-S-Ew@mail.gmail.com>
 <CAHrFyr5Uq5QFo1dxpO-dsqOVqTJDN9df-6myj2LZQ4=5w2mUAQ@mail.gmail.com>
In-Reply-To: <CAHrFyr5Uq5QFo1dxpO-dsqOVqTJDN9df-6myj2LZQ4=5w2mUAQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 19 Apr 2019 15:37:20 -0700
Message-ID: <CAKOZuetJTWxGP+MU61uJzS5EdzBxmBK4pzr=iy1GQ4DQmBgfVA@mail.gmail.com>
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

On Fri, Apr 19, 2019 at 3:18 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Sat, Apr 20, 2019 at 12:08 AM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Fri, Apr 19, 2019 at 2:45 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Fri, Apr 19, 2019 at 02:24:09PM -0700, Daniel Colascione wrote:
> > > > On Fri, Apr 19, 2019 at 2:20 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > On Fri, Apr 19, 2019 at 10:57:11PM +0200, Christian Brauner wrote:
> > > > > > On Fri, Apr 19, 2019 at 10:34 PM Daniel Colascione <dancol@google.com> wrote:
> > > > > > >
> > > > > > > On Fri, Apr 19, 2019 at 12:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, Apr 19, 2019 at 09:18:59PM +0200, Christian Brauner wrote:
> > > > > > > > > On Fri, Apr 19, 2019 at 03:02:47PM -0400, Joel Fernandes wrote:
> > > > > > > > > > On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> > > > > > > > > > > On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> > > > > > > > > > > >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > > > > > > > > >> On 04/16, Joel Fernandes wrote:
> > > > > > > > > > > >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > > > > > > > > > >> > >
> > > > > > > > > > > >> > > Could you explain when it should return POLLIN? When the whole
> > > > > > > > > > > >process exits?
> > > > > > > > > > > >> >
> > > > > > > > > > > >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> > > > > > > > > > > >or when it
> > > > > > > > > > > >> > is in a zombie state and there's no other thread in the thread
> > > > > > > > > > > >group.
> > > > > > > > > > > >>
> > > > > > > > > > > >> IOW, when the whole thread group exits, so it can't be used to
> > > > > > > > > > > >monitor sub-threads.
> > > > > > > > > > > >>
> > > > > > > > > > > >> just in case... speaking of this patch it doesn't modify
> > > > > > > > > > > >proc_tid_base_operations,
> > > > > > > > > > > >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> > > > > > > > > > > >going to use
> > > > > > > > > > > >> the anonymous file returned by CLONE_PIDFD ?
> > > > > > > > > > > >
> > > > > > > > > > > >I don't think procfs works that way. /proc/sub-thread-tid has
> > > > > > > > > > > >proc_tgid_base_operations despite not being a thread group leader.
> > > > > > > > > > > >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> > > > > > > > > > > >be hit trivially, and then the code will misbehave.
> > > > > > > > > > > >
> > > > > > > > > > > >@Joel: I think you'll have to either rewrite this to explicitly bail
> > > > > > > > > > > >out if you're dealing with a thread group leader, or make the code
> > > > > > > > > > > >work for threads, too.
> > > > > > > > > > >
> > > > > > > > > > > The latter case probably being preferred if this API is supposed to be
> > > > > > > > > > > useable for thread management in userspace.
> > > > > > > > > >
> > > > > > > > > > At the moment, we are not planning to use this for sub-thread management. I
> > > > > > > > > > am reworking this patch to only work on clone(2) pidfds which makes the above
> > > > > > > > >
> > > > > > > > > Indeed and agreed.
> > > > > > > > >
> > > > > > > > > > discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
> > > > > > > > > > patches, CLONE_THREAD with pidfd is not supported.
> > > > > > > > >
> > > > > > > > > Yes. We have no one asking for it right now and we can easily add this
> > > > > > > > > later.
> > > > > > > > >
> > > > > > > > > Admittedly I haven't gotten around to reviewing the patches here yet
> > > > > > > > > completely. But one thing about using POLLIN. FreeBSD is using POLLHUP
> > > > > > > > > on process exit which I think is nice as well. How about returning
> > > > > > > > > POLLIN | POLLHUP on process exit?
> > > > > > > > > We already do things like this. For example, when you proxy between
> > > > > > > > > ttys. If the process that you're reading data from has exited and closed
> > > > > > > > > it's end you still can't usually simply exit because it might have still
> > > > > > > > > buffered data that you want to read.  The way one can deal with this
> > > > > > > > > from  userspace is that you can observe a (POLLHUP | POLLIN) event and
> > > > > > > > > you keep on reading until you only observe a POLLHUP without a POLLIN
> > > > > > > > > event at which point you know you have read
> > > > > > > > > all data.
> > > > > > > > > I like the semantics for pidfds as well as it would indicate:
> > > > > > > > > - POLLHUP -> process has exited
> > > > > > > > > - POLLIN  -> information can be read
> > > > > > > >
> > > > > > > > Actually I think a bit different about this, in my opinion the pidfd should
> > > > > > > > always be readable (we would store the exit status somewhere in the future
> > > > > > > > which would be readable, even after task_struct is dead). So I was thinking
> > > > > > > > we always return EPOLLIN.  If process has not exited, then it blocks.
> > > > > > >
> > > > > > > ITYM that a pidfd polls as readable *once a task exits* and stays
> > > > > > > readable forever. Before a task exit, a poll on a pidfd should *not*
> > > > > > > yield POLLIN and reading that pidfd should *not* complete immediately.
> > > > > > > There's no way that, having observed POLLIN on a pidfd, you should
> > > > > > > ever then *not* see POLLIN on that pidfd in the future --- it's a
> > > > > > > one-way transition from not-ready-to-get-exit-status to
> > > > > > > ready-to-get-exit-status.
> > > > > >
> > > > > > What do you consider interesting state transitions? A listener on a pidfd
> > > > > > in epoll_wait() might be interested if the process execs for example.
> > > > > > That's a very valid use-case for e.g. systemd.
> > > > > > We can't use EPOLLIN for that too otherwise you'd need to to waitid(_WNOHANG)
> > > > > > to check whether an exit status can be read which is not nice and then you
> > > > > > multiplex different meanings on the same bit.
> > > > > > I would prefer if the exit status can only be read from the parent which is
> > > > > > clean and the least complicated semantics, i.e. Linus waitid() idea.
> > > > > > EPOLLIN on a pidfd could very well mean that data can be read via
> > > > > > a read() on the pidfd *other* than the exit status. The read could e.g.
> > > > > > give you a lean struct that indicates the type of state transition: NOTIFY_EXIT,
> > > > > > NOTIFY_EXEC, etc.. This way we are not bound to a specific poll event indicating
> > > > > > a specific state.
> > > > > > Though there's a case to be made that EPOLLHUP could indicate process exit
> > > > > > and EPOLLIN a state change + read().
> > > > >
> > > > > According to Linus, POLLHUP usually indicates that something is readable:
> > > >
> > > > I don't think Linus said that POLLHUP means readable. He did say that
> > > > it usually doesn't make sense to set POLLHUP without POLLIN, but
> > > > that's not the same as POLLHUP indicating readability.
> > >
> > > Ok, fair enough.
> > >
> > > > > https://lkml.org/lkml/2019/4/18/1181
> > > > > "So generally a HUP condition should mean that POLLIN and POLLOUT also
> > > > > get set. Not because there's any actual _data_ to be read, but simply
> > > > > because the read will not block."
> > > > >
> > > > > I feel the future state changes such as for NOTIFY_EXEC can easily be
> > > > > implemented on top of this patch.
> > > > >
> > > > > Just for the exit notification purposes, the states are:
> > > > > if process has exit_state == 0, block.
> > > > > if process is zombie/dead but not reaped, then return POLLIN
> > > > > if process is reaped, then return POLLIN | POLLHUP
> > > >
> > > > Setting POLLHUP when the process is reaped is harmless, but I don't
> > > > think it's useful. I can't think of a reason that anyone would care.
> > >
> > > We can also outright remove it. Oleg seemed to not mind it, in fact he said
> > > it may be useful to indicate the reap status so at least I am inclined to
> > > leave it in.
> > >
> > > > You can't block and wait on reaping, so you could only busy-wait, and
> > > > you can look for ESRCH on any proc file today to detect reaping. I'd
> > >
> > > proc file reading is racy though. We shouldn't even talk about that since the
> > > point of pidfd is to avoid such raw "pid" related races.
> >
> > It's not racy if you have a procfs dirfd handle open anyway. But since
> > we moved to the two-kinds-of-file-descriptor model, there's no way to
> > reliably open the procfs directory FD for a process that's exited but
> > that's not yet been reaped. The fdinfo mechanism doesn't solve this
>
> Uhm, maybe I'm slow but why?
>
> static int do_child(void *p)
> {
>         exit(EXIT_SUCCESS);
> }
>
> pid_t pid = clone(do_child, CLONE_PIDFD, &pidfd);
>
> sleep(10);
>
> /* process exits but is not reaped yet */
> procfd = open("/proc/pid");
>
> if (pidfd_send_signal(pidfd, 0, NULL, 0) == 0)
>         /* procfd is valid */
>
> waitpid(pid);

pidfd_send_signal will fail on a zombie, won't it? Or am I slow? :-)
