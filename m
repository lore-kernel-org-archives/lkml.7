Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E384CC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B9C21907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568827454;
	bh=A1V/EfLTbcRI9RyIqwgOE7WQoth8tsczLQUrafsktnI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mmj0BH6hVgGvlKfBNV9rQ4NdxuhEsIULKABBsfemKBZPvJJPY3rCOpx1370BlpB35
	 owm/uNGizwF5xAg8gdJj6s2U0HzIxN8dXKND5uR2gloXXzTj5S7W6+4qa1TdNoL4r7
	 ZyaBA5TDo8iwmVS1UP+0edjgKD9ysHp2mK6sP5Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbfIRRYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfIRRYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:24:13 -0400
Received: from paulmck-ThinkPad-P72 (unknown [50.237.200.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7096B208C0;
        Wed, 18 Sep 2019 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568827453;
        bh=A1V/EfLTbcRI9RyIqwgOE7WQoth8tsczLQUrafsktnI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bOnWVhH0PQlbobozKVtZfWh0PQSA8QsUXeIY4Zw5HPFdvpm8cjDX4gCLldTjbw05A
         pG4lVHTmzefY7a3kOU2IeEkf5jRAm8PXGrx6ZjZRy4gu+7RNDHxRpN2J4vAZVTZVcc
         Hi1QB7friKdAZBYHCY7yu8GQ6e/OwOfkYTz5mbJA=
Date:   Wed, 18 Sep 2019 10:24:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] tools/memory-model: Fix data race detection for
 unordered store and load
Message-ID: <20190918172410.GJ30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <Pine.LNX.4.44L0.1909061649430.1627-100000@iolanthe.rowland.org>
 <20190917113959.GA19404@andrea.guest.corp.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917113959.GA19404@andrea.guest.corp.microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 01:39:59PM +0200, Andrea Parri wrote:
> On Fri, Sep 06, 2019 at 04:57:22PM -0400, Alan Stern wrote:
> > Currently the Linux Kernel Memory Model gives an incorrect response
> > for the following litmus test:
> > 
> > C plain-WWC
> > 
> > {}
> > 
> > P0(int *x)
> > {
> > 	WRITE_ONCE(*x, 2);
> > }
> > 
> > P1(int *x, int *y)
> > {
> > 	int r1;
> > 	int r2;
> > 	int r3;
> > 
> > 	r1 = READ_ONCE(*x);
> > 	if (r1 == 2) {
> > 		smp_rmb();
> > 		r2 = *x;
> > 	}
> > 	smp_rmb();
> > 	r3 = READ_ONCE(*x);
> > 	WRITE_ONCE(*y, r3 - 1);
> > }
> > 
> > P2(int *x, int *y)
> > {
> > 	int r4;
> > 
> > 	r4 = READ_ONCE(*y);
> > 	if (r4 > 0)
> > 		WRITE_ONCE(*x, 1);
> > }
> > 
> > exists (x=2 /\ 1:r2=2 /\ 2:r4=1)
> > 
> > The memory model says that the plain read of *x in P1 races with the
> > WRITE_ONCE(*x) in P2.
> > 
> > The problem is that we have a write W and a read R related by neither
> > fre or rfe, but rather W ->coe W' ->rfe R, where W' is an intermediate
> > write (the WRITE_ONCE() in P0).  In this situation there is no
> > particular ordering between W and R, so either a wr-vis link from W to
> > R or an rw-xbstar link from R to W would prove that the accesses
> > aren't concurrent.
> > 
> > But the LKMM only looks for a wr-vis link, which is equivalent to
> > assuming that W must execute before R.  This is not necessarily true
> > on non-multicopy-atomic systems, as the WWC pattern demonstrates.
> > 
> > This patch changes the LKMM to accept either a wr-vis or a reverse
> > rw-xbstar link as a proof of non-concurrency.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Applied, thank you both!

							Thanx, Paul
