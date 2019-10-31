Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6B1CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6383B2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOAEojjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfJaQqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:46:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45318 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbfJaQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:46:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id q70so7637794qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=swjXqb9tq8YAKV9d/upeZfYb8oQPXdkRwweQaCfVw/k=;
        b=kOAEojjl1hg5Shn91lGHY8WDNYGiGRXBRdFuODb3J07Yf+cGrCmZuW9mhOZZ1kA+dv
         1DnyXndwMbyFdAqLB4ovJLvAtMHu/Jraq8owHqpSu5C+r/jE0JZeZk9B8XA6X0KfnJzt
         y+AW6KB7hWS6J9fmdwOMSfntCcwA+dNOC//0LLf7x/iMtpbzWqMi0rOckkyIXTid2TRC
         xgZYLedHpHx2B99IKTqXybn4ooJ1o84swQV5ECb3NrUsN6wIe/Y7v84ZrH+zK9CQmNEH
         jYcX1H54OUbcg8gROMTPBefqMDAO7LfynJB+Il8QaQ2J3HhkKkirY0tpPor7dvWEqZBC
         xZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=swjXqb9tq8YAKV9d/upeZfYb8oQPXdkRwweQaCfVw/k=;
        b=tc7JaqA+kVruR5skveSU3aolnaAWixh1S13MgEtVM+pelJUjD5rMTLYLO3aFx7ZQb2
         n5w/svECofc/rGWH8qUR1BfiWbpvwIDbsbATKl8VYhKwMRTlaZrmpWlKpuLM1RKAHNz6
         pR3C/3WzwdCv5fq+NJglF+K0IIivS2QtO5iYtnGcb83RW9+R5f6rKoCO/2PDmwTSJW+Z
         /TNB0TQmhb+GVqQw7TwDoylIENTRqKGZrjY+2sI/8YA3wgnkQqiOOO9nqcuhSmraVWAh
         d27oSvzaxR1MU7VZeITdkIM6QWRHrdG+nKVOw3/mb94AfBDGhdaOspdXr+1100p8BVS0
         d/Sw==
X-Gm-Message-State: APjAAAUgLevPvyXzPlFX+lUUYddfg4M5wlILEWvNk80K5dqRUfxdPcWr
        ujAM0TZ58T6L9eoU6TWgns+QKA==
X-Google-Smtp-Source: APXvYqzi+9eI2GBlcaPuBmfudKm6oTvKEkpfsgjcx1QX/3MJDvVeUhSBMNArYllkR1/8DGXonehHvw==
X-Received: by 2002:a37:6643:: with SMTP id a64mr6332973qkc.144.1572540407153;
        Thu, 31 Oct 2019 09:46:47 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id w15sm2537086qtk.43.2019.10.31.09.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 09:46:46 -0700 (PDT)
Subject: Re: [Patch v4 3/6] sched/fair: Enable CFS periodic tick to update
 thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-4-git-send-email-thara.gopinath@linaro.org>
 <a303b61e-42f6-dfd7-264b-ead91da5f5ca@arm.com>
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DBB0FF5.4040904@linaro.org>
Date:   Thu, 31 Oct 2019 12:46:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <a303b61e-42f6-dfd7-264b-ead91da5f5ca@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2019 12:11 PM, Dietmar Eggemann wrote:
> On 22.10.19 22:34, Thara Gopinath wrote:
>> Introduce support in CFS periodic tick to trigger the process of
>> computing average thermal pressure for a cpu.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>  kernel/sched/fair.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 682a754..4f9c2cb 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -21,6 +21,7 @@
>>   *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
>>   */
>>  #include "sched.h"
>> +#include "thermal.h"
>>  
>>  #include <trace/events/sched.h>
>>  
>> @@ -7574,6 +7575,8 @@ static void update_blocked_averages(int cpu)
>>  		done = false;
>>  
>>  	update_blocked_load_status(rq, !done);
>> +
>> +	trigger_thermal_pressure_average(rq);
>>  	rq_unlock_irqrestore(rq, &rf);
>>  }
> 
> Since you update the thermal pressure signal in CFS's
> update_blocked_averages() as well, I guess the patch title has to change.
Will do. Thanks.
> 
>>  
>> @@ -9933,6 +9936,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>  
>>  	update_misfit_status(curr, rq);
>>  	update_overutilized_status(task_rq(curr));
>> +
>> +	trigger_thermal_pressure_average(rq);
>>  }
>>  
>>  /*
>>


-- 
Warm Regards
Thara
