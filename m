Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7E0C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1631C20644
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNaElT5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfHMEfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:35:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32829 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfHMEfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:35:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so50853152pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 21:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FF+t4OfbpbPXQydk92H3dHyz9qzlzYP9A0YiDR+Zrp4=;
        b=iNaElT5f9Fx0JFXWcMllOYGAivHnGcZ+vAM3BC3rgxbs2WuFyVvLRHFAOhKrL+YaV6
         z4JcM7+aOYlFXjnWVj1awatGh+783+1nLO6LLl7QZl2dU4Wmk9A85sK+MkJmrUlWJMK8
         TRHu4+K61SJOmnfUm4ya3/IcajvfQYbQ79zAFEeeu6W9IJTjhEvk5nh15iboQ/wGTMaf
         5QjJvoojXjz449lXHAcAsWBtZVDd4RJnqX/wgE8Yp6F9+m5kYUmnb7fSAXbnTsHVWstD
         tpvENKw3ez5w6WoYBNRjAoNU5Dj5DJZXpB3/67rZFjiHWc4SQjL6AnFg2OMihpRLGQ7B
         gbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FF+t4OfbpbPXQydk92H3dHyz9qzlzYP9A0YiDR+Zrp4=;
        b=JYQpD91pAo9dlavRbHEVJj037jykWM9RqpyBmQxfiIVFZCQkO4tCQpyn+8jlv7avUs
         LhQdjdoAKcm8lLQq2EBYbRSwllcpmjPcno6Us8Jl91U2SuaPULoneMd32afLYv0R7nTL
         3U6/2XM0dRPiY/CVh0UVNqLCOk3EhhLal5f1sMXyW7+sznB0StvmehjCIWreazVy4aCn
         aUFo3NdZNcSpYXhVNZV0IqCHUbO3QZp/49+ox0jRts7wdE4G4yKS7o3Trvb0qGtETeg+
         nffrsmxGz/+gtXe2TReXSdq3waGivCcfjp4gd4iDACLGlXhh6Bi2bOHHo6bcmbSOTsfH
         GGeQ==
X-Gm-Message-State: APjAAAWKU/jevA4+oYrkqYyZwhr4VCNtCvi2eQNrGr22Izas/xr+gNer
        CxzOjvNaUiMZaQep0DNSrBA=
X-Google-Smtp-Source: APXvYqzEzXsJoI3psN7SGb0fuqOoaUnY2iJI3t6Aq5SFnCKzdy+WBtSTfPJ6Wh29XUp6lD6gDLQfZg==
X-Received: by 2002:a62:8246:: with SMTP id w67mr39913715pfd.226.1565670946206;
        Mon, 12 Aug 2019 21:35:46 -0700 (PDT)
Received: from [10.0.2.15] ([122.163.110.75])
        by smtp.gmail.com with ESMTPSA id q69sm530641pjb.0.2019.08.12.21.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 21:35:45 -0700 (PDT)
Subject: Re: [PATCH] bus: ti-sysc: Remove if-block in sysc_check_children()
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com,
        linux-kernel@vger.kernel.org, "Kristo, Tero" <t-kristo@ti.com>
References: <20190808074042.15403-1-nishkadg.linux@gmail.com>
 <2038cdcd-1506-84c6-520d-6dda50d4f317@ti.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <a1f56fcc-2207-fa32-83bc-cd219c2b893c@gmail.com>
Date:   Tue, 13 Aug 2019 10:05:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2038cdcd-1506-84c6-520d-6dda50d4f317@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/19 7:25 PM, Roger Quadros wrote:
> Nishka,
> 
> On 08/08/2019 10:40, Nishka Dasgupta wrote:
>> In function sysc_check_children, there is an if-statement checking
>> whether the value returned by function sysc_check_one_child is non-zero.
>> However, sysc_check_one_child always returns 0, and hence this check is
>> not needed. Hence remove this if-block.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
>>   drivers/bus/ti-sysc.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
>> index e6deabd8305d..bc8082ae7cb5 100644
>> --- a/drivers/bus/ti-sysc.c
>> +++ b/drivers/bus/ti-sysc.c
>> @@ -637,8 +637,6 @@ static int sysc_check_children(struct sysc *ddata)
>>   
>>   	for_each_child_of_node(ddata->dev->of_node, child) {
>>   		error = sysc_check_one_child(ddata, child);
>> -		if (error)
>> -			return error;
> 
> We cannot assume that sysc_check_one_child() will never return error in the future.
> If it can never return an error then why does it have an int return type?

I'm not sure why it has an int return type, unfortunately. This is the 
function in its entirety:

static int sysc_check_one_child(struct sysc *ddata,
				struct device_node *np)
{
	const char *name;

	name = of_get_property(np, "ti,hwmods", NULL);
	if (name)
		dev_warn(ddata->dev, "really a child ti,hwmods property?");

	sysc_check_quirk_stdout(ddata, np);
	sysc_parse_dts_quirks(ddata, np, true);

	return 0;
}

I'm not sure how to understand this function. Do dev_warn() or 
sysc_check_quirk_stdout() or sysc_parse_dts_quirks() cause a non-zero 
return from sysc_check_one_child()? Should I drop my patch?

Thanking you,
Nishka
> 
>>   	}
>>   
>>   	return 0;
>>
> 
> cheers,
> -roger
> 

