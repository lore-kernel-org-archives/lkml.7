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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B54C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DE4206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOnfWH7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfHMHho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:37:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36498 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfHMHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:37:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so50802648pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9bL0R1CxC+6qn/SXYb8QC8YPxi7C0X8KV0QY0awgnqs=;
        b=TOnfWH7iCQfqZdPtJYvcaU1bpkVbRTBH0X1zYgXX/CPoG9/HYmr1u3RRMLoEdoJlPI
         YhippxdT7Aap5SalLXDSkiTxYjkgUDnTYO6SWZpiygm0VRin7KIblU7Bef1rf5yiZFKf
         vZeqVccUOZ7q5t6N8ZNzzhHz05Z06gcD6+svkhIDX0VWRRRFWhvhJJqm/vsP85k1M3o8
         FmOvY13kaBIhAPJAihiz9Bopu3cJqT6kFDfXpcGDY2gb00pNXewRG+a7WEgn2S+76hm+
         2VgI/r6Ael1eFPLVvIwsMJbSUDrPp/M5HPc2+2GnT7uDGcGaz76nQetnFafAe+sB/NIO
         8zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9bL0R1CxC+6qn/SXYb8QC8YPxi7C0X8KV0QY0awgnqs=;
        b=IEmD17eWj2PVIiDoVyulgQ3Fb9W9orAyPaYOeCtVt2e+oyV/wAhotk5lZJnDId/vJ5
         jF7iD1aXSdcTuzyljVUtNkE9t1ynrj7BVzR2TPPoHxsEfH4j60OPbhDSHRqJZAx4uXKP
         11OSRV21CHkiV8O4q/n83JVqcvlaISDuXSzGtPZJ55U1M0qLOZX/nbQPBTh21sevnmFL
         q4PllEuEd8Zxi6jV9yAgDmTv4kGiR0n3wmkIy3XjMm4+A//BwCmh9OvKiwlbbP3/RFsx
         +ycHdANcc7e4yBD2KWk+kDYFKDwYylQ+0a5E2YZEbwNtdKMUVxN2fNzfafHYkRXQETNX
         zXzA==
X-Gm-Message-State: APjAAAWF8NCULEYRVXF3KODHI0Um4Njj4OfmtigJLye9q4dv/+qkRo9+
        4+VZNm6WH+IuZsb9pHFzN5RlK3IO
X-Google-Smtp-Source: APXvYqyPkxZNFAo0ne81beBuI7oPlOK6YuTRXBDvKbvyzprdjTOUi5Dqb8HgeLMTgEX+y81FU4bU3Q==
X-Received: by 2002:a17:90a:8688:: with SMTP id p8mr981605pjn.57.1565681863098;
        Tue, 13 Aug 2019 00:37:43 -0700 (PDT)
Received: from [10.0.2.15] ([122.163.110.75])
        by smtp.gmail.com with ESMTPSA id j6sm2885460pje.11.2019.08.13.00.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 00:37:42 -0700 (PDT)
Subject: Re: [PATCH v2] bus: ti-sysc: sysc_check_one_child(): Change return
 type to void
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com,
        linux-kernel@vger.kernel.org
References: <20190813071714.27970-1-nishkadg.linux@gmail.com>
 <85a1d7eb-dd9a-2276-ed13-67291188538e@ti.com>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <5285a1f4-644c-9e97-6e1c-9b3e66948dca@gmail.com>
Date:   Tue, 13 Aug 2019 13:07:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <85a1d7eb-dd9a-2276-ed13-67291188538e@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/19 12:58 PM, Roger Quadros wrote:
> 
> 
> On 13/08/2019 10:17, Nishka Dasgupta wrote:
>> Change return type of function sysc_check_one_child() from int to void
>> as it always returns 0. Accordingly, at its callsite, delete the
>> variable that previously stored the return value.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
>> Changes in v2:
>> - Remove error variable entirely.
>> - Change return type of sysc_check_one_child().
>>
>>   drivers/bus/ti-sysc.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
>> index e6deabd8305d..1c30fa58d70c 100644
>> --- a/drivers/bus/ti-sysc.c
>> +++ b/drivers/bus/ti-sysc.c
>> @@ -615,8 +615,8 @@ static void sysc_check_quirk_stdout(struct sysc *ddata,
>>    * node but children have "ti,hwmods". These belong to the interconnect
>>    * target node and are managed by this driver.
>>    */
>> -static int sysc_check_one_child(struct sysc *ddata,
>> -				struct device_node *np)
>> +static void sysc_check_one_child(struct sysc *ddata,
>> +				 struct device_node *np)
>>   {
>>   	const char *name;
>>   
> 
> You didn't remove the "return 0" at end of this function.
> Doesn't it complain during build?
> 
>> @@ -633,12 +633,9 @@ static int sysc_check_one_child(struct sysc *ddata,
>>   static int sysc_check_children(struct sysc *ddata)
>>   {
> 
> This could return void as well.

Okay. Sorry for the errors; I'll fix-up and resend.

However, while building it, I'm running into a compilation problem:
on line 764 (function sysc_ioremap) there is apparently an "undeclared 
variable", "SZ_1K". Is it a problem with the architecture? What arch 
should I compile it with?

Thanking you,
Nishka

> 
>>   	struct device_node *child;
>> -	int error;
>>   
>>   	for_each_child_of_node(ddata->dev->of_node, child) {
>> -		error = sysc_check_one_child(ddata, child);
>> -		if (error)
>> -			return error;
>> +		sysc_check_one_child(ddata, child);
>>   	}
> 
> You don't need the braces { }.
> 
> Please run ./scripts/checkpatch.pl --strict on your patch and fix any
> issues.
> 
>>   
>>   	return 0;
>>
> 
> return not required.
> 
> You will also need to fix all instances using sysc_check_children()
> 
> cheers,
> -roger
> 

