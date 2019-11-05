Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570EDC49EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2086B20869
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbfKEJx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:53:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40745 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbfKEJx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:53:26 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRvWc-00007n-Cx; Tue, 05 Nov 2019 10:53:22 +0100
Date:   Tue, 5 Nov 2019 10:53:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Scott Wood <swood@redhat.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] timers/nohz: Update nohz load even if tick already
 stopped
In-Reply-To: <7b782bc880a29eb7d37f2c2aff73c43e7f7d032f.camel@redhat.com>
Message-ID: <alpine.DEB.2.21.1911051048190.17054@nanos.tec.linutronix.de>
References: <20191028150716.22890-1-frederic@kernel.org>   <20191029100506.GJ4114@hirez.programming.kicks-ass.net>   <52d963553deda810113accd8d69b6dffdb37144f.camel@redhat.com>   <20191030133130.GY4097@hirez.programming.kicks-ass.net> 
 <813ed21938aa47b15f35f8834ffd98ad4dd27771.camel@redhat.com>  <alpine.DEB.2.21.1911042315390.17054@nanos.tec.linutronix.de>  <alpine.DEB.2.21.1911050042250.17054@nanos.tec.linutronix.de> <7b782bc880a29eb7d37f2c2aff73c43e7f7d032f.camel@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019, Scott Wood wrote:
> On Tue, 2019-11-05 at 00:43 +0100, Thomas Gleixner wrote:
> > As Peter pointed out to me privately we should rather go and analyze the
> > real thing instead of just applying duct tape.
> > 
> > /me drops the patch again.
> 
> The warning is due to kernel/sched/idle.c not updating curr->se.exec_start.
> 
> While debugging I noticed an issue with a particular load pattern.  The CPU
> goes non-nohz for a brief time at an interval very close to twice 
> tick_period.  When the tick is started, the timer expiration is more than
> tick_period in the past, so hrtimer_forward() tries to catch up by adding
> 2*tick_period to the expiration.  Then the tick is stopped before that new
> expiration, and when the tick is woken up the expiry is again advanced by
> 2*tick_period with the timer never actually running.  sched_tick_remote()
> does fire every second, but there are streaks of several seconds where it
> keeps catching the CPU in a non-nohz state, so neither the normal nor remote
> ticks are calling calc_load_nohz_remote().
> 
> Is there a reason to not just remove the hrtimer_forward() from
> tick_nohz_restart(), letting the timer fire if it's in the past, which will
> take care of doing hrtimer_forward()?

Well, no. tick_nohz_restart() can be invoked in a situation where the timer
is armed for something in the far future (or completelt disabled) due to
previously entering an estimated long idle (or user space execution on
NOHZ_FULL) period.

That means if the timer is not canceled, realigned to the current tick and
forwarded to the next due tick, the tick will not fire on time causing
another sort of trouble.

> As for the warning in sched_tick_remote(), it seems like a test for time
> since the last tick on this cpu (remote or otherwise) would be better than
> relying on curr->se.exec_start, in order to detect things like this.

Care to give that a shot?

Thanks,

	tglx
