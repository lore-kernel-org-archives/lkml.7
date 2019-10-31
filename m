Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A16CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7482020873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tY+/FobW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfJaQDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:03:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38744 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJaQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:03:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id t26so9235280qtr.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sOSdCYmOOeM+Q8IRVCuZSVH1babZHXYVlwGQYz/a2jE=;
        b=tY+/FobWlu7Cui31LMOtGNrp53A407ZhxRYnsbJsbimmKoglkUDzHxdlwwuOpE4PlI
         yLghVEuKURqlVSVWtP2siTPJeBffjzjqR57X6q5tjWcg8ZnZKcCUSBb2WFHCDDgB0C0T
         fdqvWKoW3TUP7pI6NrBxpeYo4xZt8ljhyXwe2kVTq9gHroOQ3TYomw5Zjk4trZaxz6s2
         FOXtZFPqbdpRf0nH3yMBDvUrfQk/eT7XybGsmfEt1OyMqhMiLqHzUCaZ61CZ3kFkyXG/
         ahubwAOuG9mtmusLMGtCR45ZVz1I155YL8elNjybjt7SxM5RbU+Rv6KrXkbiOLbn5FH6
         cy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sOSdCYmOOeM+Q8IRVCuZSVH1babZHXYVlwGQYz/a2jE=;
        b=MyeuLFv9m3fra5lrUTiYqvh563LDiLQmK1qnwNjerAp5aRuFbUgUi2nt+56VS6L/Th
         mZJG753iOGA5tFqO79r8y+HZiBjODYpoRzXf78EoItKuNF94rhgDwHHTZVSTfiDUEn4X
         jWX1P0AJsOTNxIHgvR1v/mOxl5OXFe9kWvQ3FJ76vXCKmwyWl9xTAMGb08bLI/KBhSTi
         YCwM2LoMZ4brv1RfqSYk4W9lEIg2Y9YEGjOaAlNUCJkiDgtcjjB3ShUMzkRah280EVH/
         ovOkFrqtoCie7kkROFiZUlQxNxXs3MCaDXARmHVp6hhhhzoNZgn1cKYjEL1tH4QxWY6U
         1KJQ==
X-Gm-Message-State: APjAAAWYthpeziqbeIOpErEX0FLZd/qwVZFpCEtVq+Hi8F6DBYYG2yU1
        QTA42/jDuHLI/rGVCWkIXd/OAA==
X-Google-Smtp-Source: APXvYqyiLEssZcWMl3Ig+eoHNVM51ZIafjzHonlKoCUHJD74lUdfeEH1oMu01JXJ0O0jy5dBw3eXcQ==
X-Received: by 2002:a0c:fd46:: with SMTP id j6mr5210571qvs.209.1572537789935;
        Thu, 31 Oct 2019 09:03:09 -0700 (PDT)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id m5sm1544807qtp.97.2019.10.31.09.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 09:03:09 -0700 (PDT)
Subject: Re: [Patch v4 4/6] sched/fair: update cpu_capcity to reflect thermal
 pressure
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-5-git-send-email-thara.gopinath@linaro.org>
 <20191023122252.dz7obopab6iizy4s@e107158-lin.cambridge.arm.com>
 <20191028153010.GE4097@hirez.programming.kicks-ass.net>
 <20191031105342.b3sl5xhysldfla3g@e107158-lin.cambridge.arm.com>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DBB05BC.40502@linaro.org>
Date:   Thu, 31 Oct 2019 12:03:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191031105342.b3sl5xhysldfla3g@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2019 06:53 AM, Qais Yousef wrote:
> On 10/28/19 16:30, Peter Zijlstra wrote:
>> On Wed, Oct 23, 2019 at 01:28:40PM +0100, Qais Yousef wrote:
>>> On 10/22/19 16:34, Thara Gopinath wrote:
>>>> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
>>>> pressure on a cpu means this maximum available capacity is reduced. This
>>>> patch reduces the average thermal pressure for a cpu from its maximum
>>>> available capacity so that cpu_capacity reflects the actual
>>>> available capacity.
>>>>
>>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>>> ---
>>>>  kernel/sched/fair.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 4f9c2cb..be3e802 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -7727,6 +7727,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
>>>>  
>>>>  	used = READ_ONCE(rq->avg_rt.util_avg);
>>>>  	used += READ_ONCE(rq->avg_dl.util_avg);
>>>> +	used += READ_ONCE(rq->avg_thermal.load_avg);
>>>
>>> Maybe a naive question - but can we add util_avg with load_avg without
>>> a conversion? I thought the 2 signals have different properties.
>>
>> Changelog of patch #1 explains, it's in that dense blob of text.
>>
>> But yes, you're quite right that that wants a comment here.
> 
> Thanks for the pointer! A comment would be nice indeed.
> 
> To make sure I got this correctly - it's because avg_thermal.load_avg
> represents delta_capacity which is already a 'converted' form of load. So this
> makes avg_thermal.load_avg a util_avg really. Correct?
Hello Quais,

Sorry for not replying to your earlier email. Thanks for the review.
So if you look at the code, util_sum in calculated as a binary signal
converted into capacity. Check out the the below snippet from accumulate_sum

   if (load)
                sa->load_sum += load * contrib;
        if (runnable)
                sa->runnable_load_sum += runnable * contrib;
        if (running)
                sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;

So the actual delta for the thermal pressure will never be considered
if util_avg is used.

I will update this patch with relevant comment.




-- 
Warm Regards
Thara
