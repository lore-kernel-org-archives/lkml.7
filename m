Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EF3C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E838021882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8OF4tYV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfKFRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:00:05 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:38646 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfKFRAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:00:04 -0500
Received: by mail-qv1-f68.google.com with SMTP id q19so1705966qvs.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=f9JEJF8J30F6bEwR2z5GiLYIZMgrUBUBcnr060ZsYj8=;
        b=v8OF4tYV+Z4Y+PD1DD+clPtnE9GHzDE9nhpNXvcpbiNpPZMH10DGKybwHWLgqkXZCZ
         5WblIwwioX25bpjjteUjcH4GsBo9ajH7NRL4Esz/BYoZakUyZR1r80o4fC3ReIcftbYt
         UPPhZdUfBl/7BMPLANAqkHlfxjsV1JoJFSO++cfCZlJrtgvBamyPkCSypqdgOU0FtYMW
         pWlbNeVB+D2lUjvm3Vmzdc65yhk7/ilTkN3lYC/MuXGuhlqWSBKTjj604mDCrLrzH3K0
         VRN3e9Zztjefjq6PIO8F7g5QMUvS1PxVQHyOWWtaH7+BA2+UVfabhhdt4+WAza8b06ar
         dHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=f9JEJF8J30F6bEwR2z5GiLYIZMgrUBUBcnr060ZsYj8=;
        b=gIiebKX72N6KiI8YcyUmmLtClQgmGbDJc2OpG9jzUFXmjbMeVDpv/3ang5vOyKS1rJ
         VC7AUpZH6u8sOe9NYb0j/+UpKUZ6DcgMjpySYRO8QzHo7RfPgJpx9yPU9VtBf8Oo7x6k
         s6sC6CVH/gOgx0GGgY/Z2Z8CnX/CmrTAXjKJFkRNar4fOnqoGjORyx1Shz+t3CgfL1AE
         oeDwgFc+TpUFzhnQRFGy8YOksxbBqeQxEkTKiArkBFwB+XSN3mPJmBnWqcFSx5MM9lg5
         VxHrOlwWjJCx5jtGOhNpPB9xEAjRlaeEdJa6sAYQnhfKsslOccZwPdw/JIbwbHhhI2QW
         ab/g==
X-Gm-Message-State: APjAAAV84P6hMLfL41sTQ8BKx/Pr19KSzE8twb2TC49dhhQD86l0852N
        cf/22Lqm7RlrQe18Xy1xq+cx/w==
X-Google-Smtp-Source: APXvYqygEkw/DoATTogrRZaPkWvx6Q9wG1JYz71C5o7WaVkUpWquO6E1tXlM4nd1QlhFUgNq9BNaDA==
X-Received: by 2002:a0c:fde8:: with SMTP id m8mr3273122qvu.4.1573059602637;
        Wed, 06 Nov 2019 09:00:02 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id u7sm12650106qkm.127.2019.11.06.09.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 09:00:01 -0800 (PST)
Subject: Re: [Patch v5 1/6] sched/pelt.c: Add support to track thermal
 pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-2-git-send-email-thara.gopinath@linaro.org>
 <6e2b2a11-834d-a0ee-a386-1edc624a8050@arm.com>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DC2FC10.3080102@linaro.org>
Date:   Wed, 6 Nov 2019 12:00:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <6e2b2a11-834d-a0ee-a386-1edc624a8050@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,
Thanks for the review.
On 11/06/2019 07:50 AM, Dietmar Eggemann wrote:
> On 05/11/2019 19:49, Thara Gopinath wrote:
>> Extrapolating on the exisiting framework to track rt/dl utilization using
> 
> s/exisiting/existing
> 
>> pelt signals, add a similar mechanism to track thermal pressure. The
>> difference here from rt/dl utilization tracking is that, instead of
>> tracking time spent by a cpu running a rt/dl task through util_avg,
>> the average thermal pressure is tracked through load_avg. This is
>> because thermal pressure signal is weighted "delta" capacity
>> and is not binary(util_avg is binary). "delta capacity" here
>> means delta between the actual capacity of a cpu and the decreased
>> capacity a cpu due to a thermal event.
>> In order to track average thermal pressure, a new sched_avg variable
>> avg_thermal is introduced. Function update_thermal_load_avg can be called
>> to do the periodic bookeeping (accumulate, decay and average)
> 
> s/bookeeping/bookkeeping
> 
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
>> index a96db50..3821069 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
>>  	return 0;
>>  }
> 
> Minor thing: There are function headers for rt_rq, dl_rq and irq. rt_rq
> even explains that 'load_avg and runnable_load_avg are not supported and
> meaningless.' Could you do something similar for thermal here? It's not
> self-explanatory why we track load_avg, runnable_load_avg and util_avg
> for thermal but only use load_avg.

Will put a function header and update the nits above.
> 
>> +int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
>> +{
>> +	if (___update_load_sum(now, &rq->avg_thermal,
>> +			       capacity,
>> +			       capacity,
>> +			       capacity)) {
>> +		___update_load_avg(&rq->avg_thermal, 1, 1);
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
> [...]
> 


-- 
Warm Regards
Thara
