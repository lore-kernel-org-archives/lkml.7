Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD8FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1884F217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+N7Wl6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfC1TvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:51:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53201 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1TvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:51:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so103698wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K/5jXHb1xz6jSrT5Nayrdov2yyYT5MyTGWbdV7sD+1I=;
        b=t+N7Wl6siy7eLdAdvYSC/4y+ZRkQLI7oUebp0xhYt/AyurKWUv+v2d8gjRBuw2qWpr
         t5SFE0hNtA3gaE+hIUqF5duNxZMAJ8iKgDiq0ft/6egxiBBnf9ux2j8eM1CiVIkhUy+g
         l0BvIqC+JKpvzYl4RB/V239F8qVUsOWGCowOnUrT9n5itwkQBxS4noX5mbmMjIU8Nccx
         5xqzgs8tnMPnak/Kq5TcjUyyRahpkd+pI1Ed+pbfDuW2Y7yTDKucRXDwbL3ZrDqCpTyQ
         Z+UBI9Sxv8L/JGbpH7A+rHumNxJ9jnjxdXzPGffYXJAv07puKmcoiIcm3Nvqfe89+FBG
         q5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K/5jXHb1xz6jSrT5Nayrdov2yyYT5MyTGWbdV7sD+1I=;
        b=ogLjR2Tziqyiwy+drFVsv0I0LYQbQW3AFTqfg82cbWjQ2iSHlzEM//2KnahPL5p9JW
         xqLiG+bML/8b3p4RA4mVwd7LP0XfHs7ynwt2P2ThwrqeoC5UoOPfyOd4T2dp/3bz7Ebm
         2fu0N1d44HEjGV16DX4sr3nwIHUBh1USCzhRKpxyJa6BuWXy4ffixSbXSZCEeh3CQcOQ
         BTnAF1lMIFAa2VQeOe8Jr4z5UmZUqU473dLJLqiTYwFKoqTyp3CJv2s+AB7D83PDaMyz
         F+rFaMqkspa9zMEPI1agZSeMjgOxyEWg7iTTYKzB6az3iZGGIUUA8/be08VBWdTHTxTp
         P1Nw==
X-Gm-Message-State: APjAAAVAG3CSYSNQlaaUSC4o2krh3wj1u8+0uHUPazWsS9ukviTSxmAN
        /gMkaJyZzQDSdd3jq34h/+GeRA==
X-Google-Smtp-Source: APXvYqwJ04wDfjX6PI+PCsflDKqjUqhP1xH0wycLHwWHyeVZYN0Vjvl9PuMY/i8VIHr8p0tdKvbNJg==
X-Received: by 2002:a7b:c347:: with SMTP id l7mr1099467wmj.70.1553802674462;
        Thu, 28 Mar 2019 12:51:14 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id y9sm17891wrn.18.2019.03.28.12.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:51:13 -0700 (PDT)
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-2-quentin.perret@arm.com>
 <20190328102206.doqj5fykqlld7jkd@queper01-lin>
 <f5c699d6-f8f8-ab53-2835-329ae2bd8202@linaro.org>
 <20190328174233.jthsdzxrzmzpjnqd@queper01-lin>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1f99acdf-3f9a-5419-b1b5-1bcb9b36dbb6@linaro.org>
Date:   Thu, 28 Mar 2019 20:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328174233.jthsdzxrzmzpjnqd@queper01-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2019 18:42, Quentin Perret wrote:
> Hi Daniel,
> 
> On Thursday 28 Mar 2019 at 18:27:49 (+0100), Daniel Lezcano wrote:
>> On 28/03/2019 11:22, Quentin Perret wrote:
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index 2d9c39033c1a..3c09bdaaefd3 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>>>> @@ -97,6 +97,7 @@ CONFIG_XEN=y
>>>>  CONFIG_COMPAT=y
>>>>  CONFIG_HIBERNATION=y
>>>>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
>>>> +CONFIG_ENERGY_MODEL=n
>>>
>>> Hmm, sorry I turned this to '=n' for testing and forgot to update the
>>> patch. This obviously should be '=y' ...
>>
>> I did a test without the ENERGY_MODEL config option set, dhrystone and
>> the power_allocator policy on the hikey. The board did not mitigate well
>> and ended up rebooting.
> 
> OK ... And is the same thing happening if you just run mainline w/o the
> dynamic-power-coefficient binding set for example ? The result _should_
> be the same. 

Right, it is the same.

> If not, then perhaps I missed something. I'll try to
> reproduce on my end. Just to be sure, when you say hikey, you mean
> hikey960 ? Or 620 ? In any case, thanks for testing :-)

hikey620

>> May be the cpu cooling Kconfig option should add
>> a SELECT or a DEPENDS on ENERGY_MODEL ?
> 
> Right, I've been wondering the same thing. I'm not a big fan of 'select'
> because enabling ENERGY_MODEL automatically for the thermal stuff will
> also happen to enable other things (EAS) without the user knowing. So
> I'd rather keep the ENERGY_MODEL option explicit.
> 
> But perhaps having THERMAL_GOV_POWER_ALLOCATOR 'depend on ENERGY_MODEL'
> could work. It's just that there is no _strong_ dependency, the IPA code
> isn't supposed to crash even if there is no EM ...

Given if the ENERGY_MODEL is not set there is a regression we should add
the dependency IMO.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

