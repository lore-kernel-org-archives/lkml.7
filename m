Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14798C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB3A218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e6jVDiv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbfDXQpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:45:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfDXQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g6DlFLP7NrnGwdEHow1YOFKyE5JRz/OpjxDYhcwMvsg=; b=e6jVDiv921F5TcDqtCnSTfzFm
        bMZtMxt/K2ZZFvdGG/vLX2QWT67KW09wv81ztt6OKZNngo9yMJtxv+TsrW+GcOVOSQ/kOWhfc3ITJ
        13XoIC86lAdd00Vf1XacVrTqJIBaew33WU0Fea8nQhcmuHacSakFSQYyjVUTPy9NHpEj8Hxh+SJ9E
        kSzHTG2+pMxMwbLVbtzpnKjRCEzo7Bs5qxF9YWdZSgPS6vXTgMiv3TtqI45guoodif0Q1rpPyRMQR
        AywqnZ2qeEJtqG3tGk16Vwk8TdwlkNp9Wc+FY1BWHy9gCoxkZeDhAlrcR3nXGuMt4uznmD+RxZ6z5
        8PA4UKYgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJL1M-0005wW-NB; Wed, 24 Apr 2019 16:45:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FFF9203C0A58; Wed, 24 Apr 2019 18:45:19 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:45:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2 1/3] Calculate Thermal Pressure
Message-ID: <20190424164519.GI4038@hirez.programming.kicks-ass.net>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555443521-579-2-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:38:39PM -0400, Thara Gopinath wrote:
> +static void __init init_thermal_pressure(void)
> +{
> +	struct thermal_pressure *cpu_thermal;
> +	unsigned long scale;
> +	int cpu;
> +
> +	pr_debug("Init thermal pressure\n");
> +	for_each_possible_cpu(cpu) {
> +		cpu_thermal = per_cpu(thermal_pressure_cpu, cpu);
> +		if (cpu_thermal)
> +			continue;
> +
> +		cpu_thermal = kzalloc(sizeof(*cpu_thermal), GFP_KERNEL);
> +		if (!cpu_thermal)
> +			continue;

So if you unconditinoally allocate this memory, why not just have:

DEFINE_PER_CPU(struct thermal_pressure, cpu_thermal_pressure); ?

Or stick it in struct rq or whatever.

> +		scale = SCHED_CAPACITY_SCALE;
> +		cpu_thermal->scale = scale;
> +		cpu_thermal->old_scale = scale;
> +		cpu_thermal->raw_scale = scale;
> +		cpu_thermal->age_stamp = sched_clock_cpu(cpu);
> +		cpu_thermal->last_update = sched_clock_cpu(cpu);
> +		cpu_thermal->cpu = cpu;
> +		spin_lock_init(&cpu_thermal->lock);
> +		timer_setup(&cpu_thermal->timer, thermal_pressure_timeout,
> +			    TIMER_DEFERRABLE);
> +		per_cpu(thermal_pressure_cpu, cpu) = cpu_thermal;
> +		pr_debug("cpu %d thermal scale = %ld\n", cpu, cpu_thermal->scale);
> +	}
> +
> +	for_each_possible_cpu(cpu) {

You just done that, what gives?

> +		cpu_thermal = per_cpu(thermal_pressure_cpu, cpu);
> +		if (!cpu_thermal)
> +			continue;
> +		cpu_thermal->timer.expires = jiffies +
> +						usecs_to_jiffies(TICK_USEC);

That's like a very copmlicated way of writing: '1', right?

> +		add_timer(&cpu_thermal->timer);
> +	}
> +}

So really what you want is a hook into the tick?
