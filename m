Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35462C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0B02089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1wHqu8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfEVNQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:16:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33025 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfEVNQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:16:49 -0400
Received: by mail-vs1-f68.google.com with SMTP id y6so1383748vsb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q9WDMTISxSbXUvo3thAxC/8/26mhSvfk+H8gY5FC7Rw=;
        b=j1wHqu8AOIn/TdK3Y0IuY6mHEhzfNgXhLIR1I14fCixzhZjP6kl68f73pag/2NfvhJ
         QaIDM+gBSbg8soVYGbOTRuSkxKYjpmsZ8o4QlENBPNpnIRB9eTtvwphEmF/eMo8DZ56b
         Fci3tFn/bm7JUAnW7d6CfEA/MinkOSOxXlfquk8mzB4/r6mJTLM0Oda2Kil51koQZo7v
         5sEsat+7aleE+x9ALHMt/mZ/HY7/Ogph5D+X6AqjjyN8X8Up9gA+IEkNCeLZe/fTgfIp
         eoaLwqWqwzHgGiC5chmeGfemsRNG0G6u1o2A+TxPXm1FJpGSJN4LuLq9pd0m0VZlhc6Q
         ouwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q9WDMTISxSbXUvo3thAxC/8/26mhSvfk+H8gY5FC7Rw=;
        b=jQPzIJssvOhTb4hVtANjVX3rSC3U5AT4skr1Oqnc+7PfDXPEanurAvvNbNKzdRXJyC
         ZbJjIjCt6hRh86/VqLridiNtXcBX1tmxx1yjgUnmZjRGtpFSeHZy13hRO3OgZDavMruh
         BF9mTffXtDp7IXnHndNcKPQEnOW6fgYhDlZB/5dARI1QGNOs+O/zksH3f42O82DjxbXf
         dOjVkahdYIKvpXhRVZsGK9lOfcEPkkGmaf6d1UHlKGHicLQ9MeTnBzx05+w04uZIsrgV
         NANw6/hCfuxX0CqxRX6e1G6eiaS0vZXMKIk7Q4yKFr8xHi5OBPnlFu8q2cRnQA1WYh3P
         JFZA==
X-Gm-Message-State: APjAAAVS+szPmcL2MYvyGd05EH4EfWQ50QAtpg6987YexuH682XtD03H
        7Rby87SYJbsaU7VHA1Obl77xdXjBCNFcJbOiOZ63T1QBF/8=
X-Google-Smtp-Source: APXvYqxFBOllyAKPLvt3Dkg6wZYZywBpcF5mzFj9Itr4aFvtSRh3etdyk2e7hSUxEx+v1RN+KkqaTfbiVtly9yN1HqA=
X-Received: by 2002:a67:1485:: with SMTP id 127mr14620677vsu.77.1558531007677;
 Wed, 22 May 2019 06:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <20190521084158.s5wwjgewexjzrsm6@brauner.io>
 <20190521110552.GG219653@google.com> <20190521113029.76iopljdicymghvq@brauner.io>
 <20190521113911.2rypoh7uniuri2bj@brauner.io> <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
 <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
In-Reply-To: <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 22 May 2019 06:16:35 -0700
Message-ID: <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com>
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

On Wed, May 22, 2019 at 1:22 AM Christian Brauner <christian@brauner.io> wr=
ote:
>
> On Wed, May 22, 2019 at 7:12 AM Daniel Colascione <dancol@google.com> wro=
te:
> >
> > On Tue, May 21, 2019 at 4:39 AM Christian Brauner <christian@brauner.io=
> wrote:
> > >
> > > On Tue, May 21, 2019 at 01:30:29PM +0200, Christian Brauner wrote:
> > > > On Tue, May 21, 2019 at 08:05:52PM +0900, Minchan Kim wrote:
> > > > > On Tue, May 21, 2019 at 10:42:00AM +0200, Christian Brauner wrote=
:
> > > > > > On Mon, May 20, 2019 at 12:52:47PM +0900, Minchan Kim wrote:
> > > > > > > - Background
> > > > > > >
> > > > > > > The Android terminology used for forking a new process and st=
arting an app
> > > > > > > from scratch is a cold start, while resuming an existing app =
is a hot start.
> > > > > > > While we continually try to improve the performance of cold s=
tarts, hot
> > > > > > > starts will always be significantly less power hungry as well=
 as faster so
> > > > > > > we are trying to make hot start more likely than cold start.
> > > > > > >
> > > > > > > To increase hot start, Android userspace manages the order th=
at apps should
> > > > > > > be killed in a process called ActivityManagerService. Activit=
yManagerService
> > > > > > > tracks every Android app or service that the user could be in=
teracting with
> > > > > > > at any time and translates that into a ranked list for lmkd(l=
ow memory
> > > > > > > killer daemon). They are likely to be killed by lmkd if the s=
ystem has to
> > > > > > > reclaim memory. In that sense they are similar to entries in =
any other cache.
> > > > > > > Those apps are kept alive for opportunistic performance impro=
vements but
> > > > > > > those performance improvements will vary based on the memory =
requirements of
> > > > > > > individual workloads.
> > > > > > >
> > > > > > > - Problem
> > > > > > >
> > > > > > > Naturally, cached apps were dominant consumers of memory on t=
he system.
> > > > > > > However, they were not significant consumers of swap even tho=
ugh they are
> > > > > > > good candidate for swap. Under investigation, swapping out on=
ly begins
> > > > > > > once the low zone watermark is hit and kswapd wakes up, but t=
he overall
> > > > > > > allocation rate in the system might trip lmkd thresholds and =
cause a cached
> > > > > > > process to be killed(we measured performance swapping out vs.=
 zapping the
> > > > > > > memory by killing a process. Unsurprisingly, zapping is 10x t=
imes faster
> > > > > > > even though we use zram which is much faster than real storag=
e) so kill
> > > > > > > from lmkd will often satisfy the high zone watermark, resulti=
ng in very
> > > > > > > few pages actually being moved to swap.
> > > > > > >
> > > > > > > - Approach
> > > > > > >
> > > > > > > The approach we chose was to use a new interface to allow use=
rspace to
> > > > > > > proactively reclaim entire processes by leveraging platform i=
nformation.
> > > > > > > This allowed us to bypass the inaccuracy of the kernel=E2=80=
=99s LRUs for pages
> > > > > > > that are known to be cold from userspace and to avoid races w=
ith lmkd
> > > > > > > by reclaiming apps as soon as they entered the cached state. =
Additionally,
> > > > > > > it could provide many chances for platform to use much inform=
ation to
> > > > > > > optimize memory efficiency.
> > > > > > >
> > > > > > > IMHO we should spell it out that this patchset complements MA=
DV_WONTNEED
> > > > > > > and MADV_FREE by adding non-destructive ways to gain some fre=
e memory
> > > > > > > space. MADV_COLD is similar to MADV_WONTNEED in a way that it=
 hints the
> > > > > > > kernel that memory region is not currently needed and should =
be reclaimed
> > > > > > > immediately; MADV_COOL is similar to MADV_FREE in a way that =
it hints the
> > > > > > > kernel that memory region is not currently needed and should =
be reclaimed
> > > > > > > when memory pressure rises.
> > > > > > >
> > > > > > > To achieve the goal, the patchset introduce two new options f=
or madvise.
> > > > > > > One is MADV_COOL which will deactive activated pages and the =
other is
> > > > > > > MADV_COLD which will reclaim private pages instantly. These n=
ew options
> > > > > > > complement MADV_DONTNEED and MADV_FREE by adding non-destruct=
ive ways to
> > > > > > > gain some free memory space. MADV_COLD is similar to MADV_DON=
TNEED in a way
> > > > > > > that it hints the kernel that memory region is not currently =
needed and
> > > > > > > should be reclaimed immediately; MADV_COOL is similar to MADV=
_FREE in a way
> > > > > > > that it hints the kernel that memory region is not currently =
needed and
> > > > > > > should be reclaimed when memory pressure rises.
> > > > > > >
> > > > > > > This approach is similar in spirit to madvise(MADV_WONTNEED),=
 but the
> > > > > > > information required to make the reclaim decision is not know=
n to the app.
> > > > > > > Instead, it is known to a centralized userspace daemon, and t=
hat daemon
> > > > > > > must be able to initiate reclaim on its own without any app i=
nvolvement.
> > > > > > > To solve the concern, this patch introduces new syscall -
> > > > > > >
> > > > > > >         struct pr_madvise_param {
> > > > > > >                 int size;
> > > > > > >                 const struct iovec *vec;
> > > > > > >         }
> > > > > > >
> > > > > > >         int process_madvise(int pidfd, ssize_t nr_elem, int *=
behavior,
> > > > > > >                                 struct pr_madvise_param *rest=
uls,
> > > > > > >                                 struct pr_madvise_param *rang=
es,
> > > > > > >                                 unsigned long flags);
> > > > > > >
> > > > > > > The syscall get pidfd to give hints to external process and p=
rovides
> > > > > > > pair of result/ranges vector arguments so that it could give =
several
> > > > > > > hints to each address range all at once.
> > > > > > >
> > > > > > > I guess others have different ideas about the naming of sysca=
ll and options
> > > > > > > so feel free to suggest better naming.
> > > > > >
> > > > > > Yes, all new syscalls making use of pidfds should be named
> > > > > > pidfd_<action>. So please make this pidfd_madvise.
> > > > >
> > > > > I don't have any particular preference but just wondering why pid=
fd is
> > > > > so special to have it as prefix of system call name.
> > > >
> > > > It's a whole new API to address processes. We already have
> > > > clone(CLONE_PIDFD) and pidfd_send_signal() as you have seen since y=
ou
> > > > exported pidfd_to_pid(). And we're going to have pidfd_open(). Your
> > > > syscall works only with pidfds so it's tied to this api as well so =
it
> > > > should follow the naming scheme. This also makes life easier for
> > > > userspace and is consistent.
> > >
> > > This is at least my reasoning. I'm not going to make this a whole big
> > > pedantic argument. If people have really strong feelings about not us=
ing
> > > this prefix then fine. But if syscalls can be grouped together and ha=
ve
> > > consistent naming this is always a big plus.
> >
> > My hope has been that pidfd use becomes normalized enough that
> > prefixing "pidfd_" to pidfd-accepting system calls becomes redundant.
> > We write write(), not fd_write(), right? :-) pidfd_open() makes sense
> > because the primary purpose of this system call is to operate on a
> > pidfd, but I think process_madvise() is fine.
>
> This madvise syscall just operates on pidfds. It would make sense to
> name it process_madvise() if were to operate both on pid_t and int pidfd.

The name of the function ought to encode its purpose, not its
signature. The system call under discussion operates on processes and
so should be called "process_madvise". That this system call happens
to accept a pidfd to identify the process on which it operates is not
its most interesting aspect of the system call. The argument type
isn't important enough to spotlight in the permanent name of an API.
Pidfds are novel now, but they won't be novel in the future.

> Giving specific names to system calls won't stop it from becoming
> normalized.

We could name system calls with `cat /dev/urandom | xxd` and they'd
still get used. It doesn't follow that all names are equally good.
