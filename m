Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E1C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD482084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBB5sus/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEOJ4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:56:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38825 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEOJ4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:56:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so1382749wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 02:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5JYhbd/vO4XoD/CtHSzLTiUyvf3UwZx+Y3JbyqMKmfs=;
        b=gBB5sus/t6TCjIaVANYvetAi+rVR0U8RlHgIDuV/jFgGLO+E1mCWhtrSTMhXNFruCm
         oPrKOEGbTeOD1NtJi1vidX6vzkumsEJOBrlGTQnk8hrfl1chmz5IH8f9cRpeQRJsdiaR
         YY4qKKN1F0c3u1J9yFL/C5SX10FLE0/hxCSwJYrZ6Hl0aeJ22yn9zSx3wRh5puqiTPyR
         Kk9DCJ71sIF1+eThGf3kvQ2mzTptKwPEdKUL6Lj4wJ08VOl+Lsw4LOR4suWgQntD8A5+
         5/DLw2QsC6AceztCAROjPZPOBJNb88rLyqNCJFD2VqR6wwI4RdqabmfoXRyqZkfptEus
         tDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5JYhbd/vO4XoD/CtHSzLTiUyvf3UwZx+Y3JbyqMKmfs=;
        b=qoIXUW7nXFK5yhRqJCzWEoTqsLO6Yidspe7BemmN01phVc9NxOvEjmBNwnREP+0X3w
         AfhPe4+ZxoyjdWS0/fxLsjVU5RUhlzADgQ9Da3bYlKtjsqJSvnplwfFdAoYjpsE+jLc0
         ypspvZj3zYSV5qj96CxPNePkPbI+plkCTPKOIDKLWhrC9M0uHIxAY6qV6cTnWxiZQ84F
         e6esGqDuZnN+q9Bn+O63rTl5HZUdZfI15ytR4ZLgL8vB19CJvgqOnWNNwRR4+WoAtDxl
         d+wFiPfdmb+sH80kX5vbHYNaZVFwp5Kn5hLU7I+JF8ATskNJcEOzDP0ZOayjVEuKIXaP
         MOUA==
X-Gm-Message-State: APjAAAXKU3is1twXEEDqR1/1ZqPe66yuMwuelOA2txJx1aqRL9fod4GU
        BzGXofTwyFv5thDYpKfeAWlWVQ==
X-Google-Smtp-Source: APXvYqxozk+6bk7th/l8gbao/9YhKjUJ5EJNO5OynkqEGlmWbYZkWun7AiVJeD9feyohHwCreEO9hQ==
X-Received: by 2002:adf:b3d1:: with SMTP id x17mr24575739wrd.31.1557914191908;
        Wed, 15 May 2019 02:56:31 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id j13sm1096094wru.78.2019.05.15.02.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 02:56:31 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
Date:   Wed, 15 May 2019 11:56:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2019 11:17, Quentin Perret wrote:
> Hi Daniel,
> 
> On Wednesday 15 May 2019 at 11:06:18 (+0200), Daniel Lezcano wrote:
>> On 15/05/2019 10:23, Quentin Perret wrote:
>>> In the current state, the perf_domain struct is fully defined only when
>>> CONFIG_ENERGY_MODEL=y. Since we need to write code that compiles both
>>> with or without that option in the thermal framework, make sure to
>>> actually define the struct regardless of the config option. That allows
>>> to avoid using stubbed accessor functions all the time in code paths
>>> that use the EM.
>>>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
>>
>> This patch implies the cpu cooling device can be set without the energy
>> model.
>>
>> Isn't it possible to make a strong dependency for the cpu cooling device
>> on the energy model option, add the energy model as default on arm arch
>> and drop this patch?
> 
> Right, that should work too.
> 
>> After all, the cpu cooling is using the em framework.
> 
> The reason I did it that way is simply to keep things flexible. If you
> don't compile in THERMAL_GOV_POWER_ALLOCATOR, you will never use the EM
> for CPU thermal. So I thought it would be good to not mandate compiling
> in ENERGY_MODEL in this case -- that should save a bit of space.
> 
> But TBH I don't have a strong opinion on this one, so if everybody
> agrees it's fine to just make CPU_THERMAL depend on ENERGY_MODEL, I'm
> happy to drop this patch and fix patch 3/3. That would indeed simplify
> things a bit.

Ok in this case it will be better to drop the 2/3 and add a small series
doing for the cpu_cooling.c

#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR

/* structure freq */

/* power2state */

/* state2power*/

/* getrequestedpower */

/* All functions needed for the above */

#endif

static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
        .get_max_state          = cpufreq_get_max_state,
        .get_cur_state          = cpufreq_get_cur_state,
        .set_cur_state          = cpufreq_set_cur_state,
#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
        .get_requested_power    = cpufreq_get_requested_power,
        .state2power            = cpufreq_state2power,
        .power2state            = cpufreq_power2state,
#endif
};

So you don't have to care about ENERGY_MODEL to be set as
THERMAL_GOV_POWER_ALLOCATOR depends on it.

I think the result for cpu_cooling.c will be even more cleaner with the
em change.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

