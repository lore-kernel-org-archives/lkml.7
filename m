Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3FCC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CED42084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 04:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0JLqzxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDKEOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:14:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46554 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKEOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 00:14:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so2742434pfj.13;
        Wed, 10 Apr 2019 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6QIi353B+D+qQIkmrXn+TZY3LONFQHB67nABoA1ZK2E=;
        b=P0JLqzxvr+KEB4WOTWwpjthDM54Dc+QKnKyoV/t8Z8TWkT+KONOEk1bo70fHNT+o/x
         oT3C9lEcAsEv+XoOQOwEFAUwIT8b9ZK7iiYmzh1ffPLDOM60Nik3J2uQw4D3ju/WGYu+
         Op5ClmntmVav6KDqb5NhPKmaXVJAVpgyVYSmN3kxh5M3alWh38OPUiAfmxWFGK61Lnk6
         QTXwnRbFhQ9Ys8yAqgqP52bSOmnkiXm9kAKkBUuQUZZVvsbqqfVY8QK0xfKV+bmfjbJe
         Jc8Vs6fqWSuXC8aPEoVCfAHmS4b9FR0EGwXd8DhDhMt8K+rNq7R0ZJuCYRl2eJOSK6dd
         LgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QIi353B+D+qQIkmrXn+TZY3LONFQHB67nABoA1ZK2E=;
        b=rufKPMCUfSkEgNCwWIq299W1lFZGrwHxSNUyZhQMISJReOXNU0ny8/McpfVfvEzRdf
         OXsGyhs43qWPLMFnI6yHrDkbtpIVisYx/j02UOnbohVspESPRn7Tp5dK5dhm5b1f4zCJ
         joFYvmUcZgBRTF9b3P2JfHomBXxszOmyyWrULXN1xd7p+f40IUyi7lOkrWSSXduvGGXU
         0/xnlZGt6iUSNXCRd23KF7Tg6UCo97r7QHTbbgmznGP3mQSdikVMDwOzpH/wI1fBzXu3
         5QZYQeDnDWm5xRL1cyxi4JoMF1aokH4UOwU79KEB0IT3BCPrGPtPfbhfQ/e38cDXWijY
         afVg==
X-Gm-Message-State: APjAAAV/M2V/ivR+o2we1ojLIfl1gNNazwHx/iOy07MV2l/pQI5YJK0K
        tPaL8S1W3RCYiFZy1mMyFKM=
X-Google-Smtp-Source: APXvYqyL5xdJMnaq+3brRoK+WrKqIsHNh0E+sD+JyEUu89duDnhmEzGXMkLdnguOydJN2ZfywvCyNg==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr11634776pgv.47.1554956040481;
        Wed, 10 Apr 2019 21:14:00 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f2sm30979241pgc.30.2019.04.10.21.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 21:13:59 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IFxcIOetlOWkjTogW1BBVENIXSBvZjogZGVsIHJlZHVuZGFudCB0?=
 =?UTF-8?Q?ype_conversion?=
To:     xiaojiangfeng <xiaojiangfeng@huawei.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BE69D0C4DC96EF4BA3F03246F234C4BD01FDE17F@dggeml512-mbx.china.huawei.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <5739f2b6-5909-adf0-4fa6-dfaa1614a22a@gmail.com>
Date:   Wed, 10 Apr 2019 21:13:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <BE69D0C4DC96EF4BA3F03246F234C4BD01FDE17F@dggeml512-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 6:51 PM, xiaojiangfeng wrote:
> My pleasure.
> 
> I am very new to sparse.
> 
> I guess the warning is caused by the macro min.

I think the warning is likely because the type of data is 'void *'.

Removing the (int) cast is a good fix, but does not resolve
the sparse warning.

-Frank


> Then I submitted my changes.
> 
> Thanks for code review.
> 
> 
> -----邮件原件-----
> 发件人: Frank Rowand [mailto:frowand.list@gmail.com] 
> 发送时间: 2019年4月11日 2:50
> 收件人: xiaojiangfeng <xiaojiangfeng@huawei.com>; robh+dt@kernel.org; robh@kernel.org
> 抄送: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> 主题: Re: [PATCH] of: del redundant type conversion
> 
> On 4/10/19 1:29 AM, xiaojiangfeng wrote:
>> The type of variable l in early_init_dt_scan_chosen is int, there is 
>> no need to convert to int.
>>
>> Signed-off-by: xiaojiangfeng <xiaojiangfeng@huawei.com>
>> ---
>>  drivers/of/fdt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c index 
>> 4734223..de893c9 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -1091,7 +1091,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>>  	/* Retrieve command line */
>>  	p = of_get_flat_dt_prop(node, "bootargs", &l);
>>  	if (p != NULL && l > 0)
>> -		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
>> +		strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
>>  
>>  	/*
>>  	 * CONFIG_CMDLINE is meant to be a default in case nothing else
>>
> 
> Thanks for catching the redundant cast.
> 
> There is a second problem detected by sparse on that line:
> 
>   drivers/of/fdt.c:1094:34: warning: expression using sizeof(void)
> 
> Can you please fix both issues?
> 
> Thanks,
> 
> Frank
> 

