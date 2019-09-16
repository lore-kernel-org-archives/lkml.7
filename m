Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF4C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC931206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbfIPPWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:22:20 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50980 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726389AbfIPPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:22:19 -0400
Received: (qmail 3452 invoked by uid 2102); 16 Sep 2019 11:22:18 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2019 11:22:18 -0400
Date:   Mon, 16 Sep 2019 11:22:18 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Boqun Feng <boqun.feng@gmail.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation for plain accesses and data races
In-Reply-To: <20190916051753.GA29216@tardis>
Message-ID: <Pine.LNX.4.44L0.1909161119160.1489-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Boqun Feng wrote:

> > executes if Y is a store.)  This is expressed by the visibility
> > relation (vis), where X ->vis Y is defined to hold if there is an
> > intermediate event Z such that:
> > 
> > 	X is connected to Z by a possibly empty sequence of
> > 	cumul-fence links followed by an optional rfe link (if none of
> > 	these links are present, X and Z are the same event),
> > 
> 
> I wonder whehter we could add an optional ->coe or ->fre between X and
> the possibly empty sequence of cumul-fence, smiliar to the definition
> of ->prop. This makes sense because if we have
> 
> 	X ->coe X' (and X' in on CPU C)
> 
> , X must be already propagated to C before X' executed, according to our
> operation model:
> 
> "... In particular, it must arrange for the store to be co-later than
> (i.e., to overwrite) any other store to the same location which has
> already propagated to CPU C."

You have misinterpreted the text.  The operational model says that if X 
propagates to CPU C before X' executes then X ->coe X'.  It does _not_ 
say that if X ->coe X' then X propagates to CPU C before X' executes.

> In other words, we can define ->vis as:
> 
> 	let vis = prop ; ((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
> 
> , and for this document, reference the "prop" section in
> explanation.txt. This could make the model simple (both for description
> and explanation), and one better thing is that we won't need commit in
> Paul's dev branch:
> 	
> 	c683f2c807d2 "tools/memory-model: Fix data race detection for unordered store and load"
> 
> , and data race rules will look more symmetrical ;-)
> 
> Thoughts? Or am I missing something subtle here?

See above.

Alan

