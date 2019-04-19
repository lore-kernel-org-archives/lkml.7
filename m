Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A9CC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02F720821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="VG4YzUHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDSU5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:57:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDSU5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:57:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id h21so5539202ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mc8m+moEJITkvv7tcKWJ/u36imYJnwxGy3M0tYcmGgc=;
        b=VG4YzUHDQUjJy4KWZ0IAXKLszdM8zM5abCV++aJeoxlGp3DWX2Og9XU3vgvJtsy4ua
         gwGrew7zv91gmUoYmvGUB7yRiL8k8dm1afksgP18dtzWVfM1SZJ5B+iRMGRO5gHnDcev
         5E6dQOSRBR71Zy9eP+ivXyiaI18lC20sdIoC1MD7Auzcww0w2vHCwgGDsLPshUWBpFcK
         ZGxgqb5KEdHvHaPeFH/w+JKw6GMwtQML4E/ysKYGj8efG35cafNGGlaRDNsFvEDOhio9
         G0qWMShEy6MJK0KOrCNHUEtrhYwIT11RLqXgGanOGVxOs/Vom558NIWdQiCJlu8NJlwt
         u1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mc8m+moEJITkvv7tcKWJ/u36imYJnwxGy3M0tYcmGgc=;
        b=E6Pv+z/aR4n4YvHzMBUlqnd/QzltnycB3yiage/ee4RieWG6NR7GvD6bL8n3MNu+Ox
         BJUP4tDi6ZIKwU6NJlyJoUK6xVhhUjb3pg2H0ztEtYm+xc0QQFM/jv0H1u6g05QzRsP0
         0zl3rSWZw2xa04nI63eB7OzoQLjUhS80yQ3JkTfAWd4JuBGN02LCshyd21AIiFNmgJaE
         kY3QqEkfUCm8Z5Khvc0RYV0VbBZg0veYmQ6YK6Qm4yywqtEVYEptQvlmfONLLDz8w89c
         QV9hQ8F6Y4mBvgrTqGjICvsqnW8HXHYIqBFdt4KFiOZqk+vWM/gRC1WmzMEC9rjjiL2l
         ihsw==
X-Gm-Message-State: APjAAAW7687VMfJa9m/OEKSH9YdmrO49I0op9qBPngzKPk4/rV/P+pX9
        u3IvIolWZz8N9nyWqS9sD6LEtmW7naCAUdJ0NgZEEA==
X-Google-Smtp-Source: APXvYqxO0HDBEvOnE5QlJr7xKgsh+21XyLDRcGR6nWVwXE5w2UlDGWuISvOhhpj5K4c0tmQyL7rMftCj3gKOlgrSVF8=
X-Received: by 2002:a2e:8550:: with SMTP id u16mr3326389ljj.11.1555707442235;
 Fri, 19 Apr 2019 13:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
In-Reply-To: <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Fri, 19 Apr 2019 22:57:11 +0200
Message-ID: <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
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

On Fri, Apr 19, 2019 at 10:34 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Fri, Apr 19, 2019 at 12:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Apr 19, 2019 at 09:18:59PM +0200, Christian Brauner wrote:
> > > On Fri, Apr 19, 2019 at 03:02:47PM -0400, Joel Fernandes wrote:
> > > > On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> > > > > On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> > > > > >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > > >> On 04/16, Joel Fernandes wrote:
> > > > > >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > > > >> > >
> > > > > >> > > Could you explain when it should return POLLIN? When the whole
> > > > > >process exits?
> > > > > >> >
> > > > > >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> > > > > >or when it
> > > > > >> > is in a zombie state and there's no other thread in the thread
> > > > > >group.
> > > > > >>
> > > > > >> IOW, when the whole thread group exits, so it can't be used to
> > > > > >monitor sub-threads.
> > > > > >>
> > > > > >> just in case... speaking of this patch it doesn't modify
> > > > > >proc_tid_base_operations,
> > > > > >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> > > > > >going to use
> > > > > >> the anonymous file returned by CLONE_PIDFD ?
> > > > > >
> > > > > >I don't think procfs works that way. /proc/sub-thread-tid has
> > > > > >proc_tgid_base_operations despite not being a thread group leader.
> > > > > >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> > > > > >be hit trivially, and then the code will misbehave.
> > > > > >
> > > > > >@Joel: I think you'll have to either rewrite this to explicitly bail
> > > > > >out if you're dealing with a thread group leader, or make the code
> > > > > >work for threads, too.
> > > > >
> > > > > The latter case probably being preferred if this API is supposed to be
> > > > > useable for thread management in userspace.
> > > >
> > > > At the moment, we are not planning to use this for sub-thread management. I
> > > > am reworking this patch to only work on clone(2) pidfds which makes the above
> > >
> > > Indeed and agreed.
> > >
> > > > discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
> > > > patches, CLONE_THREAD with pidfd is not supported.
> > >
> > > Yes. We have no one asking for it right now and we can easily add this
> > > later.
> > >
> > > Admittedly I haven't gotten around to reviewing the patches here yet
> > > completely. But one thing about using POLLIN. FreeBSD is using POLLHUP
> > > on process exit which I think is nice as well. How about returning
> > > POLLIN | POLLHUP on process exit?
> > > We already do things like this. For example, when you proxy between
> > > ttys. If the process that you're reading data from has exited and closed
> > > it's end you still can't usually simply exit because it might have still
> > > buffered data that you want to read.  The way one can deal with this
> > > from  userspace is that you can observe a (POLLHUP | POLLIN) event and
> > > you keep on reading until you only observe a POLLHUP without a POLLIN
> > > event at which point you know you have read
> > > all data.
> > > I like the semantics for pidfds as well as it would indicate:
> > > - POLLHUP -> process has exited
> > > - POLLIN  -> information can be read
> >
> > Actually I think a bit different about this, in my opinion the pidfd should
> > always be readable (we would store the exit status somewhere in the future
> > which would be readable, even after task_struct is dead). So I was thinking
> > we always return EPOLLIN.  If process has not exited, then it blocks.
>
> ITYM that a pidfd polls as readable *once a task exits* and stays
> readable forever. Before a task exit, a poll on a pidfd should *not*
> yield POLLIN and reading that pidfd should *not* complete immediately.
> There's no way that, having observed POLLIN on a pidfd, you should
> ever then *not* see POLLIN on that pidfd in the future --- it's a
> one-way transition from not-ready-to-get-exit-status to
> ready-to-get-exit-status.

What do you consider interesting state transitions? A listener on a pidfd
in epoll_wait() might be interested if the process execs for example.
That's a very valid use-case for e.g. systemd.
We can't use EPOLLIN for that too otherwise you'd need to to waitid(_WNOHANG)
to check whether an exit status can be read which is not nice and then you
multiplex different meanings on the same bit.
I would prefer if the exit status can only be read from the parent which is
clean and the least complicated semantics, i.e. Linus waitid() idea.
EPOLLIN on a pidfd could very well mean that data can be read via
a read() on the pidfd *other* than the exit status. The read could e.g.
give you a lean struct that indicates the type of state transition: NOTIFY_EXIT,
NOTIFY_EXEC, etc.. This way we are not bound to a specific poll event indicating
a specific state.
Though there's a case to be made that EPOLLHUP could indicate process exit
and EPOLLIN a state change + read().
