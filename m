Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2935DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD54A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/5lTpHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfFNOaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:30:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33124 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfFNOaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:30:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so9035214wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eixhaap1Vvg9COsJFwOBepIriW1ccdSZWPriQHQ789U=;
        b=r/5lTpHAeOx/YLPbIvRjtX8iZwOZaqHbn+knSgo6eTMReQzzduEeCphWM2KIlLaWTy
         TYwq7C7F/8G+QBIHMgzAF0S6/Ly8a9zKOjLJlO1LqHIXekFIfPc1VhXhjJM2q5NfmMoS
         pa5/FGg+kN8OUToCAsNo+r/H2z1vrEaJZTUjynH4jXVnIEsVikIZ6rvtSRCgdrLDg378
         JcnsQHCF6fLjHK3qVmKpmEEYo6a8EC2kiWByhO570LRktDxBcF6HDxE5pmKVJEqTh3ay
         aXkdpbURnDho4bFcePIzt/eTFtWCiPMyiSfONJLgWO1MvB0vkPIl9OvB/04RMwVf4S7X
         luMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eixhaap1Vvg9COsJFwOBepIriW1ccdSZWPriQHQ789U=;
        b=mHFdKjAr6HOWdc3sy5YIhKltLk7QXPWviYf9KcCDixmFUA3H3iRD6Bdfl6IyRMbpuq
         Z7kCGHy1YtGNGQ3+INns8Oap8yI6W1/IGHqdFi0Dx1NejObowG5SeDtyu618abH4qb6e
         tVNGExlmL1v6YfWKpEJW29xwpfWboA6XIA7XyxPu1gJ3m33qV+8MuwZh/oZ14KyqfFb6
         6urj5mpz7PbnoeSGpSG9KhSjjP+2vCOOmlUPvF4DNGw+mHCEiMYVnvVFbCsoLLGNuiLI
         Lyo0QetvsPgnR6XJ3K9Rq82CFWFr5PNvU+M7iqJEjCadpJeh5UNUoZTbJRzmddumiMj0
         Gg4w==
X-Gm-Message-State: APjAAAVrJGFRnRj8cSLpNdVW6E9BUJT6hq6GWvRX+Et1/rjzLOvQurSR
        e1EbTlnpkx57VZ4lqf8kHs24hw==
X-Google-Smtp-Source: APXvYqw9NeesQRXNRwJdM0GzEdMnk0BtAaxAEpWDY8d9OYcIWtyPcKXWFabHALi3848fcyzBK3Ct+Q==
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr7810424wmi.73.1560522616563;
        Fri, 14 Jun 2019 07:30:16 -0700 (PDT)
Received: from [192.168.0.41] (22.194.95.92.rev.sfr.net. [92.95.194.22])
        by smtp.googlemail.com with ESMTPSA id v4sm2167383wmg.22.2019.06.14.07.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 07:30:15 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Fix multiple thermal zones
 conflict in rk3399.dtsi
To:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, edubezval@gmail.com,
        manivannan.sadhasivam@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>, dianders@chromium.org,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20190604165802.7338-1-daniel.lezcano@linaro.org>
 <5188064.YWmxIpmbGp@phil> <55b9018e-672e-522b-d0a0-c5655be0f353@linaro.org>
 <e5a4f850-27e0-cad3-04bd-6c004fca2b81@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9bf85c22-f1ba-3dbc-0b67-17e124484fa1@linaro.org>
Date:   Fri, 14 Jun 2019 16:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e5a4f850-27e0-cad3-04bd-6c004fca2b81@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2019 16:02, Robin Murphy wrote:
> On 14/06/2019 14:03, Daniel Lezcano wrote:
>> On 14/06/2019 11:35, Heiko Stuebner wrote:
>>> Hi Daniel,
>>>
>>> Am Dienstag, 4. Juni 2019, 18:57:57 CEST schrieb Daniel Lezcano:
>>>> Currently the common thermal zones definitions for the rk3399 assumes
>>>> multiple thermal zones are supported by the governors. This is not the
>>>> case and each thermal zone has its own governor instance acting
>>>> individually without collaboration with other governors.
>>>>
>>>> As the cooling device for the CPU and the GPU thermal zones is the
>>>> same, each governors take different decisions for the same cooling
>>>> device leading to conflicting instructions and an erratic behavior.
>>>>
>>>> As the cooling-maps is about to become an optional property, let's
>>>> remove the cpu cooling device map from the GPU thermal zone.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 ---------
>>>>   1 file changed, 9 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>> index 196ac9b78076..e1357e0f60f7 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>> @@ -821,15 +821,6 @@
>>>>                       type = "critical";
>>>>                   };
>>>>               };
>>>> -
>>>> -            cooling-maps {
>>>> -                map0 {
>>>> -                    trip = <&gpu_alert0>;
>>>> -                    cooling-device =
>>>> -                        <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>> -                        <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>> -                };
>>>> -            };
>>>>           };
>>>>       };
>>>
>>> my knowledge of the thermal framework is not that big, but what about
>>> the
>>> rk3399-devices which further detail the cooling-maps like
>>> rk3399-gru-kevin
>>> and the rk3399-nanopc-t4 with its fan-handling in the cooling-maps?
>>
>> The rk3399-gru-kevin is correct.
>>
>> The rk3399-nanopc-t4 is not correct because the cpu and the gpu are
>> sharing the same cooling device (the fan). There are different
>> configurations:
>>
>> 1. The cpu cooling device for the CPU and the fan for the GPU
>>
>> 2. Different trip points on the CPU thermal zone, eg. one to for the CPU
>> cooling device and another one for the fan.
>>
>> There are some variant for the above. If this board is not on battery,
>> you may want to give priority to the throughput, so activate the fan
>> first and then cool down the CPU. Or if you are on battery, you may want
>> to invert the trip points.
>>
>> In any case, it is not possible to share the same cooling device for
>> different thermal zones.
> 
> OK, thanks for the clarification. I'll get my board set up again to
> figure out the best fix for rk3399-nanopc-t4 (FWIW most users are
> probably just using passive cooling or a plain DC fan anyway). You might
> want to raise this issue with the maintainers of
> arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi, since the
> everything-shared-by-everything approach in there was what I used as a
> reference.

Cc'ed: Kukjin Kim and Krzysztof Kozlowski

Easy :)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

