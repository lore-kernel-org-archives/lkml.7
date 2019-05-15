Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D0BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE1820657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euq/YjOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfEOLHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:07:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40899 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfEOLHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:07:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so2032161wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 04:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WLYROLqwvq+iq4Tg13SMOpkpNE1f0nENSLKE//G0bsk=;
        b=euq/YjOxetpfM+ZIRd16tqOJMUNMAQ639aAlV8Z7Ibig9LpEwqAJTeSnRJZv9QFR0A
         n3DaSssaT4KUsdSZYEJF2jvAGai5fUuS8T0WPRkz4o4p20gpJt7tecOOpF/0sXYuCt4c
         +gkH9sxfIb3PHS15GjRWakzRNBq90imKo8mOxdUlQBch12slcyqyLT1bNw+kIeI5Y2BK
         hqlOAm4od8MxLkFSusv/wFPi/FAd6Jl5afhpMqIgF782USJg1GQqr6rRATkZmQKNyr4T
         Reyohk2YroZHi9UP9N4sj4WdzXhQOZgyYey7kYxrPMDf/koP7KIAwgEvhf/7CifOKhnp
         mmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WLYROLqwvq+iq4Tg13SMOpkpNE1f0nENSLKE//G0bsk=;
        b=TWsABmJDGlhvgJW3QE1XpUY3DzE2hp/epANn/BpEWr5b8zaw852rd4kN88oW9fsG6J
         yclOkch17h2uUKs3BqhlD1i95GfoP4944JfDbjrS4/YfFVmwTzl4bTFCY/UmjGbvgVBn
         5H+4uP+XdJRb/4ZZ6Ymj/hf5dmX7/2NwmWCQ3Nwcw2n/UUiGj1L10Tq9mAkFNu2d1smY
         pP7ezDnm7SNgcakmbrecpOf2lCmOyYCjI2/KED8EflXpmBMDHImNuKEQDte9LcGliEwE
         r6AsSnnxeoYCAKcJP/NRL0fH0QorFPXDjgs11xNFe7l60K4dbPG4D4uYDVIeFeC33ycp
         pvMg==
X-Gm-Message-State: APjAAAXv+LeoF0eVgpHMHsG/hoWxedaXpFd8CPtNaqSs4NMQGpUlueRo
        aDMGvni1aM/nFHzV1WT4qEfAyg==
X-Google-Smtp-Source: APXvYqyk+jOEfdcEqATmFYCA0jxw/O5gBV5d9uEck/eUQUqWql3DtCIln4vAuhSqj4YJxAvSRHH8IQ==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr22070590wma.34.1557918459197;
        Wed, 15 May 2019 04:07:39 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 130sm1924399wmd.15.2019.05.15.04.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 04:07:38 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
 <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
 <20190515102200.s6uq63qnwea6xtpl@vireshk-i7>
 <20190515104043.vogspxgkapp6qsny@queper01-lin>
 <20190515104651.tv5odug7ce4zlupc@queper01-lin>
 <5b55e432-f8b0-91ae-a7de-fe02e0cad322@linaro.org>
 <20190515110156.ru2wxqvwffqgq3t3@queper01-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a4c0ab68-f8d0-a70d-58e5-b8de55199000@linaro.org>
Date:   Wed, 15 May 2019 13:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515110156.ru2wxqvwffqgq3t3@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2019 13:01, Quentin Perret wrote:
> On Wednesday 15 May 2019 at 12:51:57 (+0200), Daniel Lezcano wrote:
>> On 15/05/2019 12:46, Quentin Perret wrote:
>>> On Wednesday 15 May 2019 at 11:40:44 (+0100), Quentin Perret wrote:
>>
>> [ ... ]
>>
>>>> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>>>>         if (capacitance) {
>>>>                 ret = update_freq_table(cpufreq_cdev, capacitance);
>>>>                 if (ret) {
>>>>                         cdev = ERR_PTR(ret);
>>>>                         goto remove_ida;
>>>>                 }
>>>> -
>>>> -               cooling_ops = &cpufreq_power_cooling_ops;
>>>> -       } else {
>>>> -               cooling_ops = &cpufreq_cooling_ops;
>>>>         }
>>>> +#endif
>>>> +       cooling_ops = &cpufreq_cooling_ops;
>>>
>>> Argh, that is actually broken with !capacitance and
>>> THERMAL_GOV_POWER_ALLOCATOR=y ... Perhaps it's best to keep the two
>>> thermal_cooling_device_ops struct separated in the end.
>>
>> Or alternatively you can keep one structure but instead of filling the
>> state2power,power2state and getrequestedpower fields in the declaration,
>> you fill them in the if (capacitance) block, no?
> 
> Something like the below ? Yes, that works too. I'll write a proper
> patch and send that next week or so.

Yes, exactly. And IMHO, that helps for the understanding of code also.

> --->8---
> 
>  /* Bind cpufreq callbacks to thermal cooling device ops */
> 
>  static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
> -       .get_max_state = cpufreq_get_max_state,
> -       .get_cur_state = cpufreq_get_cur_state,
> -       .set_cur_state = cpufreq_set_cur_state,
> -};
> -
> -static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
>         .get_max_state          = cpufreq_get_max_state,
>         .get_cur_state          = cpufreq_get_cur_state,
>         .set_cur_state          = cpufreq_set_cur_state,
> -       .get_requested_power    = cpufreq_get_requested_power,
> -       .state2power            = cpufreq_state2power,
> -       .power2state            = cpufreq_power2state,
>  };
> 
>  /* Notifier for cpufreq policy change */
> @@ -674,18 +667,19 @@ __cpufreq_cooling_register(struct device_node *np,
>                         pr_debug("%s: freq:%u KHz\n", __func__, freq);
>         }
> 
> +       cooling_ops = &cpufreq_cooling_ops;
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>         if (capacitance) {
>                 ret = update_freq_table(cpufreq_cdev, capacitance);
>                 if (ret) {
>                         cdev = ERR_PTR(ret);
>                         goto remove_ida;
>                 }
> -
> -               cooling_ops = &cpufreq_power_cooling_ops;
> -       } else {
> -               cooling_ops = &cpufreq_cooling_ops;
> +               cooling_ops->get_requested_power = cpufreq_get_requested_power;
> +               cooling_ops->state2power = cpufreq_state2power;
> +               cooling_ops->power2state = cpufreq_power2state;
>         }
> -
> +#endif
>         cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
>                                                   cooling_ops);
>         if (IS_ERR(cdev))
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

