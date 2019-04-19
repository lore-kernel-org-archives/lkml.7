Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5344C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6033D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bsqIfqxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfDSUeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:34:36 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38078 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDSUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:34:35 -0400
Received: by mail-ua1-f66.google.com with SMTP id t15so2060016uao.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvRGakCeJqqdNk1DtC1nn2B7pbi0sEcCooioNgUV1v4=;
        b=bsqIfqxlo3ORWn8Xmg1yU1Qg4299WoXlwo14yV4kgBhHDQqkxJVQot9/9qEDr7lqv0
         WFCOfp3yYDOZLj1d/FoDJ8D1rI4Wlqxr4tg2KAwNrD/xhl6pfgSBS4IigVseMyTRMTqL
         qLK1W8Z1vrVXl7LfOHu8vg4itTWFsPQvsUIRC4qf2M6znAjDlWVMl/y8yF5tdmeXJrHs
         CggmcFVgogxsYUk3gH41C/6raJdbsp7gLCcr3Mt12Qpns5q0kPw8gF/AGT4Ka1k/Xu57
         C7s0V7twls9XNlaQtr6OWTKnnp969/fN79UTlcOM0mzZQ3qY8pbB421iZNyQPMfwSx5K
         VUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvRGakCeJqqdNk1DtC1nn2B7pbi0sEcCooioNgUV1v4=;
        b=fzRPLc8o9fzrxl7dTkW2gSJqB4wNfyFO4dCLAbAW/OedjEMGFIsZt+5/Ecinzkg6qf
         0W7hJFD1MvYkLIUTnY63GWCKkbJaR/ZnHuVey2+YmuF/7fjZwbSECMe+JnlS+KRg3hlL
         C99vXZjWZ0tVY4qh22DRLgORaAih+FUSafQ409DeA+64R67Ne84jPC0FhPCWqVFjGIRd
         V2Kyi0dbmlODnqHcI2bF48BO0jw4QesYEi8JmCIbADSBp07nNtIOS+w/00HSRA9CcBh+
         D/1bn/MUCNXXc/0tIYdBne7HY8UjhbguWB9Fbld1hJqKPcf2YXtmA3R0OX1ViX5C1yi8
         NWMw==
X-Gm-Message-State: APjAAAVH73cxO8W7WzkRY5FU4L4x5xMbr3BFb2oHv7jmkXdTHv2TwouC
        MFoTuCgoK6Rwi/5N/UMAVf3zVO0RMCJM3htov0721A==
X-Google-Smtp-Source: APXvYqxKTRrTOVvN6NZG2oJpX1yCy7ib3VvkOhl8JTYudnRgF+v5LtmghpjrAzjWm6y/IAqEM5dQ6JGXEHh24g5C01w=
X-Received: by 2002:ab0:14c6:: with SMTP id f6mr3229939uae.30.1555706074042;
 Fri, 19 Apr 2019 13:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
In-Reply-To: <20190419194902.GE251571@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 19 Apr 2019 13:34:22 -0700
Message-ID: <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Christian Brauner <christian@brauner.io>,
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

On Fri, Apr 19, 2019 at 12:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Apr 19, 2019 at 09:18:59PM +0200, Christian Brauner wrote:
> > On Fri, Apr 19, 2019 at 03:02:47PM -0400, Joel Fernandes wrote:
> > > On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> > > > On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> > > > >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >> On 04/16, Joel Fernandes wrote:
> > > > >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > > >> > >
> > > > >> > > Could you explain when it should return POLLIN? When the whole
> > > > >process exits?
> > > > >> >
> > > > >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> > > > >or when it
> > > > >> > is in a zombie state and there's no other thread in the thread
> > > > >group.
> > > > >>
> > > > >> IOW, when the whole thread group exits, so it can't be used to
> > > > >monitor sub-threads.
> > > > >>
> > > > >> just in case... speaking of this patch it doesn't modify
> > > > >proc_tid_base_operations,
> > > > >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> > > > >going to use
> > > > >> the anonymous file returned by CLONE_PIDFD ?
> > > > >
> > > > >I don't think procfs works that way. /proc/sub-thread-tid has
> > > > >proc_tgid_base_operations despite not being a thread group leader.
> > > > >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> > > > >be hit trivially, and then the code will misbehave.
> > > > >
> > > > >@Joel: I think you'll have to either rewrite this to explicitly bail
> > > > >out if you're dealing with a thread group leader, or make the code
> > > > >work for threads, too.
> > > >
> > > > The latter case probably being preferred if this API is supposed to be
> > > > useable for thread management in userspace.
> > >
> > > At the moment, we are not planning to use this for sub-thread management. I
> > > am reworking this patch to only work on clone(2) pidfds which makes the above
> >
> > Indeed and agreed.
> >
> > > discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
> > > patches, CLONE_THREAD with pidfd is not supported.
> >
> > Yes. We have no one asking for it right now and we can easily add this
> > later.
> >
> > Admittedly I haven't gotten around to reviewing the patches here yet
> > completely. But one thing about using POLLIN. FreeBSD is using POLLHUP
> > on process exit which I think is nice as well. How about returning
> > POLLIN | POLLHUP on process exit?
> > We already do things like this. For example, when you proxy between
> > ttys. If the process that you're reading data from has exited and closed
> > it's end you still can't usually simply exit because it might have still
> > buffered data that you want to read.  The way one can deal with this
> > from  userspace is that you can observe a (POLLHUP | POLLIN) event and
> > you keep on reading until you only observe a POLLHUP without a POLLIN
> > event at which point you know you have read
> > all data.
> > I like the semantics for pidfds as well as it would indicate:
> > - POLLHUP -> process has exited
> > - POLLIN  -> information can be read
>
> Actually I think a bit different about this, in my opinion the pidfd should
> always be readable (we would store the exit status somewhere in the future
> which would be readable, even after task_struct is dead). So I was thinking
> we always return EPOLLIN.  If process has not exited, then it blocks.

ITYM that a pidfd polls as readable *once a task exits* and stays
readable forever. Before a task exit, a poll on a pidfd should *not*
yield POLLIN and reading that pidfd should *not* complete immediately.
There's no way that, having observed POLLIN on a pidfd, you should
ever then *not* see POLLIN on that pidfd in the future --- it's a
one-way transition from not-ready-to-get-exit-status to
ready-to-get-exit-status.

Besides, didn't Linux say that he wanted waitpid(2) to be the function
for exit status on a pidfd, not read(2)? It doesn't really matter:
POLLIN on a pidfd would just make "I, the kernel, say that waitpid on
this FD won't block", whereas for something like socket, it would mean
"I, the kernel, say read(2) on this FD won't block".

I don't see the need for POLLHUP in pidfds at all. IMHO, we shouldn't
include it. "Hangup" doesn't have an obvious meaning distinct from
exit, and we might want the POLLHUP bit for something else in the
future. What would a caller do with POLLHUP? If the answer is
"something to do with ptrace", let's defer that to some future work,
since ptrace has a ton of moving parts I don't want to consider right
now.
