Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CFAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B7B206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfDYKpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:45:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40762 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfDYKpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:45:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB558374;
        Thu, 25 Apr 2019 03:45:17 -0700 (PDT)
Received: from queper01-ThinkPad-T460s (unknown [10.37.8.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB9A3F5C1;
        Thu, 25 Apr 2019 03:45:14 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:45:07 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
Message-ID: <20190425104504.pbej3b74pwinx6jj@queper01-ThinkPad-T460s>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
 <20190418094833.owlobrx6x5gclvhy@queper01-lin>
 <5CBF93F6.8000109@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5CBF93F6.8000109@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 Apr 2019 at 18:38:46 (-0400), Thara Gopinath wrote:
> I think there is one major difference between user-defined frequency
> constraints and frequency constraints due to thermal events in terms of
> the time period the system spends in the the constraint state.
> Typically, a user constraint lasts for seconds if not minutes and I
> think in this case cpu_capacity_orig should reflect this constraint and
> not cpu_capacity like this patch set.

That might not always be true I think. There's tons of userspace thermal
deamons out there, and I wouldn't be suprised if they were writing into
the cpufreq sysfs files, although I'm not sure.

Another thing is, if you want to change the capacity_orig value, you'll
need to rebuild the sched domains and all I believe. Otherwise there is
a risk to 'break' the sd_asym flags. So we need to make sure we're happy
to pay that price.

> Also, in case of the user
> constraint, there is possibly no need to accumulate and average the
> capacity constraints and instantaneous values can be directly applied to
> cpu_capacity_orig. On the other hand thermal pressure is more spiky and
> sometimes in the order of ms and us requiring the accumulating and
> averaging.
> > 
> > Perhaps the Intel boost stuff could be factored in there ? That is,
> > at times when the boost freq is not reachable capacity_of() would appear
> > smaller ... Unless this wants to be reflected instantaneously ?
> Again, do you think intel boost is more applicable to be reflected in
> cpu_capacity_orig and not cpu_capacity?

I'm not even sure if we want to reflect it at all TBH, but I'd be
interested to see what Intel folks think :-)

Thanks,
Quentin
