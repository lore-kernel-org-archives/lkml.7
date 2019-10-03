Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E945C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADD920862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbfJCTjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:39:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56499 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbfJCTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:39:32 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iG6wj-0003Qd-67; Thu, 03 Oct 2019 19:39:29 +0000
Date:   Thu, 3 Oct 2019 21:39:28 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191003193927.fvkc4tu66guv7edu@wittgenstein>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com>
 <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
 <CACT4Y+bNun9zAcUEAm9TC6C_e9W9dd3+Eq9GwPWun1zzQOtHAg@mail.gmail.com>
 <CACT4Y+Zaz9+t6LDW5csyezeHQ+whM-wPcta+REa0ESDj4JXPGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Zaz9+t6LDW5csyezeHQ+whM-wPcta+REa0ESDj4JXPGQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 06:00:38PM +0200, Dmitry Vyukov wrote:
> On Thu, Oct 3, 2019 at 3:13 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Oct 2, 2019 at 9:52 PM Marco Elver <elver@google.com> wrote:
> > >
> > > Hi Joel,
> > >
> > > On Tue, 1 Oct 2019 at 23:19, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > > Hi all,
> > > > >
> > > > > We would like to share a new data-race detector for the Linux kernel:
> > > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > > > >
> > > > > To those of you who we mentioned at LPC that we're working on a
> > > > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> > > > >
> > > > > In the coming weeks we're planning to:
> > > > > * Set up a syzkaller instance.
> > > > > * Share the dashboard so that you can see the races that are found.
> > > > > * Attempt to send fixes for some races upstream (if you find that the
> > > > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > > > point it out and we'll prioritize that).
> > > > >
> > > > > There are a few open questions:
> > > > > * The big one: most of the reported races are due to unmarked
> > > > > accesses; prioritization or pruning of races to focus initial efforts
> > > > > to fix races might be required. Comments on how best to proceed are
> > > > > welcome. We're aware that these are issues that have recently received
> > > > > attention in the context of the LKMM
> > > > > (https://lwn.net/Articles/793253/).
> > > > > * How/when to upstream KCSAN?
> > > >
> > > > Looks exciting. I think based on our discussion at LPC, you mentioned
> > > > one way of pruning is if the compiler generated different code with _ONCE
> > > > annotations than what would have otherwise been generated. Is that still on
> > > > the table, for the purposing of pruning the reports?
> > >
> > > This might be interesting at first, but it's not entirely clear how
> > > feasible it is. It's also dangerous, because the real issue would be
> > > ignored. It may be that one compiler version on a particular
> > > architecture generates the same code, but any change in compiler or
> > > architecture and this would no longer be true. Let me know if you have
> > > any more ideas.
> > >
> > > Best,
> > > -- Marco
> > >
> > > > Also appreciate a CC on future patches as well.
> > > >
> > > > thanks,
> > > >
> > > >  - Joel
> > > >
> > > >
> > > > >
> > > > > Feel free to test and send feedback.
> >
> > FYI https://twitter.com/grsecurity/status/1179736828880048128 :)
> 
> +Christian opts in for _all_ reports for
> kernel/{fork,exit,pid,signal}.c and friends.
> Just wanted it to be written down for future reference :)

Yes, please! :)
Christian
