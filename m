Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD18ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7857D2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfJOK6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:58:38 -0400
Received: from foss.arm.com ([217.140.110.172]:35446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfJOK6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:58:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7277528;
        Tue, 15 Oct 2019 03:58:37 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AEC03F68E;
        Tue, 15 Oct 2019 03:58:36 -0700 (PDT)
Subject: Re: [PATCH v2] sched/topology: Allow sched_asym_cpucapacity to be
 disabled
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        stable@vger.kernel.org
References: <20191015102956.20133-1-valentin.schneider@arm.com>
 <20191015104010.GA242992@google.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <a3a1a3d9-5d3a-3ab3-0eaf-e63e0c401c99@arm.com>
Date:   Tue, 15 Oct 2019 11:58:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015104010.GA242992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2019 11:40, Quentin Perret wrote:
>> @@ -2124,8 +2124,17 @@ static void detach_destroy_domains(const struct cpumask *cpu_map)
>>  	int i;
>>  
>>  	rcu_read_lock();
>> +
>> +	if (static_key_enabled(&sched_asym_cpucapacity)) {
>> +		unsigned int cpu = cpumask_any(cpu_map);
>> +
>> +		if (rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu)))
>> +			static_branch_dec_cpuslocked(&sched_asym_cpucapacity);
> 
> Lockdep should scream for this :)

Bleh, yes indeed...

>> +	}
>> +
>>  	for_each_cpu(i, cpu_map)
>>  		cpu_attach_domain(NULL, &def_root_domain, i);
>> +
>>  	rcu_read_unlock();
>>  }
>>  
>> -- 
>> 2.22.0
>>
