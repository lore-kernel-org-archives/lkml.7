Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC90C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104D8215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zm45PcY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfJDS24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:28:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35635 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:28:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15so9880862qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKTE+CPRe5jd94ICvF2hQ8zNqLxfi/uYBmbl92O68Kw=;
        b=Zm45PcY24Po/wDqJiyZ/zV6koWoQVRkSgx8dnFmgg4JA+uOkMBYeUs0EJx0FDf28e2
         u14hF0BHoNAks3ZLSOTcvcXjZ3r27f9JEAdTaCOKel3zN14wLq3s1qaTMfZth+nqUWgI
         hZVpvx0FNr0MB0vsMVRhE+rchV+1+6DK5f59QV4BemcuWY7Hf2wG7VPdgSziRJ1LgQh7
         oZh5OcogxICwTsO9icLOPg2S7mN6HWumL2tFg8bEznh5VR6gj2Gjkc77fdxddDqPydrM
         u5TvvrNKhNMKNagGG8bSaKPu/3lSLsrUTIkamCqxE5dlxznX98HHcSNAN+rMi7JRwep9
         UYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKTE+CPRe5jd94ICvF2hQ8zNqLxfi/uYBmbl92O68Kw=;
        b=CFlhr8vehd2OVqRieGNlTvlB81oTuZNymSYWp58/uH5Y4rKCqN+yvXz8GFLxHTos+Q
         cefIE5AaDw3LCIh1WNeXXIlGXWacI7YKRsI/n2BwwzRSAbO9SxMAP0z77Ae+5pYVX9yx
         CQSb5V58rIP8Zy+xlbiC/QjbzRZGqej7bNybuSImClNqMxo+VPiAS2VdzsAcDsUKNJJt
         s+zV5gJbma+wuiXXmuhX89H1VhwAD1JQArNfXPBNVBwrlQY7rFkb4hOewUfrpSi39/54
         UF1BZARTng948XMq8YwMju05MrT2ZQgy4e8Qg4HJMPKCbuVducEaeQe4AhjlLPIy4XQU
         R3UA==
X-Gm-Message-State: APjAAAX153jSCDOcOtYrzpJoZ71ApAEcAHgvqJQVW/UtXJzV28RYMiqX
        z2iNmZ1+LQfkVeve5wiV4wB5LfM2YfOQDm8LxzupBQ==
X-Google-Smtp-Source: APXvYqwALIZekUWWMsNraLpmx8AeeelSf50IcWXfqAW+ioakE9xjVZx21QkxyKvK/4QGj6r3FASZU/voOzdi1dNAKKo=
X-Received: by 2002:a0c:facc:: with SMTP id p12mr15620694qvo.80.1570213733780;
 Fri, 04 Oct 2019 11:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com> <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
 <20191004164859.GD253167@google.com> <CACT4Y+bPZOb=h9m__Uo0feEshdGzPz0qGK7f2omsUc6-kEvwZA@mail.gmail.com>
 <20191004165736.GF253167@google.com> <CACT4Y+aEHmbLin_5Od++WVqgiFX7hkjARGgVK0QUj7eUpFLVeg@mail.gmail.com>
 <20191004180848.GH253167@google.com>
In-Reply-To: <20191004180848.GH253167@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Oct 2019 20:28:42 +0200
Message-ID: <CACT4Y+aHQGHaeX4EkD=HeK5j9968BH+zHnVxs6k_c1XvVMGAoQ@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

" On Fri, Oct 4, 2019 at 8:08 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > We would like to share a new data-race detector for the Linux kernel:
> > > > > > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > > > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > > > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > > > > > > >
> > > > > > > > To those of you who we mentioned at LPC that we're working on a
> > > > > > > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > > > > > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > > > > > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> > > > > > > >
> > > > > > > > In the coming weeks we're planning to:
> > > > > > > > * Set up a syzkaller instance.
> > > > > > > > * Share the dashboard so that you can see the races that are found.
> > > > > > > > * Attempt to send fixes for some races upstream (if you find that the
> > > > > > > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > > > > > > point it out and we'll prioritize that).
> > > > > > > >
> > > > > > > > There are a few open questions:
> > > > > > > > * The big one: most of the reported races are due to unmarked
> > > > > > > > accesses; prioritization or pruning of races to focus initial efforts
> > > > > > > > to fix races might be required. Comments on how best to proceed are
> > > > > > > > welcome. We're aware that these are issues that have recently received
> > > > > > > > attention in the context of the LKMM
> > > > > > > > (https://lwn.net/Articles/793253/).
> > > > > > > > * How/when to upstream KCSAN?
> > > > > > >
> > > > > > > Looks exciting. I think based on our discussion at LPC, you mentioned
> > > > > > > one way of pruning is if the compiler generated different code with _ONCE
> > > > > > > annotations than what would have otherwise been generated. Is that still on
> > > > > > > the table, for the purposing of pruning the reports?
> > > > > >
> > > > > > This might be interesting at first, but it's not entirely clear how
> > > > > > feasible it is. It's also dangerous, because the real issue would be
> > > > > > ignored. It may be that one compiler version on a particular
> > > > > > architecture generates the same code, but any change in compiler or
> > > > > > architecture and this would no longer be true. Let me know if you have
> > > > > > any more ideas.
> > > > >
> > > > > My thought was this technique of looking at compiler generated code can be
> > > > > used for prioritization of the reports.  Have you tested it though? I think
> > > > > without testing such technique, we could not know how much of benefit (or
> > > > > lack thereof) there is to the issue.
> > > > >
> > > > > In fact, IIRC, the compiler generating different code with _ONCE annotation
> > > > > can be given as justification for patches doing such conversions.
> > > >
> > > >
> > > > We also should not forget about "missed mutex" races (e.g. unprotected
> > > > radix tree), which are much worse and higher priority than a missed
> > > > atomic annotation. If we look at codegen we may discard most of them
> > > > as non important.
> > >
> > > Sure. I was not asking to look at codegen as the only signal. But to use the
> > > signal for whatever it is worth.
> >
> > But then we need other, stronger signals. We don't have any.
> > So if the codegen is the only one and it says "this is not important",
> > then we conclude "this is not important".
>
> I didn't mean for codegen to say "this is not important", but rather "this IS
> important". And for the other ones, "this may not be important, or it may
> be very important, I don't know".
>
> Why do you say a missed atomic anotation is lower priority? A bug is a bug,

You started talking about prioritization ;)

> and ought to be fixed IMHO. Arguably missing lock acquisition can be detected
> more easily due to lockdep assertions and using lockdep, than missing _ONCE
> annotations. The latter has no way of being detected at runtime easily and
> can be causing failures in mysterious ways.
>
> I think you can divide the problem up.. One set of bugs that are because of
> codegen changes and data races and are "important" for that reason. Another
> one that is less clear whether they are important or not -- until you have a
> better way of providing a signal for categorizing those.
>
> Did I miss something?

We have:
1. missed annotation with changing codegen.
2. missed annotation with non-changing codegen.
3. missed mutex with changing codegen.
4. missed mutex with non-changing codegen.

One can arguably say that 2 is less important than 1. But then both 3
and 4 are not low priority under any circumstances. And we don't have
any means to distinguish 1/2 from 3/4.
In this situation I don't see how "changing codegen" vs "non-changing
codegen" gives us any useful signal.

Assuming we have some signal for lower priority, the only useful way
of using this signal that I see is throwing lower priority bugs away
automatically for now (not reporting on syzbot). Because if we do
report all bugs and humans need to look at all of them anyway, this
signal is not too useful. If am already spending time on a report, I
can as well quickly prioritize it much more precisely than any
automatic scheme.

If we are not reporting lower priority bugs, we cannot offer to
classify "missed mutexes" as lower priority.
