Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B7BC28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6237820872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1WSMi7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfFFQBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:01:46 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38071 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfFFQBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:01:46 -0400
Received: by mail-it1-f196.google.com with SMTP id h9so782696itk.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABCfAmT6WOqIRYUnhdQj6ZE+XlZQB9hg7YCFkgLqi/E=;
        b=m1WSMi7lU2cp4fUhMsxm45BH/s/HZfry3HAFJ49LBn9WkRNv9jAn2IEx61y5EGcSK5
         0vrMmnZwzG6sbMzWD5aaYg7T/7RJW9ISMGX/YcCWjFZFujnl+/E5nF5Br8U5hy05X0Bw
         DE+vJlHtipsIxV5bQ5BQdBWGV1z5Mnr2fWam2PpQXDXwBvt2vPDxikys5WoZiLVcgUmQ
         CL+wqqJr2OnFmy3qio++YmMsBhy4+pxKXk++m4YkyuwAouRStWIIy8dslnWJ1bnz7JOs
         08wDUWy8CJGwp6jM68b7sPq1Dt4LZ4TzrH+z658SZ0gMPO1BinTWsgCvgLqnq9UFd6Oq
         E96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABCfAmT6WOqIRYUnhdQj6ZE+XlZQB9hg7YCFkgLqi/E=;
        b=t16eRu8N4KsebswSnFW0o3w3A7iDkKD3mkocKbj4LpjeT1i1wQ6AJuFPq2Qk3l/69T
         uq2fkNB1k1bwijW5Zy15/7e3tlifAMB8YFM9XFt0S2vwZMrrexTsc7pNBoSsQuZ+lMYK
         ViNPOeBm7kIeTarK9NrNt/vZ0f7Xlvvqhe3AQtYHKl7CroZvP822OLqWpRa22pYXiX/R
         XiR99LHRuY1RyK2PCp0oyJ4PmURFV5mZ2jUrb95cConpORdtKdcHXoaNvI8PivAD8dDw
         /DBYgH3JXelS35HkdxbzRjp093TtSNgfpaLfOjwNnECbi5geitoxc2lpVKYeR/pQJsdB
         NkBg==
X-Gm-Message-State: APjAAAV3BIuIxjCtUmiieWg0/Psw2Gv1UUol35U14EiQpDy6MJUP8OEf
        hS/o79eySQq88PhkjEgDI1THcgIvnoUG4ZjBese7eg==
X-Google-Smtp-Source: APXvYqwv7h6N6Q2jeZW15aYywh1V3kX0M5425XRJ6kuENcEaAf9CZR15OYA5xBSvMb9jM/sya562GzUw+Koo5ckdANw=
X-Received: by 2002:a24:4417:: with SMTP id o23mr700144ita.88.1559836904841;
 Thu, 06 Jun 2019 09:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005a4b99058a97f42e@google.com> <b67a0f5d-c508-48a7-7643-b4251c749985@virtuozzo.com>
 <20190606131334.GA24822@fieldses.org> <275f77ad-1962-6a60-e60b-6b8845f12c34@virtuozzo.com>
 <CACT4Y+aJQ6J5WdviD+cOmDoHt2Dj=Q4uZ4vHbCfHe+_TCEY6-Q@mail.gmail.com>
 <00ec828a-0dcb-ca70-e938-ca26a6a8b675@virtuozzo.com> <CACT4Y+aZNxZyhJEjZjxYqh34BKz+VnfZPpZO9rDn0B_9Z_gZcw@mail.gmail.com>
 <ae7ccef7-6972-370f-e9df-951771d1e234@virtuozzo.com>
In-Reply-To: <ae7ccef7-6972-370f-e9df-951771d1e234@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Jun 2019 18:01:33 +0200
Message-ID: <CACT4Y+Z_CF8h=enZsmZ1mcnVVKxPam0Xhczyz7zYXGbvEBqHTQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in unregister_shrinker
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        syzbot <syzbot+83a43746cebef3508b49@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, bfields@redhat.com,
        Chris Down <chris@chrisdown.name>,
        Daniel Jordan <daniel.m.jordan@oracle.com>, guro@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jeff Layton <jlayton@kernel.org>, laoar.shao@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-nfs@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yang.shi@linux.alibaba.com, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 5:25 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 06.06.2019 18:18, Dmitry Vyukov wrote:
> > On Thu, Jun 6, 2019 at 4:54 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 06.06.2019 17:40, Dmitry Vyukov wrote:
> >>> On Thu, Jun 6, 2019 at 3:43 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>>>
> >>>> On 06.06.2019 16:13, J. Bruce Fields wrote:
> >>>>> On Thu, Jun 06, 2019 at 10:47:43AM +0300, Kirill Tkhai wrote:
> >>>>>> This may be connected with that shrinker unregistering is forgotten on error path.
> >>>>>
> >>>>> I was wondering about that too.  Seems like it would be hard to hit
> >>>>> reproduceably though: one of the later allocations would have to fail,
> >>>>> then later you'd have to create another namespace and this time have a
> >>>>> later module's init fail.
> >>>>
> >>>> Yes, it's had to bump into this in real life.
> >>>>
> >>>> AFAIU, syzbot triggers such the problem by using fault-injections
> >>>> on allocation places should_failslab()->should_fail(). It's possible
> >>>> to configure a specific slab, so the allocations will fail with
> >>>> requested probability.
> >>>
> >>> No fault injection was involved in triggering of this bug.
> >>> Fault injection is clearly visible in console log as "INJECTING
> >>> FAILURE at this stack track" splats and also for bugs with repros it
> >>> would be noted in the syzkaller repro as "fault_call": N. So somehow
> >>> this bug was triggered as is.
> >>>
> >>> But overall syzkaller can do better then the old probabilistic
> >>> injection. The probabilistic injection tend to both under-test what we
> >>> want to test and also crash some system services. syzkaller uses the
> >>> new "systematic fault injection" that allows to test specifically each
> >>> failure site separately in each syscall separately.
> >>
> >> Oho! Interesting.
> >
> > If you are interested. You write N into /proc/thread-self/fail-nth
> > (say, 5) then it will cause failure of the N-th (5-th) failure site in
> > the next syscall in this task only. And by reading it back after the
> > syscall you can figure out if the failure was indeed injected or not
> > (or the syscall had less than 5 failure sites).
> > Then, for each syscall in a test (or only for one syscall of
> > interest), we start by writing "1" into /proc/thread-self/fail-nth; if
> > the failure was injected, write "2" and restart the test; if the
> > failure was injected, write "3" and restart the test; and so on, until
> > the failure wasn't injected (tested all failure sites).
> > This guarantees systematic testing of each error path with minimal
> > number of runs. This has obvious extensions to "each pair of failure
> > sites" (to test failures on error paths), but it's not supported atm.
>
> And what you do in case of a tested syscall has pre-requisites? Say,
> you test close(), which requires open() and some IO before. Are such
> the dependencies statically declared in some configuration file? Or
> you test any repeatable sequence of syscalls?

There are several things at play here.
1. syzkaller has notion of "resources". A resource is something that's
produced by one system call and consumed by another, like a file
descriptor.
E.g. see this for userfault fd:
https://github.com/google/syzkaller/blob/698773cb4fbe8873ee0a2c37b86caef01e2c6159/sys/linux/uffd.txt#L8-L12
This allows syzkaller to understand that there is something called
fd_uffd that is produced by userfaultfd() and then needs to be passed
to ioctl$UFFDIO_API().
So for close it knows that it needs to get the fd somewhere first.

2. For syscalls are not explicitly tied by any resources, it will just
try to combine them randomly.

3. There is coverage-guided reinforcement learning. When it discovers
some sensible combinations of syscalls (as denoted by new kernel code
coverage) it memorizes that program for future mutations to get even
more interesting and more sensible programs. This is allows syzkaller
to build more and more interesting programs by doing small incremental
steps (this is the general idea of coverage-guided fuzzing).
