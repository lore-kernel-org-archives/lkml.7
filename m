Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA94C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5A420643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbfDRIEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:04:40 -0400
Received: from foss.arm.com ([217.140.101.70]:56976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRIEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:04:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8562B15AB;
        Thu, 18 Apr 2019 01:04:39 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0515D3F59C;
        Thu, 18 Apr 2019 01:04:36 -0700 (PDT)
Date:   Thu, 18 Apr 2019 09:04:32 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mka@chromium.org
Subject: Re: [PATCH v2 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190418080429.pn4r6lnftlfsf4c4@queper01-lin>
References: <20190417094301.17622-1-quentin.perret@arm.com>
 <20190417094301.17622-4-quentin.perret@arm.com>
 <20190418035323.onyfxo4kprwqz2wl@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418035323.onyfxo4kprwqz2wl@vireshk-mac-ubuntu>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 Apr 2019 at 09:23:23 (+0530), Viresh Kumar wrote:
> On 17-04-19, 10:43, Quentin Perret wrote:
> >  static struct thermal_cooling_device *
> >  __cpufreq_cooling_register(struct device_node *np,
> > -			struct cpufreq_policy *policy, u32 capacitance)
> > +			struct cpufreq_policy *policy,
> > +			struct em_perf_domain *em)
> >  {
> 
> > +	if (em_is_sane(cpufreq_cdev, em)) {
> > +		cpufreq_cdev->em = em;
> >  		cooling_ops = &cpufreq_power_cooling_ops;
> > -	} else {
> > +	} else if (policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) {
> >  		cooling_ops = &cpufreq_cooling_ops;
> > +	} else {
> > +		WARN(1, "cpu_cooling: no valid frequency table found\n");
> 
> Well the frequency table is valid, isn't it ?

True ...

> Maybe something like: "cpu_cooling doesn't support unsorted frequency tables" ?

Right, otherwise I guess that could be confused with the check on
cpu_table_count_valid_entries() above. And while I'm thinking about it
perhaps WARN is a bit too much here ? We can handle the error safely so
pr_err() should be enough ?

Thanks,
Quentin
