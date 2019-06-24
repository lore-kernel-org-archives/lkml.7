Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCA5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441262054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbfFXPj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:39:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57208 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726551AbfFXPjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:39:24 -0400
Received: (qmail 4704 invoked by uid 2102); 24 Jun 2019 11:39:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jun 2019 11:39:23 -0400
Date:   Mon, 24 Jun 2019 11:39:23 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools: memory-model: Improve data-race detection
In-Reply-To: <20190624152126.GA828@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1906241137380.1609-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, Paul E. McKenney wrote:

> On Sun, Jun 23, 2019 at 09:34:55PM -0700, Paul E. McKenney wrote:
> > On Sun, Jun 23, 2019 at 11:15:06AM -0400, Alan Stern wrote:
> > > On Sun, 23 Jun 2019, Akira Yokosawa wrote:
> > > 
> > > > Hi Paul and Alan,
> > > > 
> > > > On 2019/06/22 8:54, Paul E. McKenney wrote:
> > > > > On Fri, Jun 21, 2019 at 10:25:23AM -0400, Alan Stern wrote:
> > > > >> On Fri, 21 Jun 2019, Andrea Parri wrote:
> > > > >>
> > > > >>> On Thu, Jun 20, 2019 at 11:55:58AM -0400, Alan Stern wrote:
> > > > >>>> Herbert Xu recently reported a problem concerning RCU and compiler
> > > > >>>> barriers.  In the course of discussing the problem, he put forth a
> > > > >>>> litmus test which illustrated a serious defect in the Linux Kernel
> > > > >>>> Memory Model's data-race-detection code.
> > > > 
> > > > I was not involved in the mail thread and wondering what the litmus test
> > > > looked like. Some searching of the archive has suggested that Alan presented
> > > > a properly formatted test based on Herbert's idea in [1].
> > > > 
> > > > [1]: https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org/
> > > 
> > > Yes, that's it.  The test is also available at:
> > > 
> > > https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-2.litmus
> > > 
> > > Alan
> > > 
> > > > If this is the case, adding the link (or message id) in the change
> > > > log would help people see the circumstances, I suppose.
> > > > Paul, can you amend the change log?
> > > > 
> > > > I ran herd7 on said litmus test at both "lkmm" and "dev" of -rcu and
> > > > confirmed that this patch fixes the result.
> > > > 
> > > > So,
> > > > 
> > > > Tested-by: Akira Yokosawa <akiyks@gmail.com>
> > 
> > Thank you both!  I will apply these changes tomorrow morning, Pacific Time.
> 
> And done.  Please see below for the updated commit.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 46a020e9464aff884df56e5fd483134c8801e39f
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Thu Jun 20 11:55:58 2019 -0400
> 
>     tools/memory-model: Improve data-race detection
>     
>     Herbert Xu recently reported a problem concerning RCU and compiler
>     barriers.  In the course of discussing the problem, he put forth a
>     litmus test which illustrated a serious defect in the Linux Kernel
>     Memory Model's data-race-detection code [1].
>     
>     The defect was that the LKMM assumed visibility and executes-before
>     ordering of plain accesses had to be mediated by marked accesses.  In
>     Herbert's litmus test this wasn't so, and the LKMM claimed the litmus
>     test was allowed and contained a data race although neither is true.
>     
>     In fact, plain accesses can be ordered by fences even in the absence
>     of marked accesses.  In most cases this doesn't matter, because most
>     fences only order accesses within a single thread.  But the rcu-fence
>     relation is different; it can order (and induce visibility between)
>     accesses in different threads -- events which otherwise might be
>     concurrent.  This makes it relevant to data-race detection.
>     
>     This patch makes two changes to the memory model to incorporate the
>     new insight:
>     
>             If a store is separated by a fence from another access,
>             the store is necessarily visible to the other access (as
>             reflected in the ww-vis and wr-vis relations).  Similarly,
>             if a load is separated by a fence from another access then
>             the load necessarily executes before the other access (as
>             reflected in the rw-xbstar relation).
>     
>             If a store is separated by a strong fence from a marked access
>             then it is necessarily visible to any access that executes
>             after the marked access (as reflected in the ww-vis and wr-vis
>             relations).
>     
>     With these changes, the LKMM gives the desired result for Herbert's
>     litmus test and other related ones [2].
>     
>     [1]     https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1906041026570.1731-100000@iolanthe.rowland.org/
>     
>     [2]     https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-1.litmus
>             https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-2.litmus
>             https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-3.litmus
>             https://github.com/paulmckrcu/litmus/blob/master/manual/plain/C-S-rcunoderef-4.litmus

Please add:

https://github.com/paulmckrcu/litmus/blob/master/manual/plain/strong-vis.litmus

Alan

