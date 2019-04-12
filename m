Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22506C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38E82077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFq8ehtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfDLMTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:19:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36320 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfDLMTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:19:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so11705364wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ir8sEPDXChUV7v85TJcoRQP1tQ9RJbECjaDQk9/1U58=;
        b=HFq8ehtfDYOhznbD4RU9nyfn+zZhDTf8lFPaMx1JGzQ/BThu7KAB/jqHX9xFS9HcW0
         /Mq+ubTbMWpT53S2KOwpn9B8X0rg1/ES1NuX6hsMk1gSU9dHf7s/QAMcWUEEBeMo9zFD
         LcCZUNuBAx1N8OhrttYoIUbCtvAQajNDHWusLAuafnAGbnMsXKlO3xf/25zIfHf+g6wj
         24HEDEvk8GvQ86p1Fi906Bv49gzsq1RJx5PvKiAnRrnMaPyR2uRqkSZGE2fHLJAK/UN1
         JrYNGwL5LqVuWeSJwY82h3gkUfoiIGruI6UfhmTG0iI95DUWxULihZ2+p5QEsBvQxH0q
         dKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ir8sEPDXChUV7v85TJcoRQP1tQ9RJbECjaDQk9/1U58=;
        b=myNN7OiS5OrWV9IJ2ric0+NiUDTGlMU5ABroVrgq6tIdOpqM4qPHbjT6Kz/iSQFjcE
         EsxMN6Ku44Wg3jKJI4tIwf23bclMZDhQvG7vQvAlCV7d9PjdmVu6ZENlLwtA8SZC5ALw
         8CY/MKv9PL3pmEV3sOhyNCYG81nMde29KAmrC9AhFehCVHlEIxb845kbcxWZ0FdvUbkk
         huvogvTdj4hLU9GragNJLlYjcEVozicMyn7Bh8S9cCeqJEtBDlfgkSzJE2XGx1Eok44c
         nDAavlzSEIpZwRYkA6KwCIO6cA0UWXi6y7txtL+1CwfxbFGtfAET2hOqN85VtNh9xXXD
         f5KA==
X-Gm-Message-State: APjAAAWi4WBWNnt9yNGQZYoFRM0B6jO4aKu2qsbjnIz35S8bNt1vW5YD
        +RNOU3aJ30vdPC4fpvKt8X5CiA==
X-Google-Smtp-Source: APXvYqyitS1k8nFw3SVElljn2DDFnCog3CZjgODdLB0n1BhcRW9O7oCP6wksfQuEfdXfudnQUT5cMw==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr14690511wrp.172.1555071544545;
        Fri, 12 Apr 2019 05:19:04 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id w16sm60598513wrt.84.2019.04.12.05.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:19:03 -0700 (PDT)
Subject: Re: [EXT] Re: [PATCH v5] arm64: dts: ls1088a: add one more thermal
 zone node
To:     Andy Tang <andy.tang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
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
References: <20190411083236.9377-1-andy.tang@nxp.com>
 <915c86d8-d00e-f1e1-e7f5-24bc225c8e42@linaro.org>
 <AM6PR04MB4326561F037194D84CEB011AF3280@AM6PR04MB4326.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6be740a0-aaa7-6b49-ba82-8d04d47b2339@linaro.org>
Date:   Fri, 12 Apr 2019 14:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <AM6PR04MB4326561F037194D84CEB011AF3280@AM6PR04MB4326.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2019 09:47, Andy Tang wrote:
> 
>> -----Original Message-----
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: 2019年4月12日 3:15
>> To: Andy Tang <andy.tang@nxp.com>; shawnguo@kernel.org
>> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org; mark.rutland@arm.com;
>> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org; rui.zhang@intel.com;
>> edubezval@gmail.com
>> Subject: [EXT] Re: [PATCH v5] arm64: dts: ls1088a: add one more thermal zone
>> node
>>
>> WARNING: This email was created outside of NXP. DO NOT CLICK links or
>> attachments unless you recognize the sender and know the content is safe.
>>
>>
>>
>> On 11/04/2019 10:32, Yuantian Tang wrote:
>>> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core
>>> cluster sensor is used to monitor the temperature of core and SoC
>>> platform is for platform. The current dts only support the first sensor.
>>> This patch adds the second sensor node to dts to enable it.
>>>
>>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>>> ---
>>> v5:
>>>       - update the thermal zone name due to the length limitation
>>>       - remove cooling map in platform zone
>>> v4:
>>>       - use hyphen instead of underscore in node name
>>> v3:
>>>       - use more descriptive name for each zone
>>> v2:
>>>       - Add more information about sensors to description
>>>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   28
>> ++++++++++++++++++++---
>>>  1 files changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>> index de93b42..de39672 100644
>>> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
>>> @@ -129,19 +129,19 @@
>>>       };
>>>
>>>       thermal-zones {
>>> -             cpu_thermal: cpu-thermal {
>>> +             core-cluster {
>>>                       polling-delay-passive = <1000>;
>>>                       polling-delay = <5000>;
>>>                       thermal-sensors = <&tmu 0>;
>>>
>>>                       trips {
>>> -                             cpu_alert: cpu-alert {
>>> +                             core_cluster_alert: core-cluster-alert {
>>>                                       temperature = <85000>;
>>>                                       hysteresis = <2000>;
>>>                                       type = "passive";
>>>                               };
>>>
>>> -                             cpu_crit: cpu-crit {
>>> +                             core_cluster_crit: core-cluster-crit {
>>>                                       temperature = <95000>;
>>>                                       hysteresis = <2000>;
>>>                                       type = "critical"; @@ -150,7
>>> +150,7 @@
>>>
>>>                       cooling-maps {
>>>                               map0 {
>>> -                                     trip = <&cpu_alert>;
>>> +                                     trip = <&core_cluster_alert>;
>>>                                       cooling-device =
>>>                                               <&cpu0
>> THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>>>                                               <&cpu1
>> THERMAL_NO_LIMIT
>>> THERMAL_NO_LIMIT>, @@ -163,6 +163,26 @@
>>>                               };
>>>                       };
>>>               };
>>> +
>>> +             platform {
>>> +                     polling-delay-passive = <1000>;
>>> +                     polling-delay = <5000>;
>>> +                     thermal-sensors = <&tmu 1>;
>>> +
>>> +                     trips {
>>> +                             platform-alert {
>>> +                                     temperature = <85000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "passive";
>>> +                             };
>>> +
>>> +                             platform-crit {
>>> +                                     temperature = <95000>;
>>> +                                     hysteresis = <2000>;
>>> +                                     type = "critical";
>>> +                             };
>>> +                     };
>>> +             };
>>
>>
>> Unfortunately, the documentation says the thermal zone node must contain a
>> "cooling-maps" entry.
> That's a question.
> If I add "cooling-maps", then multiple zones will use same cooling device.
> If I don't, documentation says it is a " Required properties".
> I am wondering how it was dealt with on other platform supporting multiple zones.

I think the problem comes from the fact there are no governors capable
of handling multiple thermal zones.

The additional cooling device is the devfreq but as the mali driver is
not upstream, the cooling map for this device does not appear. We can
find the definitions and the driver in the AOSP [1].

Moreover, the power is usually managed by the IPA governor, but this one
can not handle multiple thermal zones, so the cooling devices are joined
together into a single thermal zone with their contribution to the
cooling effect.

Other definitions I have seen upstream are incomplete or broken.

[1]
https://android.googlesource.com/kernel/hikey-linaro/+/refs/heads/android-hikey-linaro-4.14/arch/arm64/boot/dts/hisilicon/hi3660.dtsi#1340

> Hi Shawn,
> What's your opinions about this?



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

