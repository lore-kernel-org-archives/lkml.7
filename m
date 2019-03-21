Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A032C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283682192B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553187787;
	bh=y92cZEHdoDTXHyB7361NDOYr7VXAJFgdUc2dCy4T9OM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zuuzCKE5427yr3i2pOu2VenCJMpdTulcpcRk9AnGs0/Ai++STgBnLEjoErX0suHjn
	 WV4euUYomarQKbvmC6SP3bXO28JdFNbtxOhGwINWGjBhSscu5wR/F+C/aHhl58EkJP
	 uuqoydm80og8oOzr1T+JY5HKT5LfLeZ2QQAO0baE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfCURDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCURDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:03:05 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF90E2195D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 17:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553187784;
        bh=y92cZEHdoDTXHyB7361NDOYr7VXAJFgdUc2dCy4T9OM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=udceG1FM5zLjpCWWEV9rh2gRF88G5Ntp4PA8sRxZtRWbnOfQGKv9C95B/V7CNBiQ5
         qNHLJv/uBjK+7LdQTa4F+TLQ+BW8GPOutSn8axo86hgl1fDMnUQm3a+3oafVf/OrNh
         HTtNbtKYBTG4NMwaHYZq4k2/w57HfCk4Uo9udiu4=
Received: by mail-wr1-f45.google.com with SMTP id w10so5973603wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 10:03:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUX79jxfIwjTLY6ok2mZKKFi6+zT57svMTieIOgq9Eswha9sNv/
        vjWU15VN9aP2QQ4rt005gHsIb+/sDrobPNYzVtKCuw==
X-Google-Smtp-Source: APXvYqw7TyJu23grIXFuOgX7B/HVRTSIJ3AVxQWNKk36krc2vIsO2WDGZ6zNTCj5NJ+voFgD4ZCd+Kgg0NwJcgzAIh0=
X-Received: by 2002:a5d:6252:: with SMTP id m18mr3147947wrv.199.1553187782467;
 Thu, 21 Mar 2019 10:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190319231020.tdcttojlbmx57gke@brauner.io> <20190320015249.GC129907@google.com>
 <CAKOZuetJzg_EiyuK7Pa13X3LKuBbreg7zJ5g4uQv_uV4wpmZjg@mail.gmail.com>
 <20190320035953.mnhax3vd47ya4zzm@brauner.io> <CAKOZuet3-VhmC3oHtEbPPvdiar_k_QXTf0TkgmH9LiwmW-_oNA@mail.gmail.com>
 <4A06C5BB-9171-4E70-BE31-9574B4083A9F@joelfernandes.org> <20190320182649.spryp5uaeiaxijum@brauner.io>
 <CAKOZuevHbQtrq+Nb-jw1L7O72BmAzcXmbUnfnseeXZjX4PE4tg@mail.gmail.com>
 <20190320185156.7bq775vvtsxqlzfn@brauner.io> <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
 <20190320191412.5ykyast3rgotz3nu@brauner.io> <CAKOZuesRwQ4=Svu1KgHWY=HZSS8mF8uFmuzuVOSH0QpJoy7a5w@mail.gmail.com>
In-Reply-To: <CAKOZuesRwQ4=Svu1KgHWY=HZSS8mF8uFmuzuVOSH0QpJoy7a5w@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 21 Mar 2019 10:02:50 -0700
X-Gmail-Original-Message-ID: <CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com>
Message-ID: <CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com>
Subject: Re: pidfd design
To:     Daniel Colascione <dancol@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@kernel.org>,
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
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:40 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Wed, Mar 20, 2019 at 12:14 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Wed, Mar 20, 2019 at 11:58:57AM -0700, Andy Lutomirski wrote:
> > > On Wed, Mar 20, 2019 at 11:52 AM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > You're misunderstanding. Again, I said in my previous mails it should
> > > > accept pidfds optionally as arguments, yes. But I don't want it to
> > > > return the status fds that you previously wanted pidfd_wait() to return.
> > > > I really want to see Joel's pidfd_wait() patchset and have more people
> > > > review the actual code.
> > >
> > > Just to make sure that no one is forgetting a material security consideration:
> >
> > Andy, thanks for commenting!
> >
> > >
> > > $ ls /proc/self
> > > attr             exe        mountinfo      projid_map    status
> > > autogroup        fd         mounts         root          syscall
> > > auxv             fdinfo     mountstats     sched         task
> > > cgroup           gid_map    net            schedstat     timers
> > > clear_refs       io         ns             sessionid     timerslack_ns
> > > cmdline          latency    numa_maps      setgroups     uid_map
> > > comm             limits     oom_adj        smaps         wchan
> > > coredump_filter  loginuid   oom_score      smaps_rollup
> > > cpuset           map_files  oom_score_adj  stack
> > > cwd              maps       pagemap        stat
> > > environ          mem        personality    statm
> > >
> > > A bunch of this stuff makes sense to make accessible through a syscall
> > > interface that we expect to be used even in sandboxes.  But a bunch of
> > > it does not.  For example, *_map, mounts, mountstats, and net are all
> > > namespace-wide things that certain policies expect to be unavailable.
> > > stack, for example, is a potential attack surface.  Etc.
>
> If you can access these files sources via open(2) on /proc/<pid>, you
> should be able to access them via a pidfd. If you can't, you
> shouldn't. Which /proc? The one you'd get by mounting procfs. I don't
> see how pidfd makes any material changes to anyone's security. As far
> as I'm concerned, if a sandbox can't mount /proc at all, it's just a
> broken and unsupported configuration.

It's not "broken and unsupported".  I know of an actual working,
deployed container-ish sandbox that does exactly this.  I would also
guess that quite a few not-at-all-container-like sandboxes work like
this.  (The obvious seccomp + unshare + pivot_root
deny-myself-access-to-lots-of-things trick results in no /proc, which
is by dsign.)

>
> An actual threat model and real thought paid to access capabilities
> would help. Almost everything around the interaction of Linux kernel
> namespaces and security feels like a jumble of ad-hoc patches added as
> afterthoughts in response to random objections.

I fully agree.  But if you start thinking for real about access
capabilities, there's no way that you're going to conclude that a
capability to access some process implies a capability to access the
settings of its network namespace.

>
> >> All these new APIs either need to
> > > return something more restrictive than a proc dirfd or they need to
> > > follow the same rules.
>

...

> What's special about libraries? How is a library any worse-off using
> openat(2) on a pidfd than it would be just opening the file called
> "/proc/$apid"?

Because most libraries actually work, right now, without /proc.  Even
libraries that spawn subprocesses.  If we make the new API have the
property that it doesn't work if you're in a non-root user namespace
and /proc isn't mounted, the result will be an utter mess.

>
> > > Yes, this is unfortunate, but it is indeed the current situation.  I
> > > suppose that we could return magic restricted dirfds, or we could
> > > return things that aren't dirfds and all and have some API that gives
> > > you the dirfd associated with a procfd but only if you can see
> > > /proc/PID.
> >
> > What would be your opinion to having a
> > /proc/<pid>/handle
> > file instead of having a dirfd. Essentially, what I initially proposed
> > at LPC. The change on what we currently have in master would be:
> > https://gist.github.com/brauner/59eec91550c5624c9999eaebd95a70df
>
> And how do you propose, given one of these handle objects, getting a
> process's current priority, or its current oom score, or its list of
> memory maps? As I mentioned in my original email, and which nobody has
> addressed, if you don't use a dirfd as your process handle or you
> don't provide an easy way to get one of these proc directory FDs, you
> need to duplicate a lot of metadata access interfaces.

An API that takes a process handle object and an fd pointing at /proc
(the root of the proc fs) and gives you back a proc dirfd would do the
trick.  You could do this with no new kernel features at all if you're
willing to read the pid, call openat(2), and handle the races in user
code.
