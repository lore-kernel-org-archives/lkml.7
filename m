Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B485C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC3E21900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fGH397TL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732657AbfDXQiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:38:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732538AbfDXQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lkqxAQL3xt8k0QDsS4LG+HpDDUIEhmWBmfspSXrTCQI=; b=fGH397TL1RWIS9n8MDs6R6aSh
        v42q+k7L/BRr08QxkWNRSWtrUgPUsAzYJEBipPfURIyvFi6QYT2obaA32I/4MFAuOCBO035nqCxvs
        qQw4F5wZttbmjVAos/659UgxkpEYs3Tgoc8c9sDLQlOe4CUQu6rKwVHofHPBISnyKv/BneUFMwW3d
        A2ikCrEPDJX530yBji+kbmZN+3X59EnbCMChRJsVADRSLXFDmRd6+C3g+84Gl8GAtxmr/+O12iHFD
        LhyGwABsvLndPoS65MDPceCi9uNGqnHMsN8Iw/VVBvBZwJXZP9+pnv7i1W0r6jpc5jliMbcvoXIDE
        iFAi2slhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJKuJ-0006mS-II; Wed, 24 Apr 2019 16:38:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11070203C0A58; Wed, 24 Apr 2019 18:38:02 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:38:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V2 1/3] Calculate Thermal Pressure
Message-ID: <20190424163802.GH4038@hirez.programming.kicks-ass.net>
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

> +static void thermal_pressure_update(struct thermal_pressure *cpu_thermal,
> +				    unsigned long cap_max_freq,
> +				    unsigned long max_freq, bool change_scale)
> +{
> +	unsigned long flags = 0;
> +
> +	calculate_thermal_pressure(cpu_thermal);
> +	if (change_scale)
> +		cpu_thermal->raw_scale =
> +			(cap_max_freq << SCHED_CAPACITY_SHIFT) / max_freq;

That needs {} per coding style.

> +
> +	mod_timer(&cpu_thermal->timer, jiffies +
> +				usecs_to_jiffies(TICK_USEC));
> +
> +	spin_unlock_irqrestore(&cpu_thermal->lock, flags);

This is busted has heck, @flags should be the result of irqsave(.flags).

> +}
> +
> +/**
> + * Function for the tick update of the thermal pressure.
> + * The thermal pressure update is aborted if already an update is
> + * happening.
> + */
> +static void thermal_pressure_timeout(struct timer_list *timer)
> +{
> +	struct thermal_pressure *cpu_thermal = from_timer(cpu_thermal, timer,
> +							  timer);

If you split after the = the result is so very much easier to read.

> +	unsigned long flags = 0;
> +
> +	if (!cpu_thermal)
> +		return;
> +
> +	if (!spin_trylock_irqsave(&cpu_thermal->lock, flags))
> +		return;
> +
> +	thermal_pressure_update(cpu_thermal, 0, 0, 0);
> +}
> +
> +/**
> + * Function to update thermal pressure from cooling device
> + * or any framework responsible for capping cpu maximum
> + * capacity.

Would be useful to know how wide @cpus is, typically. Is that the power
culster?

> + */
> +void sched_update_thermal_pressure(struct cpumask *cpus,
> +				   unsigned long cap_max_freq,
> +				   unsigned long max_freq)
> +{
> +	int cpu;
> +	unsigned long flags = 0;
> +	struct thermal_pressure *cpu_thermal;

You got them in exactly the wrong order here.

> +
> +	for_each_cpu(cpu, cpus) {
> +		cpu_thermal = per_cpu(thermal_pressure_cpu, cpu);
> +		if (!cpu_thermal)
> +			return;
> +		spin_lock_irqsave(&cpu_thermal->lock, flags);
> +		thermal_pressure_update(cpu_thermal, cap_max_freq, max_freq, 1);
> +	}
> +}

That's just horrible style. Move the unlock out of
thermal_pressure_update() such that lock and unlock are in the same
function.
