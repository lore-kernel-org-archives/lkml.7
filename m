Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F729C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3518C218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pTRZUOR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfCOSN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:13:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38631 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfCOSN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:13:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id s1so11137343qte.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q6eG5wgnw+unORojL17W/6kSteRzx3rHaBc67euHz48=;
        b=pTRZUOR9tD01/yvyyitOYmlPRduSzM+RUbsLOCQUvtErFaPRT4aUBZXVpiTUmR+iaH
         qNHgc9BLYVYNZ86O/4fCGpLNQ6ysglYO1DQvE9espFgJXYrSpudfPqx5W+dXZQbOX9d5
         XsE4ke3/70ppALljmAuWoLCyr3GWB/cxgr16w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q6eG5wgnw+unORojL17W/6kSteRzx3rHaBc67euHz48=;
        b=iLS3ghA8RTB/+kt9nZFtDtOmco9sLrscomvqCGuc9QRAvJ3U06ZBqngreWw3nTNbBT
         pdbemBYlvRBOq9v+6DSKq1MBupw/rB7iX21Qqq6Xkhu8ZCvAg1v+eZ43Zb3+fWe5P1qI
         fQ6AnxfgvMf0Crvwj8qToQ8fJAEj/W4wfcxe9WmtABgo6J1PnQJf0XGSncp10HO4j5zB
         KakWfzXwfWIEG53Y2JOrbFfgolYB8JZrvIRl9sb2f2CSKRYlBac2bVMFbgngmYNDTcWi
         cN2QcB33nF2lQ7McScVaJNyIQhpInm/uNj03ML6nM2a+DVbLgSHBubh2WcrVWL5jMGYB
         m3LQ==
X-Gm-Message-State: APjAAAVdonoq+DVygpA0BiBOlvebFP6RazB/q/Z+ZwW7m9BxKzBYMB2f
        dwqN5UELR+Dz+kbZRG6SDoHP5g==
X-Google-Smtp-Source: APXvYqyapHPhx1//x+Hc5HFAb2MjY04hpS7fCSjEDnWc8My3aeCiXQ6xAQfZ4yPmvPPGGZthqLWbog==
X-Received: by 2002:a0c:bc01:: with SMTP id j1mr3708437qvg.24.1552673606570;
        Fri, 15 Mar 2019 11:13:26 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id v12sm1990632qth.12.2019.03.15.11.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 11:13:24 -0700 (PDT)
Date:   Fri, 15 Mar 2019 14:13:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190315181324.GA248160@google.com>
References: <20190311204626.GA3119@sultan-box.localdomain>
 <CAJuCfpGpBxofTT-ANEEY+dFCSdwkQswox3s8Uk9Eq0BnK9i0iA@mail.gmail.com>
 <20190312080532.GE5721@dhcp22.suse.cz>
 <20190312163741.GA2762@sultan-box.localdomain>
 <CAEe=Sxn_uayj48wo7oqf8mNZ7QAGJUQVmkPcHcuEGjA_Z8ELeQ@mail.gmail.com>
 <CAEXW_YQMnbN+e-janGbZc5MH6MwdUdXNfonpLUu5O2nsSkJyeg@mail.gmail.com>
 <20190314204911.GA875@sultan-box.localdomain>
 <20190314231641.5a37932b@oasis.local.home>
 <CAKOZuetZHJzmQy3n001x4+rmWoWHEgUv2Zvow9W5+xvukxp1JQ@mail.gmail.com>
 <20190315180306.sq3z645p3hygrmt2@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315180306.sq3z645p3hygrmt2@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 07:03:07PM +0100, Christian Brauner wrote:
> On Thu, Mar 14, 2019 at 09:36:43PM -0700, Daniel Colascione wrote:
> > On Thu, Mar 14, 2019 at 8:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Thu, 14 Mar 2019 13:49:11 -0700
> > > Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> > >
> > > > Perhaps I'm missing something, but if you want to know when a process has died
> > > > after sending a SIGKILL to it, then why not just make the SIGKILL optionally
> > > > block until the process has died completely? It'd be rather trivial to just
> > > > store a pointer to an onstack completion inside the victim process' task_struct,
> > > > and then complete it in free_task().
> > >
> > > How would you implement such a method in userspace? kill() doesn't take
> > > any parameters but the pid of the process you want to send a signal to,
> > > and the signal to send. This would require a new system call, and be
> > > quite a bit of work.
> > 
> > That's what the pidfd work is for. Please read the original threads
> > about the motivation and design of that facility.
> > 
> > > If you can solve this with an ebpf program, I
> > > strongly suggest you do that instead.
> > 
> > Regarding process death notification: I will absolutely not support
> > putting aBPF and perf trace events on the critical path of core system
> > memory management functionality. Tracing and monitoring facilities are
> > great for learning about the system, but they were never intended to
> > be load-bearing. The proposed eBPF process-monitoring approach is just
> > a variant of the netlink proposal we discussed previously on the pidfd
> > threads; it has all of its drawbacks. We really need a core system
> > call  --- really, we've needed robust process management since the
> > creation of unix --- and I'm glad that we're finally getting it.
> > Adding new system calls is not expensive; going to great lengths to
> > avoid adding one is like calling a helicopter to avoid crossing the
> > street. I don't think we should present an abuse of the debugging and
> > performance monitoring infrastructure as an alternative to a robust
> > and desperately-needed bit of core functionality that's neither hard
> > to add nor complex to implement nor expensive to use.
> > 
> > Regarding the proposal for a new kernel-side lmkd: when possible, the
> > kernel should provide mechanism, not policy. Putting the low memory
> > killer back into the kernel after we've spent significant effort
> > making it possible for userspace to do that job. Compared to kernel
> > code, more easily understood, more easily debuggable, more easily
> > updated, and much safer. If we *can* move something out of the kernel,
> > we should. This patch moves us in exactly the wrong direction. Yes, we
> > need *something* that sits synchronously astride the page allocation
> > path and does *something* to stop a busy beaver allocator that eats
> > all the available memory before lmkd, even mlocked and realtime, can
> > respond. The OOM killer is adequate for this very rare case.
> > 
> > With respect to kill timing: Tim is right about the need for two
> > levels of policy: first, a high-level process prioritization and
> > memory-demand balancing scheme (which is what OOM score adjustment
> > code in ActivityManager amounts to); and second, a low-level
> > process-killing methodology that maximizes sustainable memory reclaim
> > and minimizes unwanted side effects while killing those processes that
> > should be dead. Both of these policies belong in userspace --- because
> > they *can* be in userspace --- and userspace needs only a few tools,
> > most of which already exist, to do a perfectly adequate job.
> > 
> > We do want killed processes to die promptly. That's why I support
> > boosting a process's priority somehow when lmkd is about to kill it.
> > The precise way in which we do that --- involving not only actual
> > priority, but scheduler knobs, cgroup assignment, core affinity, and
> > so on --- is a complex topic best left to userspace. lmkd already has
> > all the knobs it needs to implement whatever priority boosting policy
> > it wants.
> > 
> > Hell, once we add a pidfd_wait --- which I plan to work on, assuming
> > nobody beats me to it, after pidfd_send_signal lands --- you can
> 
> Daniel,
> 
> I've just been talking to Joel.
> I actually "expected" you to work pidfd_wait() after prior
> conversations we had on the pidfd_send_signal() patchsets. :) That's why
> I got a separate git tree on kernel.org since I expect a lot more work
> to come. I hope that Linus still decides to pull pidfd_send_signal()
> before Sunday (For the ones who have missed the link in a prior response
> of mine:
> https://lkml.org/lkml/2019/3/12/439
> 
> This is the first merge window I sent this PR.
> 
> The pidfd tree has a branch for-next that is already tracked by Stephen
> in linux-next since the 5.0 merge window. The patches for
> pidfd_send_signal() sit in the pidfd branch.
> I'd be happy to share the tree with you and Joel (We can rename it if
> you prefer I don't care).
> I would really like to centralize this work so that we sort of have a
> "united front" and end up with a coherent api and can send PRs from a
> centralized place:
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/

I am totally onboard with working together / reviewing this work with you all
on a common tree somewhere (Christian's pidfd tree is fine). I was curious,
why do we want to add a new syscall (pidfd_wait) though? Why not just use
standard poll/epoll interface on the proc fd like Daniel was suggesting.
AFAIK, once the proc file is opened, the struct pid is essentially pinned
even though the proc number may be reused. Then the caller can just poll.
We can add a waitqueue to struct pid, and wake up any waiters on process
death (A quick look shows task_struct can be mapped to its struct pid) and
also possibly optimize it using Steve's TIF flag idea. No new syscall is
needed then, let me know if I missed something?

thanks,

 - Joel
