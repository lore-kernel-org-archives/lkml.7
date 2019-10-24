Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ECFCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBA821872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kwoys+xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439414AbfJXLvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:51:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53442 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfJXLvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BRNvs1FeCC7+hhswfQgWObG2J6IdKy3tdSuL8Me79S4=; b=kwoys+xMTSIJu50Xm+nerQz8D
        253B2WdN/S0VTqc0cebWo+1GjjYhq+v8LmFK0qsL7ougbDK0NCGPNHLUQYTYIPfH4DITbHlQWBxNJ
        /8UZN32QLMLRWjA7zqOw2pfpsm00wiX4enMSfJYnmnqt+5/1oehZJ96CmSFGnY1xCMM75+w+BjOMg
        X5M6Pz0YRmy0R4RVR+actzRI95dmGlZnYBCjc84CsjxCsr9OYZ5GJ44T3YgrhhyXwx5L2JdgvugU+
        HYNIXMyv9amAJVhb/RyBWhiRFUX4VOObRLZutIN6t4CYDNcSVx9PoosHxIzccsi2q8HUpWUJrt7nF
        JRfbonbGQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNbdV-00036g-5m; Thu, 24 Oct 2019 11:50:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33F26303DDD;
        Thu, 24 Oct 2019 13:49:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A689D2100B87E; Thu, 24 Oct 2019 13:50:34 +0200 (CEST)
Date:   Thu, 24 Oct 2019 13:50:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 11/14] sched/kcpustat: Introduce vtime-aware kcpustat
 accessor for CPUTIME_SYSTEM
Message-ID: <20191024115034.GA4114@hirez.programming.kicks-ass.net>
References: <20191016025700.31277-1-frederic@kernel.org>
 <20191016025700.31277-12-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016025700.31277-12-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:56:57AM +0200, Frederic Weisbecker wrote:

> +static int kcpustat_field_vtime(u64 *cpustat,
> +				struct vtime *vtime,
> +				enum cpu_usage_stat usage,
> +				int cpu, u64 *val)
> +{
> +	unsigned int seq;
> +	int err;
> +
> +	do {
> +		seq = read_seqcount_begin(&vtime->seqcount);
> +
> +		/*
> +		 * We raced against context switch, fetch the
> +		 * kcpustat task again.
> +		 */
> +		if (vtime->cpu != cpu && vtime->cpu != -1) {
> +			err = -EAGAIN;
> +			continue;

Did that want to be break?

> +		}
> +
> +		/*
> +		 * Two possible things here:
> +		 * 1) We are seeing the scheduling out task (prev) or any past one.
> +		 * 2) We are seeing the scheduling in task (next) but it hasn't
> +		 *    passed though vtime_task_switch() yet so the pending
> +		 *    cputime of the prev task may not be flushed yet.
> +		 *
> +		 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
> +		 */
> +		if (vtime->state == VTIME_INACTIVE) {
> +			err = -EAGAIN;
> +			continue;

Idem.

If so, you can do return -EAGAIN here, and return 0 at the end and get
rid of err.

Also, if you're spin-waiting here, there should probably be a
cpu_relax() before the return -EAGAIN.

And in case that is so, you probably want the rcu_read_lock() section
below _inside_ the do{}while loop, such that the RCU section doesn't
cover the entire spin-wait.

> +		}
> +
> +		err = 0;
> +
> +		*val = cpustat[usage];
> +
> +		if (vtime->state == VTIME_SYS)
> +			*val += vtime->stime + vtime_delta(vtime);
> +
> +	} while (read_seqcount_retry(&vtime->seqcount, seq));
> +
> +	return err;
> +}
> +
> +u64 kcpustat_field(struct kernel_cpustat *kcpustat,
> +		   enum cpu_usage_stat usage, int cpu)
> +{
> +	u64 val;
> +	int err;
> +	u64 *cpustat = kcpustat->cpustat;
> +
> +	if (!vtime_accounting_enabled_cpu(cpu))
> +		return cpustat[usage];
> +
> +	/* Only support sys vtime for now */
> +	if (usage != CPUTIME_SYSTEM)
> +		return cpustat[usage];
> +
> +	rcu_read_lock();
> +
> +	do {
> +		struct rq *rq = cpu_rq(cpu);
> +		struct task_struct *curr;
> +		struct vtime *vtime;
> +
> +		curr = rcu_dereference(rq->curr);

This is indeed safe now (relies on commit

  5311a98fef7d ("tasks, sched/core: RCUify the assignment of rq->curr")

)

> +		if (WARN_ON_ONCE(!curr)) {
> +			val = cpustat[usage];
> +			break;
> +		}
> +
> +		vtime = &curr->vtime;
> +		err = kcpustat_field_vtime(cpustat, vtime, usage, cpu, &val);
> +	} while (err == -EAGAIN);
> +
> +	rcu_read_unlock();
> +
> +	return val;
> +}
> +
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
> -- 
> 2.23.0
> 
