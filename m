Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D741C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281C4214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbfKGOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:37:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48024 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKGOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:37:09 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSiuI-0007ss-9x; Thu, 07 Nov 2019 15:37:06 +0100
Date:   Thu, 7 Nov 2019 15:37:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jan Stancek <jstancek@redhat.com>, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it, viro@zeniv.linux.org.uk,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com
Subject: Re: [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <20191107125559.GI4131@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911071536190.4256@nanos.tec.linutronix.de>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com> <20191107123224.GA6315@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
 <20191107125559.GI4131@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Peter Zijlstra wrote:
> On Thu, Nov 07, 2019 at 01:40:47PM +0100, Thomas Gleixner wrote:
> > On Thu, 7 Nov 2019, Peter Zijlstra wrote:
> 
> > > +	mono = ktime_get_ns();
> > > +	real = ktime_get_real_ns();
> > > +	/*
> > > +	 * Compute btime by subtracting the elapsed time from the current
> > > +	 * CLOCK_REALTIME.
> > > +	 *
> > > +	 * XXX totally buggered, because it changes results across
> > > +	 * adjtime() calls and suspend/resume.
> > > +	 */
> > > +	delta = mono - tsk->start_time; // elapsed in ns
> > > +	btime = real - delta;		// real ns - elapsed ns
> > > +	do_div(btime, NSEC_PER_SEC);	// truncated to seconds
> > > +	stats->ac_btime = btime;
> > 
> > That has pretty much the same problem as just storing the CLOCK_REALTIME
> > start time at fork and additionally it is wreckaged vs. suspend resume.
> 
> It's wrecked in general. It also jumps around for any REALTIME
> adjustment.
> 
> > So a CLOCK_REALTIME time stamp at fork would at least be correct
> > vs. suspend resume.
> 
> But still wrecked vs REALTIME jumps, as in, when DST flips the clock
> back an hour, your timestamp is in the future.
> 
> Any which way around the whole thing is buggered.  The only real fix is
> not using REALTIME anything. Which is why I'm loath to add that REALTIME
> timestamp at fork(), it just encourages more use.

Fair enough. You have a sane alternative though: CLOCK_TAI

Thanks,

	tglx


