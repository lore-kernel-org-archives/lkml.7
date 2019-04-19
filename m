Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80674C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5BA217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="UMS+LQNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfDSVNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:13:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35780 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSVNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:13:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so3042134pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u3k8H7Dq4/HsL9e+8iUrO+IN01D/TWqW3JXJfpfvBMs=;
        b=UMS+LQNnOiVR2gwfswrkFdDwI+5VHSTKM7LkLO4EQaajF4ZP3Khm/+JP3AsZASBn3H
         HZjG1t8CL0mhMXaq9uolNlNGX3ehPUAWNrHWB2tCJ/PjR8DkG/osdSarR4i7C413oCSB
         rniZcXm/ewb5VvlEctgiMCyY1WBxEOboLUUVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u3k8H7Dq4/HsL9e+8iUrO+IN01D/TWqW3JXJfpfvBMs=;
        b=K1fiyTZiVTxb45tEKy/492j71BaKsnMdgMHEeogVwxBpskXzGuQu6vj8MBnVCun+dF
         Uv5GhnE5489QBDHBJfxTh2XmOrRNZP86XU8wGdTwGTmf9X76lWNZnLRKxw4DA5tTKG0e
         npIjQ8jYnVlNn2yNCKJ9gSLIbpxNwmNTVa/GLQ6wvQVTkVpqKoJj42OvHmDnVhLjx62J
         iH+vq6SuwPIQ+PwfGjmoNeFDA4kT8UPxx+J1YpzpCm0G/3PkULoY+3opZl+26dPfib+Y
         oNqC8OfF+4kDh3wJ3bdAkftCRRIjaayPd9sqWY+qZXjr6bMwjqOarJQpJykwk5qQL5Yn
         cg8g==
X-Gm-Message-State: APjAAAWqTy9Kxq/kR2VLUWkqU3D3wYwX+8g0N0h/hm5RCRKsil4Tv4UV
        YfgA6JALCV4Jld0YDMu7AYXQaA==
X-Google-Smtp-Source: APXvYqwoLAyP32rEzMV6dpbSA25x7Lje9+VSEbdMZUvRqQPV1TMkrQGfNAM3Qfdo0zF/WqKJwNnHyg==
X-Received: by 2002:a62:4602:: with SMTP id t2mr6203412pfa.26.1555708402017;
        Fri, 19 Apr 2019 14:13:22 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m8sm9745663pgn.59.2019.04.19.14.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 14:13:20 -0700 (PDT)
Date:   Fri, 19 Apr 2019 17:13:19 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
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
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190419211319.GA44851@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
 <20190419194902.GE251571@google.com>
 <20190419200059.r2f7i7jtlsza4eun@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419200059.r2f7i7jtlsza4eun@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 10:01:00PM +0200, Christian Brauner wrote:
> On Fri, Apr 19, 2019 at 03:49:02PM -0400, Joel Fernandes wrote:
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
> 
> So your idea is that you always get EPOLLIN when the process is alive,
> i.e. epoll_wait() immediately returns for a pidfd that referes to a live
> process if you specify EPOLLIN? E.g. if I specify EPOLLIN | EPOLLHUP
> then epoll_wait() would constantly return. I would then need to check
> for EPOLLHUP, see that it is not present and then go back into the
> epoll_wait() loop and play the same game again?
> What do you need this for?

The approach of this patch is we would return EPOLLIN only once the process
exits. Until then it blocks.

> And if you have a valid reason to do this would it make sense to set
> POLLPRI if the actual exit status can be read? This way one could at
> least specify POLLPRI | POLLHUP without being constantly woken.
> 
> > we always return EPOLLIN.  If process has not exited, then it blocks.
> > 
> > However, we also are returning EPOLLERR in previous patch if the task_struct
> > has been reaped (task == NULL). I could change that to EPOLLHUP.
> 
> That would be here, right?:
> 
> > +	if (!task)
> > +		poll_flags = POLLIN | POLLRDNORM | POLLHUP;
> 
> That sounds better to me that EPOLLERR.

I see. Ok I agree with you. It is not really an error, because even though
the task_struct doesn't exist, the data such as exit status would still be
readable so IMO POLLHUP is better.

