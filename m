Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BFEC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506DB2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 12:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbfKGMkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 07:40:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47500 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388564AbfKGMku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 07:40:50 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSh5j-0005IA-Kd; Thu, 07 Nov 2019 13:40:47 +0100
Date:   Thu, 7 Nov 2019 13:40:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jan Stancek <jstancek@redhat.com>, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it, viro@zeniv.linux.org.uk,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com
Subject: Re: [PATCH] kernel: use ktime_get_real_ts64() to calculate
 acct.ac_btime
In-Reply-To: <20191107123224.GA6315@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1911071335320.4256@nanos.tec.linutronix.de>
References: <a87876829697e1b3c63601b1401a07af79eddae6.1572651216.git.jstancek@redhat.com> <20191107123224.GA6315@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Peter Zijlstra wrote:
> Lets start by saying this accounting stuff is terrible crap and it
> deserves to fail and burn.

No argument about that.

> And what does btime want? As implemented it jumps around if you ask the
> question twice with an adjtime() call or suspend in between. Of course,
> if we take an actual CLOCK_REALTIME timestamp at fork() the value
> doesn't change, but then it can be in the future (DST,adjtime()), which
> is exactly the reason why CLOCK_REALTIME is absolute shit for timestamps
> (logging, accounting, etc.).
> 
> And your 'fix' is pretty terible too. Arguably ktime_get_seconds() wants
> fixing for not having the ns accumulation and actually differing from
> tv_sec, but now you accrue one source of ns while still disregarding
> another (also, I friggin hate timespec, it's a terrible interface for
> time).
> 
> All in all, I'm tempted to just declare this stuff broken and -EWONTFIX,
> but if we have to do something, something like the below is at least
> internally consistent.

Kinda :)

> +	mono = ktime_get_ns();
> +	real = ktime_get_real_ns();
> +	/*
> +	 * Compute btime by subtracting the elapsed time from the current
> +	 * CLOCK_REALTIME.
> +	 *
> +	 * XXX totally buggered, because it changes results across
> +	 * adjtime() calls and suspend/resume.
> +	 */
> +	delta = mono - tsk->start_time; // elapsed in ns
> +	btime = real - delta;		// real ns - elapsed ns
> +	do_div(btime, NSEC_PER_SEC);	// truncated to seconds
> +	stats->ac_btime = btime;

That has pretty much the same problem as just storing the CLOCK_REALTIME
start time at fork and additionally it is wreckaged vs. suspend resume.

So a CLOCK_REALTIME time stamp at fork would at least be correct
vs. suspend resume.

The same result is achieved by:

       boot = ktime_get_boot_ns();
       delta = boot = tsk->real_start_time;

Typing real_start_time makes me really cringe.

Thanks,

	tglx
