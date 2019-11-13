Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB1DC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B207B2245A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfKMKuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:50:03 -0500
Received: from foss.arm.com ([217.140.110.172]:50438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfKMKuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:50:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA81D7A7;
        Wed, 13 Nov 2019 02:50:01 -0800 (PST)
Received: from [192.168.1.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28EEC3F534;
        Wed, 13 Nov 2019 02:49:59 -0800 (PST)
Subject: Re: [PATCH v2] sched/freq: move call to cpufreq_update_util
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        mgorman@suse.de, dsmythies@telus.net
Cc:     linux-pm@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com
References: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
 <20191112150544.GA3664@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <3b8cafb7-894d-c302-e6c6-b5844b1298b5@arm.com>
Date:   Wed, 13 Nov 2019 11:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112150544.GA3664@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.19 16:05, Vincent Guittot wrote:
> Le Tuesday 12 Nov 2019 à 15:48:13 (+0100), Vincent Guittot a écrit :
>> update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
>> which might be inefficient when cpufreq driver has rate limitation.
>>
>> When a task is attached on a CPU, we have call path:
>>
>> update_blocked_averages()
>>   update_cfs_rq_load_avg()
>>     cfs_rq_util_change -- > trig frequency update
>>   attach_entity_load_avg()
>>     cfs_rq_util_change -- > trig frequency update

This looks like attach_entity_load_avg() is called from
update_blocked_averages(). Do you refer to the attach_entity_load_avg()
call from attach_entity_cfs_rq() or update_load_avg() here? I assume the
former.

>> The 1st frequency update will not take into account the utilization of the
>> newly attached task and the 2nd one might be discard because of rate
>> limitation of the cpufreq driver.
>>
>> update_cfs_rq_load_avg() is only called by update_blocked_averages()
>> and update_load_avg() so we can move the call to
>> {cfs_rq,cpufreq}_util_change() into these 2 functions. It's also

s/cpufreq_util_change()/cpufreq_update_util() ?

[...]

>> I have just rebased the patch on latest tip/sched/core and made it a proper
>> patchset after Doug reported that the problem has diseappeared according to
>> his 1st results but tests results are not all based on the same v5.4-rcX
>> and with menu instead of teo governor.

I had some minor tweaks to do putting this on a0e813f26ebc ("sched/core:
Further clarify sched_class::set_next_task()") ? I saw the '[tip:
sched/urgent] sched/pelt: Fix update of blocked PELT ordering' tip-bot
msg this morning though.

[...]

>> @@ -7493,9 +7495,9 @@ static void update_blocked_averages(int cpu)
>>  	 * that RT, DL and IRQ signals have been updated before updating CFS.
>>  	 */
>>  	curr_class = rq->curr->sched_class;
>> -	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>> -	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>> -	update_irq_load_avg(rq, 0);
>> +	decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
>> +	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>> +	decayed |= update_irq_load_avg(rq, 0);

Why not 'decayed  = update_cfs_rq_load_avg()' like in the
!CONFIG_FAIR_GROUP_SCHED case?

[...]
