Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB78CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B1C20862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIvJ0vfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfJ3VlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:41:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33397 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfJ3VlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:41:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id 71so4542642qkl.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=R3HNn4O+idb9q4qL9FxzX0K+EKqfjTVGmNOacIZuoJ4=;
        b=WIvJ0vfpGPnF7QUNk1pQo5j3fXMKdo6UtOUWGWWG1HSrlEos3+UTvBA0lRbmIHfKeB
         VqtOqevXPIWl7rxtOssXggkQzROu35ii3MDHftGxqJLXtkjPFOM5ybtSIL2egbBgdG60
         cIbTZf9OUhVEwiTe++nd77cW5trKijgxE1F7RLVKzmE1wKPqCo84oi22kQz2n/e2m2DM
         y4Sk0F2hxU5HxtVy64GlBTiHAOjiDX5eHIKv9fWYSpJUjZy1qNsIoBgIhzGucEigYZht
         Jz66HhhsheZPRryx4GuJ7YjrFp3bZC13Zx7R+D3+ounfOu/B+7Lla0zaith4M1pQjYUl
         lv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=R3HNn4O+idb9q4qL9FxzX0K+EKqfjTVGmNOacIZuoJ4=;
        b=qzk0vwcEiQqK2kk76D7Hd5qDuyPAtRqwQr/K3tF6aGI0l7TvV+BZHX/jx2xqNcJ5A6
         K4tishZnU42Id6ZBlg2qix7nZ2haR+Ou9Zd6xKptZ19buPgJex9SbbyFYaa9pp/NQ1+a
         N3shAqeCyRJepqeHizF1UoXfuc0MeGC69dhJSyrcKMFwMf6DQuYQN/zPfLenpbW+IWEt
         amkUmpseWDDhrAkBVMEBDj6QVAbQTrW9Emelyl2/hJJ6qsYTMK5ixaz6F3TE7T+WOk4m
         JYEU7w4/LxhesKNmNDiBuBB/yGkCFvG5egVbTGggtATe0tnRe/oRY3T6A8XhkdfvR3EX
         GH8g==
X-Gm-Message-State: APjAAAV8JkeM30wpnK5x8+48/6DEFo16/NsjIvolzsglyLLzv/a55L4B
        32H1qnyok2Mmvfw407njckMprw==
X-Google-Smtp-Source: APXvYqxKLCvJ7q2YsJGOYAhReJNzXqvWwPUzFHo1mlqnKDLBtG5MY03MD1ZrW6qHjC8r1O/7jCiQhA==
X-Received: by 2002:a37:9847:: with SMTP id a68mr2177910qke.223.1572471683329;
        Wed, 30 Oct 2019 14:41:23 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id y33sm1237462qta.18.2019.10.30.14.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 14:41:22 -0700 (PDT)
Subject: Re: [Patch v4 3/6] sched/fair: Enable CFS periodic tick to update
 thermal pressure
To:     Peter Zijlstra <peterz@infradead.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-4-git-send-email-thara.gopinath@linaro.org>
 <20191028152421.GD4097@hirez.programming.kicks-ass.net>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DBA0381.8010605@linaro.org>
Date:   Wed, 30 Oct 2019 17:41:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191028152421.GD4097@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2019 11:24 AM, Peter Zijlstra wrote:
> On Tue, Oct 22, 2019 at 04:34:22PM -0400, Thara Gopinath wrote:
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
> This changes only 1 of the 2 implementations of
> update_blocked_averages(). Also, how does this interact with
> rq->has_blocked_load ?
I will add it to the other implementation of update_blocked_averages and
will also update others_have_blocked.
> 
>> @@ -9933,6 +9936,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>  
>>  	update_misfit_status(curr, rq);
>>  	update_overutilized_status(task_rq(curr));
>> +
>> +	trigger_thermal_pressure_average(rq);
>>  }
> 
> This seems to imply all this thermal stuff is fair only, in which case I
> could suggest putting those few lines in fair.c. ~45 extra lines on
> 1e5+ lines really doesn't matter.
> 


-- 
Warm Regards
Thara
