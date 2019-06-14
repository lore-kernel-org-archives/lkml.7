Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFF7C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D207F2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfFNKJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:09:34 -0400
Received: from foss.arm.com ([217.140.110.172]:58654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfFNKJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:09:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F06ED2B;
        Fri, 14 Jun 2019 03:09:30 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E6443F246;
        Fri, 14 Jun 2019 03:11:12 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Fix multiple thermal zones
 conflict in rk3399.dtsi
To:     Heiko Stuebner <heiko@sntech.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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
        <linux-rockchip@lists.infradead.org>, dianders@chromium.org
References: <20190604165802.7338-1-daniel.lezcano@linaro.org>
 <5188064.YWmxIpmbGp@phil>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3ee47d34-bf71-9e53-9387-7407865d3110@arm.com>
Date:   Fri, 14 Jun 2019 11:09:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5188064.YWmxIpmbGp@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2019 10:35, Heiko Stuebner wrote:
> Hi Daniel,
> 
> Am Dienstag, 4. Juni 2019, 18:57:57 CEST schrieb Daniel Lezcano:
>> Currently the common thermal zones definitions for the rk3399 assumes
>> multiple thermal zones are supported by the governors. This is not the
>> case and each thermal zone has its own governor instance acting
>> individually without collaboration with other governors.
>>
>> As the cooling device for the CPU and the GPU thermal zones is the
>> same, each governors take different decisions for the same cooling
>> device leading to conflicting instructions and an erratic behavior.
>>
>> As the cooling-maps is about to become an optional property, let's
>> remove the cpu cooling device map from the GPU thermal zone.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 ---------
>>   1 file changed, 9 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 196ac9b78076..e1357e0f60f7 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -821,15 +821,6 @@
>>   					type = "critical";
>>   				};
>>   			};
>> -
>> -			cooling-maps {
>> -				map0 {
>> -					trip = <&gpu_alert0>;
>> -					cooling-device =
>> -						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> -						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> -				};
>> -			};
>>   		};
>>   	};
> 
> my knowledge of the thermal framework is not that big, but what about the
> rk3399-devices which further detail the cooling-maps like rk3399-gru-kevin
> and the rk3399-nanopc-t4 with its fan-handling in the cooling-maps?

FWIW, my knowledge of thermal is probably even less :)

For NanoPC-T4 I think I more or less just took Odroid-XU3/4 as the best 
pwm-fan example and adapted that into the existing RK3399 zones in the 
manner which seemed most logical to my interpretation - if what was 
there wasn't right to begin with, then I may well have done that wrong too.

Robin.
