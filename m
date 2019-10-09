Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4A0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E221E20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJbDYOXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfJIHqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:46:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34622 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:46:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id q203so1359493qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sxXKt3AG8Tk8Yu+PG3kbL4A+1NeXOKutWUO/KuZh7Ek=;
        b=nJbDYOXGjSV4xCIvw8szYDZLh/tIZvHGG5t5fcB/SCio6Cw8Puq2TMJP8wpsW27smT
         6O/1Hfk1Gu1j9wQnhqlubBMDm/uyfAlQ1RiMK8LeCAj7iRub/6yg8SpoHnUoSFdjwhJD
         KyLCx6fFRt5jb5Nhbf9bfx0SBNRImDoxWFjWtwXcGc9nMJDMuQY279hmDiu6eHYZRTb/
         IpGfPAN05DxUhjn99xNZWk72/p6Sdde+zFG73uDMJPeGtwb7fsooBf8KCElm232E9HEO
         ZKP//XHQtiDJEJB4cp1OBt4A3pgR45AobXIESeqpzwFDp2Lz9bQRQuynl+NPRSHKOrTg
         SUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxXKt3AG8Tk8Yu+PG3kbL4A+1NeXOKutWUO/KuZh7Ek=;
        b=GR7BagkzSS0g1y0Zyb13mNJJ6pGk2UAdUVuc8udW9+xS8XShseH17rxYsK/6gAtT+3
         kv9IQvs4fa3suPVnulO5zW6M9sRMj02Z185C75e7OKqN12iXlMKmDhyMpTbwBeuK5pLs
         CZ79ZpdAfBpLv5RdtknaLP38VWZ1/yjqNfy/qey6vRGYSUOnFOl+zQB2qzMbg780SCKW
         OTDX2eHIEup1fqCto9g8opMbnC1oogy3r35QGO+muQ6qZSf+7HHKdP328TNc90GeTIv0
         7hP2VKNC/NRJezQMZ9tMmj5pcgTLZE7b4J4WdUIzo/FFnsIHel7VxjnSukmGG/4fgtmN
         MQug==
X-Gm-Message-State: APjAAAWE8NZUYfhSJr3YiX65TRoJ0v74bW6xJoA6lics1Aq6YeWUSlZK
        5kkVrhcldUzHq+L8MZ1HV4nlpmQCo4qTzAjEXr/TiQ==
X-Google-Smtp-Source: APXvYqxg0hrpi0aT+5w5xS8rtR7z83/QTHChGQRPjCCcr9/QiIb4guUX0i1PaQQ/9w3ORsVzB5RWxN5DDxy9NJuyJHU=
X-Received: by 2002:a37:4a87:: with SMTP id x129mr2264716qka.43.1570607163183;
 Wed, 09 Oct 2019 00:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck> <0715d98b-12e9-fd81-31d1-67bcb752b0a1@gmail.com>
 <CACT4Y+bdPKQDGag1rZG6mCj2EKwEsgWdMuHZq_um2KuWOrog6Q@mail.gmail.com>
In-Reply-To: <CACT4Y+bdPKQDGag1rZG6mCj2EKwEsgWdMuHZq_um2KuWOrog6Q@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Oct 2019 09:45:50 +0200
Message-ID: <CACT4Y+Z+rX_cvDLwkzCvmudR6brCNM-8yA+hx9V6nXe159tf6A@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Eric Dumazet <eric.dumazet@gmail.com>
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
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 5, 2019 at 6:16 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sat, Oct 5, 2019 at 2:58 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > > This one is tricky. What I think we need to avoid is an onslaught of
> > > patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
> > > code being modified. My worry is that Joe Developer is eager to get their
> > > first patch into the kernel, so runs this tool and starts spamming
> > > maintainers with these things to the point that they start ignoring KCSAN
> > > reports altogether because of the time they take up.
> > >
> > > I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
> > > to have a comment describing the racy access, a bit like we do for memory
> > > barriers. Another possibility would be to use atomic_t more widely if
> > > there is genuine concurrency involved.
> > >
> >
> > About READ_ONCE() and WRITE_ONCE(), we will probably need
> >
> > ADD_ONCE(var, value)  for arches that can implement the RMW in a single instruction.
> >
> > WRITE_ONCE(var, var + value) does not look pretty, and increases register pressure.
>
> FWIW modern compilers can handle this if we tell them what we are trying to do:
>
> void foo(int *p, int x)
> {
>     x += __atomic_load_n(p, __ATOMIC_RELAXED);
>     __atomic_store_n(p, x, __ATOMIC_RELAXED);
> }
>
> $ clang test.c -c -O2 && objdump -d test.o
>
> 0000000000000000 <foo>:
>    0: 01 37                add    %esi,(%rdi)
>    2: c3                    retq
>
> We can have syntactic sugar on top of this of course.

An interesting precedent come up in another KCSAN bug report. Namely,
it may be reasonable for a compiler to use different optimization
heuristics for concurrent and non-concurrent code. Consider there are
some legal code transformations, but it's unclear if they are
profitable or not. It may be the case that for non-concurrent code the
expectation is that it's a profitable transformation, but for
concurrent code it is not. So that may be another reason to
communicate to compiler what we want to do, rather than trying to
trick and play against each other. I've added the concrete example
here:
https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-may-improve-performance
