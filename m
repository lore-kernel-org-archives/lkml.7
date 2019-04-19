Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6B6C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6EF217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OPa8z4Y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfDSVUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:20:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34716 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfDSVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:20:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so3109490plt.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cfEecVnvamXFtWUlfFupVj/pT2q/fHA5qW/QsQJm3qM=;
        b=OPa8z4Y2YvrsIBeX3WF5BQ4Rx5ch+6t4D91wa5a0Arsh3DktWDDQAg3V69RSxwh6O+
         00SAFOldg0Z73/BgHD7qJudLGwyP4rP9RxL9yGaB26ds7uZfBdO7J87BnvSrnLMUQRnL
         wW/7/2IOwbV+LVr++pOmK+DhMC0bHWrhzZyjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cfEecVnvamXFtWUlfFupVj/pT2q/fHA5qW/QsQJm3qM=;
        b=gdVRsfDj2ekldRLJes3XSjs3uJ5ZVmUc1jpbFmZAEDUSsqsN6xQKIUMNEsU69zGhnY
         Ntx4ibp6dDLJRx0DowWK+wJeIP4dw02xNjXVApavO2d1K29CPIRATbHBxge9+nmRKrzy
         ub61lX7xGF4fBRJPcIGwWU4TPuu4mJ7UrDG1lpUzZw4wA2VzCensuxAbWIguLCCPsgax
         e0rq0ZfGAnBEfoHdfNQLSSQAfDvKhWmO8FkhJ4Vd2euxO7yXC5/zbK1amtZwQUswFdOE
         jBK+bX8+rxkBCdbc5TlwlHtbO6GpCpETXJqDohwqT1zoNoZRX/CCxBpvikerce54CvkT
         nVAQ==
X-Gm-Message-State: APjAAAW/5U9ACUwpGGlstS6cNoQyIr3dUVC6uyM3gABmSg7O1N6HYEZp
        rIplQUuh0XZlMObdgp52V4Q0HQ==
X-Google-Smtp-Source: APXvYqy5gG+cdhXOYLjSgushpuV2mCFs+q3uhWMRlzkz4btJxsWrt0UEyG4nAfhyrQCOoCBMJRCCBw==
X-Received: by 2002:a17:902:382:: with SMTP id d2mr6081557pld.253.1555708804522;
        Fri, 19 Apr 2019 14:20:04 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i15sm7764377pfr.8.2019.04.19.14.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 14:20:03 -0700 (PDT)
Date:   Fri, 19 Apr 2019 17:20:02 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
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
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190419212002.GB44851@google.com>
References: <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
 <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:57:11PM +0200, Christian Brauner wrote:
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
> We can't use EPOLLIN for that too otherwise you'd need to to waitid(_WNOHANG)
> to check whether an exit status can be read which is not nice and then you
> multiplex different meanings on the same bit.
> I would prefer if the exit status can only be read from the parent which is
> clean and the least complicated semantics, i.e. Linus waitid() idea.
> EPOLLIN on a pidfd could very well mean that data can be read via
> a read() on the pidfd *other* than the exit status. The read could e.g.
> give you a lean struct that indicates the type of state transition: NOTIFY_EXIT,
> NOTIFY_EXEC, etc.. This way we are not bound to a specific poll event indicating
> a specific state.
> Though there's a case to be made that EPOLLHUP could indicate process exit
> and EPOLLIN a state change + read().

According to Linus, POLLHUP usually indicates that something is readable:
https://lkml.org/lkml/2019/4/18/1181
"So generally a HUP condition should mean that POLLIN and POLLOUT also
get set. Not because there's any actual _data_ to be read, but simply
because the read will not block."

I feel the future state changes such as for NOTIFY_EXEC can easily be
implemented on top of this patch.

Just for the exit notification purposes, the states are:
if process has exit_state == 0, block.
if process is zombie/dead but not reaped, then return POLLIN
if process is reaped, then return POLLIN | POLLHUP

for the exec notification case, that could be implemnted along with this with
something like:
if process has exit_state == 0, or has not exec'd since poll was called, block.
if process exec'd, then return POLLIN
if process is zombie/dead but not reaped, then return POLLIN
if process is reaped, then return POLLIN | POLLHUP

Do you agree or did I miss something?

thanks,

 - Joel

