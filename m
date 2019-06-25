Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA9DC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40271215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaU2CpSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfFYLaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:30:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38122 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfFYLaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:30:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so15866508ljg.5;
        Tue, 25 Jun 2019 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GrSlqTrfjDTebmzfMhekFIQ03hJAaaEIvyasOyrgdGQ=;
        b=VaU2CpSwoLaCkJA70KwSxJ0Y4hBQSzr6GCIF3d/2vKmYsnAJ98uUD67CX7ROoIVEu9
         AD2XU24rdlnNwSB3jqVxtlzPq0P4Cra9qaARXbnLQ5QLShlQoyksaAaFdlmmsIzccaT+
         wwkFvo0CrRwksJtYB9/N0k+rgv47x71+z+9Ix0pF81+ds58SkQ5Tx4IGHn+FxWAndmku
         oAVvCWJejcqecSIwT3RetqOfOJXDeixvMQthTULy6IznXWAmqBMQEhbWi9P42d52gj5n
         wigZExHZbvBRGrQZex6hM//uuK/RNvNX3WKf1lx0NXZVQt6F6kNHxPmrv/7bgkAW4Bun
         0A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GrSlqTrfjDTebmzfMhekFIQ03hJAaaEIvyasOyrgdGQ=;
        b=EY9HGvZxIGxUA2J8PcCwkiatUhCdxjvbS+qw0XSPRZM23lF/GHkDtYxteoM2rd4fzX
         9M4muHRlENL7/RoyRnLx9yATylrJ1akUYieSVuXnXt7hn/3Wctzho8nRQH3zU/Qg2Vu6
         Pu3O1OlY4hx9f0zu8dO/7K1T3ftGYq2GDr9qizrlb0X1R328eP0BDTy1OahIu01DQNdE
         spoBcpZE2p9NCLdshEqF9WtzJaCngFDRZQsb/UFOs8c3SFnBBj47Y3nu36I/XScZlV6x
         zq+1iT6TBzqOTo3QHgDsi5VnTeSrE0/oHmFn3SMcalIFiPkO1OaJvtukUdfmtza0HtKc
         NWyg==
X-Gm-Message-State: APjAAAWszUIHnl+X630hbkUXCKpiLlZGfdFVBMJFPF6HI5iRfWpqM/v0
        6Ro1zwxo3IhKM1SoxmNE3cc=
X-Google-Smtp-Source: APXvYqzWn4IVRrzmk2mj1JPP+8NJ6RlFFd8d53q/lJpzHV8OxKKuKphNXquiy/1j5sApPGrFtkE6Xg==
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr38705844lja.230.1561462203119;
        Tue, 25 Jun 2019 04:30:03 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id t4sm1020232ljh.9.2019.06.25.04.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 04:30:02 -0700 (PDT)
Subject: Re: [PATCH v4 13/16] PM / devfreq: tegra: Support Tegra30
To:     myungjoo.ham@samsung.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
References: <7561edbc-c17c-101a-b339-fc7f9968a470@gmail.com>
 <37db00bc-3a22-d1c2-7bdc-e27af42cd5c7@gmail.com>
 <20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
 <20190624073414epcms1p87b6dc13758b6bd401d275cfba583314a@epcms1p8>
 <20190624111134epcms1p361aed3c72edd6eebc95408331c8d9739@epcms1p3>
 <CGME20190624065919epcms1p1a366de5f455f5138c438d1da8151c12f@epcms1p1>
 <20190625014214epcms1p1b8f2d76cd8cfdf3fdf517be08a92ccdf@epcms1p1>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7488653b-e8ec-27e6-0390-5e23481857e9@gmail.com>
Date:   Tue, 25 Jun 2019 14:30:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625014214epcms1p1b8f2d76cd8cfdf3fdf517be08a92ccdf@epcms1p1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.06.2019 4:42, MyungJoo Ham пишет:
> Sender : Dmitry Osipenko <digetx@gmail.com>
>> 24.06.2019 14:11, MyungJoo Ham пишет:
>>>>
>>>> --------- Original Message ---------
>>>> Sender : Dmitry Osipenko <digetx@gmail.com>
>>>>
>>>> 24.06.2019 10:34, MyungJoo Ham пишет:
>>>>>>
>>>>>> A question:
>>>>>>
>>>>>> Does this driver support Tegra20 as well?
>>>>>> I'm asking this because ARCH_TEGRA includes ARCH_TEGRA_2x_SOC
>>>>>> according to /drivers/soc/tegra/Kconfig.
>>>>>>
>>>>>
>>>>> For this matter, how about updating your 13/16 patch as follows?
>>>>>
>>> []
>>>>
>>>> Good call! I'll update this patch following yours suggestion, thanks.
>>>
>>> Or, you may approve the modified commits here:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git/log/?h=for-next
>>
>> Looks almost good to me!
>>
>> I just recalled that there is also a 64bit variant of Tegra124, the Tegra132. Hence
>> the Tegra30+ Kconfig entry should look like this (it's also worthy to break the lines
>> for readability):
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index ccb1a68c4b51..bd2efbc27725 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -94,7 +94,10 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>
>> config ARM_TEGRA_DEVFREQ
>>        tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>> -       depends on ARCH_TEGRA || COMPILE_TEST
>> +       depends on ARCH_TEGRA_3x_SOC  || ARCH_TEGRA_114_SOC || \
>> +                  ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>> +                  ARCH_TEGRA_210_SOC || \
>> +                  COMPILE_TEST
>>        select PM_OPP
>>        help
>>          This adds the DEVFREQ driver for the Tegra family of SoCs.
>>
>> Could you please adjust the patches like I'm suggesting? I'll approve yours change
>> then and won't re-spin the first batch of the patches.
> 
> I've adjusted as you suggested. It's pushed to the git repo as well.

Thank you very much, looking good now!
