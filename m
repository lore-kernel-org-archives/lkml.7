Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B65C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ACF2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycvY7sZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfEOKyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:54:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37628 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOKyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:54:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so2013507wmo.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yCGaHsCBgstblM6mBuRdN67cN8JHM7IAOcSPPHfwyxk=;
        b=ycvY7sZwj/lO/v1FWXvxEh3TFW351keKaPN0WjyORa91GJS7lYUvz9ErzxnVOWcmNu
         Hb3lLuRHWl2koQYmjB5BVSP23O8rstj2YEiT464J3sf7p0fmLS5eDvpYQ+vhD2Wcd3KB
         +ftoa7BUra3VE+K7xh/0wGwlIhCm8FaSfACLmc/CV2C/BKjJUa98HBSik+sJSKOSUm6Z
         n5+UkSOgBN5TCCMUzvuWnFdzw7fZ/Avp7d8gmAb8uRJSTrfSwjp1BV/iVbDxg1coEVtZ
         Ojz9DrV4/06srKWY2PE3ywMKzf74iNoTBcJvMNmUmvICDM/bck3Wld9LznaGQRjEAKap
         a5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yCGaHsCBgstblM6mBuRdN67cN8JHM7IAOcSPPHfwyxk=;
        b=PcfnPIdpnC0v8D5nrETwJmzMdnrlYIMQxy9+Wl0B44gEFNomvMG29lie2WTl7wl1gA
         GBaMp+KM6q7cmy6LLUwMu5vB3O5iRtiaxIC5zna4nOkUrEjrYkiisogGUGl1IFvcZZZv
         UuHeM8PiNYK0CThfCPX/m5bIkFCRyw+yQt5EpbW/of6qLfQnsVY7PEN5t3V5IeL+Ym5s
         iKQlMC9XhM1TXC5rjvhWjIU7qOIuBQng/t1/KS5UwoiaAkV4YNexAoSdjFlywPRwPC2K
         GzK8ioc27+IhX2IiqInTYux/mKUVSzReuV9fkpmZf8Bx0tG552Bt0Swqk6eUHBY22lEY
         yzZg==
X-Gm-Message-State: APjAAAW9IfbYKqwVVn8NoOnPQXKYCFRMGe6bxYHT3KNo8JxPrJfMk54D
        RajuVqkZeDh/Hgp4YboPHOYeNdUfZfU=
X-Google-Smtp-Source: APXvYqzD3cJ6A0k7/klH/RClkLZ4g1NFiBt0lsDFFnyPi3JyILtCZkiLU9LHGjDbYsOjgC3ryTj9BQ==
X-Received: by 2002:a7b:ce03:: with SMTP id m3mr21051346wmc.99.1557917652174;
        Wed, 15 May 2019 03:54:12 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id y17sm1691446wrp.70.2019.05.15.03.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 03:54:11 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
To:     Quentin Perret <quentin.perret@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
 <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
 <cf1474cb-7e31-7070-b988-a0c4d3f6f081@linaro.org>
 <20190515102200.s6uq63qnwea6xtpl@vireshk-i7>
 <20190515104043.vogspxgkapp6qsny@queper01-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b7e91d70-cd16-791c-94e1-3667ff264e49@linaro.org>
Date:   Wed, 15 May 2019 12:54:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515104043.vogspxgkapp6qsny@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2019 12:40, Quentin Perret wrote:
> On Wednesday 15 May 2019 at 15:52:00 (+0530), Viresh Kumar wrote:
>> On 15-05-19, 12:16, Daniel Lezcano wrote:
>>> Viresh what do you think ?
>>
>> I agree with your last suggestions. They do make sense.
> 
> Good :-)
> 
> So, FWIW, the below compiles w/ or w/o THERMAL_GOV_POWER_ALLOCATOR. I'll
> test it and clean it up some more and put it as patch 1 in the series if
> that's OK.
> 
> Thanks,
> Quentin
> 
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..ee431848ef71 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -58,7 +58,9 @@
>   */
>  struct freq_table {
>         u32 frequency;

I suspect we will have a problem here as cpufreq_set_cur_state uses the
frequency and when switching to EM, we will still need a freq table.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

