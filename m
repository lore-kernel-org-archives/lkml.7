Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D073EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F34C217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfDJKRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:17:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51228 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbfDJKRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:17:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95DCA15AB;
        Wed, 10 Apr 2019 03:17:24 -0700 (PDT)
Received: from [10.0.2.15] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 546F93F59C;
        Wed, 10 Apr 2019 03:17:23 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/topology: build_sched_groups: Skip duplicate
 group rewrites
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, Dietmar.Eggemann@arm.com,
        morten.rasmussen@arm.com
References: <20190409173546.4747-1-valentin.schneider@arm.com>
 <20190409173546.4747-2-valentin.schneider@arm.com>
 <20190410092723.d4j4ctccogprtptg@e107158-lin.cambridge.arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <ab929846-4f05-0ce9-c159-7f560a7edfca@arm.com>
Date:   Wed, 10 Apr 2019 11:17:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410092723.d4j4ctccogprtptg@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2019 10:27, Qais Yousef wrote:
[...]
>> @@ -1066,9 +1067,14 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
>>  	sg = *per_cpu_ptr(sdd->sg, cpu);
>>  	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
>>  
>> -	/* For claim_allocations: */
>> -	atomic_inc(&sg->ref);
>> -	atomic_inc(&sg->sgc->ref);
>> +	/* Increase refcounts for claim_allocations: */
>> +	already_visited = atomic_inc_return(&sg->ref) > 1;
>> +	/* sgc visits should follow a similar trend as sg */
>> +	WARN_ON(already_visited != (atomic_inc_return(&sg->sgc->ref) > 1));
> 
> NIT: I think it would be better to not have any side effect of calling
> WARN_ON(). Ie: do the atomic_inc_return() outside the WARN_ON() condition.
> Having two bool already_visited_sg and already_visited_sgc will make the code
> more readable too.
> 

I agree it's not the nicest reading flow there is. It's already gone in
tip/sched/core but if needed I can resend with this extra separation.

> Thanks
> 
> --
> Qais Yousef
> 
>> +
>> +	/* If we have already visited that group, it's already initialized. */
>> +	if (already_visited)
>> +		return sg;
>>  
>>  	if (child) {
>>  		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
>> --
>> 2.20.1
>>
