Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0193C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7AD21929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 21:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cd5srtaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfKEV3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:29:37 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41124 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfKEV3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:29:37 -0500
Received: by mail-qv1-f67.google.com with SMTP id g18so551023qvp.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 13:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=VypAeugKlRr4nXH7zXKOxjywjKxKdwE5Vg0BnqsK3U4=;
        b=Cd5srtaHJLBmZ0kBZwDLJn2SdmORIFui+f6dM4PI/mIpVxri2dVoQohuedqBD0SCzx
         GxDonCl0pldQKSdyjXueaXCsIS+Ba3djwdX7T11iQqlE4fq06UO4GJH+fR7GOk66a3S2
         /ObTdTugQI8j8xTglQYA4NzVSeXO3XrUQnAv7JH6hphH7dEDGYr4TBLn1IOScWxmBAEQ
         Utl+ZUx2S2nPqgRpaI3ZyA/Frb+Hq2+oiOrnzYJB4C5dpGlPgh6Ydte182aHItegZnRa
         s+/s+fcoR7DhlisM3pZGPwFZu4EaPFFEQjCQpfiBzz4oOvo2IqsxwEV6O+FR/qYgmPEB
         Uq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VypAeugKlRr4nXH7zXKOxjywjKxKdwE5Vg0BnqsK3U4=;
        b=oLlhF9dhB1b+fHYwH3N6QZkUng8FB/JNc2mpxbZaA8j7AcXxOcJe0FpwxQG2nQzstL
         ovlPVby5YIzvb3jdzl+d7F47YIFJlCfSKWtA8wVOInPTw1mF14Qm8eCDuJ5M9TO+d5le
         DCe0cZ5njL4wTEwkXYtO958GCCI1WNbUG8x3q/geXLqaZXNVULJavdZ3Pg+u9aazzNjO
         jNctdzqn2gBWFsHaQMkYd+WErunvN0RYK6iDwl/oFBWfdJMH2nYExnNwEtRvNvoSSvut
         ksac1IY7h3vhi3nRLwXnHtrS1qmEiKiKX7WpVlVHADKrtQGvEH11tPU7vFIvi8XYFHRl
         /UcA==
X-Gm-Message-State: APjAAAXqq1PghVH8dxTe2wH+UfitkQtZJFuor1ZhDE/toXtXX/AGt+KV
        I6A+1u7Gdg7+1hkPduAI1P9Tnw==
X-Google-Smtp-Source: APXvYqzKwJ7gmS33lt6kb8LeXtL00GGQqfiZGcj2lYNuWnZKnS8WEdvxjV72M/WI3JKSKjo0KI1YvQ==
X-Received: by 2002:ad4:4bd0:: with SMTP id l16mr15813309qvw.180.1572989374390;
        Tue, 05 Nov 2019 13:29:34 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id p33sm13234600qtf.80.2019.11.05.13.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 13:29:33 -0800 (PST)
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and update
 instantaneous thermal pressure
To:     Ionela Voinescu <ionela.voinescu@arm.com>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
 <20191105202037.GA17494@e108754-lin> <5DC1E348.2090104@linaro.org>
 <20191105211446.GA25349@e108754-lin>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5DC1E9BC.1010001@linaro.org>
Date:   Tue, 5 Nov 2019 16:29:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191105211446.GA25349@e108754-lin>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2019 04:15 PM, Ionela Voinescu wrote:
> On Tuesday 05 Nov 2019 at 16:02:00 (-0500), Thara Gopinath wrote:
>> On 11/05/2019 03:21 PM, Ionela Voinescu wrote:
>>> Hi Thara,
>>>
>>> On Tuesday 05 Nov 2019 at 13:49:42 (-0500), Thara Gopinath wrote:
>>> [...]
>>>> +static void trigger_thermal_pressure_average(struct rq *rq)
>>>> +{
>>>> +#ifdef CONFIG_SMP
>>>> +	update_thermal_load_avg(rq_clock_task(rq), rq,
>>>> +				per_cpu(thermal_pressure, cpu_of(rq)));
>>>> +#endif
>>>> +}
>>>
>>> Why did you decide to keep trigger_thermal_pressure_average and not
>>> call update_thermal_load_avg directly?
>>>
>>> For !CONFIG_SMP you already have an update_thermal_load_avg function
>>> that does nothing, in kernel/sched/pelt.h, so you don't need that
>>> ifdef. 
>> Hi,
>>
>> Yes you are right. But later with the shift option added, I shift
>> rq_clock_task(rq) by the shift. I thought it is better to contain it in
>> a function that replicate it in three different places. I can remove the
>> CONFIG_SMP in the next version.
> 
> You could still keep that in one place if you shift the now argument of
> ___update_load_sum instead.

No. I cannot do this. The authors of the pelt framework  prefers not to
include a shift parameter there. I had discussed this with Vincent earlier.

> 
> To me that trigger_thermal_pressure_average function seems more code
> than it's worth for this.
> 
> Thanks,
> Ionela.
> 
>>>
>>> Thanks,
>>> Ionela.
>>>
>>>> +
>>>>  /*
>>>>   * All the scheduling class methods:
>>>>   */
>>>> -- 
>>>> 2.1.4
>>>>
>>
>>
>> -- 
>> Warm Regards
>> Thara


-- 
Warm Regards
Thara
