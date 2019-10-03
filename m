Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54595C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2200C2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ux5nAYlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfJCNOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:14:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36873 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfJCNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:14:11 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so3496781qtr.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjQvtW5KCBAhxkXZKBpTw3Thc1AXYBDLoKRUiQoeyvg=;
        b=Ux5nAYlQ9Yn7WG4UF2qw8RylFHuO0L2HAo44axKf7TjfqtzcRmqlAvj5ARzygQgGOG
         MzogY0KlYe/FjCgm9/0ZusfW72VRZ4uZy4dtdc56HnzEtkXKD4NyaVsb4AUA5yYFbqrf
         SYAxgM1GhM4icx9dGx5eFCM97/i89UM/WRpfhjtZlI9YWy7XuuXMFSQQsL2eDd/pCum4
         f+uEOCLuG4B7mxdRAa3g5TMmEHye4gWNbYmYWmaDrd5ZRAPEOqYnwjrTvZesj1SkO1XD
         FCVR7HRuRimHgkHGjbY0uAgv124H6+Plyl8559oe5aeIN69KCrYZvRes+PjDqG/aKjbx
         uFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjQvtW5KCBAhxkXZKBpTw3Thc1AXYBDLoKRUiQoeyvg=;
        b=R7+AMMTc0TqsOTbS96K96HgEZU70QSC4rVryWQnjw+WaUVqiuXBUoqwYlGKM5L0fTW
         R1ooMgFwWY2ru9e6KmfPO0wSSrzOTkehUVI98JeC7fTTSotM3MtcRs9Q3858TPlIFF7N
         4p+E8Maye52J86rsrLIU0YrhTaqkHZlTS39ZFnlxjyhjjUyWr3GkhIWhm0wBucNBk1V+
         f/d3YmJEO6r37jcpX11tvMd4lgk0XgXxPo1J2eqvcv1hqaizwWvrq/qVmGU1WzddmR6u
         8DClZhLrBJhVut+AAgds67bFs0yPNgauewSBw9uJ81WkdmDNkJY6Tma/JR5ffHtZSAzN
         /GVw==
X-Gm-Message-State: APjAAAXQvE7b+TjmJmBAFxRn/14F89qZeKXgszlSH01Rs7FPgaiPg9R0
        RehWbX2sP5YkolT1XZiGckDu9EZLWb1nWS45r2KShA==
X-Google-Smtp-Source: APXvYqx46VL8BiLxZS8kOhAGH18FRPo0bE4MIrAYpRnckeMIKR3KpU5qVoBEDW2koRAWlytrsJAgLVwUhuUXyXD37vY=
X-Received: by 2002:ac8:7642:: with SMTP id i2mr9488940qtr.57.1570108450446;
 Thu, 03 Oct 2019 06:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com> <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
In-Reply-To: <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Oct 2019 15:13:57 +0200
Message-ID: <CACT4Y+bNun9zAcUEAm9TC6C_e9W9dd3+Eq9GwPWun1zzQOtHAg@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Marco Elver <elver@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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

On Wed, Oct 2, 2019 at 9:52 PM Marco Elver <elver@google.com> wrote:
>
> Hi Joel,
>
> On Tue, 1 Oct 2019 at 23:19, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > Hi all,
> > >
> > > We would like to share a new data-race detector for the Linux kernel:
> > > Kernel Concurrency Sanitizer (KCSAN) --
> > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > >
> > > To those of you who we mentioned at LPC that we're working on a
> > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> > >
> > > In the coming weeks we're planning to:
> > > * Set up a syzkaller instance.
> > > * Share the dashboard so that you can see the races that are found.
> > > * Attempt to send fixes for some races upstream (if you find that the
> > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > point it out and we'll prioritize that).
> > >
> > > There are a few open questions:
> > > * The big one: most of the reported races are due to unmarked
> > > accesses; prioritization or pruning of races to focus initial efforts
> > > to fix races might be required. Comments on how best to proceed are
> > > welcome. We're aware that these are issues that have recently received
> > > attention in the context of the LKMM
> > > (https://lwn.net/Articles/793253/).
> > > * How/when to upstream KCSAN?
> >
> > Looks exciting. I think based on our discussion at LPC, you mentioned
> > one way of pruning is if the compiler generated different code with _ONCE
> > annotations than what would have otherwise been generated. Is that still on
> > the table, for the purposing of pruning the reports?
>
> This might be interesting at first, but it's not entirely clear how
> feasible it is. It's also dangerous, because the real issue would be
> ignored. It may be that one compiler version on a particular
> architecture generates the same code, but any change in compiler or
> architecture and this would no longer be true. Let me know if you have
> any more ideas.
>
> Best,
> -- Marco
>
> > Also appreciate a CC on future patches as well.
> >
> > thanks,
> >
> >  - Joel
> >
> >
> > >
> > > Feel free to test and send feedback.

FYI https://twitter.com/grsecurity/status/1179736828880048128 :)
