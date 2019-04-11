Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7798C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD352133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py0dNP3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfDKFaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:30:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38210 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKFaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:30:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so2938448pgl.5;
        Wed, 10 Apr 2019 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z7Rx/jxZLm6kduy4s0h6fiejHh/wdcAIrN1wWT4lMeU=;
        b=Py0dNP3AGQZ26DLRMGT/Ff+VL1Locg+6DzP4gGsKt7AwnSN8IqlSpB3urs8d4Iupzd
         wGbVU585V7JnzcOiGfbUjcm0WkOVz89wDLmXq1YerpG1K43Xx7qOAqXqtstcL4jpnNOQ
         Tk+UxlKbKzB3jgqE0wziPB2pUU8ccPmcRWevOd1FJxFGlEW969lbnhh/pg1wNWULiDof
         pJ113tNKR1eGeIxDHRunQII/hEEggDH4oR7JrLCZMwcAPRnYgXpKwPC6uY7fqPGnFrWX
         4n6pO2SqdELCl/kJhs74V9ySnFpwJXtlRadIJLg2WvcJS+/iwWoWZ/s8Hyfd/El+3yuS
         0cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z7Rx/jxZLm6kduy4s0h6fiejHh/wdcAIrN1wWT4lMeU=;
        b=pJRn8XhgTbS4PjN6lReU3EpLZJCHEPhrKw8ePZJ6+xN9Mvs2gtfyKHobbcuM02TVSj
         82tb8wZzA+a7Wn/gMnRBodvaVlpvtl6qSIAt/lh3nejvCKPmAKk2RqDVu/TQ9d0fr6SH
         REmHZpLkPaZ5oQbaifxz8CRcZ9p4NdYj/yjHWhZNzoOvvt8YKdN/9jcsfaGIZN/1M+f2
         xnXkH/2l2yyrOjGWS18IJYe7ETgY2dD4pVkNf6FEwCaLvk4fy82g4Y3tIFtg6wIMGg85
         DaRGqTAbTAoVzNHHLHmM0FmN7QkAHSFQZWdWkC620oDAHv6MXTThJDyPoIQlZJHHbD8B
         fZjQ==
X-Gm-Message-State: APjAAAUpcOVCiv0KScOHxdPqzgNKZ2pT413xPUIrOC+uu1eX6gR9vnUq
        jaUsB/hUxqCYUXJaGRloOR8=
X-Google-Smtp-Source: APXvYqxvwHOmjiuoba2WwaS7fWqR95QU4dS3q0Rzn2o2AjjgOX684VZJcNiu8pfWiOcIJLhWNQ/VNA==
X-Received: by 2002:a62:b61a:: with SMTP id j26mr48223440pff.203.1554960622935;
        Wed, 10 Apr 2019 22:30:22 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id g10sm20768522pgq.54.2019.04.10.22.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:30:22 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IFxcIOetlOWkjTogW1BBVENIXSBvZjogZGVsIHJlZHVuZGFudCB0?=
 =?UTF-8?Q?ype_conversion?=
From:   Frank Rowand <frowand.list@gmail.com>
To:     xiaojiangfeng <xiaojiangfeng@huawei.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BE69D0C4DC96EF4BA3F03246F234C4BD01FDE17F@dggeml512-mbx.china.huawei.com>
 <5739f2b6-5909-adf0-4fa6-dfaa1614a22a@gmail.com>
 <803ef005-c5af-0682-7aa2-cff1fda5a85e@gmail.com>
Message-ID: <64c41d24-e956-2f91-5838-0e572e532af7@gmail.com>
Date:   Wed, 10 Apr 2019 22:30:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <803ef005-c5af-0682-7aa2-cff1fda5a85e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 9:21 PM, Frank Rowand wrote:
> On 4/10/19 9:13 PM, Frank Rowand wrote:
>> On 4/10/19 6:51 PM, xiaojiangfeng wrote:
>>> My pleasure.
>>>
>>> I am very new to sparse.
>>>
>>> I guess the warning is caused by the macro min.
>>
>> I think the warning is likely because the type of data is 'void *'.
>>
>> Removing the (int) cast is a good fix, but does not resolve
>> the sparse warning.
> 
> Let me correct myself.  When I ran sparse, I see the removing min() does
> eliminate the sparse warning.  I'm not sure why, so I'll go dig a little
> deeper.

Digging leaves me with more information, but still not sure of the actual
underlying cause.  min() is defined in include/linux/kernel.h.  Unraveling
the defines, the code that sparse is complaining about is in
__no_side_effects(), which is:

#define __no_side_effects(x, y) \
                (__is_constexpr(x) && __is_constexpr(y))

and __is_constexpr() is:

#define __is_constexpr(x) \
        (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

The compiler warning points to the second sizeof() in the __is_constexpr() for
'l', which expands as:

  (sizeof(int) == sizeof(*(8 ? ((void *)((long)(   l) * 0l)) : (int *)8)))

I'll dig into this a little more, to see if maybe the problem is related to
my compiler version or sparse version.  Or if the reason lies elsewhere.

-Frank


> 
> -Frank
> 
>>
>> -Frank
>>
>>
>>> Then I submitted my changes.
>>>
>>> Thanks for code review.
>>>
>>>
>>> -----邮件原件-----
>>> 发件人: Frank Rowand [mailto:frowand.list@gmail.com] 
>>> 发送时间: 2019年4月11日 2:50
>>> 收件人: xiaojiangfeng <xiaojiangfeng@huawei.com>; robh+dt@kernel.org; robh@kernel.org
>>> 抄送: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>>> 主题: Re: [PATCH] of: del redundant type conversion
>>>
>>> On 4/10/19 1:29 AM, xiaojiangfeng wrote:
>>>> The type of variable l in early_init_dt_scan_chosen is int, there is 
>>>> no need to convert to int.
>>>>
>>>> Signed-off-by: xiaojiangfeng <xiaojiangfeng@huawei.com>
>>>> ---
>>>>  drivers/of/fdt.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c index 
>>>> 4734223..de893c9 100644
>>>> --- a/drivers/of/fdt.c
>>>> +++ b/drivers/of/fdt.c
>>>> @@ -1091,7 +1091,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>>>>  	/* Retrieve command line */
>>>>  	p = of_get_flat_dt_prop(node, "bootargs", &l);
>>>>  	if (p != NULL && l > 0)
>>>> -		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
>>>> +		strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
>>>>  
>>>>  	/*
>>>>  	 * CONFIG_CMDLINE is meant to be a default in case nothing else
>>>>
>>>
>>> Thanks for catching the redundant cast.
>>>
>>> There is a second problem detected by sparse on that line:
>>>
>>>   drivers/of/fdt.c:1094:34: warning: expression using sizeof(void)
>>>
>>> Can you please fix both issues?
>>>
>>> Thanks,
>>>
>>> Frank
>>>
>>
>>
> 
> 

