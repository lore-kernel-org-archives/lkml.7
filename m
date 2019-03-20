Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D59C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7791B2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dK4LQal2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCTBwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:52:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39846 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCTBwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:52:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id t28so765875qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=URYsqXzm4tpouWLG3Ria7i5qb4uisz6pczg3Jg8fHXg=;
        b=dK4LQal2tGrvNa1nScgf/3oiN6mSuxN8xz/BwabXf8ZuCHrRh46yKA5uAtsZ5TrC9W
         rKmwOcQdsboFYsplDCMiuBD3eES7eNcSjP664ETourBZuFhgRal0ClFZQ8ngCB6gwYPE
         xTlF7aoAGjTcd7R3j2eQySf6kP/FuKOGS3dmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=URYsqXzm4tpouWLG3Ria7i5qb4uisz6pczg3Jg8fHXg=;
        b=HUhL+prCGeN5gXEuSFph2IUdJYSXApBR2zVI09zzM0MeDLSzNQJpmBNRsWgqXZTx6H
         Qkyx9dK5f8EGVMWX4zvwWhrPEXEgGDh1cZMn/OTgmwi16+CAyzw07MfklFxic0BdwQrJ
         nX5rEG228+wr5dtg2PaY/COmc8WPIPMi4o38RLlvhzBJJTmmIOBhfcruL1y3zNm72Jis
         pbsSL3+/qkXGJM70GZ2NXfrKCH4qpVwIUtC0o2ZboEoCpSozPRLayw9mT/CEAR1bHdyb
         VLKWxaizN+4Bif6HjFpor5Va8rG2JBF5UVx9xasVz6mfGlUZ17IadA4ZzOGe3ybJKDxb
         KwdQ==
X-Gm-Message-State: APjAAAW8fk/JSNybCmcNCYvEXUniaR+eNzbOiCESDzI7V4qldpbp6+qu
        5R8tevRlJhLfNW/FIDe6nZDKcA==
X-Google-Smtp-Source: APXvYqx+foeYw1DyavKsbljAbp9XQfjAgI+VcP6eQPgdScgF62bYg9Q0IuXwzRlzeQxwUQx3Dl+qvA==
X-Received: by 2002:aed:20e4:: with SMTP id 91mr4530293qtb.362.1553046771741;
        Tue, 19 Mar 2019 18:52:51 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id z140sm409609qka.81.2019.03.19.18.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:52:50 -0700 (PDT)
Date:   Tue, 19 Mar 2019 21:52:49 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190320015249.GC129907@google.com>
References: <20190316185726.jc53aqq5ph65ojpk@brauner.io>
 <CAJuCfpF-uYpUZ1RO99i2qEw5Ou4nSimSkiQvnNQ_rv8ogHKRfw@mail.gmail.com>
 <20190317015306.GA167393@google.com>
 <20190317114238.ab6tvvovpkpozld5@brauner.io>
 <CAKOZuetZPhqQqSgZpyY0cLgy0jroLJRx-B93rkQzcOByL8ih_Q@mail.gmail.com>
 <20190318002949.mqknisgt7cmjmt7n@brauner.io>
 <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319231020.tdcttojlbmx57gke@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:10:23AM +0100, Christian Brauner wrote:
> On Tue, Mar 19, 2019 at 03:48:32PM -0700, Daniel Colascione wrote:
> > On Tue, Mar 19, 2019 at 3:14 PM Christian Brauner <christian@brauner.io> wrote:
> > > So I dislike the idea of allocating new inodes from the procfs super
> > > block. I would like to avoid pinning the whole pidfd concept exclusively
> > > to proc. The idea is that the pidfd API will be useable through procfs
> > > via open("/proc/<pid>") because that is what users expect and really
> > > wanted to have for a long time. So it makes sense to have this working.
> > > But it should really be useable without it. That's why translate_pid()
> > > and pidfd_clone() are on the table.  What I'm saying is, once the pidfd
> > > api is "complete" you should be able to set CONFIG_PROCFS=N - even
> > > though that's crazy - and still be able to use pidfds. This is also a
> > > point akpm asked about when I did the pidfd_send_signal work.
> > 
> > I agree that you shouldn't need CONFIG_PROCFS=Y to use pidfds. One
> > crazy idea that I was discussing with Joel the other day is to just
> > make CONFIG_PROCFS=Y mandatory and provide a new get_procfs_root()
> > system call that returned, out of thin air and independent of the
> > mount table, a procfs root directory file descriptor for the caller's
> > PID namspace and suitable for use with openat(2).
> 
> Even if this works I'm pretty sure that Al and a lot of others will not
> be happy about this. A syscall to get an fd to /proc? That's not going
> to happen and I don't see the need for a separate syscall just for that.
> (I do see the point of making CONFIG_PROCFS=y the default btw.)

I think his point here was that he wanted a handle to procfs no matter where
it was mounted and then can later use openat on that. Agreed that it may be
unnecessary unless there is a usecase for it, and especially if the /proc
directory being the defacto mountpoint for procfs is a universal convention.

> Inode allocation from the procfs mount for the file descriptors Joel
> wants is not correct. Their not really procfs file descriptors so this
> is a nack. We can't just hook into proc that way.

I was not particular about using procfs mount for the FDs but that's the only
way I knew how to do it until you pointed out anon_inode (my grep skills
missed that), so thank you!

> > C'mon: /proc is used by everyone today and almost every program breaks
> > if it's not around. The string "/proc" is already de facto kernel ABI.
> > Let's just drop the pretense of /proc being optional and bake it into
> > the kernel proper, then give programs a way to get to /proc that isn't
> > tied to any particular mount configuration. This way, we don't need a
> > translate_pid(), since callers can just use procfs to do the same
> > thing. (That is, if I understand correctly what translate_pid does.)
> 
> I'm not sure what you think translate_pid() is doing since you're not
> saying what you think it does.
> Examples from the old patchset:
> translate_pid(pid, ns, -1)      - get pid in our pid namespace
> translate_pid(pid, -1, ns)      - get pid in other pid namespace
> translate_pid(1, ns, -1)        - get pid of init task for namespace
> translate_pid(pid, -1, ns) > 0  - is pid is reachable from ns?
> translate_pid(1, ns1, ns2) > 0  - is ns1 inside ns2?
> translate_pid(1, ns1, ns2) == 0 - is ns1 outside ns2?
> translate_pid(1, ns1, ns2) == 1 - is ns1 equal ns2?
> 
> Allowing this syscall to yield pidfds as proper regular file fds and
> also taking pidfds as argument is an excellent way to kill a few
> problems at once:
> - cheap pid namespace introspection
> - creates a bridge between the "old" pid-based api and the "new" pidfd api

This second point would solve the problem of getting a new pidfd given a pid
indeed, without depending on /proc/<pid> at all. So kudos for that and I am
glad you are making it return pidfds (but correct me if I misunderstood what
you're planning to do with translate_fd). It also obviates any need for
dealing with procfs mount points.

> - allows us to get proper non-directory file descriptors for any pids we
>   like

Here I got a bit lost. AIUI pidfd is a directory fd. Why would we want it to
not be a directory fd? That would be ambigiuous with what pidfd_send_signal
expects.

Also would it be a bad idea to extend translate_pid to also do what we want
for the pidfd_wait syscall?  So translate_fd in this case would return an fd
that is just used for the pid's death status.

All of these extensions seem to mean translate_pid should probably take a
fourth parameter that tells it the target translation type?

They way I am hypothesizing, translate_pid, it should probably be
- translation to a pid in some ns
- translation of a pid to a pidfd
- translation of a pid to a "wait" fd which returns the death/reap process status.

If that makes sense, that would also avoid the need for a new syscall we are adding.

> The additional advantage is that people are already happy to add this
> syscall so simply extending it and routing it through the pidfd tree or
> Eric's tree is reasonable. (It should probably grow a flag argument. I
> need to start prototyping this.)

Great!

> > 
> > We still need a pidfd_clone() for atomicity reasons, but that's a
> > separate story. My goal is to be able to write a library that
> 
> Yes, on my todo list and I have a ported patch based on prior working
> rotting somehwere on my git server.

Is that different from using dup2 on a pidfd?  Sorry I don't follow what is
pidfd_clone / why it is needed.

thanks,

 - Joel
