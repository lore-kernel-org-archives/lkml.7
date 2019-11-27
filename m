Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C9C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026A32068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfK0MKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:10:30 -0500
Received: from foss.arm.com ([217.140.110.172]:46938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfK0MK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:10:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C48DF30E;
        Wed, 27 Nov 2019 04:10:28 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54C553F6C4;
        Wed, 27 Nov 2019 04:10:27 -0800 (PST)
Date:   Wed, 27 Nov 2019 12:10:25 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
Message-ID: <20191127121025.GD29301@bogus>
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
 <20191127120744.iivgw25nixovfj7i@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127120744.iivgw25nixovfj7i@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 05:37:44PM +0530, Viresh Kumar wrote:
> On 27-11-19, 12:48, Dietmar Eggemann wrote:
> > Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
> > functions.") the core cpumask has to be modified during cpu hotplug
> > operations.
> >
> > ("arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC")
> > [1] fixed that but revealed another issue on TC2, i.e in its cpufreq
> > driver.
> >
> > During CPU hp stress operations on multiple CPUs, policy->related_cpus
> > can be altered. This is wrong since this cpumask should contain the
> > online and offline CPUs.
> >
> > The WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus)) in
> > cpufreq_online() triggers in this case.
> >
> > The core cpumask can't be used to set the policy->cpus in
> > ve_spc_cpufreq_init() anymore in case it is called via
> > cpuhp_cpufreq_online()->cpufreq_online()->cpufreq_driver->init().
> >
> > An empty online() callback can be used to avoid that the init()
> > driver function is called during CPU hotplug in so that
> > policy->related_cpus will not be changed.
> >
> > Implementing an online() also requires an offline() callback.
> >
> > Tested on TC2 with CPU hp stress test (CPU hp from multiple CPUs at
> > the same time).
> >
> > [1]
> > https://lore.kernel.org/r/20191127103353.12417-1-dietmar.eggemann@arm.com
> >
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> Wanna provide any fixes tag ?
>
> > ---
> >  drivers/cpufreq/vexpress-spc-cpufreq.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
>
> This is 5.5 material or 5.6 ?
>

v5.5 for sure, broken even on v5.4 but unless someone really cares for
stable on TC2, I am happy to skip it.

--
Regards,
Sudeep
