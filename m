Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89CCC32771
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 01:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A23222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 01:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBXFdNMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgAEBFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 20:05:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41439 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAEBFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 20:05:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so47424247ljc.8;
        Sat, 04 Jan 2020 17:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=by4tfSoTAV+JLschlMD5HX37YOQ4eMnDIxNMWutbetQ=;
        b=TBXFdNMs3yzXw1YnMJXgTBQFJXButI5L+HdktNwol6APbVGK7EZTS1tNN0nYoGxrq3
         TkfXqOKziqWaka3isjmK2HFTl2VhSo53vTy+1d/9JZF5alXIeuaDVCm5d4J7BFV8VKlI
         etVU6iNQ0cxHxfnhJoKdDFRhdmkalGLtwDHGztzJCMN5HL9f22cDXx0bVK/Rchl+H41+
         Tf2L1b2kSaaqhEbH/F93gTPFP4HJlOun+N2g6P8C1nvFv3rS05UYm4z9L6xaml12lp8t
         IQKJu3IDnabjapsewEM9VY7uJbjLzbuHOj3K61nEPhcAjV749IB5J7cpfrBPgd/SGZt3
         DW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=by4tfSoTAV+JLschlMD5HX37YOQ4eMnDIxNMWutbetQ=;
        b=BEuZ497Lwa+0QJxyhpMgTXLLbwGJC+EPdvFi0njOdSKffo10iaY4PhJqynAgJrj15B
         3Fmfdo7mx9ub+TmIOFSZAHNsjxSOJtx6jHtw13dmE7EQgKNJsM4M2s1qCwndIj7p1MUM
         DcS7tbgt0US1gJhrQNhiroDTMPHIqNReRt3/rQHqR+/1cMTKJTpK8f78WKmj6KxDt9MX
         +6Gs3Q7NCBWGLyt5hMFe8kXM5Z+MeEwqWNB5CgnjulgF7FjIx52eWXUwrUZQfoRa+t0+
         LqIfDReiBPDeUINzbh1IGFoQBi9PkGdz04b++yo2BNuwFNeAIyMLcc6xNULo05HQ0xDT
         F+hg==
X-Gm-Message-State: APjAAAUJfEHCX5rwtwWsojzutmSFWEckAzpk44Vv0gVtI8S/7if4M5Jj
        dnR+C8mFIlBtycFMJr0H8R4V32+R
X-Google-Smtp-Source: APXvYqwP5i4OsnrnoLMZNV8UkJdD2AjQhEANkC/mg0pYIS7v9tQEJrBn8TuOirgM9WWG6RnIzqZEYA==
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr52823683ljj.206.1578186337852;
        Sat, 04 Jan 2020 17:05:37 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q26sm26874979lfc.52.2020.01.04.17.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2020 17:05:37 -0800 (PST)
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-13-git-send-email-skomatineni@nvidia.com>
 <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
 <20191225175736.GC27497@sirena.org.uk>
 <856d8a92-0c24-6722-952c-06b86c706e97@gmail.com>
 <dbbce994-27f5-d949-078d-05646100e6be@nvidia.com>
 <b6ec6cfd-d883-ea28-00f8-884fa80cfee1@nvidia.com>
 <576fca44-6734-5431-b523-512747a0bf12@gmail.com>
 <fb252096-e101-7d21-9717-c23607ae6edd@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0f956c12-98cf-3466-f3ee-ffc3a23e3e3d@gmail.com>
Date:   Sun, 5 Jan 2020 04:05:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <fb252096-e101-7d21-9717-c23607ae6edd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.01.2020 08:49, Sowjanya Komatineni пишет:
> 
> On 1/2/20 8:12 AM, Dmitry Osipenko wrote:
>> 02.01.2020 10:03, Sowjanya Komatineni пишет:
>>> On 12/27/19 1:19 PM, Sowjanya Komatineni wrote:
>>>> On 12/27/19 6:56 AM, Dmitry Osipenko wrote:
>>>>> 25.12.2019 20:57, Mark Brown пишет:
>>>>>> On Mon, Dec 23, 2019 at 12:14:34AM +0300, Dmitry Osipenko wrote:
>>>>>>> 21.12.2019 01:26, Sowjanya Komatineni пишет:
>>>>>>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>>>>>>>> through Tegra210 and currently Tegra clock driver does initial parent
>>>>>>>> configuration for audio mclk "clk_out_1" and enables them by default.
>>>>>> Please delete unneeded context from mails when replying.  Doing this
>>>>>> makes it much easier to find your reply in the message, helping ensure
>>>>>> it won't be missed by people scrolling through the irrelevant quoted
>>>>>> material.
>>>>> Ok
>>>>>
>>>>>>>> -    clk_disable_unprepare(data->clk_cdev1);
>>>>>>>> -    clk_disable_unprepare(data->clk_pll_a_out0);
>>>>>>>> -    clk_disable_unprepare(data->clk_pll_a);
>>>>>>>> +    if (__clk_is_enabled(data->clk_cdev1))
>>>>>>>> +        clk_disable_unprepare(data->clk_cdev1);
>>>>>>> The root of the problem is that you removed clocks enabling from
>>>>>>> tegra_asoc_utils_init().
>>>> currently, audio mclk and its parent clocks enabling are from clock
>>>> driver init and not from tegra_asoc_utils_init.
>>>>>>> I'm not sure why clocks should be disabled during the rate-changing,
>>>>>>> probably this action is not really needed.
>>>>>> I know nothing about this particular device but this is not that
>>>>>> unusual a restriction for audio hardware, you often can't
>>>>>> robustly reconfigure the clocking for a device while it's active
>>>>>> due to issues in the hardware.  You often see issues with FIFOs
>>>>>> glitching or state machines getting stuck.  This may not be an
>>>>>> issue here but if it's something that's documented as a
>>>>>> requirement it's probably good to pay attention.
>>>>> I don't know details about that hardware either, maybe it is simply not
>>>>> safe to change PLL_A rate dynamically and then CLK_SET_RATE_GATE could
>>>>> be used.
>>>>>
>>>>> If nobody knows for sure, then will be better to keep
>>>>> tegra_asoc_utils_set_rate() unchanged.
>>>> plla rate change through tegra_asoc_utils_set_rate() happens only when
>>>> there is not active playback or record corresponding to this sound
>>>> device.
>>>>
>>>> So, I don't see reason for disabling clock during rate change and not
>>>> sure why we had this from the beginning.
>>>>
>>>> Thierry/Sameer,
>>>>
>>>> Can you please comment?
>>>>
>>>> Yes, we can use CLK_SET_RATE_GATE for PLLA and remove clock disabling
>>>> before rate change.
>>>>
>>> PLLA is used for both I2S controller clock and also for audio mclk. I2S
>>> driver suspend resume implementations takes care of enabling and
>>> disabling I2S clock but audio mclk will be enabled during that time and
>>> PLLA disable might not happen. So using CLK_SET_RATE_GATE prevents rate
>>> change to happen and as rate change happens only when there is no active
>>> audio record/playback, we can perform rate change without disable/enable
>>> during rate change.
>>>
>>> So probably below changes should be good.
>>>
>>>   * remove asoc_utils_set_rate call from asoc_utils_init as set_rate
>>>     happens during existing hw_params callback implementations in sound
>>>     drivers and there is no need to do rate change during asoc_utils_init.
>>>   * remove disable/enable clocks during rate change in asoc_utils_set_rate.
>>>   * add startup and shutdown snd_soc_ops callbacks to do enable and
>>>     disable audio mclk.
>>>
>> Sounds good, thanks. I'll be happy to review and test it.
> 
> Regarding disabling audio mclk during PLLA rate change, no need to
> explicitly disable PLLA on asoc utils as clock driver takes care of it
> properly during pll rate change.
> 
> But the downstream clock divider hardware can malfunction without
> recovery when subject to unstable PLL output during locking, unless
> clock is gated.
> 
> So it is recommended to disable downstream clocks during PLL rate change.
> 
> PLLA downstream clocks are I2S and audio mclk (cdev1/clk1 and extern1
> clocks) and I2S clock is disabled in I2S driver by PM runtime ops.

The I2S driver uses asynchronous pm_runtime_put() and thus there is no
guarantee that I2S clock is disabled at the time of changing PLLA rate.
Could this be a problem?

> For audio mclk, need to make sure mclk are disabled during rate change.
> 
> So below are the changes to audio clocks that will be in next version.
> 
>   * remove tegra_asoc_utils_set_rate call from tegra_asoc_utils_init as
>     tegra_asoc_utils_set_rate happens during hw_params callback.
>   * add shutdown snd_soc_ops callbacks to disable of audio mclk.
>   * remove disable audio mclk (cdev1) and plla clocks prior to rate
>     change in tegra_asoc_utils_set_rate (as audio mclk will always be in
>     disabled state every time hw_param callback gets executed) and keep
>     audio mclk enable after the rate change in tegra_asoc_utils_set_rate.
> 

