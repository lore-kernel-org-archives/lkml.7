Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3951DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0149520850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXZVfCe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfDKEWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:22:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41935 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfDKEWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 00:22:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so2720005plj.8;
        Wed, 10 Apr 2019 21:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eo95cX0QN5vPuk9L/5MGbU3e32moRiUsEXZsQZ1hm6s=;
        b=oXZVfCe04xvfWc17KAwKImNyS17TSBzN9lDRlWg/vdZNdoz8iGjqG+8xki8uLVmP8J
         q34p2H0qP37qb8BlceVzPhb3R+Y3JQ34vI09H8KDvf4XvRfRn8Y6puAp/S4AENXWCf3Z
         CnKcuIjM58Gqye9IJlk12jKYaNT8H/lLF0Ko2wH00pCiB2XkGTp1Jh4MUVYCYxuUXTcU
         2hHf1OIbW/WQLiE481BjCOTRN6zeLLKK7Apu6dQ8HTkwWU5Wt+EHYhgmsDzjHdoDncgM
         h+0w3T9AsyWI+SpO9NgtmtuQMkyjYPbnW8fwP0gdMT4YUEj61TJgtKXJC83+gfstyPxi
         HNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eo95cX0QN5vPuk9L/5MGbU3e32moRiUsEXZsQZ1hm6s=;
        b=bAmICIfZq5U8F2sGmggDbxMF7vhlU1cm4bEYbuIwsKl1idByq49sQqn+pCfjFuqCRy
         UxczkGhjRAFqaeRYPZO1NutiO1jc8dNDmlSkKgUQ6/o74FSoyS1Gij8NZj1Vbm7hGltD
         pt61yT4Is9Gq5QGC7+HT0sQII/LHon8ozfg+GRAOlQPEx1xs0bzKWX+Xh3oLm0l12Qsp
         FNq58MvycskTJigxV560nxfuWPZ46edu5Z06EqmlQEEGTOG73pF7WmM3QYfVJ6z0Nr9T
         i+14VHh2jRr0uN5m1o3FCTQLe0tklQI/BJOfpeYo5xt9yoc50ST+M2P3KeO9s8IR061M
         3E5A==
X-Gm-Message-State: APjAAAWGkfl3Er+4U8vc9BEH+CszlK99ui5Kcqj4DNCED/IeD9PxXJM2
        5MCWR4RlyXAWQ+/m1Q02t7c=
X-Google-Smtp-Source: APXvYqznTcZ6SpnP7IkxgKGrrk5JeL1pOz373qd/WP4FVkBR53nPvzNLjJL0uViDGVQF7/+EnKejUQ==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr47786316plt.59.1554956520525;
        Wed, 10 Apr 2019 21:22:00 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h20sm48981740pfj.40.2019.04.10.21.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 21:22:00 -0700 (PDT)
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
Message-ID: <803ef005-c5af-0682-7aa2-cff1fda5a85e@gmail.com>
Date:   Wed, 10 Apr 2019 21:21:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <5739f2b6-5909-adf0-4fa6-dfaa1614a22a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 9:13 PM, Frank Rowand wrote:
> On 4/10/19 6:51 PM, xiaojiangfeng wrote:
>> My pleasure.
>>
>> I am very new to sparse.
>>
>> I guess the warning is caused by the macro min.
> 
> I think the warning is likely because the type of data is 'void *'.
> 
> Removing the (int) cast is a good fix, but does not resolve
> the sparse warning.

Let me correct myself.  When I ran sparse, I see the removing min() does
eliminate the sparse warning.  I'm not sure why, so I'll go dig a little
deeper.

-Frank

> 
> -Frank
> 
> 
>> Then I submitted my changes.
>>
>> Thanks for code review.
>>
>>
>> -----邮件原件-----
>> 发件人: Frank Rowand [mailto:frowand.list@gmail.com] 
>> 发送时间: 2019年4月11日 2:50
>> 收件人: xiaojiangfeng <xiaojiangfeng@huawei.com>; robh+dt@kernel.org; robh@kernel.org
>> 抄送: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> 主题: Re: [PATCH] of: del redundant type conversion
>>
>> On 4/10/19 1:29 AM, xiaojiangfeng wrote:
>>> The type of variable l in early_init_dt_scan_chosen is int, there is 
>>> no need to convert to int.
>>>
>>> Signed-off-by: xiaojiangfeng <xiaojiangfeng@huawei.com>
>>> ---
>>>  drivers/of/fdt.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c index 
>>> 4734223..de893c9 100644
>>> --- a/drivers/of/fdt.c
>>> +++ b/drivers/of/fdt.c
>>> @@ -1091,7 +1091,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>>>  	/* Retrieve command line */
>>>  	p = of_get_flat_dt_prop(node, "bootargs", &l);
>>>  	if (p != NULL && l > 0)
>>> -		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
>>> +		strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
>>>  
>>>  	/*
>>>  	 * CONFIG_CMDLINE is meant to be a default in case nothing else
>>>
>>
>> Thanks for catching the redundant cast.
>>
>> There is a second problem detected by sparse on that line:
>>
>>   drivers/of/fdt.c:1094:34: warning: expression using sizeof(void)
>>
>> Can you please fix both issues?
>>
>> Thanks,
>>
>> Frank
>>
> 
> 

