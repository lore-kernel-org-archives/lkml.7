Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB160C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905E520835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1zLA0E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437936AbfIWIVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:21:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34399 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437610AbfIWIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:21:52 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so14504043qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dG+IUBD3k3NqJ3XZ6q5TzuUzXf08ps14N7Cnt35pHj4=;
        b=Y1zLA0E64qY1JMhWXseL2XED1vgCe0Kga0U3jU0nQm9tyK374O6vmzji/Jg8lA/jRx
         gG1GT81UVQDJcLe4sdn/hxAXb85avK3TMuyjKev0JnU6O8cItmCJfBaSzsIUvTHM3+5w
         6qV+eoJyBiPH07TGEi9HcTo2f8bAITsdFRzwxFEQWkMNE555JKvxQCoLOykByEF2s285
         27g3nuOSfrxqGULZaNS+ggYfZ1c4NFUYRYOSfPAblJ3WENwI8LRRSdp5AcJXkzl/8kgX
         TNkNJtXhwZLVw+tyeQxCJIsXKaxBYldtc9Yb7ZSL7LIhUIc4JtJynWSP1+TS6wgknA6D
         xOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dG+IUBD3k3NqJ3XZ6q5TzuUzXf08ps14N7Cnt35pHj4=;
        b=X+29Tqc58UTvn7iLlAZ0aDEc5DfVwkdytymPAISyfmliFASFXZ3SQsGv56oE7VO83+
         Gf9RE1PjBTCDI6DVnNKvQrIIVU72ZJ0/KHRJ10GhCSWfOxzM7x/HyWY70qegJCUfY4pE
         ZiETEIrbo+GmD6ojDhbsTO43x2eZxjDQKPm8wgXiZrPEDUpiF4056iBaCoCvg+8kt4KM
         teA/7dZmIRAnpSypjATSM2yhDPRUTO6dL/vntkcqJFT86/u1DBSZc5WdSw0aJd5pSdDk
         xiIpowjDOBcdkqtkgqhSPsHk4d03qVG1cVjIyGBpHRPQpPKoYB4itmn6eXPIsVOWPdIL
         1q2A==
X-Gm-Message-State: APjAAAUNGIfC/jfmstx/HjkSYWs0xe1XzMGcUvEmDLIGNOTuB+vWwxq9
        xi5iyFykRrN/+aQNnxOz5cENuohEcJfXzeLhsPz4iA==
X-Google-Smtp-Source: APXvYqzz7cHXMQpD1jBafgXKLZFZ0/WTTpyPCn95t/84MxF0PmzEbgHKUUrOcxUDcBmS2lMJp43hU1iSaGwQDYdaTAA=
X-Received: by 2002:a37:9202:: with SMTP id u2mr16131182qkd.8.1569226910085;
 Mon, 23 Sep 2019 01:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck> <20190923043113.GA1080@tardis>
In-Reply-To: <20190923043113.GA1080@tardis>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 Sep 2019 10:21:38 +0200
Message-ID: <CACT4Y+a8qwBA_cHfZXFyO=E8qt2dFwy-ahy=cd66KcvFbpcyZQ@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
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

On Mon, Sep 23, 2019 at 6:31 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Fri, Sep 20, 2019 at 04:54:21PM +0100, Will Deacon wrote:
> > Hi Marco,
> >
> > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > We would like to share a new data-race detector for the Linux kernel:
> > > Kernel Concurrency Sanitizer (KCSAN) --
> > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > >
> > > To those of you who we mentioned at LPC that we're working on a
> > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> >
> > Oh, spiffy!
> >
> > > In the coming weeks we're planning to:
> > > * Set up a syzkaller instance.
> > > * Share the dashboard so that you can see the races that are found.
> > > * Attempt to send fixes for some races upstream (if you find that the
> > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > point it out and we'll prioritize that).
> >
> > Curious: do you take into account things like alignment and/or access size
> > when looking at READ_ONCE/WRITE_ONCE? Perhaps you could initially prune
> > naturally aligned accesses for which __native_word() is true?
> >
> > > There are a few open questions:
> > > * The big one: most of the reported races are due to unmarked
> > > accesses; prioritization or pruning of races to focus initial efforts
> > > to fix races might be required. Comments on how best to proceed are
> > > welcome. We're aware that these are issues that have recently received
> > > attention in the context of the LKMM
> > > (https://lwn.net/Articles/793253/).
> >
> > This one is tricky. What I think we need to avoid is an onslaught of
> > patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
> > code being modified. My worry is that Joe Developer is eager to get their
> > first patch into the kernel, so runs this tool and starts spamming
> > maintainers with these things to the point that they start ignoring KCSAN
> > reports altogether because of the time they take up.
> >
> > I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
> > to have a comment describing the racy access, a bit like we do for memory
> > barriers. Another possibility would be to use atomic_t more widely if
> > there is genuine concurrency involved.
> >
>
> Instead of commenting READ_ONCE/WRITE_ONCE()s, how about adding
> anotations for data fields/variables that might be accessed without
> holding a lock? Because if all accesses to a variable are protected by
> proper locks, we mostly don't need to worry about data races caused by
> not using READ_ONCE/WRITE_ONCE(). Bad things happen when we write to a
> variable using locks but read it outside a lock critical section for
> better performance, for example, rcu_node::qsmask. I'm thinking so maybe
> we can introduce a new annotation similar to __rcu, maybe call it
> __lockfree ;-) as follow:
>
>         struct rcu_node {
>                 ...
>                 unsigned long __lockfree qsmask;
>                 ...
>         }
>
> , and __lockfree indicates that by design the maintainer of this data
> structure or variable believe there will be accesses outside lock
> critical sections. Note that not all accesses to __lockfree field, need
> to be READ_ONCE/WRITE_ONCE(), if the developer manages to build a
> complex but working wake/wait state machine so that it could not be
> accessed in the same time, READ_ONCE()/WRITE_ONCE() is not needed.
>
> If we have such an annotation, I think it won't be hard for configuring
> KCSAN to only examine accesses to variables with this annotation. Also
> this annotation could help other checkers in the future.
>
> If KCSAN (at the least the upstream version) only check accesses with
> such an anotation, "spamming with KCSAN warnings/fixes" will be the
> choice of each maintainer ;-)
>
> Thoughts?

But doesn't this defeat the main goal of any race detector -- finding
concurrent accesses to complex data structures, e.g. forgotten
spinlock around rbtree manipulation? Since rbtree is not meant to
concurrent accesses, it won't have __lockfree annotation, and thus we
will ignore races on it...
