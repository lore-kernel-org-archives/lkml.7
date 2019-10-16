Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23536ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1A2218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RC11To3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437471AbfJPVQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:16:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46647 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfJPVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:16:00 -0400
Received: by mail-qk1-f196.google.com with SMTP id e66so3637355qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Rq3sgQ4yogwO7Q9sdE9u/UpAfUNvEMK3KFs6N0a+tLY=;
        b=RC11To3HQPJ/oUt4Z02+stsI0U8K4IzLRyheQ68o5WVIOgpghrWlV1q4PFJmbsESFq
         b5RnUFzL2MGMpwsWgWGUtUnH/uW4dWEYWWrk8cQgPJAkzGxjGLOqyYN9Wbf0o0wLwJGX
         uKp3okx11o4m049sQHIqjIY04gFd73eP0N7yzZ/x/otpS2287zj3H/mUOyuOH+DaG1s3
         gudR7b/D1fzyPZrYimeHlhLwZZIrMIf5OWTax89FCgq/F5THbHaFzNu9GBw2IkX8cGDj
         +Qbzhk74nYxJbcczHVPA+NbUkrDJkVFJYctQWGe0Qh4umVxo5OfUsgpyVJX1EdIyiQfC
         4D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Rq3sgQ4yogwO7Q9sdE9u/UpAfUNvEMK3KFs6N0a+tLY=;
        b=n40E3JWoitcqBfUxzqLLDzhH8dgkMJ4DsiugxkT68C/7dfBeJ6fFtFgUrA5y29rSMU
         nkhBuTvzxM8USfmUdzv5to89QODn+wjkchCCZGiLzcsMYj0AvEd1xrQxg/+he9LxwjeR
         NTsWcWFgdmBA4dxH5lQ+XdH4xcsLWNKIEMt5Hilimvepz+R0QCGWoe/P8RATjRqNe0w2
         OhlVTxLyTJDl3niaWoSkQzhjhMFj29/nKze2LzNYpr8upJu6KbUq0KoUzIOhLRW0Vgdz
         zalXy2m+jn15RvZA7uRGuHwaUFBHnQ+AOS1YV9kOPsm5RDswjr9SJT/kSEGNNP/LDN10
         CMDQ==
X-Gm-Message-State: APjAAAXqooUAT74inJzLcWpvz8MhkOS2iQaNKX3MIJsqg4edmy62aXEM
        UHKkjduDWtk5MVqN4j/OlrHJpQ==
X-Google-Smtp-Source: APXvYqxH4ywtjDGpE6AaRq8o3bilzZy7zf3LiNpPyK+H52+23Da1zNsyIntAc71z82qkiaswzOqRYA==
X-Received: by 2002:a37:a345:: with SMTP id m66mr5652964qke.487.1571260558980;
        Wed, 16 Oct 2019 14:15:58 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id e13sm35111qkm.110.2019.10.16.14.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 14:15:58 -0700 (PDT)
Subject: Re: [Patch v3 1/7] sched/pelt.c: Add support to track thermal
 pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
 <1571014705-19646-2-git-send-email-thara.gopinath@linaro.org>
 <CAKfTPtCCjETcDNdP1xuRJ0w3futRV+J+hqkXgYyPQXzOqnaoVg@mail.gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DA7888C.3050406@linaro.org>
Date:   Wed, 16 Oct 2019 17:15:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCCjETcDNdP1xuRJ0w3futRV+J+hqkXgYyPQXzOqnaoVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Thanks for the review.
On 10/14/2019 09:55 AM, Vincent Guittot wrote:
> Hi Thara,
> 
> On Mon, 14 Oct 2019 at 02:58, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Extrapolating on the exisitng framework to track rt/dl utilization using
> 
> s/exisitng/existing/
> 
>> pelt signals, add a similar mechanism to track thermal pressue. The
> 
> s/pessure/pressure/
Will fix all the typo.
> 
>> difference here from rt/dl utilization tracking is that, instead of
>> tracking time spent by a cpu running a rt/dl task through util_avg,
>> the average thermal pressure is tracked through load_avg.
> 
> It would be good to mention why you use load_avg field instead of
> util_avg field: because the signal is weighted with the capped
> capacity and is not binary
> And also explained a bit what capacity refer to
> 
>> In order to track average thermal pressure, a new sched_avg variable
>> avg_thermal is introduced. Function update_thermal_avg can be called
>> to do the periodic bookeeping (accumulate, decay and average)
>> of the thermal pressure.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  kernel/sched/pelt.c  | 13 +++++++++++++
>>  kernel/sched/pelt.h  |  7 +++++++
>>  kernel/sched/sched.h |  1 +
>>  3 files changed, 21 insertions(+)
>>
>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index a96db50..f06aae3 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>>         return 0;
>>  }
>>
>> +int update_thermal_avg(u64 now, struct rq *rq, u64 capacity)
> 
> All the other functions are named :
> update_cfs_rq/rt_rq/dl_rq/irq_load_avg
> 
> might be good to keep similar name with update_thermal_load_avg

Sure. Will rename the function.
> 
>> +{
>> +       if (___update_load_sum(now, &rq->avg_thermal,
>> +                              capacity,
>> +                              capacity,
>> +                              capacity)) {
>> +               ___update_load_avg(&rq->avg_thermal, 1, 1);
>> +               return 1;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>>  /*
>>   * irq:
>> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
>> index afff644..01c5436 100644
>> --- a/kernel/sched/pelt.h
>> +++ b/kernel/sched/pelt.h
>> @@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
>>  int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
>>  int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
>>  int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
>> +int update_thermal_avg(u64 now, struct rq *rq, u64 capacity);
>>
>>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>>  int update_irq_load_avg(struct rq *rq, u64 running);
>> @@ -175,6 +176,12 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
>>  static inline void
>>  update_idle_rq_clock_pelt(struct rq *rq) { }
>>
>> +static inline int
> 
> can you keep some function ordering as above and move
> update_thermal_avg() just after update_dl_rq_load_avg

will do.

Warm Regards
Thara

