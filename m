Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97D0C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8E02087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUcg4niK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfCAEVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:21:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32969 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCAEVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 23:21:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id i19so10809879pfd.0;
        Thu, 28 Feb 2019 20:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XqWVLQo+0c9TMh3Jp82Vt/m+tyYOsGfEqM4JMup8HNA=;
        b=LUcg4niKjE27Y8LmQgoEEhMDZJJEKw4pSB0/BMVZsYvLv52w6RjN9wJulvsU7fF3of
         kf6yFvAfhDaJdyNnLkM/mILiru97vQv5tA73hkpC5595F6X80MSAJ5RVjC5waLLBJZX3
         2yZxVB4isMzlpVBx6IDh7zj8LJ7hm2B2vLY9AYbf/CJXGTTgIyOUXUxaJMS9B0EUyhHC
         7Be1cDLtEwNXbfP2myk32eOjg8+Wdu/8O8WBBnADc2+zqhX9ddxoyHekkC003DS8bf/z
         IbTuvwqdQHXKudVADOpGPzVQPQ3WHMYJGRdFzsBpS++bMpvCv2g+MBSpm+Q99nMHxXm9
         nVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XqWVLQo+0c9TMh3Jp82Vt/m+tyYOsGfEqM4JMup8HNA=;
        b=f68do5QKFObH90lf1++vGU7rdr/hlhmavYUoSgFYjRylAMBFurmj6KDG2nn3wgoZf2
         7wltHg5FGWnDfYmyuYaSpZEEilAYVGGK6g9AF7Pk0tHdVJ83U+R9S2QacJkOzrayiNVW
         IQsan26zwOzyBGEv0QuO8PAWA2opgvXgIm5XiiGFDUi6RyJ0+TJE1NZ8MzuM0/cAZSpg
         kLQ4uvNqdK+prEyRDTCJicylKCxEOl231ZvceXZDugeJ6krp4T0bNWapTK4G7OQKz+h5
         OdBFlVEjJniTDBDNX9vPFjp3eQytytxef6Vea0QyY9NYqhS6oVZjQ4tHropWMiXtIY5P
         W0PA==
X-Gm-Message-State: AHQUAuaDuRpMd38NyI0KUzsShKOrIwz7IB/LBsDOH7xtHXlEx+T06W+W
        Q0W50LTb+RzOFoS2E5YeBk0=
X-Google-Smtp-Source: APXvYqy+5c9YyJNNNmoxjevzfav+4v7eMiNFmN3j5bei0pxoXwcLlIV6zc+7sU0A0J6OU6uaWjAtgg==
X-Received: by 2002:a62:4389:: with SMTP id l9mr3626528pfi.170.1551414089381;
        Thu, 28 Feb 2019 20:21:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2sm25611493pgc.67.2019.02.28.20.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 20:21:28 -0800 (PST)
Subject: Re: [PATCH V4 1/2] watchdog: imx_sc: Add i.MX system controller
 watchdog support
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1551340510-2324-1-git-send-email-Anson.Huang@nxp.com>
 <575f5a40-5590-12fc-e117-a97577982844@roeck-us.net>
 <DB3PR0402MB391655BBF367452B7BF6A7CEF5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <dcc27575-8191-cfa9-4991-c02b399860df@roeck-us.net>
Date:   Thu, 28 Feb 2019 20:21:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB391655BBF367452B7BF6A7CEF5760@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/19 7:46 PM, Anson Huang wrote:
> Hi, Guenter
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
>> Roeck
>> Sent: 2019年2月28日 22:58
>> To: Anson Huang <anson.huang@nxp.com>; catalin.marinas@arm.com;
>> will.deacon@arm.com; wim@linux-watchdog.org; shawnguo@kernel.org;
>> s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
>> Andy Gross <andy.gross@linaro.org>; heiko@sntech.de;
>> horms+renesas@verge.net.au; arnd@arndb.de; olof@lixom.net;
>> jagan@amarulasolutions.com; bjorn.andersson@linaro.org;
>> enric.balletbo@collabora.com; marc.w.gonzalez@free.fr; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>> watchdog@vger.kernel.org
>> Cc: dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH V4 1/2] watchdog: imx_sc: Add i.MX system controller
>> watchdog support
>>
>> On 2/27/19 11:59 PM, Anson Huang wrote:
>>> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
>>> inside, the system controller is in charge of controlling power, clock
>>> and watchdog etc..
>>>
>>> This patch adds i.MX system controller watchdog driver support,
>>> watchdog operation needs to be done in secure EL3 mode via
>>> ARM-Trusted-Firmware, using SMC call, CPU will trap into
>>> ARM-Trusted-Firmware and then it will request system controller to do
>>> watchdog operation via IPC.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> ---
>>> Changes since V3:
>>>           - add ARM64 dependency for this driver;
>>>           - change SPDX license to GPL-2.0 to match module license;
>>>           - register platform device in driver instead of getting from dts;
>>> 	- return linux error code instead of system controller firmware error
>> code for watchdog operation
>>> 	  failed case.
>>> ---
>>>    drivers/watchdog/Kconfig      |  13 +++
>>>    drivers/watchdog/Makefile     |   1 +
>>>    drivers/watchdog/imx_sc_wdt.c | 201
>> ++++++++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 215 insertions(+)
>>>    create mode 100644 drivers/watchdog/imx_sc_wdt.c
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
>>> 65c3c42..8c6575e 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -625,6 +625,19 @@ config IMX2_WDT
>>>    	  To compile this driver as a module, choose M here: the
>>>    	  module will be called imx2_wdt.
>>>
>>> +config IMX_SC_WDT
>>> +	tristate "IMX SC Watchdog"
>>> +	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
>>> +	select WATCHDOG_CORE
>>> +	help
>>> +	  This is the driver for the system controller watchdog
>>> +	  on the NXP i.MX SoCs with system controller inside.
>>> +	  If you have one of these processors and wish to have
>>> +	  watchdog support enabled, say Y, otherwise say N.
>>> +
>>> +	  To compile this driver as a module, choose M here: the
>>> +	  module will be called imx_sc_wdt.
>>> +
>>
>> With this patch applied, alpha:allmodconfig and almost all other
>> allmodconfig/allyesconfig builds fail with:
>>
>> ERROR: "__arm_smccc_smc" [drivers/watchdog/imx_sc_wdt.ko] undefined!
>> scripts/Makefile.modpost:92: recipe for target '__modpost' failed
>> make[1]: *** [__modpost] Error 1
>> Makefile:1260: recipe for target 'modules' failed
>>
>> as I told you before would happen. For the future, please consider that
>> forcing me to "prove" such failures does take a significant amount of time,
>> which is not always readily available.
> 
> Sorry for wasting your time, it is just because I misunderstand your point, NOT
> that I did NOT force you to prove it.
> 
> I am a little confuse, since this is new to me about these configs, I looked into
> other drivers which also use arm_smccc_smc, they do NOT add special config
> dependency for the failure build cause as you said, can you be more detail about
> this build issue, I tried below build, but the failure I met is other, so could you please
> advise how to fix such dependency issue, adding dummy function looks like NOT
> a good way since this arm_smccc_smc() API is widely used in kernel, there should be
> some common solution for it, Thanks in advanced and appreciate for your time.
> 

I am quite sure that the other drivers calling arm_smccc_smc don't have
"|| COMPILE_TEST" as dependency, or they have a secondary dependency.

Randomly picking some

RTC_DRV_IMX_SC - no.
ARM_RK3399_DMC_DEVFREQ - no.
PHY_MVEBU_A3700_COMPHY - yes, but it also has "depends on HAVE_ARM_SMCCC" as
separate line, limiting its scope.

You can either drop "|| COMPILE_TEST" or add "depends on HAVE_ARM_SMCCC"
in a separate line. There may be other options, but I did not explore them.

Guenter
