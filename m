Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28FDC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A542133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KoQx+8ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfDKQwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:52:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53647 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:52:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so7596473wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9t4ilQ6mof2vrLlpPEWpt1SKNbSf3Ic0fWoK+soeb7k=;
        b=KoQx+8iiWRxjA8U2wqa3Gp4LXLKkMSDps9mjaswCu2E2D75/ajSZcpqVF72V/CMWpB
         E04amp3V283Qxd5MqHfVBcBAT7RMXry65eEMWgyRUOyn2BgqjeNomweQRPrFGCRUdHi5
         I7Zu3T8ulQp16SjL0Z+tsV6XoOtTI7OaWTiZQKadmZ3uexV05U1ops4CYHx/d2EhgUm4
         MaI7VpSDnXHhqO5G1rbIFX4eTQ3+j17GrMvwW5keA6MqrIAQ2pqyRNK2PLtwhIh9bt6v
         AnLBnrN+BvliGStfKI+gUULlm/A0+wBGK7INTJGzfy4TnA7LZ/URWhucul4Vg+vCXhIL
         +E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9t4ilQ6mof2vrLlpPEWpt1SKNbSf3Ic0fWoK+soeb7k=;
        b=Wt5d+wEGno51OdI3rL9tJIPutTBSNRB6lz27rLp7qONzqOt1Y1ks/EHp6U5tZrjkc5
         gy6m58rgOvmPAvtGoH5FgCdHIAYNgsZ3tBOZU70snJ7ROT1apfdJu+MzL0zdbAOoMJVs
         032vtLODWCWID4GmVaRMLHrhNusyG7x/XMQrjU3a4IzdUDsdng0PiEyyQsEe5mO5y23A
         7LN3bOMOxZ/EgoA2Rq/MrHZnZ/fusOBcBL3JuX+cgWfZowt6VVFSlG19Ece2PjZlra1o
         uIEPckT5xupR4lp9Uyi3TQeiJ4LefjQUIxNSOTRD0SWyCvF/6MPm/SX4vdh9rugPROmb
         tH7w==
X-Gm-Message-State: APjAAAUs0XiHemEpPmLtM+dlx5DIF7B1Ps119CJsscyLcdqP3FPNvN8z
        Jwke73YFYoPrt6MqaJ8FcJDZYuv3S5c=
X-Google-Smtp-Source: APXvYqx0gbTtZ4aF/yVlAevNj6Jyrc5c4iwdKCkgY4KAaVtrSC2rGv+ELhgjLV/NSgdK7lCsb4tFEw==
X-Received: by 2002:a1c:480b:: with SMTP id v11mr7334426wma.25.1555001542551;
        Thu, 11 Apr 2019 09:52:22 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
        by smtp.googlemail.com with ESMTPSA id j7sm56746955wrt.96.2019.04.11.09.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:52:22 -0700 (PDT)
Subject: Re: [PATCH v3 01/13] thermal: qoriq: Remove unnecessary DT node is
 NULL check
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-2-andrew.smirnov@gmail.com>
 <22f0c6d4-842e-bb91-a684-6edb6345e036@linaro.org>
 <CAHQ1cqEDiqn3KJeG62zqLm0tLv=+dgVHxSafm9_TYoi=VOMNhA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6cc7173a-ea45-4f79-61e6-bcfe1b9aaa4a@linaro.org>
Date:   Thu, 11 Apr 2019 18:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqEDiqn3KJeG62zqLm0tLv=+dgVHxSafm9_TYoi=VOMNhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2019 19:51, Andrey Smirnov wrote:
> On Wed, Apr 3, 2019 at 8:21 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 01/04/2019 06:14, Andrey Smirnov wrote:
>>> This driver is meant to be used with Device Tree and there's no
>>> use-case where device's DT node is going to be NULL. Remove code
>>> protecting against that.
>>
>> May be elaborate why is never going to be NULL?
>>
> 
> Hmm, I am not sure what can be elaborated further than what's already
> there. The driver is written to be instantiated via DT and there's no
> code that tries to do that via board code or anything like that. I am
> guessing you maybe read the description differently. Can you help me
> by giving an example of what you think needs clarifying?

May be just say if the probe function is called, the dev.of_node is
guarantee to be filled by the underlying framework because the
compatible string was found so the check is pointless.

Anyway, it is a detail.

>>> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
>>> Cc: Chris Healy <cphealy@gmail.com>
>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>> Cc: Eduardo Valentin <edubezval@gmail.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
>>> Cc: linux-imx@nxp.com
>>> Cc: linux-pm@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>>> ---
>>>  drivers/thermal/qoriq_thermal.c | 5 -----
>>>  1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
>>> index 3b5f5b3fb1bc..7b364933bfb1 100644
>>> --- a/drivers/thermal/qoriq_thermal.c
>>> +++ b/drivers/thermal/qoriq_thermal.c
>>> @@ -193,11 +193,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>>>       struct qoriq_tmu_data *data;
>>>       struct device_node *np = pdev->dev.of_node;
>>>
>>> -     if (!np) {
>>> -             dev_err(&pdev->dev, "Device OF-Node is NULL");
>>> -             return -ENODEV;
>>> -     }
>>> -
>>>       data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
>>>                           GFP_KERNEL);
>>>       if (!data)
>>>
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

