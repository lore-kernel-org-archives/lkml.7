Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719C4FA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CD22089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501924AbfJQJ7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:59:07 -0400
Received: from [217.140.110.172] ([217.140.110.172]:37694 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2405688AbfJQJ7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:59:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52E201B4B;
        Thu, 17 Oct 2019 02:58:40 -0700 (PDT)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 838423F718;
        Thu, 17 Oct 2019 02:58:38 -0700 (PDT)
Subject: Re: [RFC PATCH v3 1/6] PM: Introduce em_pd_get_higher_freq()
To:     Douglas RAILLARD <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
References: <20191011134500.235736-1-douglas.raillard@arm.com>
 <20191011134500.235736-2-douglas.raillard@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <5aa79534-7059-09e7-00b8-752f6699f9d4@arm.com>
Date:   Thu, 17 Oct 2019 11:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011134500.235736-2-douglas.raillard@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2019 15:44, Douglas RAILLARD wrote:

[...]

> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index d249b88a4d5a..dd6a35f099ea 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -159,6 +159,53 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
>  	return pd->nr_cap_states;
>  }
>  
> +#define EM_COST_MARGIN_SCALE 1024U
> +
> +/**
> + * em_pd_get_higher_freq() - Get the highest frequency that does not exceed the
> + * given cost margin compared to min_freq
> + * @pd		: performance domain for which this must be done
> + * @min_freq	: minimum frequency to return
> + * @cost_margin	: allowed margin compared to min_freq, on the
> + *		  EM_COST_MARGIN_SCALE scale.
> + *
> + * Return: the chosen frequency, guaranteed to be at least as high as min_freq.
> + */
> +static inline unsigned long em_pd_get_higher_freq(struct em_perf_domain *pd,
> +	unsigned long min_freq, unsigned long cost_margin)
> +{
> +	unsigned long max_cost = 0;
> +	struct em_cap_state *cs;
> +	int i;
> +
> +	if (!pd)
> +		return min_freq;
> +
> +	/* Compute the maximum allowed cost */
> +	for (i = 0; i < pd->nr_cap_states; i++) {
> +		cs = &pd->table[i];
> +		if (cs->frequency >= min_freq) {
> +			max_cost = cs->cost +
> +				(cs->cost * cost_margin) / EM_COST_MARGIN_SCALE;

Maybe you could mention in the header that this is the place where the
algorithm could be tuned. (even though it doesn't offer any tuning
interface, which is a good thing).

> +			break;
> +		}
> +	}
> +
> +	/* Find the highest frequency that will not exceed the cost margin */
> +	for (i = pd->nr_cap_states-1; i >= 0; i--) {
> +		cs = &pd->table[i];
> +		if (cs->cost <= max_cost)
> +			return cs->frequency;
> +	}
> +
> +	/*
> +	 * We should normally never reach here, unless min_freq was higher than
> +	 * the highest available frequency, which is not expected to happen.
> +	 */

Maybe add a WARN_ONCE(1, "foobar"); here to indicate this unlikely event
(CPUfreq and EM framwork out of sync)?

[...]
