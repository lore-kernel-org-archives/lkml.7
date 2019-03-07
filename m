Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F51620652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUIg2eUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCGJOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:14:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52508 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfCGJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:14:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id f65so8481099wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e9RBVvAxQxq7YMd55uBBT3rk6IKzDIGLAuj6GXVn7io=;
        b=EUIg2eUE+4bzy9w3zU7xnhwCyJWCKkSO7gKHqN2qUdIT1H+nNv8o/xqV485zhHRx4T
         TzfcnPavlt8o9/V07ZDmQEiQFX2xRfAjX44cxNqcelJ34ExfR4kSNHnJF1SIdE6CM47I
         NRrH9eXBiSgTDR1XB7Vk2vaem5+IZX+FyTUG9pCE8TTdE3cN9pTUQ/XbejOzb8jsPdx2
         25lSrVHlwpa1WVMoypH5dQnUtPLdmjTKb3/VD4YJfFQBXkGZhXklIN/3Tpl5TG0bRWPM
         EFCN/S5u6R4C82N05KvQcVta9wHAgnhJjhxHiYw1F6OcI8txva8yaSWESrGq0nlJ+4Df
         EF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e9RBVvAxQxq7YMd55uBBT3rk6IKzDIGLAuj6GXVn7io=;
        b=WWyuSJw/UCTaJsUy3G3QT6QFHQ3t8cg0GG0y7ysulxf0K9ZohqEg3Zrb7K88yuO0OL
         DTCpqSCO944PvfMrEew7bMhzCp0ue9Ql5rES8BeR9z5IapaMBy38M8H81trKqSIg3hnO
         89Eq0cpPrRijHlAzGrZU/bJmDTFNb37O2TEiV5nryvqXMr/APLnCwJSHjkk3qzvfuySH
         hjN1MG2S7A1zvPy736OC76LGtlAmEDEo1VMHwA08/Gjx/n6wRICpF7ApZlrdSt3GTltI
         9PLCCPK327EQudGOYAGOBI5JLJeMDpTbQUHvMVV9u+MuiJa/mI5AWU4hBopG55Te83pd
         RmPw==
X-Gm-Message-State: APjAAAU2RHehKGwo6aDxCc1pak8EcGd1kqFNjwvXErO8QUYTbAi8OueU
        3E4bHk78SKAM9nlHhniI6IUZNA==
X-Google-Smtp-Source: APXvYqyZTKOWuMKHJDo2JJRzBbsxL58WSRVbdf//AGR21PRr++WlA25Vfts/1AmNUV3jYAdUxg2hwA==
X-Received: by 2002:a1c:bcd7:: with SMTP id m206mr5230373wmf.36.1551950086374;
        Thu, 07 Mar 2019 01:14:46 -0800 (PST)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id s3sm6402042wrt.81.2019.03.07.01.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 01:14:45 -0800 (PST)
Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
To:     Andy Tang <andy.tang@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
References: <20190304032111.21770-1-andy.tang@nxp.com>
 <20190304062115.GB26041@dragon>
 <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dc94e884-f5eb-fe07-27ef-6a94c3174acb@linaro.org>
Date:   Thu, 7 Mar 2019 10:14:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB433386B86A5E6AA804E9C3B5F3710@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2019 07:46, Andy Tang wrote:
> 
> 
>> -----Original Message-----
>> From: Shawn Guo <shawnguo@kernel.org>
>> Sent: 2019Äê3ÔÂ4ÈÕ 14:21
>> To: Andy Tang <andy.tang@nxp.com>
>> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
>> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org;
>> daniel.lezcano@linaro.org; rui.zhang@intel.com; edubezval@gmail.com
>> Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
>>
>> On Mon, Mar 04, 2019 at 11:21:11AM +0800, Yuantian Tang wrote:
>>> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core
>>> cluster sensor is used to monitor the temperature of core and SoC
>>> platform is for platform. The current dts only support the first sensor.
>>> This patch adds the second sensor node to dts to enable it.
>>>
>>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>>> ---
>>> v2:
>>> 	- Add more information about sensors to description
>>> PS: In order to keep consistency to the first thermal-zone node, there
>>> will be "WARNING: line over 80 characters" warnings.
>>>
>>>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43
>> +++++++++++++++++++++--
>>>  1 files changed, 39 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>> index 661137f..9f52bc9 100644
>>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>> @@ -129,19 +129,19 @@
>>>  	};
>>>
>>>  	thermal-zones {
>>> -		cpu_thermal: cpu-thermal {
>>> +		ccu {
>>
>> Is this change really necessary?  What does 'ccu' stand for?
> I think so. ccu stands for core cluster unit. cpu is too general.
> On some platforms, there are more than one core clusters.
> At least we should change it to "core cluster" if short form is not appropriate.

If the sensor is a the cluster level, 'cluster' is enough. IMHO, no need
to give a description of what contains the cluster, otherwise you will
end up with a 'core-gpu-cluster-l2' name.

>>
>>>  			polling-delay-passive = <1000>;
>>>  			polling-delay = <5000>;
>>>  			thermal-sensors = <&tmu 0>;
>>>
>>>  			trips {
>>> -				cpu_alert: cpu-alert {
>>> +				ccu_alert: ccu-alert {
>>>  					temperature = <85000>;
>>>  					hysteresis = <2000>;
>>>  					type = "passive";
>>>  				};
>>>
>>> -				cpu_crit: cpu-crit {
>>> +				ccu_crit: ccu-crit {
>>>  					temperature = <95000>;
>>>  					hysteresis = <2000>;
>>>  					type = "critical";
>>> @@ -150,7 +150,42 @@
>>>
>>>  			cooling-maps {
>>>  				map0 {
>>> -					trip = <&cpu_alert>;
>>> +					trip = <&ccu_alert>;
>>> +					cooling-device =
>>> +						<&cpu0 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>>> +						<&cpu1 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>>> +						<&cpu2 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>>> +						<&cpu3 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>>> +						<&cpu4 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>>> +						<&cpu5 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>>> +						<&cpu6 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>>> +						<&cpu7 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>;
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		plt {
>>
>> What about 'platform-thermal' for node name, platform-alert and platform-crit
>> for trip nodes below?
> OK, will use long name form.
> 
> BR,
> Andy
>>
>> Shawn
>>
>>> +			polling-delay-passive = <1000>;
>>> +			polling-delay = <5000>;
>>> +			thermal-sensors = <&tmu 1>;
>>> +
>>> +			trips {
>>> +				plt_alert: plt-alert {
>>> +					temperature = <85000>;
>>> +					hysteresis = <2000>;
>>> +					type = "passive";
>>> +				};
>>> +
>>> +				plt_crit: plt-crit {
>>> +					temperature = <95000>;
>>> +					hysteresis = <2000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +
>>> +			cooling-maps {
>>> +				map0 {
>>> +					trip = <&plt_alert>;
>>>  					cooling-device =
>>>  						<&cpu0 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>>>  						<&cpu1 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>>> --
>>> 1.7.1
>>>


-- 
 <http://www.linaro.org/> Linaro.org ©¦ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

