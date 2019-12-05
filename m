Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C842C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F7C24651
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfLEJYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:24:47 -0500
Received: from foss.arm.com ([217.140.110.172]:55140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfLEJYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:24:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9D6A328;
        Thu,  5 Dec 2019 01:24:45 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A00F3F68E;
        Thu,  5 Dec 2019 01:24:43 -0800 (PST)
Subject: Re: [RFC 0/3] Introduce per-task latency_tolerance for scheduler
 hints
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@qperret.net, David.Laight@ACULAB.COM,
        morten.rasmussen@arm.com, pjt@google.com, tj@kernel.org,
        viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <450fc7e2-49d5-d809-281f-7d9a99d3e530@arm.com>
Date:   Thu, 5 Dec 2019 10:24:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191125094618.30298-1-parth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2019 10:46, Parth Shah wrote:
> This patch series is based on the discussion started as the "Usecases for
> the per-task latency-nice attribute"[1]
> 
> This patch series introduces a new per-task attribute latency_tolerance to
> provide the scheduler hints about the latency requirements of the task.

I forgot but is there a chance to have this as a per-taskgroup attribute
as well?

> Latency_tolerance is a ranged attribute of a task with the value ranging
> from [-20, 19] both inclusive which makes it align with the task nice
> value.
> 
> The value should provide scheduler hints about the relative latency
> requirements of tasks, meaning the task with "latency_tolerance = -20"
> should have lower latency than compared to those tasks with higher values.
> Similarly a task with "latency_tolerance = 19" can have higher latency and
> hence such tasks may bot care much about the latency numbers.
> 
> The default value is set to 0. The usecases defined in [1] can use this
> range of [-20, 19] for latency_tolerance for the specific purpose. This
> patch does not define any use cases for such attribute so that any change
> in naming or range does not affect much to the other (future) patches using
> this. The actual use of latency_tolerance during task wakeup and
> load-balancing is yet to be coded for each of those usecases.

This can definitely be useful for Android/EAS by replacing the current
proprietary solution in android-google-common android-5.4:

commit 760b82c9b88d ("ANDROID: sched/fair: Bias EAS placement for latency")
commit c28f9d3945f1 ("ANDROID: sched/core: Add a latency-sensitive flag
to uclamp")

which links to usercase 6 (EAS) in [1].
