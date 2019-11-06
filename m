Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C89C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E32F21882
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRJMvKgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbfKFRBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:01:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33047 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732352AbfKFRBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:01:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id y39so34493761qty.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1YkokgK/hXG9nZEjXyGUWaHvhkSIFQdZBFHevJIglRo=;
        b=tRJMvKgddVtpOXo/MzS+cGY5ilVByBFJDJ88m9zKx1JKj2rfrsktiFtsiZ4V6ThWln
         0sJX+QgwbOSY+EUnWlq8Go83HIWvAzRfWZL4GKijFh1U1ekDYFi6GCL5Nfs5wbDjZp4v
         as7hE5l24nCVf/mbUSNDU5ib40KgbihEjhJXvhnbmQnpTBoxKq3FDdM/RtA7uW0eJY+r
         SlMtAMwC+1LcH/nccbv7hH4TLrtAyXGGkkHZzJfHzKU77O2Kwq/XK+u8NjcLX5AqWZ/U
         KPkJkDUTAfHTaXESWi/IhNL6SNd2mCEIyxG7K1lopMZOrpjp9/wmkWuVfCaD5rSGoH+/
         5d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1YkokgK/hXG9nZEjXyGUWaHvhkSIFQdZBFHevJIglRo=;
        b=RECYMMz4IyyMPEcTZWxIHHWiuPwqRplxLimOoElaku9gyPAkR1AdjJjqRs8Yf1rLZ+
         AJ5QLmfyj8DdKleNThFWX3potenZq9qIdZ5X+JT5O2AmWstezvnRqzoAQYvDTGeXmOZf
         vX8AWm6K2tf9MNO1bzEOzR8xq1JWcMxajhtPaAPzem7DiWlSvt5Ewc9kq/i7uAGvU1m4
         tkSLModBzvfsOmntd1E1GCKzd7Ax7feZwTaEfOWuune4fL7PPK13CxShlFcJM4j9UZC5
         uFoxRr42SWOthSyJQyDUx2d489Ip+Mnn2fLzUPdazdJqNIGfKdgdnUIQTksfomqtvlgR
         f8sg==
X-Gm-Message-State: APjAAAXV9TzjkCEgMT5U1XEYjjXdDtvifLYQIX8EWgz/fJLNIfr+sC51
        UF1wNKmuZ8B8zg+A4RlFJToH2w==
X-Google-Smtp-Source: APXvYqxdU901BFxbDtR2Rd4uDOiWpRBN/+H61rqGylSm1v6pCqitdnpcme8Fd2ykJ8tdTip1La24Hw==
X-Received: by 2002:aed:31e7:: with SMTP id 94mr3393686qth.71.1573059673522;
        Wed, 06 Nov 2019 09:01:13 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id 23sm12270001qkj.52.2019.11.06.09.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 09:01:12 -0800 (PST)
Subject: Re: [Patch v5 3/6] sched/fair: Enable periodic update of average
 thermal pressure
To:     Vincent Guittot <vincent.guittot@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-4-git-send-email-thara.gopinath@linaro.org>
 <CAKfTPtBrOdiN+wBfy-1cHr65d48-cBZc3LS7Jt_65Ptssb0Gpg@mail.gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DC2FC58.7050604@linaro.org>
Date:   Wed, 6 Nov 2019 12:01:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBrOdiN+wBfy-1cHr65d48-cBZc3LS7Jt_65Ptssb0Gpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 03:32 AM, Vincent Guittot wrote:
> On Tue, 5 Nov 2019 at 19:49, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>>
>> Introduce support in CFS periodic tick and other bookkeeping apis
>> to trigger the process of computing average thermal pressure for a
>> cpu. Also consider avg_thermal.load_avg in others_have_blocked
>> which allows for decay of pelt signals.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v4->v5:
>>         - Updated both versions of update_blocked_averages to trigger the
>>           process of computing average thermal pressure.
>>         - Updated others_have_blocked to considerd avg_thermal.load_avg.
>>
>>  kernel/sched/fair.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2e907cc..9fb0494 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -92,6 +92,8 @@ const_debug unsigned int sysctl_sched_migration_cost  = 500000UL;
>>   */
>>  static DEFINE_PER_CPU(unsigned long, thermal_pressure);
>>
>> +static void trigger_thermal_pressure_average(struct rq *rq);
>> +
>>  #ifdef CONFIG_SMP
>>  /*
>>   * For asym packing, by default the lower numbered CPU has higher priority.
>> @@ -7493,6 +7495,9 @@ static inline bool others_have_blocked(struct rq *rq)
>>         if (READ_ONCE(rq->avg_dl.util_avg))
>>                 return true;
>>
>> +       if (READ_ONCE(rq->avg_thermal.load_avg))
>> +               return true;
>> +
>>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
>>         if (READ_ONCE(rq->avg_irq.util_avg))
>>                 return true;
>> @@ -7580,6 +7585,8 @@ static void update_blocked_averages(int cpu)
>>                 done = false;
>>
>>         update_blocked_load_status(rq, !done);
>> +
>> +       trigger_thermal_pressure_average(rq);
> 
> This must be called before others_have_blocked() to take into account
> the latest update

It is a bug. I agree. Will fix it.
> 
>>         rq_unlock_irqrestore(rq, &rf);
>>  }
>>
>> @@ -7646,6 +7653,7 @@ static inline void update_blocked_averages(int cpu)
>>         update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
>>         update_irq_load_avg(rq, 0);
>>         update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
>> +       trigger_thermal_pressure_average(rq);
> 
> idem
> 
>>         rq_unlock_irqrestore(rq, &rf);
>>  }
>>
>> @@ -9939,6 +9947,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>
>>         update_misfit_status(curr, rq);
>>         update_overutilized_status(task_rq(curr));
>> +
> 
> remove blank line
> 
>> +       trigger_thermal_pressure_average(rq);
>>  }
>>
>>  /*
>> --
>> 2.1.4
>>


-- 
Warm Regards
Thara
