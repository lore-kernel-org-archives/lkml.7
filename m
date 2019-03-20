Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F63C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD4220850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="S90Arcuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCTTOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:14:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46798 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfCTTOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:14:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so2356404pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BAW01zqy6KxlVMaU5EuHvmflo6RBzBcSay2jwpmFxtM=;
        b=S90ArcujnR16oCFASCAbzc3HMSYpIwOPCx6A18mUDzw3qdn1BrQGMBKxn9nTiPbL0p
         URb900dK+UL3rEr7NralddzqkDFVdKKIzsmkdkILPwMx8IuDdvGOhXyTGchBEbYOtJt+
         k0mWH6EagWlUrglzpB9aH1Dt1Z0X+6yAPg30bfK+JdDCUyEXBiKgAu8071nRWRYieKYo
         3xkflEgOoWgK4lavxsYpQgMnnWunMKt+hkb9x3/Jjahi0wrC9Kup2IdAvy/yHm89UyYW
         tpyyoMvz7ccHf1DuzBvZbYYO/jdF7ZDjSHC9dqSSbdtjtV45bjTFd3pS7H7jRAWt4a5S
         OQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BAW01zqy6KxlVMaU5EuHvmflo6RBzBcSay2jwpmFxtM=;
        b=S+3ex/WGQjK88FJ2KpR2FfjXivbD2EmX/pnIgIxwiylDCGWSkYkf4tMSvKDgUmTqMk
         OUi35Ge9PcSTTqn7K15IBLEJ7Xj/xb4U2+L7olfQmA1TdilX7/+dmEnFPbHN0uLOMPpg
         xY3xxHmjO0QJ3RN3J8OJ77JBqZhJe5LfEHwCe/Vo2pYcVJqD0mJJEUMwtJdapd2FTGdh
         UsmZkRMeKh2eOdWTTDVeIAPL4Ju5qR5aLcgOgDYA0fHHzwhqE/fDgVAFdqgIh34e7cN4
         TqdReMtmIFOQnLT1pmHlEPbuyJeaMu7200z50QJYD49jXYu9gawTRWVBQm4znjb2Ch/2
         kK2g==
X-Gm-Message-State: APjAAAU1LclvSYKg44BPGldPAwLh42VNZt+wcbaYQT6JEhEkP38zxSFx
        ySKkXDPPC8aq8AX82Bx+yMs9qQ==
X-Google-Smtp-Source: APXvYqyBzEWhP63aMikE/5koL0Bk7AbFDYRAW8kPrRrLuH0iqP+m6I9MXZC/Ae4fdSIHkGrJY5FT/w==
X-Received: by 2002:a63:181a:: with SMTP id y26mr9038768pgl.268.1553109256447;
        Wed, 20 Mar 2019 12:14:16 -0700 (PDT)
Received: from brauner.io ([12.25.160.29])
        by smtp.gmail.com with ESMTPSA id h3sm5563561pfb.31.2019.03.20.12.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 12:14:15 -0700 (PDT)
Date:   Wed, 20 Mar 2019 20:14:14 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
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
Subject: Re: pidfd design
Message-ID: <20190320191412.5ykyast3rgotz3nu@brauner.io>
References: <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <CAKOZuetJzg_EiyuK7Pa13X3LKuBbreg7zJ5g4uQv_uV4wpmZjg@mail.gmail.com>
 <20190320035953.mnhax3vd47ya4zzm@brauner.io>
 <CAKOZuet3-VhmC3oHtEbPPvdiar_k_QXTf0TkgmH9LiwmW-_oNA@mail.gmail.com>
 <4A06C5BB-9171-4E70-BE31-9574B4083A9F@joelfernandes.org>
 <20190320182649.spryp5uaeiaxijum@brauner.io>
 <CAKOZuevHbQtrq+Nb-jw1L7O72BmAzcXmbUnfnseeXZjX4PE4tg@mail.gmail.com>
 <20190320185156.7bq775vvtsxqlzfn@brauner.io>
 <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 11:58:57AM -0700, Andy Lutomirski wrote:
> On Wed, Mar 20, 2019 at 11:52 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > You're misunderstanding. Again, I said in my previous mails it should
> > accept pidfds optionally as arguments, yes. But I don't want it to
> > return the status fds that you previously wanted pidfd_wait() to return.
> > I really want to see Joel's pidfd_wait() patchset and have more people
> > review the actual code.
> 
> Just to make sure that no one is forgetting a material security consideration:

Andy, thanks for commenting!

> 
> $ ls /proc/self
> attr             exe        mountinfo      projid_map    status
> autogroup        fd         mounts         root          syscall
> auxv             fdinfo     mountstats     sched         task
> cgroup           gid_map    net            schedstat     timers
> clear_refs       io         ns             sessionid     timerslack_ns
> cmdline          latency    numa_maps      setgroups     uid_map
> comm             limits     oom_adj        smaps         wchan
> coredump_filter  loginuid   oom_score      smaps_rollup
> cpuset           map_files  oom_score_adj  stack
> cwd              maps       pagemap        stat
> environ          mem        personality    statm
> 
> A bunch of this stuff makes sense to make accessible through a syscall
> interface that we expect to be used even in sandboxes.  But a bunch of
> it does not.  For example, *_map, mounts, mountstats, and net are all
> namespace-wide things that certain policies expect to be unavailable.
> stack, for example, is a potential attack surface.  Etc.
> 
> As it stands, if you create a fresh userns and mountns and try to
> mount /proc, there are some really awful and hideous rules that are
> checked for security reasons.  All these new APIs either need to
> return something more restrictive than a proc dirfd or they need to
> follow the same rules.  And I'm afraid that the latter may be a
> nonstarter if you expect these APIs to be used in libraries.
> 
> Yes, this is unfortunate, but it is indeed the current situation.  I
> suppose that we could return magic restricted dirfds, or we could
> return things that aren't dirfds and all and have some API that gives
> you the dirfd associated with a procfd but only if you can see
> /proc/PID.

What would be your opinion to having a
/proc/<pid>/handle
file instead of having a dirfd. Essentially, what I initially proposed
at LPC. The change on what we currently have in master would be:
https://gist.github.com/brauner/59eec91550c5624c9999eaebd95a70df
