Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2019BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01161205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfDYMum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:50:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43248 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbfDYMum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:50:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E849A78;
        Thu, 25 Apr 2019 05:50:42 -0700 (PDT)
Received: from queper01-ThinkPad-T460s (unknown [10.37.8.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA81A3F5C1;
        Thu, 25 Apr 2019 05:50:38 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:50:36 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH V3 3/3] thermal/cpu-cooling: Update thermal pressure in
 case of a maximum frequency capping
Message-ID: <20190425125033.pe5ya6me5sr4diix@queper01-ThinkPad-T460s>
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-4-git-send-email-thara.gopinath@linaro.org>
 <20190418094833.owlobrx6x5gclvhy@queper01-lin>
 <5CBF93F6.8000109@linaro.org>
 <20190425104504.pbej3b74pwinx6jj@queper01-ThinkPad-T460s>
 <CAKfTPtAmCvQVudPrUzWa-yhPBRATFYr1a1=iPZ3fonv_K5wn5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAmCvQVudPrUzWa-yhPBRATFYr1a1=iPZ3fonv_K5wn5w@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 Apr 2019 at 14:04:10 (+0200), Vincent Guittot wrote:
> On Thu, 25 Apr 2019 at 12:45, Quentin Perret <quentin.perret@arm.com> wrote:
> >
> > On Tuesday 23 Apr 2019 at 18:38:46 (-0400), Thara Gopinath wrote:
> > > I think there is one major difference between user-defined frequency
> > > constraints and frequency constraints due to thermal events in terms of
> > > the time period the system spends in the the constraint state.
> > > Typically, a user constraint lasts for seconds if not minutes and I
> > > think in this case cpu_capacity_orig should reflect this constraint and
> > > not cpu_capacity like this patch set.
> >
> > That might not always be true I think. There's tons of userspace thermal
> > deamons out there, and I wouldn't be suprised if they were writing into
> > the cpufreq sysfs files, although I'm not sure.
> 
> They would better use the sysfs set_target interface of cpu_cooling
> device in this case.

Right

> > Another thing is, if you want to change the capacity_orig value, you'll
> > need to rebuild the sched domains and all I believe. Otherwise there is
> > a risk to 'break' the sd_asym flags. So we need to make sure we're happy
> > to pay that price.
> 
> That would be the goal, if userspace uses the sysfs interface of
> cpufreq to set a new max frequency, it should be considered as a long
> change in regards to the scheduling rate and in this case it should be
> interesting to update cpacity_orig and rebuild sched_domain.

I guess as long as we don't rebuild too frequently that could work.
Perhaps we could put some rate limiting in there to enforce that. Though
we don't do it for hotplug so ... :/
