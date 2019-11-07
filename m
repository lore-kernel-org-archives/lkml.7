Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D2AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7DA2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389515AbfKGRYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:24:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48846 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729669AbfKGRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:24:36 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iSlWM-0002KO-3t; Thu, 07 Nov 2019 18:24:34 +0100
Date:   Thu, 7 Nov 2019 18:24:34 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191107172434.ylz4hyxw4rbmhre2@linutronix.de>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191107091319.6zf5tmdi54amtann@linutronix.de>
 <20191107161749.GA93945@dennisz-mbp>
 <20191107162842.2qgd3db2cjmmsxeh@linutronix.de>
 <20191107165519.GA99408@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107165519.GA99408@dennisz-mbp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-07 11:55:19 [-0500], Dennis Zhou wrote:
> On Thu, Nov 07, 2019 at 05:28:42PM +0100, Sebastian Andrzej Siewior wrote:
> > > I just want to clarify a little bit. Is this patch aimed at fixing an
> > > issue with RT kernels specifically? 
> > 
> > Due to the implications of preempt_disable() on RT kernels it fixes
> > problems with RT kernels.
> > 
> 
> Great, do you mind adding this explanation with what the implications
> are in the commit message?

some RCU section here invoke callbacks which acquire spinlock_t locks.
This does not work on RT with disabled preemption.

> > > It'd also be nice to have the
> > > numbers as well as if the kernel was RT or non-RT.
> > 
> > The benchmark was done on a CONFIG_PREEMPT kernel. As said in the commit
> > log, the numbers were mostly the same, I can re-run the test and post
> > numbers if you want them.
> > This patch makes no difference on PREEMPT_NONE or PREEMPT_VOLUNTARY
> > kernels.
> > 
> 
> I think a more explicit explanation in the commit message would suffice.

What do you mean by "more explicit explanation"? The part with the
numbers or that it makes no difference for PREEMPT_NONE and
PREEMPT_VOLUNTARY?

> Thanks,
> Dennis

Sebastian
