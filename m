Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED84DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC69120989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xbkzd+ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEGXVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:21:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34577 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:21:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck18so8929218plb.1;
        Tue, 07 May 2019 16:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+gKSlDLnDf/+lOEDDP2Iyq5/Ag+VeBN4xDo4/a6mcWE=;
        b=Xbkzd+ahKjnjPuFAeJ37rdP601/YT/yiEItlz9avQ/dyh/XWESKqPiRwDStmiiMvOB
         yIbAu0kjJffnXj83mXIhvtoAvPuBeDL21aBao0UMDM6GwGxMg6pxXEai8S5jTy87lCOy
         lTjsmDHTpCxdOAwy0O1gSpsX7pqajG+2dsaKCHBE60KaiGL0qGelg+ndUkbEW7gbuAdF
         cRC3CyIckZrtNlcgBvirZER8mKrAb2eUPtIM6feMx6wHd5BbQMYf4YL0+m0X/t4+JccH
         7Y4GE6iRpuhUkhoJpThYZPslQnXvaKYKfWxTT6rCbvQkXdzeqzpt5w2kdNRNMdkKfLK1
         PFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+gKSlDLnDf/+lOEDDP2Iyq5/Ag+VeBN4xDo4/a6mcWE=;
        b=jTzZPtR2/JBPYHUoWv8sp0DZM5ajA+rx4BtMjI/h2m+sTjTGZtXJQcsN2AtBXihYtR
         ZT5GHS/oW+HrtFH0YLUgL0bGNzgcSBCoSg0JBGwfAu6TjRzAZ993X9GBdEINwEBkFM+N
         LMKTgBC6a0nIQBDftNB0O1+VWKuBguXyuEBMq4L8fBmQz5GFtYfSNbXQ/fPxs6UL6PTb
         z/CK43CMryjnP67882HBdogRj4nlehg87UM9C2RYRVt9rdV2r/cT80ccslGOdXahGOmp
         IkH/18oezreC/9/3KeCg9hBndWttttMsxPECSgOJ078HqdlXqQZFOu474caBvIWMw61h
         OJbw==
X-Gm-Message-State: APjAAAUk9LIkXxO3uB5k+o+RwSpn5o/Mm45VbPFYIhtPBeuISoxXfemG
        U11MCvTAHdPP9SYEClQkTnZahL2/
X-Google-Smtp-Source: APXvYqz93rUWqPle/G8Op3EXe4WndFHGalqvrnzO565qJxS6Yp9F+7od8crkk6C0Mm0UtjfR6LV7rA==
X-Received: by 2002:a17:902:b40b:: with SMTP id x11mr44424746plr.265.1557271265376;
        Tue, 07 May 2019 16:21:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g128sm20055716pfb.131.2019.05.07.16.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 16:21:03 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] kernel: Provide a __pow10() function
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
References: <20190507193504.28248-1-f.fainelli@gmail.com>
 <20190507193504.28248-2-f.fainelli@gmail.com>
 <20190507210654.GA4951@roeck-us.net>
 <b3c4fdd3-0c91-9681-e471-a9ddbbd256c8@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9c9d44ea-1cd2-0705-5d0f-b05af0682f90@roeck-us.net>
Date:   Tue, 7 May 2019 16:21:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b3c4fdd3-0c91-9681-e471-a9ddbbd256c8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 2:49 PM, Florian Fainelli wrote:
> On 5/7/19 2:06 PM, Guenter Roeck wrote:
>> On Tue, May 07, 2019 at 12:35:02PM -0700, Florian Fainelli wrote:
>>> Provide a simple macro that can return the value of 10 raised to a
>>> positive integer. We are going to use this in order to scale units from
>>> firmware to HWMON.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>   include/linux/kernel.h | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>>> index 2d14e21c16c0..62fc8bd84bc9 100644
>>> --- a/include/linux/kernel.h
>>> +++ b/include/linux/kernel.h
>>> @@ -294,6 +294,17 @@ static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
>>>   	return (u32)(((u64) val * ep_ro) >> 32);
>>>   }
>>>   
>>> +/* Return in f the value of 10 raise to the power x */
>>> +#define __pow10(x, f)(					\
>>> +{							\
>>> +	typeof(x) __x = abs(x);				\
>>> +	f = 1;						\
>>> +	while (__x--)					\
>>> +		f *= 10;				\
>>> +	f;						\
>>> +}							\
>>> +)
>>
>> Kind of unusual. I would have expected to use this like
>> 	f = __pow10(x);
>> ie without having to provide f as parameter. That would be much less
>> confusing. I assume this is to make the result type independent, but
>> I am not sure if that is worth the trouble.
> 
> Correct, that was the intent here.
> 
>>
>> Are there users outside the hwmon code ? If not, it might be simpler
>> to keep it there for now.
> 
> There appears to be a few outside actually:
> 
> drivers/acpi/sbs.c::battery_scale
> drivers/iio/common/hid-sensors/hid-sensor-attributes.c::pow_10
> 
> There could be others but those two came out as obvious candidates.
> 
> Would you be okay with a local pow10 function within scmi-hwmon.c and a
> subsequent patch series providing a common function?
> 

I would prefer that, actually, to reduce dependencies.

Thanks,
Guenter
