Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24765C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F32206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFUOZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:25:24 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:33500 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725975AbfFUOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:25:24 -0400
Received: (qmail 2413 invoked by uid 2102); 21 Jun 2019 10:25:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jun 2019 10:25:23 -0400
Date:   Fri, 21 Jun 2019 10:25:23 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tools: memory-model: Improve data-race detection
In-Reply-To: <20190621084129.GA6827@andrea>
Message-ID: <Pine.LNX.4.44L0.1906211023040.1471-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Andrea Parri wrote:

> On Thu, Jun 20, 2019 at 11:55:58AM -0400, Alan Stern wrote:
> > Herbert Xu recently reported a problem concerning RCU and compiler
> > barriers.  In the course of discussing the problem, he put forth a
> > litmus test which illustrated a serious defect in the Linux Kernel
> > Memory Model's data-race-detection code.
> > 
> > The defect was that the LKMM assumed visibility and executes-before
> > ordering of plain accesses had to be mediated by marked accesses.  In
> > Herbert's litmus test this wasn't so, and the LKMM claimed the litmus
> > test was allowed and contained a data race although neither is true.
> > 
> > In fact, plain accesses can be ordered by fences even in the absence
> > of marked accesses.  In most cases this doesn't matter, because most
> > fences only order accesses within a single thread.  But the rcu-fence
> > relation is different; it can order (and induce visibility between)
> > accesses in different threads -- events which otherwise might be
> > concurrent.  This makes it relevant to data-race detection.
> > 
> > This patch makes two changes to the memory model to incorporate the
> > new insight:
> > 
> > 	If a store is separated by a fence from another access,
> > 	the store is necessarily visible to the other access (as
> > 	reflected in the ww-vis and wr-vis relations).  Similarly,
> > 	if a load is separated by a fence from another access then
> > 	the load necessarily executes before the other access (as
> > 	reflected in the rw-xbstar relation).
> > 
> > 	If a store is separated by a strong fence from a marked access
> > 	then it is necessarily visible to any access that executes
> > 	after the marked access (as reflected in the ww-vis and wr-vis
> > 	relations).
> > 
> > With these changes, the LKMM gives the desired result for Herbert's
> > litmus test and other related ones.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > Reported-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> For the entire series:
> 
> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> 
> Two nits, but up to Paul AFAIAC:
> 
>  - This is a first time for "tools: memory-model:" in Subject; we were
>    kind of converging to "tools/memory-model:"...

Yeah, sure.  That's the sort of detail I have a hard time remembering.

>  - The report preceded the patch; we might as well reflect this in the
>    order of the tags.

Either way is okay with me.

Alan

