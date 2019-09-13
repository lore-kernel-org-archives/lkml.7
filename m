Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E081BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D6B214DE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 19:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbfIMTN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:13:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:54112 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725536AbfIMTN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 15:13:27 -0400
Received: (qmail 5375 invoked by uid 2102); 13 Sep 2019 15:13:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Sep 2019 15:13:26 -0400
Date:   Fri, 13 Sep 2019 15:13:26 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation for plain accesses and data races
In-Reply-To: <20190912220126.GA14560@paulmck-ThinkPad-P72>
Message-ID: <Pine.LNX.4.44L0.1909131509250.1466-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019, Paul E. McKenney wrote:

> On Fri, Sep 06, 2019 at 02:11:29PM -0400, Alan Stern wrote:

> > To this end, the LKMM imposes three extra restrictions, together
> > called the "plain-coherence" axiom because of their resemblance to the
> > coherency rules:
> > 
> > 	If R and W conflict and it is possible to link R to W by one
> > 	of the xb* sequences listed above, then W ->rfe R is not
> > 	allowed (i.e., a load cannot read from a store that it
> > 	executes before, even if one or both is plain).
> > 
> > 	If W and R conflict and it is possible to link W to R by one
> > 	of the vis sequences listed above, then R ->fre W is not
> > 	allowed (i.e., if a store is visible to a load then the load
> > 	must read from that store or one coherence-after it).
> > 
> > 	If W and W' conflict and it is possible to link W to W' by one
> > 	of the vis sequences listed above, then W' ->co W is not
> > 	allowed (i.e., if one store is visible to another then it must
> > 	come after in the coherence order).

> I will need to read this last section again.  Perhaps more than once.  ;-)

I decided this part could use some improvement.  Here is the updated
text:


To this end, the LKMM imposes three extra restrictions, together
called the "plain-coherence" axiom because of their resemblance to the
rules used by the operational model to ensure cache coherence (that
is, the rules governing the memory subsystem's choice of a store to
satisfy a load request and its determination of where a store will
fall in the coherence order):

	If R and W conflict and it is possible to link R to W by one
	of the xb* sequences listed above, then W ->rfe R is not
	allowed (i.e., a load cannot read from a store that it
	executes before, even if one or both is plain).

	If W and R conflict and it is possible to link W to R by one
	of the vis sequences listed above, then R ->fre W is not
	allowed (i.e., if a store is visible to a load then the load
	must read from that store or one coherence-after it).

	If W and W' conflict and it is possible to link W to W' by one
	of the vis sequences listed above, then W' ->co W is not
	allowed (i.e., if one store is visible to a second then the
	second must come after the first in the coherence order).


Alan

