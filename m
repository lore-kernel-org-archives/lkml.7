Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE45AC46470
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988AE217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOi/c1/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfEVFMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:12:07 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:44697 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfEVFMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:12:07 -0400
Received: by mail-ua1-f50.google.com with SMTP id p13so409095uaa.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 22:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9cSHLpfk2ut/G7daeeu1vHKOr/f5bhaXmSC+S8dDp1M=;
        b=NOi/c1/BZL0A1MVfXBT4OMbxgq+TQemvctfYgkP3g9iiscfCUdMH6vSQ7H52vQJzHO
         DRZUIY1ZmZ0g2qEGRNSSekNSlq7LKKncp4KHqYeLAKreov879Fuw28YUYpf7hiSmjDm3
         fbVeq9wzHEIwB1Mk8tx5gNrXjWsiCKGqCeffC2cqOozfiRTfOlp2TkeOKm0j3M4VPaJY
         m9IVvtmC6e1oxxn/Y6cO5Cm2EfWQAFdVXJdsIBzJeiKEwI4qXQkshYjX5a5eHJaYIbON
         2DDqK/SLsWzJDrG/puzEK7ZI3rKEkMzCPvwyHD0XnouepO/vuKEigV4541uUAlTp1g6B
         1OEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9cSHLpfk2ut/G7daeeu1vHKOr/f5bhaXmSC+S8dDp1M=;
        b=lxJYUyYX9VwXUw84Scu6l0UAbN13FPEAtmy7WcZkXRIEWWFan1rlyM7e3+OfChV/tN
         KJG3faA/2qTg+is4w1pdlPhZ+uX650AuvcDyEWlZWoLZRVb56qJMqxNtNF0DXKnNVdoT
         1+pPB1aKfbt+33Q6CLXJzKANmXMRCExpOjpOph07Z+l5ajn2DN3ef3c9vzMul9aNlxms
         MicbShDMXqZ+fZYxEUsKu9/m63ykrJW/vvgbNdfCbdUXQ5tyP2F0D/GtdqQI4kVmqi+v
         BQ5MmoImnLnzXMw0q0dMWgLggwIcgnhdQYSEOZ0YNjLY8SYRmv5NrcdFVLlICQ6J3k9Q
         1g9A==
X-Gm-Message-State: APjAAAXBSxFRciB/goMmfAaQfKJ1ojEZMmeNJLE2dRSRjiqNx2egHUdX
        riCHA1sbRQ1VdN8Q0h94gMqQy6D00YBZNZflntjllEfucxM=
X-Google-Smtp-Source: APXvYqy8+dYZRe6z0Nwha0PQyg+QYkW6/ymoocZj4J2VwOSqdTfwW7boSafeq0W2BM0JYFNKSl7I/6pdfZ4d/zaIRd8=
X-Received: by 2002:ab0:1529:: with SMTP id o38mr21734487uae.30.1558501925277;
 Tue, 21 May 2019 22:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <20190521084158.s5wwjgewexjzrsm6@brauner.io>
 <20190521110552.GG219653@google.com> <20190521113029.76iopljdicymghvq@brauner.io>
 <20190521113911.2rypoh7uniuri2bj@brauner.io>
In-Reply-To: <20190521113911.2rypoh7uniuri2bj@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 21 May 2019 22:11:53 -0700
Message-ID: <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Christian Brauner <christian@brauner.io>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 4:39 AM Christian Brauner <christian@brauner.io> wr=
ote:
>
> On Tue, May 21, 2019 at 01:30:29PM +0200, Christian Brauner wrote:
> > On Tue, May 21, 2019 at 08:05:52PM +0900, Minchan Kim wrote:
> > > On Tue, May 21, 2019 at 10:42:00AM +0200, Christian Brauner wrote:
> > > > On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> > > > > - Background
> > > > >
> > > > > The Android terminology used for forking a new process and starti=
ng an app
> > > > > from scratch is a cold start, while resuming an existing app is a=
 hot start.
> > > > > While we continually try to improve the performance of cold start=
s, hot
> > > > > starts will always be significantly less power hungry as well as =
faster so
> > > > > we are trying to make hot start more likely than cold start.
> > > > >
> > > > > To increase hot start, Android userspace manages the order that a=
pps should
> > > > > be killed in a process called ActivityManagerService. ActivityMan=
agerService
> > > > > tracks every Android app or service that the user could be intera=
cting with
> > > > > at any time and translates that into a ranked list for lmkd(low m=
emory
> > > > > killer daemon). They are likely to be killed by lmkd if the syste=
m has to
> > > > > reclaim memory. In that sense they are similar to entries in any =
other cache.
> > > > > Those apps are kept alive for opportunistic performance improveme=
nts but
> > > > > those performance improvements will vary based on the memory requ=
irements of
> > > > > individual workloads.
> > > > >
> > > > > - Problem
> > > > >
> > > > > Naturally, cached apps were dominant consumers of memory on the s=
ystem.
> > > > > However, they were not significant consumers of swap even though =
they are
> > > > > good candidate for swap. Under investigation, swapping out only b=
egins
> > > > > once the low zone watermark is hit and kswapd wakes up, but the o=
verall
> > > > > allocation rate in the system might trip lmkd thresholds and caus=
e a cached
> > > > > process to be killed(we measured performance swapping out vs. zap=
ping the
> > > > > memory by killing a process. Unsurprisingly, zapping is 10x times=
 faster
> > > > > even though we use zram which is much faster than real storage) s=
o kill
> > > > > from lmkd will often satisfy the high zone watermark, resulting i=
n very
> > > > > few pages actually being moved to swap.
> > > > >
> > > > > - Approach
> > > > >
> > > > > The approach we chose was to use a new interface to allow userspa=
ce to
> > > > > proactively reclaim entire processes by leveraging platform infor=
mation.
> > > > > This allowed us to bypass the inaccuracy of the kernel=E2=80=99s =
LRUs for pages
> > > > > that are known to be cold from userspace and to avoid races with =
lmkd
> > > > > by reclaiming apps as soon as they entered the cached state. Addi=
tionally,
> > > > > it could provide many chances for platform to use much informatio=
n to
> > > > > optimize memory efficiency.
> > > > >
> > > > > IMHO we should spell it out that this patchset complements MADV_W=
ONTNEED
> > > > > and MADV_FREE by adding non-destructive ways to gain some free me=
mory
> > > > > space. MADV_COLD is similar to MADV_WONTNEED in a way that it hin=
ts the
> > > > > kernel that memory region is not currently needed and should be r=
eclaimed
> > > > > immediately; MADV_COOL is similar to MADV_FREE in a way that it h=
ints the
> > > > > kernel that memory region is not currently needed and should be r=
eclaimed
> > > > > when memory pressure rises.
> > > > >
> > > > > To achieve the goal, the patchset introduce two new options for m=
advise.
> > > > > One is MADV_COOL which will deactive activated pages and the othe=
r is
> > > > > MADV_COLD which will reclaim private pages instantly. These new o=
ptions
> > > > > complement MADV_DONTNEED and MADV_FREE by adding non-destructive =
ways to
> > > > > gain some free memory space. MADV_COLD is similar to MADV_DONTNEE=
D in a way
> > > > > that it hints the kernel that memory region is not currently need=
ed and
> > > > > should be reclaimed immediately; MADV_COOL is similar to MADV_FRE=
E in a way
> > > > > that it hints the kernel that memory region is not currently need=
ed and
> > > > > should be reclaimed when memory pressure rises.
> > > > >
> > > > > This approach is similar in spirit to madvise(MADV_WONTNEED), but=
 the
> > > > > information required to make the reclaim decision is not known to=
 the app.
> > > > > Instead, it is known to a centralized userspace daemon, and that =
daemon
> > > > > must be able to initiate reclaim on its own without any app invol=
vement.
> > > > > To solve the concern, this patch introduces new syscall -
> > > > >
> > > > >         struct pr_madvise_param {
> > > > >                 int size;
> > > > >                 const struct iovec *vec;
> > > > >         }
> > > > >
> > > > >         int process_madvise(int pidfd, ssize_t nr_elem, int *beha=
vior,
> > > > >                                 struct pr_madvise_param *restuls,
> > > > >                                 struct pr_madvise_param *ranges,
> > > > >                                 unsigned long flags);
> > > > >
> > > > > The syscall get pidfd to give hints to external process and provi=
des
> > > > > pair of result/ranges vector arguments so that it could give seve=
ral
> > > > > hints to each address range all at once.
> > > > >
> > > > > I guess others have different ideas about the naming of syscall a=
nd options
> > > > > so feel free to suggest better naming.
> > > >
> > > > Yes, all new syscalls making use of pidfds should be named
> > > > pidfd_<action>. So please make this pidfd_madvise.
> > >
> > > I don't have any particular preference but just wondering why pidfd i=
s
> > > so special to have it as prefix of system call name.
> >
> > It's a whole new API to address processes. We already have
> > clone(CLONE_PIDFD) and pidfd_send_signal() as you have seen since you
> > exported pidfd_to_pid(). And we're going to have pidfd_open(). Your
> > syscall works only with pidfds so it's tied to this api as well so it
> > should follow the naming scheme. This also makes life easier for
> > userspace and is consistent.
>
> This is at least my reasoning. I'm not going to make this a whole big
> pedantic argument. If people have really strong feelings about not using
> this prefix then fine. But if syscalls can be grouped together and have
> consistent naming this is always a big plus.

My hope has been that pidfd use becomes normalized enough that
prefixing "pidfd_" to pidfd-accepting system calls becomes redundant.
We write write(), not fd_write(), right? :-) pidfd_open() makes sense
because the primary purpose of this system call is to operate on a
pidfd, but I think process_madvise() is fine.
