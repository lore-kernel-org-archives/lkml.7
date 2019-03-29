Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A21FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34BC21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfC2JQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:16:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56612 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbfC2JQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:16:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF0E4A78;
        Fri, 29 Mar 2019 02:16:42 -0700 (PDT)
Received: from queper01-ThinkPad-T460s (unknown [10.37.9.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39A5E3F557;
        Fri, 29 Mar 2019 02:16:40 -0700 (PDT)
Date:   Fri, 29 Mar 2019 09:16:38 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190329091636.gbmh5hzw46ucangr@queper01-ThinkPad-T460s>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
 <30926b3d-0074-8c84-a081-d3dbc9258525@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30926b3d-0074-8c84-a081-d3dbc9258525@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thursday 28 Mar 2019 at 21:23:35 (+0100), Daniel Lezcano wrote:
> >  /**
> >   * struct time_in_idle - Idle time stats
> >   * @time: previous reading of the absolute time that this cpu was idle
> > @@ -82,7 +70,7 @@ struct time_in_idle {
> >   *	frequency.
> >   * @max_level: maximum cooling level. One less than total number of valid
> >   *	cpufreq frequencies.
> > - * @freq_table: Freq table in descending order of frequencies
> > + * @em: Reference on the Energy Model of the device
> >   * @cdev: thermal_cooling_device pointer to keep track of the
> >   *	registered cooling device.
> >   * @policy: cpufreq policy.
> > @@ -98,7 +86,7 @@ struct cpufreq_cooling_device {
> >  	unsigned int cpufreq_state;
> >  	unsigned int clipped_freq;
> >  	unsigned int max_level;
> > -	struct freq_table *freq_table;	/* In descending order */
> > +	struct em_perf_domain *em;
> 
> Why do you need to add this field? it will be accessible via policy->em, no?

You mean via the CPUFreq policy ? Then no, the EM isn't attached to the
CPUFreq policy. And we can't attach it directly to the CPUFreq policy
since in *theory* it is not required to map 1:1 to CPUFreq policies
(even though that _is_ true for all existing platforms). That's one of
the things this patch checks in that em_is_sane() function below.

FWIW, the idea of the design is, the EM framework is 'independent' and
it's up to the client subsystems (scheduler, IPA) to check if it actually
works for them. In the case of the scheduler, for example, we can't use
an EM that's too complex because that would cause too much overhead, so
we don't start EAS if that's not the case. See:

  https://elixir.bootlin.com/linux/latest/source/kernel/sched/topology.c#L367

In the case of IPA, we need to do something similar. We can't use an EM
that doesn't map 1:1 to CPUFreq policies, so we bail out if that's not
true, etc, ... This isn't supposed to trigger any time soon, but it's
good to have a check just to be on the safe side I think.

> 
> >  	struct thermal_cooling_device *cdev;
> >  	struct cpufreq_policy *policy;
> >  	struct list_head node;
> > @@ -121,14 +109,14 @@ static LIST_HEAD(cpufreq_cdev_list);
> >  static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,

Thanks,
Quentin
