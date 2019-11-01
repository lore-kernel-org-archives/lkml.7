Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E1CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89496217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572618640;
	bh=6swmzGZ6W4m7+r/4MFAVFqhIbyFdbUu5MV3GQEOZcQg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=A7BPyOT8uA/oAw+8qturaFx8mrOtrlExzNcLhJDqxDgbqX9PqBTerj9da/n5Nz82y
	 CgNoF6OjKgDESxqYGF+fI7nL1TSxmF44pMkxbuFYru9em2C6Ec+2KisqDkD+/0wXg0
	 zoqfRu9VOStSOb0l+g/Yi04jHzJBSFfbjCSxqVD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKAOaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfKAOai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:30:38 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD972085B;
        Fri,  1 Nov 2019 14:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572618637;
        bh=6swmzGZ6W4m7+r/4MFAVFqhIbyFdbUu5MV3GQEOZcQg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ABxyxbJr58QFu6NSOBGZ9ISXt4rUUHYfG5jdOIsxXo97oQ6q7TXGeog/1fVNH0Xkj
         vBInleml28yISY+5IVsFWaG0fHTubnH5ssF6A3Y6pTHa4Jp4Ok01tpniJjVRtVigij
         5Yg0Ra8PrkZCsh3/sDsgdg3bf6jel/QkuzZxeZQA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E73DA3522AF9; Fri,  1 Nov 2019 07:30:36 -0700 (PDT)
Date:   Fri, 1 Nov 2019 07:30:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20191101143036.GM20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-12-laijs@linux.alibaba.com>
 <20191101125816.GD17910@paulmck-ThinkPad-P72>
 <20191101131315.GY4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101131315.GY4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 02:13:15PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 01, 2019 at 05:58:16AM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 31, 2019 at 10:08:06AM +0000, Lai Jiangshan wrote:
> > > +/* We mask the RCU_NEED_SPECIAL bit so that it return real depth */
> > > +static __always_inline int rcu_preempt_depth(void)
> > > +{
> > > +	return raw_cpu_read_4(__rcu_preempt_depth) & ~RCU_NEED_SPECIAL;
> > 
> > Why not raw_cpu_generic_read()?
> > 
> > OK, OK, I get that raw_cpu_read_4() translates directly into an "mov"
> > instruction on x86, but given that x86 percpu_from_op() is able to
> > adjust based on operand size, why doesn't something like raw_cpu_read()
> > also have an x86-specific definition that adjusts based on operand size?
> 
> The reason for preempt.h was header recursion hell.

Fair enough, being as that is also the reason for _rcu_read_lock()
not being inlined.  :-/

> > > +}
> > > +
> > > +static __always_inline void rcu_preempt_depth_set(int pc)
> > > +{
> > > +	int old, new;
> > > +
> > > +	do {
> > > +		old = raw_cpu_read_4(__rcu_preempt_depth);
> > > +		new = (old & RCU_NEED_SPECIAL) |
> > > +			(pc & ~RCU_NEED_SPECIAL);
> > > +	} while (raw_cpu_cmpxchg_4(__rcu_preempt_depth, old, new) != old);
> > 
> > Ummm...
> > 
> > OK, as you know, I have long wanted _rcu_read_lock() to be inlineable.
> > But are you -sure- that an x86 cmpxchg is faster than a function call
> > and return?  I have strong doubts on that score.
> 
> This is a regular CMPXCHG instruction, not a LOCK prefixed one, and that
> should make all the difference

Yes, understood, but this is also adding some arithmetic, a comparison,
and a conditional branch.  Are you -sure- that this is cheaper than
an unconditional call and return?

> > Plus multiplying the x86-specific code by 26 doesn't look good.
> > 
> > And the RCU read-side nesting depth really is a per-task thing.  Copying
> > it to and from the task at context-switch time might make sense if we
> > had a serious optimization, but it does not appear that we do.
> > 
> > You original patch some years back, ill-received though it was at the
> > time, is looking rather good by comparison.  Plus it did not require
> > architecture-specific code!
> 
> Right, so the per-cpu preempt_count code relies on the preempt_count
> being invariant over context switches. That means we never have to
> save/restore the thing.
> 
> For (preemptible) rcu, this is 'obviously' not the case.
> 
> That said, I've not looked over this patch series, I only got 1 actual
> patch, not the whole series, and I've not had time to go dig out the
> rest..

I have taken a couple of the earlier patches in the series.

Perhaps inlining these things is instead a job for the long anticipated
GCC LTO?  ;-)

							Thanx, Paul
