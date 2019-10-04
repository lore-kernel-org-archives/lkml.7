Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C10C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE85222CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwAJsXkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfJDRBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:01:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41680 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:01:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id d16so9461236qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/+diOvmD2cdT3EOqXHZRXZjOjtDcKS88F8U+M4R9pI=;
        b=fwAJsXknm6WXNZb7ILUKHv/lvWGosru+D2yRsKId6aGGQj2BT8G+91PVInDIt6hoiq
         Wm3LmIZmyCZuo/L1IBopcKOmJODXPtjRWvTgQH4DYnEa83qVU0m4oXi7FsRSqKz7NKAJ
         JAz/VqX3RTW7fcgmBOXfPSq6jzeppu9N4JzlU2ui5BAaRjP/13xcrVM2z1YlQmqMWK/V
         LAKPdMYcvsnjRfWdO0JVRXKpckxYeoOgrGwZDPBIKKhyIK+lUVavra53geh5FpSROaCi
         gnN3Ibv3BWO1u8fAxn2EZzVOhXeNN5Rod7cqTGXzDWBBTA7prGz5b7nSDtO7rG0c6Gi5
         9faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/+diOvmD2cdT3EOqXHZRXZjOjtDcKS88F8U+M4R9pI=;
        b=nTh6oYObzQHtcrB4nX5rkP7Kij/+q+2vSf7Nr9/xql1Sh6CEFLhwHVmSaN+Tq13JgU
         3wtZCtqNhKsa6+K3PefYCBM3Z1wdq8Ta1lkho+KfgxwCOtptilTupjuqMVjrzsP1ha8a
         rBW7WVpnx0ulHA2b2UPXtNKSA/BnvwkwdGtpIaPuI27CroZ1iuP6E/HfCzLvqHju92eO
         AEwsOsIK1QhQPV+AuI6NFIYuvSYR53BXoL5mMWf0sRXRVgZKEyKvPPsObtLcfeOySr6s
         Hy9mGETAUToaSpalh06DfvDY+Oq74Nb6nBJYCdsBaTzMkv65RXczuq3thPST/RnZpVGT
         io7Q==
X-Gm-Message-State: APjAAAWcGQSUjSvSNeY3YWSldcJ2bHG9d3NKYjU6xsPoQAV3K7/OHKuM
        mGa46XCew6iTlgglwiMPKRgs7keopNznsaJbrbvz8A==
X-Google-Smtp-Source: APXvYqxPTZprTzOLyCwwk6HciZmAHGYj4T6b7zTKO6WENw+B47UDpBsBwx4EMhLAWA6k+CB0k30FLgcp1bYJtOpAq1w=
X-Received: by 2002:ac8:76c6:: with SMTP id q6mr16725217qtr.158.1570208508546;
 Fri, 04 Oct 2019 10:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com> <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
 <20191004164859.GD253167@google.com> <CACT4Y+bPZOb=h9m__Uo0feEshdGzPz0qGK7f2omsUc6-kEvwZA@mail.gmail.com>
 <20191004165736.GF253167@google.com>
In-Reply-To: <20191004165736.GF253167@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Oct 2019 19:01:37 +0200
Message-ID: <CACT4Y+aEHmbLin_5Od++WVqgiFX7hkjARGgVK0QUj7eUpFLVeg@mail.gmail.com>
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

On Fri, Oct 4, 2019 at 6:57 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Oct 04, 2019 at 06:52:49PM +0200, Dmitry Vyukov wrote:
> > On Fri, Oct 4, 2019 at 6:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Wed, Oct 02, 2019 at 09:51:58PM +0200, Marco Elver wrote:
> > > > Hi Joel,
> > > >
> > > > On Tue, 1 Oct 2019 at 23:19, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > We would like to share a new data-race detector for the Linux kernel:
> > > > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > > > > >
> > > > > > To those of you who we mentioned at LPC that we're working on a
> > > > > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > > > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > > > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> > > > > >
> > > > > > In the coming weeks we're planning to:
> > > > > > * Set up a syzkaller instance.
> > > > > > * Share the dashboard so that you can see the races that are found.
> > > > > > * Attempt to send fixes for some races upstream (if you find that the
> > > > > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > > > > point it out and we'll prioritize that).
> > > > > >
> > > > > > There are a few open questions:
> > > > > > * The big one: most of the reported races are due to unmarked
> > > > > > accesses; prioritization or pruning of races to focus initial efforts
> > > > > > to fix races might be required. Comments on how best to proceed are
> > > > > > welcome. We're aware that these are issues that have recently received
> > > > > > attention in the context of the LKMM
> > > > > > (https://lwn.net/Articles/793253/).
> > > > > > * How/when to upstream KCSAN?
> > > > >
> > > > > Looks exciting. I think based on our discussion at LPC, you mentioned
> > > > > one way of pruning is if the compiler generated different code with _ONCE
> > > > > annotations than what would have otherwise been generated. Is that still on
> > > > > the table, for the purposing of pruning the reports?
> > > >
> > > > This might be interesting at first, but it's not entirely clear how
> > > > feasible it is. It's also dangerous, because the real issue would be
> > > > ignored. It may be that one compiler version on a particular
> > > > architecture generates the same code, but any change in compiler or
> > > > architecture and this would no longer be true. Let me know if you have
> > > > any more ideas.
> > >
> > > My thought was this technique of looking at compiler generated code can be
> > > used for prioritization of the reports.  Have you tested it though? I think
> > > without testing such technique, we could not know how much of benefit (or
> > > lack thereof) there is to the issue.
> > >
> > > In fact, IIRC, the compiler generating different code with _ONCE annotation
> > > can be given as justification for patches doing such conversions.
> >
> >
> > We also should not forget about "missed mutex" races (e.g. unprotected
> > radix tree), which are much worse and higher priority than a missed
> > atomic annotation. If we look at codegen we may discard most of them
> > as non important.
>
> Sure. I was not asking to look at codegen as the only signal. But to use the
> signal for whatever it is worth.

But then we need other, stronger signals. We don't have any.
So if the codegen is the only one and it says "this is not important",
then we conclude "this is not important".
