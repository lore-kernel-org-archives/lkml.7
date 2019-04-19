Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7929DC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D652171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1ZDK/4JL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfDSTa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:30:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52654 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfDSTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6VWnVgCweh/i9J13ePCp1WXpskD7OICjHvPqGHw06p0=; b=1ZDK/4JL4PFJ7ECgMePxOadtU
        3iO1VjKc1QJ3XtMihHAFP6phDWMBwxN2J5Sn5JdX/KgZ4WEDpsNuEJjjq2r0oJy7jqe3+Q56+a5S0
        7VzTe4BOcHBHK7sGxPTNgcztZxz4N9Ms+Bqvfxq/hV7qa22+Yh73orjOn7ThwetWkTCH7n21uQzYS
        4/uhUJ/uFnFz1+UV5t2LkbNoJ1SRnYDleHcjvFG2jhVaEFxSuBP1iBfZB9B/D1hipJGw7TG23SJyD
        r8pIBywdaBJutJtSUtY3VQa+8c8uwzADZFTVDT7YvUXL8KN9Mv9T4fzdlNcRkNKxcolj+01tETHcG
        i0ub7QG5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHXoC-0006kP-UV; Fri, 19 Apr 2019 18:00:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D55C229BF0C04; Fri, 19 Apr 2019 20:00:17 +0200 (CEST)
Date:   Fri, 19 Apr 2019 20:00:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Message-ID: <20190419180017.GP4038@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 01:21:45PM -0400, Alan Stern wrote:
> Index: usb-devel/Documentation/atomic_t.txt
> ===================================================================
> --- usb-devel.orig/Documentation/atomic_t.txt
> +++ usb-devel/Documentation/atomic_t.txt
> @@ -171,7 +171,10 @@ The barriers:
>    smp_mb__{before,after}_atomic()
>  
>  only apply to the RMW ops and can be used to augment/upgrade the ordering
> -inherent to the used atomic op. These barriers provide a full smp_mb().
> +inherent to the used atomic op. Unlike normal smp_mb() barriers, they order
> +only the RMW op itself against the instructions preceding the
> +smp_mb__before_atomic() or following the smp_mb__after_atomic(); they do
> +not order instructions on the other side of the RMW op at all.

Now it is I who is confused; what?

	x = 1;
	smp_mb__before_atomic();
	atomic_add(1, &a);
	y = 1;

the stores to both x and y will be ordered as if an smp_mb() where
there. There is no order between a and y otoh.
