Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E6AC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B632178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l8irkmXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbfKGM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:56:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733250AbfKGM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gyawpv+WI0lozJSUWTS2ESip9V0449YFZgqA+zRI1YQ=; b=l8irkmXsFre5AlFshSr4RYVdK
        x2OYS1VvM1+Ap6bdD3j6W+5trgT5sj3RkjpcY137yFMDSHl8eE/RpBvkkhOOLndg/9u1hFR7s8dK+
        WxlfaX41N3nZzPmG3WexDelchUAcB4yW1GtDzeHsEn3lk6LX7aFzs1AdWcVjDqOCDM6bdU//cbqvB
        osfHGSyIndvDNV9I/ab5C6ih0oXoGqdytaNmSu2ySnhTrZ71R5djL+xdPOxA/RXnQCbsyJPSR7ljU
        yLTF5xRAvRztq8mekVAHz5AjnRZ7ulAGXUQndYzk4lDmGZ59BWkfWYn6LYyiI7huBFYlOI9DM9IjV
        ddMsmYdUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iShKT-0000nk-Am; Thu, 07 Nov 2019 12:56:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0F92300692;
        Thu,  7 Nov 2019 13:54:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78C9E2025EDA7; Thu,  7 Nov 2019 13:55:59 +0100 (CET)
Date:   Thu, 7 Nov 2019 13:55:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jan Stancek <jstancek@redhat.com>, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it, viro@zeniv.linux.org.uk,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com
Subject: Re: [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
Message-ID: <20191107125559.GI4131@hirez.programming.kicks-ass.net>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com>
 <20191107123224.GA6315@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 01:40:47PM +0100, Thomas Gleixner wrote:
> On Thu, 7 Nov 2019, Peter Zijlstra wrote:

> > +	mono = ktime_get_ns();
> > +	real = ktime_get_real_ns();
> > +	/*
> > +	 * Compute btime by subtracting the elapsed time from the current
> > +	 * CLOCK_REALTIME.
> > +	 *
> > +	 * XXX totally buggered, because it changes results across
> > +	 * adjtime() calls and suspend/resume.
> > +	 */
> > +	delta = mono - tsk->start_time; // elapsed in ns
> > +	btime = real - delta;		// real ns - elapsed ns
> > +	do_div(btime, NSEC_PER_SEC);	// truncated to seconds
> > +	stats->ac_btime = btime;
> 
> That has pretty much the same problem as just storing the CLOCK_REALTIME
> start time at fork and additionally it is wreckaged vs. suspend resume.

It's wrecked in general. It also jumps around for any REALTIME
adjustment.

> So a CLOCK_REALTIME time stamp at fork would at least be correct
> vs. suspend resume.

But still wrecked vs REALTIME jumps, as in, when DST flips the clock
back an hour, your timestamp is in the future.

Any which way around the whole thing is buggered.  The only real fix is
not using REALTIME anything. Which is why I'm loath to add that REALTIME
timestamp at fork(), it just encourages more use.
