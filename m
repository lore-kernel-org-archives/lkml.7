Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AF0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33AA20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 14:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="U5XfVnBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfEVOwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 10:52:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52353 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbfEVOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 10:52:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so2556565wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3DnnIUojWaR5YIA9yH08ChhAbPSeJyxJCDjrmsDfSsA=;
        b=U5XfVnBmGagx0TH5T0dG1OqPauKyU5SKMZ0ZCqzNJVWYAOE2xwZX1eOtsD/mE39TZ4
         y8LZldnII9DDg8vB4aM0k/zdTCrCrDOxon3Kwa/J5see9x1FkqPzjM24DintCwCthbN7
         bZyxhiq93dym4w/djrwc9lbHYeN2pgd33TmXmnjjNIVla7rSQekCDM26dwNrGD8aSfe9
         IfH8YO4PvSr3zglxjNZaOt7MTAtpT/gFGnUzlo5w9Mt8DXmGTKumgfZGENhLID52tBTE
         Tvxa3Vuh+33sHwUExR+xszjMWJbWL+F0uQoJsN0xlxER+b/wPMX1i9mZ9Tj1PhMoUTxR
         4v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3DnnIUojWaR5YIA9yH08ChhAbPSeJyxJCDjrmsDfSsA=;
        b=THPtEBK3UOOiT7HOpNXL6Pp0DsvlvRWlWrfQce9NDdIyOfd+Pa8OgtNOFWJRxDzRyi
         rch4hmUx6mV9Fs3eZ+HudMyE+S0cd/9UHjKTgWKg/uGel6baYzonKjf7gZYIS9U5uDJZ
         nIz+ieL/HrLNZ0uSyIuIijfLpTIkDpxEI+DFGrQ4jFV86iqek1NTajwq6q7EYWLHwbst
         yiYr89zvYhLetJ+xkUOWYyYEOXrcq0I4djIg6Qd+fTvRZv87OEM7+t8mCs8qBOq5AEJG
         zMYATbSxHLpmKieG7gQsVEIAwvITaeHgI+wv/TfQ6axjhTqXhCO9lpvv1mCBshcPjNYg
         CnCw==
X-Gm-Message-State: APjAAAVnEB8Ym0wgv/kvICN/i1kjzxByfxgtoUuislbAaWsNCHD82IL0
        wV5Q36Ei1TUjDRmffksgRvqORw==
X-Google-Smtp-Source: APXvYqxe/48zJHcWQd1hbtgV5hwv5K4QMSu47Dx8duCnDwXSuhmOK/vOE163vDGsj42L8A/JRSS5kw==
X-Received: by 2002:a1c:6c1a:: with SMTP id h26mr7609241wmc.89.1558536741141;
        Wed, 22 May 2019 07:52:21 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id t19sm5255055wmi.42.2019.05.22.07.52.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 07:52:20 -0700 (PDT)
Date:   Wed, 22 May 2019 16:52:18 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
Message-ID: <20190522145216.jkimuudoxi6pder2@brauner.io>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190521084158.s5wwjgewexjzrsm6@brauner.io>
 <20190521110552.GG219653@google.com>
 <20190521113029.76iopljdicymghvq@brauner.io>
 <20190521113911.2rypoh7uniuri2bj@brauner.io>
 <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
 <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
 <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 06:16:35AM -0700, Daniel Colascione wrote:
> On Wed, May 22, 2019 at 1:22 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Wed, May 22, 2019 at 7:12 AM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > On Tue, May 21, 2019 at 4:39 AM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > On Tue, May 21, 2019 at 01:30:29PM +0200, Christian Brauner wrote:
> > > > > On Tue, May 21, 2019 at 08:05:52PM +0900, Minchan Kim wrote:
> > > > > > On Tue, May 21, 2019 at 10:42:00AM +0200, Christian Brauner wrote:
> > > > > > > On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> > > > > > > > - Background
> > > > > > > >
> > > > > > > > The Android terminology used for forking a new process and starting an app
> > > > > > > > from scratch is a cold start, while resuming an existing app is a hot start.
> > > > > > > > While we continually try to improve the performance of cold starts, hot
> > > > > > > > starts will always be significantly less power hungry as well as faster so
> > > > > > > > we are trying to make hot start more likely than cold start.
> > > > > > > >
> > > > > > > > To increase hot start, Android userspace manages the order that apps should
> > > > > > > > be killed in a process called ActivityManagerService. ActivityManagerService
> > > > > > > > tracks every Android app or service that the user could be interacting with
> > > > > > > > at any time and translates that into a ranked list for lmkd(low memory
> > > > > > > > killer daemon). They are likely to be killed by lmkd if the system has to
> > > > > > > > reclaim memory. In that sense they are similar to entries in any other cache.
> > > > > > > > Those apps are kept alive for opportunistic performance improvements but
> > > > > > > > those performance improvements will vary based on the memory requirements of
> > > > > > > > individual workloads.
> > > > > > > >
> > > > > > > > - Problem
> > > > > > > >
> > > > > > > > Naturally, cached apps were dominant consumers of memory on the system.
> > > > > > > > However, they were not significant consumers of swap even though they are
> > > > > > > > good candidate for swap. Under investigation, swapping out only begins
> > > > > > > > once the low zone watermark is hit and kswapd wakes up, but the overall
> > > > > > > > allocation rate in the system might trip lmkd thresholds and cause a cached
> > > > > > > > process to be killed(we measured performance swapping out vs. zapping the
> > > > > > > > memory by killing a process. Unsurprisingly, zapping is 10x times faster
> > > > > > > > even though we use zram which is much faster than real storage) so kill
> > > > > > > > from lmkd will often satisfy the high zone watermark, resulting in very
> > > > > > > > few pages actually being moved to swap.
> > > > > > > >
> > > > > > > > - Approach
> > > > > > > >
> > > > > > > > The approach we chose was to use a new interface to allow userspace to
> > > > > > > > proactively reclaim entire processes by leveraging platform information.
> > > > > > > > This allowed us to bypass the inaccuracy of the kernel’s LRUs for pages
> > > > > > > > that are known to be cold from userspace and to avoid races with lmkd
> > > > > > > > by reclaiming apps as soon as they entered the cached state. Additionally,
> > > > > > > > it could provide many chances for platform to use much information to
> > > > > > > > optimize memory efficiency.
> > > > > > > >
> > > > > > > > IMHO we should spell it out that this patchset complements MADV_WONTNEED
> > > > > > > > and MADV_FREE by adding non-destructive ways to gain some free memory
> > > > > > > > space. MADV_COLD is similar to MADV_WONTNEED in a way that it hints the
> > > > > > > > kernel that memory region is not currently needed and should be reclaimed
> > > > > > > > immediately; MADV_COOL is similar to MADV_FREE in a way that it hints the
> > > > > > > > kernel that memory region is not currently needed and should be reclaimed
> > > > > > > > when memory pressure rises.
> > > > > > > >
> > > > > > > > To achieve the goal, the patchset introduce two new options for madvise.
> > > > > > > > One is MADV_COOL which will deactive activated pages and the other is
> > > > > > > > MADV_COLD which will reclaim private pages instantly. These new options
> > > > > > > > complement MADV_DONTNEED and MADV_FREE by adding non-destructive ways to
> > > > > > > > gain some free memory space. MADV_COLD is similar to MADV_DONTNEED in a way
> > > > > > > > that it hints the kernel that memory region is not currently needed and
> > > > > > > > should be reclaimed immediately; MADV_COOL is similar to MADV_FREE in a way
> > > > > > > > that it hints the kernel that memory region is not currently needed and
> > > > > > > > should be reclaimed when memory pressure rises.
> > > > > > > >
> > > > > > > > This approach is similar in spirit to madvise(MADV_WONTNEED), but the
> > > > > > > > information required to make the reclaim decision is not known to the app.
> > > > > > > > Instead, it is known to a centralized userspace daemon, and that daemon
> > > > > > > > must be able to initiate reclaim on its own without any app involvement.
> > > > > > > > To solve the concern, this patch introduces new syscall -
> > > > > > > >
> > > > > > > >         struct pr_madvise_param {
> > > > > > > >                 int size;
> > > > > > > >                 const struct iovec *vec;
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         int process_madvise(int pidfd, ssize_t nr_elem, int *behavior,
> > > > > > > >                                 struct pr_madvise_param *restuls,
> > > > > > > >                                 struct pr_madvise_param *ranges,
> > > > > > > >                                 unsigned long flags);
> > > > > > > >
> > > > > > > > The syscall get pidfd to give hints to external process and provides
> > > > > > > > pair of result/ranges vector arguments so that it could give several
> > > > > > > > hints to each address range all at once.
> > > > > > > >
> > > > > > > > I guess others have different ideas about the naming of syscall and options
> > > > > > > > so feel free to suggest better naming.
> > > > > > >
> > > > > > > Yes, all new syscalls making use of pidfds should be named
> > > > > > > pidfd_<action>. So please make this pidfd_madvise.
> > > > > >
> > > > > > I don't have any particular preference but just wondering why pidfd is
> > > > > > so special to have it as prefix of system call name.
> > > > >
> > > > > It's a whole new API to address processes. We already have
> > > > > clone(CLONE_PIDFD) and pidfd_send_signal() as you have seen since you
> > > > > exported pidfd_to_pid(). And we're going to have pidfd_open(). Your
> > > > > syscall works only with pidfds so it's tied to this api as well so it
> > > > > should follow the naming scheme. This also makes life easier for
> > > > > userspace and is consistent.
> > > >
> > > > This is at least my reasoning. I'm not going to make this a whole big
> > > > pedantic argument. If people have really strong feelings about not using
> > > > this prefix then fine. But if syscalls can be grouped together and have
> > > > consistent naming this is always a big plus.
> > >
> > > My hope has been that pidfd use becomes normalized enough that
> > > prefixing "pidfd_" to pidfd-accepting system calls becomes redundant.
> > > We write write(), not fd_write(), right? :-) pidfd_open() makes sense
> > > because the primary purpose of this system call is to operate on a
> > > pidfd, but I think process_madvise() is fine.
> >
> > This madvise syscall just operates on pidfds. It would make sense to
> > name it process_madvise() if were to operate both on pid_t and int pidfd.
> 
> The name of the function ought to encode its purpose, not its
> signature. The system call under discussion operates on processes and
> so should be called "process_madvise". That this system call happens
> to accept a pidfd to identify the process on which it operates is not
> its most interesting aspect of the system call. The argument type
> isn't important enough to spotlight in the permanent name of an API.
> Pidfds are novel now, but they won't be novel in the future.

I'm not going to go into yet another long argument. I prefer pidfd_*.
It's tied to the api, transparent for userspace, and disambiguates it
from process_vm_{read,write}v that both take a pid_t.
