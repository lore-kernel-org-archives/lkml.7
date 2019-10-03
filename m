Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F27C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A852321A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n69rlZo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfJCQAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:00:54 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35863 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfJCQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:00:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so4329190qtf.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHlhVUvFqch680wlgcRKCc65z2j3hwVlcjsPrmD0yPY=;
        b=n69rlZo+yOLc/EmziRkwRlvjCx5SWOGz+Ap4YoTfo+AQCgGMj+280TsW+KTXzRGpJq
         KExcaSPjwVtN5UxZtTVkiTu1oFtZmDjjSFUhzoUymytly2b2c7LXQXsspaEsT/yCIUgn
         OhIB9Kx5HSQL6/Z/NrN9ytAYBs2PYzCDJb9mEcY6UlF7wElr1dvhv+yrCRbUoiOIUTb2
         pLEmUqWtC7aeHQgGzgTGpsUjQBHUsbaZG/7/CwBtRCkpFnCGwsCO2YK1CSP/N/6VhAl9
         sol16PrnH5BIq5WXRJSq6DtqXaDkY20X/vutZUCbwnrQ5NU5W/Xwnx51FyAp3kMMhqA0
         Ihcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHlhVUvFqch680wlgcRKCc65z2j3hwVlcjsPrmD0yPY=;
        b=GXCpZeqU/KIESorKlCabPvpCW9baet0OGcjmWT0Eeo3T9j2pqJQdyrH2pktZ/hGU4T
         aRf+LSFNAP3pZ5FGEaYvhUfDB5IP8T6+peCbn7vOJ3+8gVkCOHCgCu+5VYXaFPgrvDCX
         p76ZdWn0QI72voz6HsxNVO3Teb3KNpBiwQy0eVjM3SJJDGA8JDfz9MHyoXdbR2MkMzbI
         66Tpz/+4fhCbnN9r9926AJsenCRMZvmdJz+TXUrEs9coFVPvKxBK1924XaZug9ymG0QB
         vkj6+Wo7DIsu14jfrhC43QslJd+kuDcBB8tDu/OyVcB/LYLY328fD6jo3zjAMfhjWJ/S
         PKeA==
X-Gm-Message-State: APjAAAWJJKOTm8BB8tUoAFOJdc2G/vOHGQsXgm2vFsiYUBQ1Xl59WiTc
        RV5XElS0NeFlaKGSbHNZVq6OM/3zjG8xGjvix2xXeQ==
X-Google-Smtp-Source: APXvYqwCdMxh4briDkus03w+Fevn/52BFVCaS0a+4l2orABcmLrmeDyvK2IkpeXW659l+oihpmAV+V5OsnmKp5OGgns=
X-Received: by 2002:ac8:7642:: with SMTP id i2mr10304461qtr.57.1570118450459;
 Thu, 03 Oct 2019 09:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com> <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
 <CACT4Y+bNun9zAcUEAm9TC6C_e9W9dd3+Eq9GwPWun1zzQOtHAg@mail.gmail.com>
In-Reply-To: <CACT4Y+bNun9zAcUEAm9TC6C_e9W9dd3+Eq9GwPWun1zzQOtHAg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Oct 2019 18:00:38 +0200
Message-ID: <CACT4Y+Zaz9+t6LDW5csyezeHQ+whM-wPcta+REa0ESDj4JXPGQ@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Marco Elver <elver@google.com>,
        Christian Brauner <christian@brauner.io>
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

On Thu, Oct 3, 2019 at 3:13 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Oct 2, 2019 at 9:52 PM Marco Elver <elver@google.com> wrote:
> >
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
> >
> > Best,
> > -- Marco
> >
> > > Also appreciate a CC on future patches as well.
> > >
> > > thanks,
> > >
> > >  - Joel
> > >
> > >
> > > >
> > > > Feel free to test and send feedback.
>
> FYI https://twitter.com/grsecurity/status/1179736828880048128 :)

+Christian opts in for _all_ reports for
kernel/{fork,exit,pid,signal}.c and friends.
Just wanted it to be written down for future reference :)
