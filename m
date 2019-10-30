Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686BCCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328D02067D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ml1Kjv0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfJ3Vhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:37:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33899 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfJ3Vhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:37:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id e14so5483960qto.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UwBNfcG9T4Ez2G+dzanxbhsfrkOhXSnedMAoblgFpl4=;
        b=ml1Kjv0tloBRAh3zQRm7SGFzzDU2AzAarZr6Yv2w9gD3V+osmXURcuMlVipF0QnbM4
         GC7+2We9PQQxJq5OLF+X/3udCGxrJsYa/6DQPi5+5ay+o/h2Zku1RvJ9Y91QSCxtaMoX
         355krIYfUIDHgjyGO+gUtc2513z2FHwBjMiP2Xj6kCiBwqiPU7lkiX2bcM/GAgbWpM8w
         QGhGgWmyg4cuf8PabC0TdhStnorlXT8bfnT2+gGyskLpgWYnfHd/Nx4txEhCWRjqR2zo
         oNFcAxQlVOjqQf05feU/fu8AejJMcwYLbIZkPdt1sNNrG3ds0pWTvJYH8w91MxABBUAd
         CRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UwBNfcG9T4Ez2G+dzanxbhsfrkOhXSnedMAoblgFpl4=;
        b=CSh2bQH7Cemjb6AY6rcNAazPNdq9ix1m0DPG6I0fgmuARhnegUunxS4cQqpZa0lWww
         LVwpsDx1sDK8227TUgWOBa9MGT9UAQCohBqd7cuIa8I+Q95ApQKcT1L1/Z0Jk0Vnex6e
         oHzf7JPsjICoTz8n5mexK9t2WRwFroX7dd/8rJz6wYImEOnCwEVjgW7ni6Aojrep2Y+Y
         YvAqqPp8uOrHbl/nEVq9UwX9MVXu0x20Kx2sXZpxaVjq0WT3t9m0sFje5Pd5y7RflwjH
         2mGjWPigcYjNCn4Ic+NxUFGfqOpMgFrdc7AVCuufJYeCujocSJO1lIl2xIoMt6C7DQ0R
         rydQ==
X-Gm-Message-State: APjAAAWIPCMmu9X4xykQdMoIB9UYoXpepgkBbfiXGQN95v3thPhTG5nt
        xyR6uDZ13WL+lMI1CvGIw+Jxsw==
X-Google-Smtp-Source: APXvYqy4pWJ2fxc96Jj9usXTSWO6SHuoyvhpjdZT6zzaLvufggDq/b2Xky46BxBj3AeXwa/+hqEv4g==
X-Received: by 2002:ac8:4506:: with SMTP id q6mr2280547qtn.277.1572471456129;
        Wed, 30 Oct 2019 14:37:36 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id p17sm678846qkm.135.2019.10.30.14.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 14:37:35 -0700 (PDT)
Subject: Re: [Patch v4 2/6] sched: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Peter Zijlstra <peterz@infradead.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-3-git-send-email-thara.gopinath@linaro.org>
 <20191028152135.GC4097@hirez.programming.kicks-ass.net>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DBA029E.8020508@linaro.org>
Date:   Wed, 30 Oct 2019 17:37:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191028152135.GC4097@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,
Thanks for the review.


On 10/28/2019 11:21 AM, Peter Zijlstra wrote:
> On Tue, Oct 22, 2019 at 04:34:21PM -0400, Thara Gopinath wrote:
>> Add thermal.c and thermal.h files that provides interface
>> APIs to initialize, update/average, track, accumulate and decay
>> thermal pressure per cpu basis. A per cpu variable delta_capacity is
>> introduced to keep track of instantaneous per cpu thermal pressure.
>> Thermal pressure is the delta between maximum capacity and capped
>> capacity due to a thermal event.
> 
>> API trigger_thermal_pressure_average is called for periodic accumulate
>> and decay of the thermal pressure. It is to to be called from a
>> periodic tick function. This API passes on the instantaneous delta
>> capacity of a cpu to update_thermal_load_avg to do the necessary
>> accumulate, decay and average.
> 
>> API update_thermal_pressure is for the system to update the thermal
>> pressure by providing a capped frequency ratio.
> 
>> Considering, trigger_thermal_pressure_average reads delta_capacity and
>> update_thermal_pressure writes into delta_capacity, one can argue for
>> some sort of locking mechanism to avoid a stale value.
> 
>> But considering trigger_thermal_pressure_average can be called from a
>> system critical path like scheduler tick function, a locking mechanism
>> is not ideal. This means that it is possible the delta_capacity value
>> used to calculate average thermal pressure for a cpu can be
>> stale for upto 1 tick period.
> 
> Please use a blank line at the end of a paragraph.

Will do

> 
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
> 
>>  include/linux/sched.h  |  8 ++++++++
>>  kernel/sched/Makefile  |  2 +-
>>  kernel/sched/thermal.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  kernel/sched/thermal.h | 13 +++++++++++++
>>  4 files changed, 67 insertions(+), 1 deletion(-)
>>  create mode 100644 kernel/sched/thermal.c
>>  create mode 100644 kernel/sched/thermal.h
> 
> These are some tiny files, do these functions really need their own
> little files?

I will merge them  into fair.c. There will be update_thermal_pressure
that will be called from cpu_cooling or other relevant framework.
> 
> 
>> diff --git a/kernel/sched/thermal.c b/kernel/sched/thermal.c
>> new file mode 100644
>> index 0000000..0c84960
>> --- /dev/null
>> +++ b/kernel/sched/thermal.c
>> @@ -0,0 +1,45 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Scheduler Thermal Interactions
>> + *
>> + *  Copyright (C) 2018 Linaro, Inc., Thara Gopinath <thara.gopinath@linaro.org>
>> + */
>> +
>> +#include <linux/sched.h>
>> +#include "sched.h"
>> +#include "pelt.h"
>> +#include "thermal.h"
>> +
>> +static DEFINE_PER_CPU(unsigned long, delta_capacity);
>> +
>> +/**
>> + * update_thermal_pressure: Update thermal pressure
>> + * @cpu: the cpu for which thermal pressure is to be updated for
>> + * @capped_freq_ratio: capped max frequency << SCHED_CAPACITY_SHIFT / max freq
>> + *
>> + * capped_freq_ratio is normalized into capped capacity and the delta between
>> + * the arch_scale_cpu_capacity and capped capacity is stored in per cpu
>> + * delta_capacity.
>> + */
>> +void update_thermal_pressure(int cpu, u64 capped_freq_ratio)
>> +{
>> +	unsigned long __capacity, delta;
>> +
>> +	/* Normalize the capped freq ratio */
>> +	__capacity = (capped_freq_ratio * arch_scale_cpu_capacity(cpu)) >>
>> +							SCHED_CAPACITY_SHIFT;
>> +	delta = arch_scale_cpu_capacity(cpu) -  __capacity;
>> +	pr_debug("updating cpu%d thermal pressure to %lu\n", cpu, delta);
> 
> Surely we can do without the pr_debug() here?

Will remove. I had it while developing to check if the thermal pressure
is calculated correct.
> 
>> +	per_cpu(delta_capacity, cpu) = delta;
>> +}


-- 
Warm Regards
Thara
