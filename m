Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFA2CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7E7208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CALC57mM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfKANOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:14:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43240 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKANOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3nFhZkwFfSlZqv3Tzrw6PNtRIM5soC/TmXhFHY9PIXk=; b=CALC57mM3DpFo5nCcHmnTQnkU
        ofwSXWa+SXYVk3F9J1+qpmsPL6lWypyd5egwXV1qhwbwuph/8h7WwgsJouNjp+pOJaPmNRBpPMGf3
        XtjGEo4OWsJwIHYNotUGW8ORzWbeyEAAkUpZHniEemmW2KTct6tL3/MTnw6Bum409iTQg+9WVSO3L
        HzfMU4ZJ5KPPO02zb1/V2V17UmWTFckwLnTqQgH51kH/+al+jA+HlUfLHuUITP6xabYQbjZ8pDyGk
        l7BlUbOePjh5EE4jSHQ/TAwdXFXl7yQNs4gZZIuQ1gTVLFZggx+ob35yi9tWi89LImzzlTOI4JlMO
        XBAkPu6tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQWjy-0007lG-PA; Fri, 01 Nov 2019 13:13:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7511305E42;
        Fri,  1 Nov 2019 14:12:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5C952B423E0F; Fri,  1 Nov 2019 14:13:15 +0100 (CET)
Date:   Fri, 1 Nov 2019 14:13:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Rik van Riel <riel@surriel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jann Horn <jannh@google.com>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Yuyang Du <duyuyang@gmail.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 11/11] x86,rcu: use percpu rcu_preempt_depth
Message-ID: <20191101131315.GY4131@hirez.programming.kicks-ass.net>
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-12-laijs@linux.alibaba.com>
 <20191101125816.GD17910@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101125816.GD17910@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 05:58:16AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 31, 2019 at 10:08:06AM +0000, Lai Jiangshan wrote:
> > +/* We mask the RCU_NEED_SPECIAL bit so that it return real depth */
> > +static __always_inline int rcu_preempt_depth(void)
> > +{
> > +	return raw_cpu_read_4(__rcu_preempt_depth) & ~RCU_NEED_SPECIAL;
> 
> Why not raw_cpu_generic_read()?
> 
> OK, OK, I get that raw_cpu_read_4() translates directly into an "mov"
> instruction on x86, but given that x86 percpu_from_op() is able to
> adjust based on operand size, why doesn't something like raw_cpu_read()
> also have an x86-specific definition that adjusts based on operand size?

The reason for preempt.h was header recursion hell.

> > +}
> > +
> > +static __always_inline void rcu_preempt_depth_set(int pc)
> > +{
> > +	int old, new;
> > +
> > +	do {
> > +		old = raw_cpu_read_4(__rcu_preempt_depth);
> > +		new = (old & RCU_NEED_SPECIAL) |
> > +			(pc & ~RCU_NEED_SPECIAL);
> > +	} while (raw_cpu_cmpxchg_4(__rcu_preempt_depth, old, new) != old);
> 
> Ummm...
> 
> OK, as you know, I have long wanted _rcu_read_lock() to be inlineable.
> But are you -sure- that an x86 cmpxchg is faster than a function call
> and return?  I have strong doubts on that score.

This is a regular CMPXCHG instruction, not a LOCK prefixed one, and that
should make all the difference

> Plus multiplying the x86-specific code by 26 doesn't look good.
> 
> And the RCU read-side nesting depth really is a per-task thing.  Copying
> it to and from the task at context-switch time might make sense if we
> had a serious optimization, but it does not appear that we do.
> 
> You original patch some years back, ill-received though it was at the
> time, is looking rather good by comparison.  Plus it did not require
> architecture-specific code!

Right, so the per-cpu preempt_count code relies on the preempt_count
being invariant over context switches. That means we never have to
save/restore the thing.

For (preemptible) rcu, this is 'obviously' not the case.

That said, I've not looked over this patch series, I only got 1 actual
patch, not the whole series, and I've not had time to go dig out the
rest..
