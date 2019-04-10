Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68A9C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745B5206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfDJI5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:57:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50286 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfDJI5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:57:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55BC5374;
        Wed, 10 Apr 2019 01:57:08 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1D73F59C;
        Wed, 10 Apr 2019 01:57:05 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:57:04 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190410085702.nll6spd565oio3ds@queper01-lin>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
 <20190410054449.zwmemg7vza557gue@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410054449.zwmemg7vza557gue@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 Apr 2019 at 11:14:49 (+0530), Viresh Kumar wrote:
> On 28-03-19, 10:13, Quentin Perret wrote:
> > +static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
> > +			      unsigned long state)
> > +{
> > +	struct cpufreq_policy *policy;
> > +	unsigned long idx;
> > +
> > +	/* Use the Energy Model table if available */
> > +	if (cpufreq_cdev->em) {
> > +		idx = cpufreq_cdev->max_level - state;
> > +		return cpufreq_cdev->em->table[idx].frequency;
> > +	}
> > +
> > +	/* Otherwise, fallback on the CPUFreq table */
> > +	policy = cpufreq_cdev->policy;
> > +	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
> 
> It is not guaranteed that the frequency table is sorted in any order, isn't it ?

Hmm, indeed... I thought cpufreq_table_validate_and_sort() was actively
sorting the table but it seems I was wrong.

But I _think_ in practice the freq table actually happens to be sorted
for the upstream cpufreq drivers with the CPUFREQ_IS_COOLING_DEV flag
set. Most of them use dev_pm_opp_init_cpufreq_table() which guarantees
the table is sorted and qoriq-cpufreq explicitly sorts the table. But
I'm not sure about qcom-cpufreq-hw ...

So, if the above is true, perhaps I could simply add a check to mandate
that policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_UNSORTED for
cpu_cooling ? That shouldn't harm the existing users.

Do you happen to know a board where the table is unsorted ? Is it a
common use-case ?

If yes, then I'll probably need to drop the dependency on cpufreq's
freq_table and use something else to convert indexes into frequencies
(PM_OPP ?). Unless we can force-sort the table in the cpufreq core, but
that might require lots of changes to lots of drivers too.

> 
> > +		idx = cpufreq_cdev->max_level - state;
> > +	else
> > +		idx = state;
> 
> -- 
> viresh

Thanks,
Quentin
