Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14FDC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972D820866
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZSXQ40i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfFPRrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 13:47:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33362 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFPRrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:47:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so2904193wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k32GHXPQOSojycs+3f1EfADUcN8SPLsNXB1pAx3700A=;
        b=sZSXQ40il31HHkyUY7WfPrQ7A+Inu3+pL1PjJ+s8M4b64bquu2O5Xczr17R5UXUvUm
         keuqbIAe+ZjxGaA6AHzWuPhr7GEGzBOouYg2RE6pa6LJAShUc+zjo8ObdqsL+Nhgggon
         Ysw+1pq9ZEH97fggUQAvgga0fxc1p0gIp+Our0fNJ3nXfUrdCvjm+N90uYrpVVuFqrjr
         UYD/XPMdKTituDG0Zp+udUAskJPCDA5j9E8jmEdk+RFNbf1RFO+WoOzSjvQqEoTE2k6Y
         zoKfJR3L108H+5TgB8wZ45srKfZQnI55tFoiZ23S/JCEPiYYqx8+Qv4VjV6v//La3hFh
         x98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k32GHXPQOSojycs+3f1EfADUcN8SPLsNXB1pAx3700A=;
        b=IOuyZP39KNgljx+9m2Tg58lL+hI0zqjUdLz0i9D9u+Xq4nr5k6/h0DOrbPH9PGVNHr
         qnUTaL599mnqw7gIGgToSN4FyMM/GAnI2kHG4dFnEOv3QdmzYRAOkSUrJjuE2t1XjQkC
         4i44j6oZ06YvyyLTmSDmQFW5CPy2B9yAbrLZBHwa/jiGJc3nSuiTF+X9SfCt8E2quGDw
         OngCEGjjajdx3fFlbadGGbmw9YCo0V1AcrpBIbndQibCWr2eEkmEuh8LWyv8ObGjoaHk
         sVm5rVGOZSay/wL23KAprXUgQEYUXr+lacTwihpUo9NpmWaL4AyFeOoC20A1d1cmFIVp
         zNyw==
X-Gm-Message-State: APjAAAXVpY+uKhhu2L35RFE7n/KZizR0TJzfiRCZsCjnKHlugozpbxHV
        2tNiAYokHyVMNb1l5meK6MZUp047VMA=
X-Google-Smtp-Source: APXvYqzUqWaPTHh0BJXtzSYmaLlaxeU16DnJpdyLhtS63jKadI3LwAnHD8/A6Z+pcYq2Y/Vn3NOMpw==
X-Received: by 2002:a1c:2e0a:: with SMTP id u10mr16672537wmu.92.1560707261532;
        Sun, 16 Jun 2019 10:47:41 -0700 (PDT)
Received: from [192.168.0.41] (44.64.130.77.rev.sfr.net. [77.130.64.44])
        by smtp.googlemail.com with ESMTPSA id o126sm4060798wmo.1.2019.06.16.10.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 10:47:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Fix multiple thermal zones
 conflict in rk3399.dtsi
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        edubezval@gmail.com, manivannan.sadhasivam@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
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
        Kukjin Kim <kgene@kernel.org>
References: <20190604165802.7338-1-daniel.lezcano@linaro.org>
 <5188064.YWmxIpmbGp@phil> <55b9018e-672e-522b-d0a0-c5655be0f353@linaro.org>
 <e5a4f850-27e0-cad3-04bd-6c004fca2b81@arm.com>
 <9bf85c22-f1ba-3dbc-0b67-17e124484fa1@linaro.org>
 <20190616093127.GC3826@kozik-lap>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <55da0654-ce67-b843-5ca4-37f63577b102@linaro.org>
Date:   Sun, 16 Jun 2019 19:47:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190616093127.GC3826@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2019 11:31, Krzysztof Kozlowski wrote:
> On Fri, Jun 14, 2019 at 04:30:13PM +0200, Daniel Lezcano wrote:
>> On 14/06/2019 16:02, Robin Murphy wrote:
>>> On 14/06/2019 14:03, Daniel Lezcano wrote:
>>>> On 14/06/2019 11:35, Heiko Stuebner wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> Am Dienstag, 4. Juni 2019, 18:57:57 CEST schrieb Daniel Lezcano:
>>>>>> Currently the common thermal zones definitions for the rk3399 assumes
>>>>>> multiple thermal zones are supported by the governors. This is not the
>>>>>> case and each thermal zone has its own governor instance acting
>>>>>> individually without collaboration with other governors.
>>>>>>
>>>>>> As the cooling device for the CPU and the GPU thermal zones is the
>>>>>> same, each governors take different decisions for the same cooling
>>>>>> device leading to conflicting instructions and an erratic behavior.
>>>>>>
>>>>>> As the cooling-maps is about to become an optional property, let's
>>>>>> remove the cpu cooling device map from the GPU thermal zone.
>>>>>>
>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>> ---
>>>>>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 ---------
>>>>>>   1 file changed, 9 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>>>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>>>> index 196ac9b78076..e1357e0f60f7 100644
>>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>>>> @@ -821,15 +821,6 @@
>>>>>>                       type = "critical";
>>>>>>                   };
>>>>>>               };
>>>>>> -
>>>>>> -            cooling-maps {
>>>>>> -                map0 {
>>>>>> -                    trip = <&gpu_alert0>;
>>>>>> -                    cooling-device =
>>>>>> -                        <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>>>> -                        <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>>>>>> -                };
>>>>>> -            };
>>>>>>           };
>>>>>>       };
>>>>>
>>>>> my knowledge of the thermal framework is not that big, but what about
>>>>> the
>>>>> rk3399-devices which further detail the cooling-maps like
>>>>> rk3399-gru-kevin
>>>>> and the rk3399-nanopc-t4 with its fan-handling in the cooling-maps?
>>>>
>>>> The rk3399-gru-kevin is correct.
>>>>
>>>> The rk3399-nanopc-t4 is not correct because the cpu and the gpu are
>>>> sharing the same cooling device (the fan). There are different
>>>> configurations:
>>>>
>>>> 1. The cpu cooling device for the CPU and the fan for the GPU
>>>>
>>>> 2. Different trip points on the CPU thermal zone, eg. one to for the CPU
>>>> cooling device and another one for the fan.
>>>>
>>>> There are some variant for the above. If this board is not on battery,
>>>> you may want to give priority to the throughput, so activate the fan
>>>> first and then cool down the CPU. Or if you are on battery, you may want
>>>> to invert the trip points.
>>>>
>>>> In any case, it is not possible to share the same cooling device for
>>>> different thermal zones.
>>>
>>> OK, thanks for the clarification. I'll get my board set up again to
>>> figure out the best fix for rk3399-nanopc-t4 (FWIW most users are
>>> probably just using passive cooling or a plain DC fan anyway). You might
>>> want to raise this issue with the maintainers of
>>> arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi, since the
>>> everything-shared-by-everything approach in there was what I used as a
>>> reference.
>>
>> Cc'ed: Kukjin Kim and Krzysztof Kozlowski
>>
>> Easy :)
>>
> 
> Assuming that all trip-points are the same between thermal zones, I
> understand that solution could be to have one thermal zone with thermal
> multiple sensors (some time ago bindings did not support it) and all
> cooling devices? Then only one governor would be assigned?

The multiple sensors, multiple thermal zones and governors dealing with
different group of them is not implemented [yet]. Basically, you can
consider there is a 1:1 relationship between each of them.

 one thermal zone = one sensor = one cooling device

Given the configuration and the hardware, it would make sense to create
one thermal zone per cluster.

There is one clock line per cluster. It is possible to create two CPU
cooling devices, one for each cluster.

IMO, the fan definition is correct except it should be assigned to one
thermal zone only.

One configuration could be:

thermal-zones {
	little-thermal-zone: little-thermal-zone {
		thermal-sensors = <&tmu_cpu0 0>;
                polling-delay-passive = <250>;
                polling-delay = <0>;

		trips {
			ltz_alert0: ltz-alert-0 {
				temperature = <50000>;
				hysteresis = <5000>;
                        	type = "active";
			};

			ltz_alert1: cpu-alert-1 {
				temperature = <60000>;
				hysteresis = <5000>;
				type = "active";
			};

			ltz_alert2: ltz-alert-2 {
				temperature = <70000>;
				hysteresis = <5000>;
				type = "active";
			};

			ltz_alert3: ltz-alert-3 {
				temperature = <75000>;
				hysteresis = <10000>;
				type = "passive";
			};

			ltz_crit0: ltz-crit-0 {
				temperature = <120000>;
				hysteresis = <0>;
				type = "critical";
			};
		};

		cooling-maps {
			map0 {
				trip = <&ltz_alert0>;
				cooling-device = <&fan0 0 1>;
			};

			map1 {
				trip = <&ltz_alert1>;
				cooling-device = <&fan0 1 2>;
			};

			map2 {
				trip = <&ltz_alert2>;
				cooling-device = <&fan0 2 3>;
			};

			map3 {
				trip = <&ltz_alert3>;
				cooling-device = <&cpu0
						THERMAL_NO_LIMIT
						THERMAL_NO_LIMIT>,

						 <&cpu1
						THERMAL_NO_LIMIT
						THERMAL_NO_LIMIT>,

						 <&cpu2
						THERMAL_NO_LIMIT
						THERMAL_NO_LIMIT>,

						 <&cpu3
						THERMAL_NO_LIMIT
						THERMAL_NO_LIMIT>,
			};
		};
	};

	big-thermal-zone: big-thermal-zone {

		/* The same as little, except the sensor and the cpu
		  cooling &cpu4, &cpu5, &cpu6, &cpu7 */

	};
};


That said, the idle injection cooling device is for the moment being
developed and that would be a good opportunity to test a real per cpu
cooling device as the exynos5422 has a per core sensor.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

