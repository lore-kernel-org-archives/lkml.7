Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F364ECA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23732086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfJaJoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:44:23 -0400
Received: from foss.arm.com ([217.140.110.172]:46318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbfJaJoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:44:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF3531F1;
        Thu, 31 Oct 2019 02:44:22 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5FE3F719;
        Thu, 31 Oct 2019 02:44:22 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:44:20 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 0/6] Introduce Thermal Pressure
Message-ID: <20191031094420.GA19197@e108754-lin>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Tuesday 22 Oct 2019 at 16:34:19 (-0400), Thara Gopinath wrote:
> Thermal governors can respond to an overheat event of a cpu by
> capping the cpu's maximum possible frequency. This in turn
> means that the maximum available compute capacity of the
> cpu is restricted. But today in the kernel, task scheduler is 
> not notified of capping of maximum frequency of a cpu.
> In other words, scheduler is unware of maximum capacity

Nit: s/unware/unaware

> restrictions placed on a cpu due to thermal activity.
> This patch series attempts to address this issue.
> The benefits identified are better task placement among available
> cpus in event of overheating which in turn leads to better
> performance numbers.
> 
> The reduction in the maximum possible capacity of a cpu due to a 
> thermal event can be considered as thermal pressure. Instantaneous
> thermal pressure is hard to record and can sometime be erroneous
> as there can be mismatch between the actual capping of capacity
> and scheduler recording it. Thus solution is to have a weighted
> average per cpu value for thermal pressure over time.
> The weight reflects the amount of time the cpu has spent at a
> capped maximum frequency. Since thermal pressure is recorded as
> an average, it must be decayed periodically. Exisiting algorithm
> in the kernel scheduler pelt framework is re-used to calculate
> the weighted average. This patch series also defines a sysctl
> inerface to allow for a configurable decay period.
> 
> Regarding testing, basic build, boot and sanity testing have been
> performed on db845c platform with debian file system.
> Further, dhrystone and hackbench tests have been
> run with the thermal pressure algorithm. During testing, due to
> constraints of step wise governor in dealing with big little systems,
> trip point 0 temperature was made assymetric between cpus in little
> cluster and big cluster; the idea being that
> big core will heat up and cpu cooling device will throttle the
> frequency of the big cores faster, there by limiting the maximum available
> capacity and the scheduler will spread out tasks to little cores as well.
>

Can you please share the changes you've made to sdm845.dtsi and a kernel
base on top of which to apply your patches? I would like to reproduce
your results and run more tests and it would be good if our setups were
as close as possible.

> Test Results
> 
> Hackbench: 1 group , 30000 loops, 10 runs       
>                                                Result         SD             
>                                                (Secs)     (% of mean)     
>  No Thermal Pressure                            14.03       2.69%           
>  Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%         
>  Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%           
>  Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%         
>  Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%           
>  Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%  
> 
> Dhrystone Run Time  : 20 threads, 3000 MLOOPS
>                                                  Result      SD             
>                                                  (Secs)    (% of mean)     
>  No Thermal Pressure                              9.452      4.49%
>  Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
>  Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
>  Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
>  Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
>  Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%  
>

Do you happen to know by how much the CPUs were capped during these
experiments?

Thanks,
Ionela.

> A Brief History
> 
> The first version of this patch-series was posted with resuing
> PELT algorithm to decay thermal pressure signal. The discussions
> that followed were around whether intanteneous thermal pressure
> solution is better and whether a stand-alone algortihm to accumulate
> and decay thermal pressure is more appropriate than re-using the
> PELT framework. 
> Tests on Hikey960 showed the stand-alone algorithm performing slightly
> better than resuing PELT algorithm and V2 was posted with the stand
> alone algorithm. Test results were shared as part of this series.
> Discussions were around re-using PELT algorithm and running
> further tests with more granular decay period.
> 
> For some time after this development was impeded due to hardware
> unavailability, some other unforseen and possibly unfortunate events.
> For this version, h/w was switched from hikey960 to db845c.
> Also Instantaneous thermal pressure was never tested as part of this
> cycle as it is clear that weighted average is a better implementation.
> The non-PELT algorithm never gave any conclusive results to prove that it
> is better than reusing PELT algorithm, in this round of testing.
> Also reusing PELT algorithm means thermal pressure tracks the
> other utilization signals in the scheduler.
> 
> v3->v4:
> 	- "Patch 3/7:sched: Initialize per cpu thermal pressure structure"
> 	   is dropped as it is no longer needed following changes in other
> 	   other patches.
> 	- rest of the change log mentioned in specific patches.
> 
> Thara Gopinath (6):
>   sched/pelt.c: Add support to track thermal pressure
>   sched: Add infrastructure to store and update instantaneous thermal
>     pressure
>   sched/fair: Enable CFS periodic tick to update thermal pressure
>   sched/fair: update cpu_capcity to reflect thermal pressure
>   thermal/cpu-cooling: Update thermal pressure in case of a maximum
>     frequency capping
>   sched: thermal: Enable tuning of decay period
> 
>  Documentation/admin-guide/kernel-parameters.txt |  5 ++
>  drivers/thermal/cpu_cooling.c                   | 31 ++++++++++-
>  include/linux/sched.h                           |  8 +++
>  kernel/sched/Makefile                           |  2 +-
>  kernel/sched/fair.c                             |  6 +++
>  kernel/sched/pelt.c                             | 13 +++++
>  kernel/sched/pelt.h                             |  7 +++
>  kernel/sched/sched.h                            |  1 +
>  kernel/sched/thermal.c                          | 68 +++++++++++++++++++++++++
>  kernel/sched/thermal.h                          | 13 +++++
>  10 files changed, 151 insertions(+), 3 deletions(-)
>  create mode 100644 kernel/sched/thermal.c
>  create mode 100644 kernel/sched/thermal.h
> 
> -- 
> 2.1.4
> 
