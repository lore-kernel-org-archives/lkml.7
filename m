Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF75D206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389058AbfIPPZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:25:08 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51056 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726389AbfIPPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:25:08 -0400
Received: (qmail 3474 invoked by uid 2102); 16 Sep 2019 11:25:07 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2019 11:25:07 -0400
Date:   Mon, 16 Sep 2019 11:25:07 -0400 (EDT)
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
In-Reply-To: <20190916115254.GB29216@tardis>
Message-ID: <Pine.LNX.4.44L0.1909161122390.1489-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Boqun Feng wrote:

> > In other words, we can define ->vis as:
> > 
> > 	let vis = prop ; ((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
> > 
> 
> Hmm.. so the problem with this approach is that the (xbstar & int) part
> doesn't satisfy the requirement of visibility... i.e.
> 
> 	X ->prop Z ->(xbstar & int) Y
> 
> may not guarantee when Y executes, X is already propagated to Y's CPU.

Yes, it doesn't guarantee this.  But the reason it doesn't guarantee 
this is because of the prop.  The (xbstar & int) part is okay.  In 
other words, if

	Z ->(xbstar & int) Y

then it is certainly true that any store propagating to Z's CPU before 
Z executes also propagates to Y's CPU (which is the same one) before Y 
executes.

Alan

