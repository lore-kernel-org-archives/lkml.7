Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D94C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF968206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 11:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FjdT/Mrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439422AbfIWLBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:01:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43037 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436755AbfIWLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 07:01:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id t84so7154542oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tD1gFIlIhno2JODhrG4T/Y3CfRBXx+18zcgSXO7UpGs=;
        b=FjdT/MrjldO/5MNfPQL2LSNt7runVYM3AbctjQqvmRcJmZZvm7sj3fyeD9xgX5nunT
         XREaTrg4gY2yxzaSJT5tP0uijEYbuVBARcL7DwLVCsQHbKUBD39cjULlqHLQqt+JiPLp
         GeTfBAawCgAcMtb/BtdVRUd90R/mRpP4az+rlCe69ViBsdTZzT+a6S4xXgYmvvipYsZ4
         dCCluUzg8s8W5KKCjjhE405QBtQt2Ss4Oqi85eA7L1p8mBYLj6CsF8Ylq1qNmd/z0pLo
         54owZqgmtfEBLALnGU6yLaBUbGJjPUxwIRGZnucE1L11dhe+5TbdzsDcAR/dnUQGVcbq
         AmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tD1gFIlIhno2JODhrG4T/Y3CfRBXx+18zcgSXO7UpGs=;
        b=ZGpfnZPgp4qCGmmpyCa1AMf65Jy83w7RpNe+yJjJoQxu4Gl6ePB39z22Y4B1WATrZa
         VDI8r8AKu6x41gLER4Vzg5RA2lMIhjd/gSEY4CdzPwRmZrklKu7AZD88LVAh1ju757n9
         HQHXOov0sw69Y9lkuHVFTPkWwC1Ne16GOtPIJy8l0567lm/oa4MLFJtFxoSdyxB9R5wY
         YTK+CZr0aQM7O3gsiG1l9QW5lx4PUoVXLGOwJT+gLGsJuMo1U5dbBIZ136CZhjUYdkHI
         qvfcxW3Th3PRLToaMwEuf/d4jt93j3QPpXcuiEm+IvFeE1SmI0jzR/+wlLDwFNnhZ+YB
         SpVQ==
X-Gm-Message-State: APjAAAXcDdUOlBYa4VTeC9gpYvwGpKb5U3eKI+HTsvVWDkND/8KRAndy
        MbFK5iJ5LrIB44JXFFe/ozPmOgKp63nL39C/YEKW/w==
X-Google-Smtp-Source: APXvYqwd/njuMTaAfhYz6AZCq48IrkvfB3Zfi4RX+obPPH+rEUDaIdzL4WsGnQIOC2OdYXTkZHRD1R6JC/yOjU0eGH0=
X-Received: by 2002:aca:56ca:: with SMTP id k193mr12068915oib.155.1569236500660;
 Mon, 23 Sep 2019 04:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck> <20190923043113.GA1080@tardis>
 <CACT4Y+a8qwBA_cHfZXFyO=E8qt2dFwy-ahy=cd66KcvFbpcyZQ@mail.gmail.com>
 <20190923085409.GB1080@tardis> <CACT4Y+YfkV80QF2qxjfHnBghM8Am8m_YHzCtPRfSmOrF-y3bbg@mail.gmail.com>
In-Reply-To: <CACT4Y+YfkV80QF2qxjfHnBghM8Am8m_YHzCtPRfSmOrF-y3bbg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 23 Sep 2019 13:01:27 +0200
Message-ID: <CANpmjNNX5gJ-CRZ-zg3vNzTcBh6+_zEFQzEGTVFKX-z_KwweVw@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019 at 10:59, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, Sep 23, 2019 at 10:54 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Sep 23, 2019 at 10:21:38AM +0200, Dmitry Vyukov wrote:
> > > On Mon, Sep 23, 2019 at 6:31 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Fri, Sep 20, 2019 at 04:54:21PM +0100, Will Deacon wrote:
> > > > > Hi Marco,
> > > > >
> > > > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > > > We would like to share a new data-race detector for the Linux kernel:
> > > > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > > > > >
> > > > > > To those of you who we mentioned at LPC that we're working on a
> > > > > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > > > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > > > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> > > > >
> > > > > Oh, spiffy!
> > > > >
> > > > > > In the coming weeks we're planning to:
> > > > > > * Set up a syzkaller instance.
> > > > > > * Share the dashboard so that you can see the races that are found.
> > > > > > * Attempt to send fixes for some races upstream (if you find that the
> > > > > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > > > > point it out and we'll prioritize that).
> > > > >
> > > > > Curious: do you take into account things like alignment and/or access size
> > > > > when looking at READ_ONCE/WRITE_ONCE? Perhaps you could initially prune
> > > > > naturally aligned accesses for which __native_word() is true?
> > > > >
> > > > > > There are a few open questions:
> > > > > > * The big one: most of the reported races are due to unmarked
> > > > > > accesses; prioritization or pruning of races to focus initial efforts
> > > > > > to fix races might be required. Comments on how best to proceed are
> > > > > > welcome. We're aware that these are issues that have recently received
> > > > > > attention in the context of the LKMM
> > > > > > (https://lwn.net/Articles/793253/).
> > > > >
> > > > > This one is tricky. What I think we need to avoid is an onslaught of
> > > > > patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
> > > > > code being modified. My worry is that Joe Developer is eager to get their
> > > > > first patch into the kernel, so runs this tool and starts spamming
> > > > > maintainers with these things to the point that they start ignoring KCSAN
> > > > > reports altogether because of the time they take up.
> > > > >
> > > > > I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
> > > > > to have a comment describing the racy access, a bit like we do for memory
> > > > > barriers. Another possibility would be to use atomic_t more widely if
> > > > > there is genuine concurrency involved.
> > > > >
> > > >
> > > > Instead of commenting READ_ONCE/WRITE_ONCE()s, how about adding
> > > > anotations for data fields/variables that might be accessed without
> > > > holding a lock? Because if all accesses to a variable are protected by
> > > > proper locks, we mostly don't need to worry about data races caused by
> > > > not using READ_ONCE/WRITE_ONCE(). Bad things happen when we write to a
> > > > variable using locks but read it outside a lock critical section for
> > > > better performance, for example, rcu_node::qsmask. I'm thinking so maybe
> > > > we can introduce a new annotation similar to __rcu, maybe call it
> > > > __lockfree ;-) as follow:
> > > >
> > > >         struct rcu_node {
> > > >                 ...
> > > >                 unsigned long __lockfree qsmask;
> > > >                 ...
> > > >         }
> > > >
> > > > , and __lockfree indicates that by design the maintainer of this data
> > > > structure or variable believe there will be accesses outside lock
> > > > critical sections. Note that not all accesses to __lockfree field, need
> > > > to be READ_ONCE/WRITE_ONCE(), if the developer manages to build a
> > > > complex but working wake/wait state machine so that it could not be
> > > > accessed in the same time, READ_ONCE()/WRITE_ONCE() is not needed.
> > > >
> > > > If we have such an annotation, I think it won't be hard for configuring
> > > > KCSAN to only examine accesses to variables with this annotation. Also
> > > > this annotation could help other checkers in the future.
> > > >
> > > > If KCSAN (at the least the upstream version) only check accesses with
> > > > such an anotation, "spamming with KCSAN warnings/fixes" will be the
> > > > choice of each maintainer ;-)
> > > >
> > > > Thoughts?
> > >
> > > But doesn't this defeat the main goal of any race detector -- finding
> > > concurrent accesses to complex data structures, e.g. forgotten
> > > spinlock around rbtree manipulation? Since rbtree is not meant to
> > > concurrent accesses, it won't have __lockfree annotation, and thus we
> > > will ignore races on it...
> >
> > Maybe, but for forgotten locks detection, we already have lockdep and
> > also sparse can help a little.
>
> They don't do this at all, or to the necessary degree.
>
> > Having a __lockfree annotation could be
> > benefical for KCSAN to focus on checking the accesses whose race
> > conditions could only be detected by KCSAN at this time. I think this
> > could help KCSAN find problem more easily (and fast).

Just to confirm, the annotation is supposed to mean "this variable
should not be accessed concurrently". '__lockfree' may be confusing,
as "lock-free" has a very specific meaning ("lock-free algorithm"),
and I initially thought the annotation means the opposite. Maybe more
intuitive would be '__nonatomic'.

My view, however, is that this will not scale. 1) Our goal is to
*avoid* more annotations if possible. 2) Furthermore, any such
annotation assumes the developer already has understanding of all
concurrently accessed variables; however, this may not be the case for
the next person touching the code, resulting in an error. By
"whitelisting" variables, we would likely miss almost every serious
bug.

To enable/disable KCSAN for entire subsystems, it's already possible
to use 'KCSAN_SANITIZE :=n' in the Makefile, or 'KCSAN_SANITIZE_file.o
:= n' for individual files.

> > Out of curiosity, does KCSAN ever find a problem with forgotten locks
> > involved? I didn't see any in the -with-fixes branch (that's
> > understandable, given the seriousness, the fixes of this kind of
> > problems could already be submitted to upstream once KCSAN found it.)

The sheer volume of 'benign' data-races makes it difficult to filter
through and get to these, but it certainly detects such issues.

Thanks,
-- Marco

> This one comes to mind:
> https://www.spinics.net/lists/linux-mm/msg92677.html
>
> Maybe some others here, but I don't remember which ones now:
> https://github.com/google/ktsan/wiki/KTSAN-Found-Bugs
