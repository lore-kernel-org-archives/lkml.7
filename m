Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D23C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8660218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQKSe3w+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfCOP4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:56:54 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37236 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfCOP4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:56:53 -0400
Received: by mail-it1-f193.google.com with SMTP id z124so11614912itc.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4rtgT9B6M1B9LQmL3+oXFzPJ5+Ql+wZXXQfq4r7qxM=;
        b=sQKSe3w+XoNEOHxv44wL0wTqwONaxtUvQC34Q2Nez1GqGkGvEXukH/JAod5bOJXGHm
         OKGDpaVbIA/dn/74y/fofwr/x6nLERCAStBftMQvXXcbmjhz98E7nUE+wwdzHn3khfx+
         9FC1ns2uL6HfNp+q032A5iCx39NEwhkRkYXDmt5pB6fDuk8LyAj1frF2LnOOv6lj8lgD
         592ejppi3Gh6xhesU26P0CiVMsDdMDAR076ZgzCHEKe4oXwnXT7UB2gksgsfbwbQpcPB
         An5ekgh1mI2jscsUv9feC58UwwOfUQdGBYKOUdtUjOyki0GE6ap6da45meACeTZmwcCV
         sPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4rtgT9B6M1B9LQmL3+oXFzPJ5+Ql+wZXXQfq4r7qxM=;
        b=nCAnMsZyeAhomRDc+eubklCDbmu3W8B56fG0CXpHHlFR2YlZUaqltvYdvLKYnucYRK
         ljDBnAv+CqSVg4zfGtC+F5IAFVgpylt3gCA/KrgYo4HB73hivwSdLldo9HRkbGn6v26W
         a/yL2EptyaG/PTcQigvpZx8yesXKhlTtglrZrbXFhrC2iwtgXUwFJ5HLe6qzdikR+F1p
         3R8pERaZNUl+GDXqjvr++kEwODSz97m4zWHzbnXJi17sRbyMrSs6NaYX5h/RCumZyf9D
         A/s6fBUFBZXF+R8yhB3k3Fz3VpbfIXqqQ2AA1pnI2I036JzyZn+y5C5JfOksnFy1GHR4
         taqw==
X-Gm-Message-State: APjAAAUTZFSJoJ4TBv0m2sNr7fNxLtSKIwEQKXmGQhuJXK2UjpxqVxG5
        9p8kqdLa5ZmfsSUjQ9hosm2rYMf3UpRAy9fH0el9Dw==
X-Google-Smtp-Source: APXvYqyqcIlbt1RfAFrK2X9pXdPK7c9C3TBI78IspfigtRt/4QFN//wL64B3tnVby9qAAl/BFark1nkjyptSDxFdTH8=
X-Received: by 2002:a24:a81:: with SMTP id 123mr2553188itw.43.1552665412172;
 Fri, 15 Mar 2019 08:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190310203403.27915-1-sultan@kerneltoast.com>
 <20190311174320.GC5721@dhcp22.suse.cz> <20190311175800.GA5522@sultan-box.localdomain>
 <CAJuCfpHTjXejo+u--3MLZZj7kWQVbptyya4yp1GLE3hB=BBX7w@mail.gmail.com>
 <20190311204626.GA3119@sultan-box.localdomain> <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz> <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
 <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
 <20190314204911.GA875@sultan-box.localdomain> <20190314231641.5a37932b@oasis.local.home>
 <CAKOZuetZHJzmQy3n001x4+rmWoWHEgUv2Zvow9W5+xvukxp1JQ@mail.gmail.com>
In-Reply-To: <CAKOZuetZHJzmQy3n001x4+rmWoWHEgUv2Zvow9W5+xvukxp1JQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 15 Mar 2019 08:56:40 -0700
Message-ID: <CAJuCfpFXhE0LwLf-KEuN8W5zqHh_nLzgv7DGjrePiSr6xkvSKA@mail.gmail.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
To:     Daniel Colascione <dancol@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 9:37 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Thu, Mar 14, 2019 at 8:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 14 Mar 2019 13:49:11 -0700
> > Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> >
> > > Perhaps I'm missing something, but if you want to know when a process has died
> > > after sending a SIGKILL to it, then why not just make the SIGKILL optionally
> > > block until the process has died completely? It'd be rather trivial to just
> > > store a pointer to an onstack completion inside the victim process' task_struct,
> > > and then complete it in free_task().
> >
> > How would you implement such a method in userspace? kill() doesn't take
> > any parameters but the pid of the process you want to send a signal to,
> > and the signal to send. This would require a new system call, and be
> > quite a bit of work.
>
> That's what the pidfd work is for. Please read the original threads
> about the motivation and design of that facility.
>
> > If you can solve this with an ebpf program, I
> > strongly suggest you do that instead.
>
> Regarding process death notification: I will absolutely not support
> putting aBPF and perf trace events on the critical path of core system
> memory management functionality. Tracing and monitoring facilities are
> great for learning about the system, but they were never intended to
> be load-bearing. The proposed eBPF process-monitoring approach is just
> a variant of the netlink proposal we discussed previously on the pidfd
> threads; it has all of its drawbacks. We really need a core system
> call  --- really, we've needed robust process management since the
> creation of unix --- and I'm glad that we're finally getting it.
> Adding new system calls is not expensive; going to great lengths to
> avoid adding one is like calling a helicopter to avoid crossing the
> street. I don't think we should present an abuse of the debugging and
> performance monitoring infrastructure as an alternative to a robust
> and desperately-needed bit of core functionality that's neither hard
> to add nor complex to implement nor expensive to use.
>
> Regarding the proposal for a new kernel-side lmkd: when possible, the
> kernel should provide mechanism, not policy. Putting the low memory
> killer back into the kernel after we've spent significant effort
> making it possible for userspace to do that job. Compared to kernel
> code, more easily understood, more easily debuggable, more easily
> updated, and much safer. If we *can* move something out of the kernel,
> we should. This patch moves us in exactly the wrong direction. Yes, we
> need *something* that sits synchronously astride the page allocation
> path and does *something* to stop a busy beaver allocator that eats
> all the available memory before lmkd, even mlocked and realtime, can
> respond. The OOM killer is adequate for this very rare case.
>
> With respect to kill timing: Tim is right about the need for two
> levels of policy: first, a high-level process prioritization and
> memory-demand balancing scheme (which is what OOM score adjustment
> code in ActivityManager amounts to); and second, a low-level
> process-killing methodology that maximizes sustainable memory reclaim
> and minimizes unwanted side effects while killing those processes that
> should be dead. Both of these policies belong in userspace --- because
> they *can* be in userspace --- and userspace needs only a few tools,
> most of which already exist, to do a perfectly adequate job.
>
> We do want killed processes to die promptly. That's why I support
> boosting a process's priority somehow when lmkd is about to kill it.
> The precise way in which we do that --- involving not only actual
> priority, but scheduler knobs, cgroup assignment, core affinity, and
> so on --- is a complex topic best left to userspace. lmkd already has
> all the knobs it needs to implement whatever priority boosting policy
> it wants.
>
> Hell, once we add a pidfd_wait --- which I plan to work on, assuming
> nobody beats me to it, after pidfd_send_signal lands --- you can
> imagine a general-purpose priority inheritance mechanism expediting
> process death when a high-priority process waits on a pidfd_wait
> handle for a condemned process. You know you're on the right track
> design-wise when you start seeing this kind of elegant constructive
> interference between seemingly-unrelated features. What we don't need
> is some kind of blocking SIGKILL alternative or backdoor event
> delivery system.

When talking about pidfd_wait functionality do you mean something like
this: https://lore.kernel.org/patchwork/patch/345098/ ? I missed the
discussion about it, could you please point me to it?

> We definitely don't want to have to wait for a process's parent to
> reap it. Instead, we want to wait for it to become a zombie. That's
> why I designed my original exithand patch to fire death notification
> upon transition to the zombie state, not upon process table removal,
> and I expect pidfd_wait (or whatever we call it) to act the same way.
>
> In any case, there's a clear path forward here --- general-purpose,
> cheap, and elegant --- and we should just focus on doing that instead
> of more complex proposals with few advantages.
