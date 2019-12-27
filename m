Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8473AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 15:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C64222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 15:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P03xYqEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfL0PWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 10:22:18 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44442 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0PWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 10:22:17 -0500
Received: by mail-qk1-f195.google.com with SMTP id w127so21704129qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=q/5pToebsXwR45NBxV6wXVjuLILCBYdTY0wd0j924VQ=;
        b=P03xYqEoVwTNgrLqvA8+7xkPAhykF47NSuY3r6yEgVup1SFamngJvcN6KE2lzUOHt6
         bP7Bz+pqqDAWkPzohI/LLtWOM1YHwtGJzhBcp3oFXWi7LcghkLcDxUr2PvZ+vp0f/Agd
         UngIlnKay5C2rJX+YwpGNUMi8YAx/d/LiP9MRWsz5ssHhwPM80PpENEKI3EPyBM+BRlW
         +xcJr1RfGOimv4DgyG+xB6ehjEbEXgi2LMhtWAQTM+SlAIudN/xHkmLcZ/SiYa60QAv2
         OhjNkJW0J2ruZkW93qXhDW6aIxSApnp9b3NFs9W3R6mRjjQOnFtE2i6SdsteSZk6rEZI
         h1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=q/5pToebsXwR45NBxV6wXVjuLILCBYdTY0wd0j924VQ=;
        b=oEarLfSYbZDmbt1jEXhjf4ZICM7JpjSe7nzHeRjstx9Rvk2d9ReCa0M/06MqTcYBCz
         d5/4jwgQhiQeKnJOrFwyOiUvrXgKz2C4ZMtgqP7hCxeXbDzpKvU6BEc8EV5anx6u0YLt
         Ix4kI6DglCVMqJnSATlKZ9IbAa9SFyTAy0ic6S2/VFie74i0D6bo9Z74fvD15QKngzsG
         zgUFQ3t8Os7Ds4wv9b+llFuWB9KaZ/cL1N7ZsoRRZeevADhIfHTvOk83Pb7gj8NvwIc9
         IYYIMOjkCmSLPvMoZUqBG+29l/us0JOEm/sYb/HnWjNKOVEfm4mbR2mJy8IWMzzieRI4
         8xng==
X-Gm-Message-State: APjAAAWzIY1x5IcPKvjRlc9nWCXZnTSe28fngIlEkb0kSwAJg0mOwf0N
        L2IFfhTmZVcRVTnwZWWWOQmfSw==
X-Google-Smtp-Source: APXvYqy6szxex0QEGm5xWs1fnlfx3eTZUBsk/wv3TTEwD2X5K6tXMgEbcDM+cGy9l5fQJ0gVjvHpug==
X-Received: by 2002:a05:620a:b0f:: with SMTP id t15mr42638632qkg.135.1577460135914;
        Fri, 27 Dec 2019 07:22:15 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id r6sm10569519qtm.63.2019.12.27.07.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 07:22:15 -0800 (PST)
Subject: Re: [Patch v6 4/7] sched/fair: Enable periodic update of average
 thermal pressure
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <1576123908-12105-5-git-send-email-thara.gopinath@linaro.org>
 <20191216143932.GT2844@hirez.programming.kicks-ass.net>
 <20191216175901.GA157313@google.com>
 <78b0f8a6-462b-acca-7682-f5269fea17c5@arm.com>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E0621A5.5040901@linaro.org>
Date:   Fri, 27 Dec 2019 10:22:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <78b0f8a6-462b-acca-7682-f5269fea17c5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/2019 07:57 AM, Dietmar Eggemann wrote:
> On 16/12/2019 18:59, Quentin Perret wrote:
>> On Monday 16 Dec 2019 at 15:39:32 (+0100), Peter Zijlstra wrote:
>>>> @@ -10274,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>>>  
>>>>  	update_misfit_status(curr, rq);
>>>>  	update_overutilized_status(task_rq(curr));
>>>> +	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
>>>>  }
>>>
>>> My objection here is that when the arch does not have support for it,
>>> there is still code generated and runtime overhead associated with it.
>>
>> I guess this function could be stubbed for CONFIG_CPU_THERMAL=n ?
>> That is, reflecting the thermal pressure in the scheduler only makes
>> sense when the thermal infrastructure is enabled to begin with (which is
>> indeed not the case for most archs).
> 
> Makes sense to me. If we can agree that 'CPU cooling' is the only actor
> for thermal (CPU capacity) capping.
> 
> thermal_sys-$(CONFIG_CPU_THERMAL)       += cpu_cooling.o
> 

Hi All,
Thanks for all the reviews!

The other option will be to have a separate
CONFIG_HAVE_SCHED_THERMAL_PRESSURE. This will ensure that we are not
tied to cpu cooling thermal infrastructure. What say?
 There is a CONFIG_HAVE_SCHED_AVG_IRQ for irq load average in pelt.c.


-- 
Warm Regards
Thara
