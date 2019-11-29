Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96A5C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD6B21774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfK2Ltz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:49:55 -0500
Received: from foss.arm.com ([217.140.110.172]:46698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2Ltz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:49:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FC9D1FB;
        Fri, 29 Nov 2019 03:49:55 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B508D3F52E;
        Fri, 29 Nov 2019 03:49:53 -0800 (PST)
Date:   Fri, 29 Nov 2019 11:49:26 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: vexpress-spc: Switch cpumask from topology
 core to OPP sharing
Message-ID: <20191129114926.GA24793@bogus>
References: <20191128101547.519-1-sudeep.holla@arm.com>
 <20191128101547.519-2-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128101547.519-2-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh, Rafael,

On Thu, Nov 28, 2019 at 10:15:47AM +0000, Sudeep Holla wrote:
> Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
> functions.") the core cpumask has to be modified during cpu hotplug
> operations. So using them to set up cpufreq policy cpumask may be
> incorrect as it may contain only cpus that are online at that instance.
>
> Instead, we can use the cpumask setup by OPP library that contains all
> the cpus sharing OPP table using dev_pm_opp_get_sharing_cpus.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

This can go independently via PM tree and I can take 1/2 via SoC tree
(as the file is being moved). The problem will be fixed only after both
lands, but this alone won't break the build. Or if you guys provide
Ack, I can take both together via ARM SoC team. Let me know.

--
Regards,
Sudeep
