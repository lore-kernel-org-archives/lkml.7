Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC24FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A8820854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwvnpVMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbfCYUXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:23:36 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42570 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfCYUXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:23:35 -0400
Received: by mail-vs1-f68.google.com with SMTP id f15so6230202vsk.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuf/CUjb0V2c8RpjecXsYX3PuKA2P32xcFIq/XDvi5E=;
        b=QwvnpVMBEZMGRpiWTRxsXyNB5PxDFVkuyqmbE67I1rC2UnROIBvXYnIL6DJ+8b6yqO
         JFT00w7KeBFM7DW3ZagIAc23itGj09Fl0Y4xSDTadFzPxZHL7HX9eFSSOEjpme7x78+B
         LChv18LYTDo2ZwM5zer8BLFcKPrcgvgCpGgLuxt10On3tFJWvOS3lRnYtcBz5t9n3d0Y
         a4DrJg1BDUMiKUERqNUzPRgQjQ83oSKBWh9QE1mt+1joSsTOTAbihkwxQ+ZdqfqiDExb
         vlnnoMjOpmpPqnYt34v12hvCutUdIIDyJDJk/EO0zpgdbI4vjUe2HpK4Znzsdw9XpZqZ
         DVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuf/CUjb0V2c8RpjecXsYX3PuKA2P32xcFIq/XDvi5E=;
        b=cXWsXkKfqmaIds3z0+//IZgsH3zDVjibgRDQto4etpd7CrUguL8KUAzfEivOqzYxGz
         jvYWOSxO9I1cRnP1vHPFRPqFy+Ac9F+EJPntgd9XQPGAGu2pXoDV7Wi+/WiXh/I3jmD2
         RJfxX0l8odpstW85N2nmqjYfrcJr847OSz9eXjmGZsxleHlsnC4/pWr6noT8dPmmKBKj
         zyts0NhpJJ3yBn5sNevSki/e1JTUMHuD9UzwgmHANqq5TuYjeW64pz97oEbPjvjBMMhO
         69B84spYo9apjaaukdSHD6xMwT/FspR4knPlkjKu32WgM3/cBboCxfZGcxNW+bwU5CJ1
         EkXw==
X-Gm-Message-State: APjAAAWbxs5SjS5vbuOKN0CWHqqPNyQ6PK9cXNqf8ChY67X6dSHUQCto
        LBurYf7/3GsCIIZaDs6CfLFR3RWom7+4CFEX/xVUEA==
X-Google-Smtp-Source: APXvYqxZeIdPxoGbyR0dxUgNZ7pSUPhxIFL3JffKVE7sAH1QOtWpl8laXyx7+hoBhrkowXkpmo0Uhz08r7Ju4xfJfRo=
X-Received: by 2002:a67:cc2:: with SMTP id 185mr16474350vsm.77.1553545413970;
 Mon, 25 Mar 2019 13:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190319231020.tdcttojlbmx57gke@brauner.io> <20190320015249.GC129907@google.com>
 <CAKOZuetJzg_EiyuK7Pa13X3LKuBbreg7zJ5g4uQv_uV4wpmZjg@mail.gmail.com>
 <20190320035953.mnhax3vd47ya4zzm@brauner.io> <CAKOZuet3-VhmC3oHtEbPPvdiar_k_QXTf0TkgmH9LiwmW-_oNA@mail.gmail.com>
 <4A06C5BB-9171-4E70-BE31-9574B4083A9F@joelfernandes.org> <20190320182649.spryp5uaeiaxijum@brauner.io>
 <CAKOZuevHbQtrq+Nb-jw1L7O72BmAzcXmbUnfnseeXZjX4PE4tg@mail.gmail.com>
 <20190320185156.7bq775vvtsxqlzfn@brauner.io> <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
 <20190320191412.5ykyast3rgotz3nu@brauner.io> <CAKOZuesRwQ4=Svu1KgHWY=HZSS8mF8uFmuzuVOSH0QpJoy7a5w@mail.gmail.com>
 <CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com> <CAG48ez3VMjLJBC_F3BxC2sc2s-28NdsrUduR=jX66XH0w2O-Qg@mail.gmail.com>
In-Reply-To: <CAG48ez3VMjLJBC_F3BxC2sc2s-28NdsrUduR=jX66XH0w2O-Qg@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 25 Mar 2019 13:23:21 -0700
Message-ID: <CAKOZueuNGn31QYpRa5G-OP_S=G3f9TBQ-w27giABn7UVgPQ8Ng@mail.gmail.com>
Subject: Re: pidfd design
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 1:14 PM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Mar 25, 2019 at 8:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> > On Wed, Mar 20, 2019 at 12:40 PM Daniel Colascione <dancol@google.com> wrote:
> > > On Wed, Mar 20, 2019 at 12:14 PM Christian Brauner <christian@brauner.io> wrote:
> > > > On Wed, Mar 20, 2019 at 11:58:57AM -0700, Andy Lutomirski wrote:
> > > > > On Wed, Mar 20, 2019 at 11:52 AM Christian Brauner <christian@brauner.io> wrote:
> > > > > >
> > > > > > You're misunderstanding. Again, I said in my previous mails it should
> > > > > > accept pidfds optionally as arguments, yes. But I don't want it to
> > > > > > return the status fds that you previously wanted pidfd_wait() to return.
> > > > > > I really want to see Joel's pidfd_wait() patchset and have more people
> > > > > > review the actual code.
> > > > >
> > > > > Just to make sure that no one is forgetting a material security consideration:
> > > >
> > > > Andy, thanks for commenting!
> > > >
> > > > >
> > > > > $ ls /proc/self
> > > > > attr             exe        mountinfo      projid_map    status
> > > > > autogroup        fd         mounts         root          syscall
> > > > > auxv             fdinfo     mountstats     sched         task
> > > > > cgroup           gid_map    net            schedstat     timers
> > > > > clear_refs       io         ns             sessionid     timerslack_ns
> > > > > cmdline          latency    numa_maps      setgroups     uid_map
> > > > > comm             limits     oom_adj        smaps         wchan
> > > > > coredump_filter  loginuid   oom_score      smaps_rollup
> > > > > cpuset           map_files  oom_score_adj  stack
> > > > > cwd              maps       pagemap        stat
> > > > > environ          mem        personality    statm
> > > > >
> > > > > A bunch of this stuff makes sense to make accessible through a syscall
> > > > > interface that we expect to be used even in sandboxes.  But a bunch of
> > > > > it does not.  For example, *_map, mounts, mountstats, and net are all
> > > > > namespace-wide things that certain policies expect to be unavailable.
> > > > > stack, for example, is a potential attack surface.  Etc.
> > >
> > > If you can access these files sources via open(2) on /proc/<pid>, you
> > > should be able to access them via a pidfd. If you can't, you
> > > shouldn't. Which /proc? The one you'd get by mounting procfs. I don't
> > > see how pidfd makes any material changes to anyone's security. As far
> > > as I'm concerned, if a sandbox can't mount /proc at all, it's just a
> > > broken and unsupported configuration.
> >
> > It's not "broken and unsupported".  I know of an actual working,
> > deployed container-ish sandbox that does exactly this.  I would also
> > guess that quite a few not-at-all-container-like sandboxes work like
> > this.  (The obvious seccomp + unshare + pivot_root
> > deny-myself-access-to-lots-of-things trick results in no /proc, which
> > is by dsign.)
> >
> > >
> > > An actual threat model and real thought paid to access capabilities
> > > would help. Almost everything around the interaction of Linux kernel
> > > namespaces and security feels like a jumble of ad-hoc patches added as
> > > afterthoughts in response to random objections.
> >
> > I fully agree.  But if you start thinking for real about access
> > capabilities, there's no way that you're going to conclude that a
> > capability to access some process implies a capability to access the
> > settings of its network namespace.
> >
> > >
> > > >> All these new APIs either need to
> > > > > return something more restrictive than a proc dirfd or they need to
> > > > > follow the same rules.
> > >
> >
> > ...
> >
> > > What's special about libraries? How is a library any worse-off using
> > > openat(2) on a pidfd than it would be just opening the file called
> > > "/proc/$apid"?
> >
> > Because most libraries actually work, right now, without /proc.  Even
> > libraries that spawn subprocesses.  If we make the new API have the
> > property that it doesn't work if you're in a non-root user namespace
> > and /proc isn't mounted, the result will be an utter mess.
> >
> > >
> > > > > Yes, this is unfortunate, but it is indeed the current situation.  I
> > > > > suppose that we could return magic restricted dirfds, or we could
> > > > > return things that aren't dirfds and all and have some API that gives
> > > > > you the dirfd associated with a procfd but only if you can see
> > > > > /proc/PID.
> > > >
> > > > What would be your opinion to having a
> > > > /proc/<pid>/handle
> > > > file instead of having a dirfd. Essentially, what I initially proposed
> > > > at LPC. The change on what we currently have in master would be:
> > > > https://gist.github.com/brauner/59eec91550c5624c9999eaebd95a70df
> > >
> > > And how do you propose, given one of these handle objects, getting a
> > > process's current priority, or its current oom score, or its list of
> > > memory maps? As I mentioned in my original email, and which nobody has
> > > addressed, if you don't use a dirfd as your process handle or you
> > > don't provide an easy way to get one of these proc directory FDs, you
> > > need to duplicate a lot of metadata access interfaces.
> >
> > An API that takes a process handle object and an fd pointing at /proc
> > (the root of the proc fs) and gives you back a proc dirfd would do the
> > trick.  You could do this with no new kernel features at all if you're
> > willing to read the pid, call openat(2), and handle the races in user
> > code.
>
> This seems like something that might be a good fit for two ioctls?

As an aside, we had a long discussion about why fundamental facilities
like this should be system calls, not ioctls. I think the arguments
still apply.

> One ioctl on procfs roots to translate pidfds into that procfs,
> subject to both the normal lookup permission checks and only working
> if the pidfd has a translation into the procfs:
>
> int proc_root_fd = open("/proc", O_RDONLY);
> int proc_dir_fd = ioctl(proc_root_fd, PROC_PIDFD_TO_PROCFSFD, pidfd);
>
> And one ioctl on procfs directories to translate from PGIDs and PIDs to pidfds:
>
> int proc_pgid_fd = open("/proc/self", O_RDONLY);
> int self_pg_pidfd = ioctl(proc_pgid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> int proc_pid_fd = open("/proc/thread-self", O_RDONLY);
> int self_p_pidfd = ioctl(proc_pid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
>
>
> And then, as you proposed, the new sys_clone() can just return a
> pidfd, and you can convert it into a procfs fd yourself if you want.

I think that's the consensus we reached on the other thread. The
O_DIRECTORY open on /proc/self/fd/mypidfd seems like it'd work well
enough.
