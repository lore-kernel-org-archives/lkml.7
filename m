Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB34C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBDD222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yx4qOeKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfJDQxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:53:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42447 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:53:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so6397906qkl.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szbrEQ+44GjFscMv1BfBPhkqI0C+sNQmLHo22e0JAFc=;
        b=Yx4qOeKmD0XWNid+LHX1bDDL6SZHVT2FZ1d+Lk1LZsJp3YgCRrxVe0NoV1WUz/PwLU
         VM750Iuos8cQz6GTDnquCwvSVGHgK+fV7O+ZYK8ha/zvjamwmK+0LqOjujQ6Xl1Reisl
         YFUlshXN68dyg3oU8t/UNexrAgauxC3gLdLLxNreI7fDa004Kb1x5Ggd7qDiDo0kmYtq
         cfYxEgQdQz5TrJo9UnJKNFB+1tEA04/qFIRkB4zzHsJEPEmCuFE9Cznpl8ClP9V4Ioji
         KkDvcE8KsUSSPdZgXqb2zlAkFedUwOdDVXHx16J9pxNDDXNFDCbN3F45KyOUm8wiQ28Q
         FKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szbrEQ+44GjFscMv1BfBPhkqI0C+sNQmLHo22e0JAFc=;
        b=GnvwWCf/MVtAUUf8tvrvH5egkJKG5OqNss+eU0PEWpItsvTsQLOpccbfsC75s+MFn/
         6V45xF3sL/eTiYoNlRKr5okTEUAnKjbTBaLdMKimlfLgkydMfAnBDouT5zS0yArVq2SN
         CZ9fRkmUK1+upzw4tJXknTzblxvXuXoq72+8/cSn3gXeHbI2MJ02I3xFb0014IXtEF1Z
         PJKMFAP/bEflxFR894fXBm/rPekauAfOvf2QGRsYjKyoy6XKZ+X71ceW2Xgqt99Wm0NL
         k+sDGHPhtFg9sAGFwnj8bYzm/MfOqk9VaVNLEoB8Gxfv+BqiTjWMz2WRCgjbBd1t2O9U
         YlUw==
X-Gm-Message-State: APjAAAX8phNfyV7Rll1MvUCEmdRrsrxeVo9tfZ3fYNwCRD/GqrUqxGJC
        RBpv/dEA5+fTmLByYNxNVhItmwRxXzOcgb6idnRG8A==
X-Google-Smtp-Source: APXvYqzWIGhS5eddfBw1HGeHlIg5Y4jipnTwAaE+Wn20faNnBKw1aq7vtNfqOuReDvRLYOr6H2CtEBWUnjhuxzQi6TY=
X-Received: by 2002:a37:d84:: with SMTP id 126mr10177395qkn.407.1570207980784;
 Fri, 04 Oct 2019 09:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com> <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
 <20191004164859.GD253167@google.com>
In-Reply-To: <20191004164859.GD253167@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Oct 2019 18:52:49 +0200
Message-ID: <CACT4Y+bPZOb=h9m__Uo0feEshdGzPz0qGK7f2omsUc6-kEvwZA@mail.gmail.com>
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

On Fri, Oct 4, 2019 at 6:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Oct 02, 2019 at 09:51:58PM +0200, Marco Elver wrote:
> > Hi Joel,
> >
> > On Tue, 1 Oct 2019 at 23:19, Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > Hi all,
> > > >
> > > > We would like to share a new data-race detector for the Linux kernel:
> > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > > >
> > > > To those of you who we mentioned at LPC that we're working on a
> > > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> > > >
> > > > In the coming weeks we're planning to:
> > > > * Set up a syzkaller instance.
> > > > * Share the dashboard so that you can see the races that are found.
> > > > * Attempt to send fixes for some races upstream (if you find that the
> > > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > > point it out and we'll prioritize that).
> > > >
> > > > There are a few open questions:
> > > > * The big one: most of the reported races are due to unmarked
> > > > accesses; prioritization or pruning of races to focus initial efforts
> > > > to fix races might be required. Comments on how best to proceed are
> > > > welcome. We're aware that these are issues that have recently received
> > > > attention in the context of the LKMM
> > > > (https://lwn.net/Articles/793253/).
> > > > * How/when to upstream KCSAN?
> > >
> > > Looks exciting. I think based on our discussion at LPC, you mentioned
> > > one way of pruning is if the compiler generated different code with _ONCE
> > > annotations than what would have otherwise been generated. Is that still on
> > > the table, for the purposing of pruning the reports?
> >
> > This might be interesting at first, but it's not entirely clear how
> > feasible it is. It's also dangerous, because the real issue would be
> > ignored. It may be that one compiler version on a particular
> > architecture generates the same code, but any change in compiler or
> > architecture and this would no longer be true. Let me know if you have
> > any more ideas.
>
> My thought was this technique of looking at compiler generated code can be
> used for prioritization of the reports.  Have you tested it though? I think
> without testing such technique, we could not know how much of benefit (or
> lack thereof) there is to the issue.
>
> In fact, IIRC, the compiler generating different code with _ONCE annotation
> can be given as justification for patches doing such conversions.


We also should not forget about "missed mutex" races (e.g. unprotected
radix tree), which are much worse and higher priority than a missed
atomic annotation. If we look at codegen we may discard most of them
as non important.
