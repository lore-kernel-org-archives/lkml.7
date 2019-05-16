Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FC9C46460
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E8020818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 12:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfEPMmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 08:42:08 -0400
Received: from foss.arm.com ([217.140.101.70]:44480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfEPMmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 08:42:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A5DA80D;
        Thu, 16 May 2019 05:42:07 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 334D93F703;
        Thu, 16 May 2019 05:42:06 -0700 (PDT)
Date:   Thu, 16 May 2019 13:42:00 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     douglas.raillard@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, quentin.perret@arm.com,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 1/7] PM: Introduce em_pd_get_higher_freq()
Message-ID: <20190516124200.opxczohjelhvrzmo@e110439-lin>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <20190508174301.4828-2-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508174301.4828-2-douglas.raillard@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-May 18:42, douglas.raillard@arm.com wrote:
> From: Douglas RAILLARD <douglas.raillard@arm.com>
> 
> em_pd_get_higher_freq() returns a frequency greater or equal to the
> provided one while taking into account a given cost margin. It also
> skips inefficient OPPs that have a higher cost than another one with a
> higher frequency.

It's worth to add a small description and definition of what we mean by
"OPP efficiency". Despite being just an RFC, it could help to better
understand what we are after.

[...]

> +/** + * em_pd_get_higher_freq() - Get the highest frequency that
> does not exceed the
> + * given cost margin compared to min_freq
> + * @pd		: performance domain for which this must be done
> + * @min_freq	: minimum frequency to return
> + * @cost_margin	: allowed margin compared to min_freq, as a per-1024 value.
                                                                    ^^^^^^^^
here...

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
> +			max_cost = cs->cost + (cs->cost * cost_margin) / 1024;
                                                                         ^^^^
... end here we should probably better use SCHED_CAPACITY_SCALE
instead of hard-coding in values, isn't it?

> +			break;
> +		}
> +	}
> +

[...]

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
