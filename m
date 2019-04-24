Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8184FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A3D208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfDXP5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:57:18 -0400
Received: from foss.arm.com ([217.140.101.70]:47704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731990AbfDXP5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:57:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D027A78;
        Wed, 24 Apr 2019 08:57:18 -0700 (PDT)
Received: from [10.1.194.42] (e108754-lin.cambridge.arm.com [10.1.194.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0F3C3F557;
        Wed, 24 Apr 2019 08:57:15 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] Introduce Thermal Pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, javi.merino@kernel.org,
        edubezval@gmail.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, nicolas.dechesne@linaro.org,
        bjorn.andersson@linaro.org, dietmar.eggemann@arm.com
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
From:   Ionela Voinescu <ionela.voinescu@arm.com>
Message-ID: <b777c6da-0fe2-96d2-240d-96b065a3f18d@arm.com>
Date:   Wed, 24 Apr 2019 16:57:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

The idea and the results look promising. I'm trying to understand better
the cause of the improvements so I've added below some questions that
would help me out with this.


> Regarding testing, basic build, boot and sanity testing have been
> performed on hikey960 mainline kernel with debian file system.
> Further, aobench (An occlusion renderer for benchmarking realworld
> floating point performance), dhrystone and hackbench test have been
> run with the thermal pressure algorithm. During testing, due to
> constraints of step wise governor in dealing with big little systems,
> cpu cooling was disabled on little core, the idea being that
> big core will heat up and cpu cooling device will throttle the
> frequency of the big cores there by limiting the maximum available
> capacity and the scheduler will spread out tasks to little cores as well.
> Finally, this patch series has been boot tested on db410C running v5.1-rc4
> kernel.
>

Did you try using IPA as well? It is better equipped to deal with
big-LITTLE systems and it's more probable IPA will be used for these
systems, where your solution will have the biggest impact as well.
The difference will be that you'll have both the big cluster and the
LITTLE cluster capped in different proportions depending on their
utilization and their efficiency.

> During the course of development various methods of capturing
> and reflecting thermal pressure were implemented.
> 
> The first method to be evaluated was to convert the
> capped max frequency into capacity and have the scheduler use the
> instantaneous value when updating cpu_capacity.
> This method is referenced as "Instantaneous Thermal Pressure" in the
> test results below. 
> 
> The next two methods employs different methods of averaging the
> thermal pressure before applying it when updating cpu_capacity.
> The first of these methods re-used the PELT algorithm already present
> in the kernel that does the averaging of rt and dl load and utilization.
> This method is referenced as "Thermal Pressure Averaging using PELT fmwk"
> in the test results below.
> 
> The final method employs an averaging algorithm that collects and
> decays thermal pressure based on the decay period. In this method,
> the decay period is configurable. This method is referenced as
> "Thermal Pressure Averaging non-PELT Algo. Decay : XXX ms" in the
> test results below.
> 
> The test results below shows 3-5% improvement in performance when
> using the third solution compared to the default system today where
> scheduler is unware of cpu capacity limitations due to thermal events.
> 

Did you happen to record the amount of capping imposed on the big cores
when these results were obtained? Did you find scenarios where the
capacity of the bigs resulted in being lower than the capacity of the
LITTLEs (capacity inversion)?
This is one case where we'll see a big impact in considering thermal
pressure.

Also, given that these are more or less sustained workloads, I'm
wondering if there is any effect on workloads running on an uncapped
system following capping. I would image such a test being composed of a
single threaded period (no capping) followed by a multi-threaded period
(with capping), continued in a loop. It might be interesting to have
something like this as well, as part of your test coverage.


Thanks,
Ionela.
