Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F03C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A568A2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7RonqaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCHJ2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:28:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36584 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfCHJ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:28:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so11828699wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 01:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KMYqWqmEZpW/SIThjEhLEnUHdzRiZxufT4g0ftdB7fI=;
        b=U7RonqaPgYoovOfIW2WlvZrSBBZqVr+V3r9TYbNovlibFts20Qapy0R4mAOOGHlxSx
         d7v7D+aRMcsNZC1T74dyVQ391UxsljZtz1M+M+oY1lKD1V+m56f5tUaJkaw8xs9D009a
         9tUCB0LRB3CmHP2E9cosLLGj81/L1npnGYYcnqm+Ozmlw2FnA1pitL/G+7n2UI2Ekfgm
         6HsoEEo0pzzxHUfeLR0DyU830lT9tRaP6pJoU+gPXP3gbj3G2NXHozvUn/GHdoFEZAh7
         zxds2J9AMfJhsB4GK/3NvOGV4LFcN5FB5esdQYNuQa4JzZVRTMHfGz6ah1yd7Hm9eg5s
         udYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KMYqWqmEZpW/SIThjEhLEnUHdzRiZxufT4g0ftdB7fI=;
        b=rebsZdlVSTFTqFxQDX1nPk3cCkZuNopO+2kWAXNEehkjlVYWRo6PPY0yjrp2hMn3Wy
         yzaiKX+S2Grrc2/0lTtCwDH8JDbaam29AcWgKZf5pYMn1Aw4qjAUm/m+5+vyISPmOHKT
         6eMaHR/zc/p/shg5Ld3TmdCzdtBJ7qn3GW1dv2qAO8eeiSKlwlh15Tw6g7oeEG5A0vTi
         ihhXLZCosk2MGff4Dq5HL+yEgmhPt5U76iM/wOkFYHOBhHJxWzRpJ6mIWwIphlS0mCow
         U0Wu5Iz06DXZas9yuTtoZO2Xg/mfUDmk1bq1kfSkT/lSph7TDXYVt2LkVdWxOWu+dU5k
         DIlw==
X-Gm-Message-State: APjAAAWYxceq/PV0nNann3GVGVcoDxElED9TwE/3qf3m/DADd6/HjqDi
        D7EaJKwpIDwT27SXW0DbtxFJqQ==
X-Google-Smtp-Source: APXvYqyMmA61W09ZuCqnICNNJW+EG1GFSbQZoRgP2otbpPTsE+ePK/78tqQUGxCm9PuGUqkJMu0UMA==
X-Received: by 2002:a1c:449:: with SMTP id 70mr8679512wme.118.1552037294775;
        Fri, 08 Mar 2019 01:28:14 -0800 (PST)
Received: from [192.168.0.44] (246.127.130.77.rev.sfr.net. [77.130.127.246])
        by smtp.googlemail.com with ESMTPSA id z15sm12524412wrh.18.2019.03.08.01.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:28:13 -0800 (PST)
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
 <dc94e884-f5eb-fe07-27ef-6a94c3174acb@linaro.org>
 <VI1PR04MB43330C6FAAD0D8EAE901C56FF34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cb262e2c-7115-86a5-01ce-4a12d45ee019@linaro.org>
Date:   Fri, 8 Mar 2019 10:28:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB43330C6FAAD0D8EAE901C56FF34D0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2019 03:07, Andy Tang wrote:
> 
> 
>> -----Original Message-----
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: 2019Äê3ÔÂ7ÈÕ 17:15
>> To: Andy Tang <andy.tang@nxp.com>; Shawn Guo <shawnguo@kernel.org>
>> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
>> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org; rui.zhang@intel.com;
>> edubezval@gmail.com
>> Subject: Re: [PATCH v2] arm64: dts: ls1088a: add one more thermal zone node
>>
>>>>> PS: In order to keep consistency to the first thermal-zone node,
>>>>> there will be "WARNING: line over 80 characters" warnings.
>>>>>
>>>>>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43
>>>> +++++++++++++++++++++--
>>>>>  1 files changed, 39 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>>>> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>>>> index 661137f..9f52bc9 100644
>>>>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>>>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>>>> @@ -129,19 +129,19 @@
>>>>>  	};
>>>>>
>>>>>  	thermal-zones {
>>>>> -		cpu_thermal: cpu-thermal {
>>>>> +		ccu {
>>>>
>>>> Is this change really necessary?  What does 'ccu' stand for?
>>> I think so. ccu stands for core cluster unit. cpu is too general.
>>> On some platforms, there are more than one core clusters.
>>> At least we should change it to "core cluster" if short form is not appropriate.
>>
>> If the sensor is a the cluster level, 'cluster' is enough. IMHO, no need to give a
>> description of what contains the cluster, otherwise you will end up with a
>> 'core-gpu-cluster-l2' name.
> If cluster is specific to core, we can use cluster instead. But I don't think so.
> Cluster may refer to "core cluster", "GPU cluster" etc.
> So, I think "core-cluster" is ok.
> If core was divided to several clusters, we can name it as "core-cluster1", "core-cluster2" etc.
> If GPU was divided to several clusters we can name it as "gpu-cluster1", "gpu-cluster2" etc. 


Hi Andy,

I think there is a confusion around the 'cpu' term and 'cluster'.

ARM would like to see the 'cluster' word to disappear, so whenever
possible we should avoid it.

From the hardware side, 'CPU' is usually used to describe the physical
chip containing the cores+cache.

From the software side, 'CPU' is usually used to describe the logical
process unit, aka a core or a hyper-thread.

As we are in the DT, so describing the hardware, the CPU refers to the
group cores+caches.

From my POV, using 'cpu' for the group of cores and 'gpu' for the
graphic sounds ok, and so far that is what is used for the other platforms.

If you change the name, that may give the feeling there is something
special with those thermal zones.




-- 
 <http://www.linaro.org/> Linaro.org ©¦ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

