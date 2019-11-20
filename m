Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E0720748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574262022;
	bh=lWoyQqVoV6v/Nh5wWjW0nmXWL6cUgxI8xFAbLloTv3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c3a8DNFDBZXd/eGvFSDdclX+yIpRIc2zTCKQz6ymNsnUdtVxNwzGRXtrQ/IDRF/8X
	 MJv9MJvP+U5MJjYebxVbKORZ3TbphtGzYz/Ld4YUmqFx4JhrZxKBk8rxEC7ewjsLHl
	 elXE3MI/ldm3XyXzqs7fzO8ounjInaZGYgFuqwX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfKTPAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbfKTPAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:00:21 -0500
Received: from localhost (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A122620731;
        Wed, 20 Nov 2019 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574262020;
        bh=lWoyQqVoV6v/Nh5wWjW0nmXWL6cUgxI8xFAbLloTv3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZ0jOxx8gP7BTTdM+RFW7UGSXm+Eq6hgxGanKA2cRQPT9lk0sjUe21KGWQgiXxxrQ
         Q2Z1im+B6uE5JbpVAa1bvPreJCkF8DQ3F6yfN1jOAsUYa2BWGem2oy/YP/ugWnuH5Y
         ub/j+ZCWFx3G6ADYf3dBp0Ayy9m5WYxKb2LMsRIs=
Date:   Wed, 20 Nov 2019 16:00:17 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/6] sched/vtime: Bring all-in-one kcpustat accessor for
 vtime fields
Message-ID: <20191120150016.GA3383@lenoir>
References: <20191119232218.4206-1-frederic@kernel.org>
 <20191119232218.4206-3-frederic@kernel.org>
 <20191120120449.GB89662@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120120449.GB89662@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 01:04:49PM +0100, Ingo Molnar wrote:
> > +static int vtime_state_check(struct vtime *vtime, int cpu)
> > +{
> > +	/*
> > +	 * We raced against context switch, fetch the
> > +	 * kcpustat task again.
> > +	 */
> 
> s/against context switch
>  /against a context switch

Ok.

> 
> > +void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
> > +		      u64 *user, u64 *nice, u64 *system,
> > +		      u64 *guest, u64 *guest_nice)
> > +{
> > +	u64 *cpustat = kcpustat->cpustat;
> > +	struct rq *rq;
> > +	int err;
> > +
> > +	if (!vtime_accounting_enabled_cpu(cpu)) {
> > +		kcpustat_cputime_raw(cpustat, user, nice,
> > +				     system, guest, guest_nice);
> > +		return;
> > +	}
> > +
> > +	rq = cpu_rq(cpu);
> > +
> > +	for (;;) {
> > +		struct task_struct *curr;
> > +
> > +		rcu_read_lock();
> > +		curr = rcu_dereference(rq->curr);
> > +		if (WARN_ON_ONCE(!curr)) {
> > +			rcu_read_unlock();
> > +			kcpustat_cputime_raw(cpustat, user, nice,
> > +					     system, guest, guest_nice);
> > +			return;
> > +		}
> > +
> > +		err = kcpustat_cputime_vtime(cpustat, curr, cpu, user,
> > +					     nice, system, guest, guest_nice);
> > +		rcu_read_unlock();
> > +
> > +		if (!err)
> > +			return;
> > +
> > +		cpu_relax();
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(kcpustat_cputime);
> 
> I'm wondering whether it's worth introducing a helper structure for this 
> train of parameters: user, nice, system, guest, guest_nice?
> 
> We also have similar constructs in other places:
> 
> +               u64 cpu_user, cpu_nice, cpu_sys, cpu_guest, cpu_guest_nice;
> 
> But more broadly, what do we gain by passing along a quartet of pointers, 
> while we could also just use a 'struct kernel_cpustat' and store the 
> values there naturally?
> 
> Yes, it's larger, because it also has 5 other fields - but we lose much 
> of the space savings due to always passing along the 4 pointers already.
> 
> So I really think the parameter passing should be organized better here.

Yeah I've been thinking about that too but I was worried about the stack use.
It's probably not a big worry eventually. I'll do that for the next series.

> This probably affects similar cpustat functions as well.

Only this one fortunately :-)

Thanks.
