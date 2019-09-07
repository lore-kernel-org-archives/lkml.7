Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E3C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118B2218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567871830;
	bh=8+SRY4VXi7n58FbZc4gmkkL77BnU5IJr2rZXjzK87y4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SJ6PvgnAD4inlkrGn61r0l1GmDJ23CXs7qC/6hcFo9/jbe+lHv+GvLSa0epOJtbpA
	 gsT2Y+jWxztdzGyX1HfNFG5MfFrwQpyu7J3IwagcRxXzXYWri6nbKMH7JYjZagZa7G
	 Ko616LoKfxKco+Bd4MSilX4qqMjUtetEV8UG6pyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406771AbfIGP5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 11:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406760AbfIGP5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 11:57:08 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB245218AC;
        Sat,  7 Sep 2019 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567871827;
        bh=8+SRY4VXi7n58FbZc4gmkkL77BnU5IJr2rZXjzK87y4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vuq4ksDtuQ0kFld8hjRajz+vpugLjAjt7HHwfQbR49wZjJwYgJN6MuYYEPTFvQiVO
         NyqtnJZYPn8i18jTv44tjuvr7aR8kMWCnUBI4NVf7HWM+AlDOu5gcG1TcgK13qp8Wu
         JNZ3W6dT/RLaqTD/Ezi1H8zBbAMn4CoO9ACJ6eIo=
Date:   Sat, 7 Sep 2019 08:57:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
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
Message-ID: <20190907155706.GA27893@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <Pine.LNX.4.44L0.1909061649430.1627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1909061649430.1627-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 04:57:22PM -0400, Alan Stern wrote:
> Currently the Linux Kernel Memory Model gives an incorrect response
> for the following litmus test:
> 
> C plain-WWC
> 
> {}
> 
> P0(int *x)
> {
> 	WRITE_ONCE(*x, 2);
> }
> 
> P1(int *x, int *y)
> {
> 	int r1;
> 	int r2;
> 	int r3;
> 
> 	r1 = READ_ONCE(*x);
> 	if (r1 == 2) {
> 		smp_rmb();
> 		r2 = *x;
> 	}
> 	smp_rmb();
> 	r3 = READ_ONCE(*x);
> 	WRITE_ONCE(*y, r3 - 1);
> }
> 
> P2(int *x, int *y)
> {
> 	int r4;
> 
> 	r4 = READ_ONCE(*y);
> 	if (r4 > 0)
> 		WRITE_ONCE(*x, 1);
> }
> 
> exists (x=2 /\ 1:r2=2 /\ 2:r4=1)
> 
> The memory model says that the plain read of *x in P1 races with the
> WRITE_ONCE(*x) in P2.
> 
> The problem is that we have a write W and a read R related by neither
> fre or rfe, but rather W ->coe W' ->rfe R, where W' is an intermediate
> write (the WRITE_ONCE() in P0).  In this situation there is no
> particular ordering between W and R, so either a wr-vis link from W to
> R or an rw-xbstar link from R to W would prove that the accesses
> aren't concurrent.
> 
> But the LKMM only looks for a wr-vis link, which is equivalent to
> assuming that W must execute before R.  This is not necessarily true
> on non-multicopy-atomic systems, as the WWC pattern demonstrates.
> 
> This patch changes the LKMM to accept either a wr-vis or a reverse
> rw-xbstar link as a proof of non-concurrency.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Queued and pushed for review and testing, thank you very much!

						Thanx, Paul

> ---
> 
>  tools/memory-model/linux-kernel.cat |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: usb-devel/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.cat
> +++ usb-devel/tools/memory-model/linux-kernel.cat
> @@ -197,7 +197,7 @@ empty (wr-incoh | rw-incoh | ww-incoh) a
>  (* Actual races *)
>  let ww-nonrace = ww-vis & ((Marked * W) | rw-xbstar) & ((W * Marked) | wr-vis)
>  let ww-race = (pre-race & co) \ ww-nonrace
> -let wr-race = (pre-race & (co? ; rf)) \ wr-vis
> +let wr-race = (pre-race & (co? ; rf)) \ wr-vis \ rw-xbstar^-1
>  let rw-race = (pre-race & fr) \ rw-xbstar
>  
>  flag ~empty (ww-race | wr-race | rw-race) as data-race
> 
