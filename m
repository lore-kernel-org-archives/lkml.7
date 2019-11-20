Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76E6C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C0C223D1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574251496;
	bh=6dGWB4xvEdJyCYEeTQJzkZ9l0FigWvBJfhutzJxqCDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YImG4cSMa1RgPoAt1kSs2GyOCB19JNozVF/2Sb5uB4/vmL1OeV/glV/GYQhqC9XK8
	 do10CIvprdfNKSNTG6jkpJiiIBv4sN0GSMAR5DLC/zjzGBjK1IKIRh4ia9gIA58hdb
	 P9t1h7evmikMDRxCoOzvEHzOAXEEHlurtcIDi14k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfKTMEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:04:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46154 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfKTMEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:04:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so27836609wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q4VLJjVAb59aTdw6yj5OaPsr8v0tuOEHw/RKF7/OFl0=;
        b=as7VlJ10/EVIXlHjWlpNebZmejIlclfNEgtMwra7/2dm5AgLoa+PJjKoSFDNQNrjBj
         f4FjTjobJoHNPllnsX0k6DreDQ62ZI8sd0djbtQOkOuUIDTE+m5/Gs0oCc887Q/0axBf
         rGp9h7/FwpTM9Zv8aZHTV+6xKgbJjGlNFSGwE+pzE7r1EIDxshjK2YHOQon4uwkG1a0F
         6tUtoMF/PMd6cZh3c5aaCCBIziaHnYn7m3ZFdw1kHcHsWEpW6JiQOW4i+kDV9TXLq/yp
         MXdUdzRoKLh22lzJttByIz7NFyXzdygtaMObJc1n2GSOTVTH0/EIG1UyhBaNjNPWvtCZ
         dq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q4VLJjVAb59aTdw6yj5OaPsr8v0tuOEHw/RKF7/OFl0=;
        b=hqrUaUTWy5+jzmGrk7ahFh/MoPphwIKhmU6DuVi5gmgWloKp5D9SAEaxL5jHgc/lql
         F+Mjk1cKGelDy22l6Wrk7M/tkSOnH4cA5X3HuAU+mdm4mZ03vrCDsnxIETtcynYakNv/
         OICBC5u1EYsZp596bmSs5O3VG5NmcMbcazL24ODwWwEAauPfGVxOIzR9B/hq1R4mj/W7
         lYbRAnMUTZph26L0VQVkvmDtlf9utr4jmkM/nLEmKomQvoDwOcZlrLwyej6gn/nixJZ6
         fC6LNaGsMkEUPBKCjiFw6hopDRONRrYIgZErkqzPi7S1vwsvb3+KOTfZxdJyS/uDvd3r
         f+uQ==
X-Gm-Message-State: APjAAAUV3PcJMR2DR+VjIR+T9+aasKrvzmxFCqDNWkSRdPyYO1Hu3Vat
        AOl532DscB0hnNVRnDyeHuk=
X-Google-Smtp-Source: APXvYqwnAZgW4v0hBpoaQFd0aQzOBvzcUxmTh13c5BFpZdfj1jcCvSh5SCngiigROa7TWZwpBiBz+w==
X-Received: by 2002:adf:fd85:: with SMTP id d5mr2911872wrr.101.1574251492368;
        Wed, 20 Nov 2019 04:04:52 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y16sm30915322wro.25.2019.11.20.04.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 04:04:51 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:04:49 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20191120120449.GB89662@gmail.com>
References: <20191119232218.4206-1-frederic@kernel.org>
 <20191119232218.4206-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119232218.4206-3-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> Many callsites want to fetch the values of system, user, user_nice, guest
> or guest_nice kcpustat fields altogether or at least a pair of these.
> 
> In that case calling kcpustat_field() for each requested field brings
> unecessary overhead when we could fetch all of them in a row.
> 
> So provide kcpustat_cputime() that fetches all vtime sensitive fields
> under the same RCU and seqcount block.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/kernel_stat.h |  23 ++++++
>  kernel/sched/cputime.c      | 139 ++++++++++++++++++++++++++++++------
>  2 files changed, 142 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> index 79781196eb25..6bd70e464c61 100644
> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -78,15 +78,38 @@ static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
>  	return kstat_cpu(cpu).irqs_sum;
>  }
>  
> +
> +static inline void kcpustat_cputime_raw(u64 *cpustat, u64 *user, u64 *nice,
> +					u64 *system, u64 *guest, u64 *guest_nice)
> +{
> +	*user = cpustat[CPUTIME_USER];
> +	*nice = cpustat[CPUTIME_NICE];
> +	*system = cpustat[CPUTIME_SYSTEM];
> +	*guest = cpustat[CPUTIME_GUEST];
> +	*guest_nice = cpustat[CPUTIME_GUEST_NICE];

Could the 'cpustat' pointer be constified?

Also, please:

> +	*user	    = cpustat[CPUTIME_USER];
> +	*nice	    = cpustat[CPUTIME_NICE];
> +	*system	    = cpustat[CPUTIME_SYSTEM];
> +	*guest	    = cpustat[CPUTIME_GUEST];
> +	*guest_nice = cpustat[CPUTIME_GUEST_NICE];

More pleasing to look at and easier to verify as well.

> +static int vtime_state_check(struct vtime *vtime, int cpu)
> +{
> +	/*
> +	 * We raced against context switch, fetch the
> +	 * kcpustat task again.
> +	 */

s/against context switch
 /against a context switch

> +void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
> +		      u64 *user, u64 *nice, u64 *system,
> +		      u64 *guest, u64 *guest_nice)
> +{
> +	u64 *cpustat = kcpustat->cpustat;
> +	struct rq *rq;
> +	int err;
> +
> +	if (!vtime_accounting_enabled_cpu(cpu)) {
> +		kcpustat_cputime_raw(cpustat, user, nice,
> +				     system, guest, guest_nice);
> +		return;
> +	}
> +
> +	rq = cpu_rq(cpu);
> +
> +	for (;;) {
> +		struct task_struct *curr;
> +
> +		rcu_read_lock();
> +		curr = rcu_dereference(rq->curr);
> +		if (WARN_ON_ONCE(!curr)) {
> +			rcu_read_unlock();
> +			kcpustat_cputime_raw(cpustat, user, nice,
> +					     system, guest, guest_nice);
> +			return;
> +		}
> +
> +		err = kcpustat_cputime_vtime(cpustat, curr, cpu, user,
> +					     nice, system, guest, guest_nice);
> +		rcu_read_unlock();
> +
> +		if (!err)
> +			return;
> +
> +		cpu_relax();
> +	}
> +}
> +EXPORT_SYMBOL_GPL(kcpustat_cputime);

I'm wondering whether it's worth introducing a helper structure for this 
train of parameters: user, nice, system, guest, guest_nice?

We also have similar constructs in other places:

+               u64 cpu_user, cpu_nice, cpu_sys, cpu_guest, cpu_guest_nice;

But more broadly, what do we gain by passing along a quartet of pointers, 
while we could also just use a 'struct kernel_cpustat' and store the 
values there naturally?

Yes, it's larger, because it also has 5 other fields - but we lose much 
of the space savings due to always passing along the 4 pointers already.

So I really think the parameter passing should be organized better here. 
This probably affects similar cpustat functions as well.

Thanks,

	Ingo
