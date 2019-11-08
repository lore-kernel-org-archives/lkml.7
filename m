Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0B6FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE28218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbfKHKxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:53:13 -0500
Received: from foss.arm.com ([217.140.110.172]:40442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfKHKxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:53:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72D307CD;
        Fri,  8 Nov 2019 02:53:12 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87F2D3F719;
        Fri,  8 Nov 2019 02:53:10 -0800 (PST)
Subject: Re: [Patch v5 6/6] sched/fair: Enable tuning of decay period
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-7-git-send-email-thara.gopinath@linaro.org>
 <20191107104901.GA472@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <706278eb-1906-79f3-7a9f-6ab5080ecb63@arm.com>
Date:   Fri, 8 Nov 2019 11:53:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107104901.GA472@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2019 11:49, Vincent Guittot wrote:
> Le Tuesday 05 Nov 2019 à 13:49:46 (-0500), Thara Gopinath a écrit :

[...]

>>  /**
>> @@ -10444,8 +10465,8 @@ void update_thermal_pressure(int cpu, unsigned long capped_capacity)
>>  static void trigger_thermal_pressure_average(struct rq *rq)
>>  {
>>  #ifdef CONFIG_SMP
>> -	update_thermal_load_avg(rq_clock_task(rq), rq,
>> -				per_cpu(thermal_pressure, cpu_of(rq)));
>> +	update_thermal_load_avg(rq_clock_task(rq) >> sched_thermal_decay_shift,
>> +				rq, per_cpu(thermal_pressure, cpu_of(rq)));
> 
> Would be better to create
> 
> +static inline u64 rq_clock_thermal(struct rq *rq)
> +{
> +       lockdep_assert_held(&rq->lock);
> +       assert_clock_updated(rq);

IMHO, the asserts can be skipped here since they're already done in
rq_clock_task().

> +       return rq_clock_task(rq) >> sched_thermal_decay_shift;
> +}
