Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD98C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2652064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfJOLt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:49:26 -0400
Received: from foss.arm.com ([217.140.110.172]:36922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfJOLt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:49:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E797337;
        Tue, 15 Oct 2019 04:49:25 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130213F68E;
        Tue, 15 Oct 2019 04:49:23 -0700 (PDT)
Subject: Re: [PATCH v2] sched/topology: Allow sched_asym_cpucapacity to be
 disabled
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        stable@vger.kernel.org
References: <20191015102956.20133-1-valentin.schneider@arm.com>
 <20191015104010.GA242992@google.com>
 <a3a1a3d9-5d3a-3ab3-0eaf-e63e0c401c99@arm.com>
Message-ID: <d1dac9d1-3ac6-1a1b-f1c9-48b136833686@arm.com>
Date:   Tue, 15 Oct 2019 12:49:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a3a1a3d9-5d3a-3ab3-0eaf-e63e0c401c99@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/10/2019 11:58, Valentin Schneider wrote:
> On 15/10/2019 11:40, Quentin Perret wrote:
>>> @@ -2124,8 +2124,17 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
>>>  	int i;
>>>  
>>>  	rcu_read_lock();
>>> +
>>> +	if (static_key_enabled(&sched_asym_cpucapacity)) {
>>> +		unsigned int cpu = cpumask_any(cpu_map);
>>> +
>>> +		if (rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu)))
>>> +			static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
>>
>> Lockdep should scream for this :)
> 
> Bleh, yes indeed...
> 

Urgh, I forgot about the funny hotplug lock scenario at boot time.
rebuild_sched_domains() takes the lock but sched_init_domains() doesn't, so
we don't get the might_sleep warn at boot time.

So if we want to flip the key post boot time we probably need to separately
count our asymmetric root domains and flip the key after all the rebuilds,
outside of the hotplug lock.
