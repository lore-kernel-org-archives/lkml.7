Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3F4C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C360206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/Rwk20/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfEGRoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:44:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36442 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfEGRoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:44:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so5070859wmj.1;
        Tue, 07 May 2019 10:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lUKp27BYghRFZlVQjWKYNq5xXwlaTl/g5v0aaJBgwTE=;
        b=N/Rwk20/d0z+lJ/SYOB3r4fZyUGg4c9PYvUROLW6ERBQUcE8hy4+5nMxlPL2AqrD4L
         iHQpz7zUFU+6lItyQiqYzCnQ3gQXcV3KcEuXtk9RvNU//oVr/EZf/49miI1CICcwmzO6
         snNCogOkdeNcHKQMhTfd4yVkVADVrRHChnyxvwyF+M+WZ5REwR105tJFqOYwCY5eYy//
         VsEKwPjSpNWHoWi+Avb+lC4EzTIyzh588SRGM1gdTDSYhwZ2Hj9xGfqQXC3Zkrxu4YdF
         sMIFsAwia6RupApOVdCdEIVB1pDx1OWf08kwXiY6FcV0TFZbYP/pMGam35Kf6ksFXIXn
         pf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lUKp27BYghRFZlVQjWKYNq5xXwlaTl/g5v0aaJBgwTE=;
        b=nMzabgzmKPbZxdfq4j1UoJky5fH8B7HG5+ICDzYs9Pr2Qpa/LGfT1ezO8u76RsBySg
         y83vYLzm80UNZjpwYi/ItqYGQ7UCjYNJtFui2W7bXqpXbl+nj4UW0413qU+yJISmzFDO
         G1rR6wfa1+rzo8x5eidxzQ8Jac7zXgPz3XfV/nMpVClAibG50UJwAw1lqrGL7d2Es3cu
         9lgSi+ZN0t5xqlZak1uiHasSvBNTjax+E6JW1nBj3cnU/PfNXmsM5z4NBFkjQc3+OL+u
         8r8Kx1oCNe7d94+0lZ9fhLxdDhoYT6B3UPAlg+RojtJdy0BYz180u4/DOgWoGFiFGUBc
         DMlA==
X-Gm-Message-State: APjAAAUh9ykc1QnNYoz7hndF7GGZ1PJL820ZGMzTdicr8DYgfiRXMHv9
        kpes5In9sMa66u3j0tF1cHOC7jI+
X-Google-Smtp-Source: APXvYqxISjMORMPGMj/gciHjL6Sz+7BbJZ8TY9WXHEx/1MzUhmiU8JCIYId7wK/dOmuQl8g9rDpnBw==
X-Received: by 2002:a05:600c:114e:: with SMTP id z14mr7464310wmz.92.1557251049643;
        Tue, 07 May 2019 10:44:09 -0700 (PDT)
Received: from [10.67.49.27] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id v12sm12446985wrw.23.2019.05.07.10.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:44:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] hwmon: scmi: Scale values to target desired HWMON
 units
To:     Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
References: <20190506224109.9357-1-f.fainelli@gmail.com>
 <20190506224109.9357-3-f.fainelli@gmail.com>
 <a4dd5f4f-af12-8783-c612-cf3e88a9b94f@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <e67efa2b-813c-c9f3-8f3d-b32c1b61ebc8@gmail.com>
Date:   Tue, 7 May 2019 10:44:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a4dd5f4f-af12-8783-c612-cf3e88a9b94f@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/19 6:55 AM, Guenter Roeck wrote:
> Hi Florian,
> 
> On 5/6/19 3:41 PM, Florian Fainelli wrote:
>> If the SCMI firmware implementation is reporting values in a scale that
>> is different from the HWMON units, we need to scale up or down the value
>> according to how far appart they are.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   drivers/hwmon/scmi-hwmon.c | 55 +++++++++++++++++++++++++++++++-------
>>   1 file changed, 46 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
>> index a80183a488c5..e9913509cb88 100644
>> --- a/drivers/hwmon/scmi-hwmon.c
>> +++ b/drivers/hwmon/scmi-hwmon.c
>> @@ -18,6 +18,51 @@ struct scmi_sensors {
>>       const struct scmi_sensor_info **info[hwmon_max];
>>   };
>>   +static enum hwmon_sensor_types scmi_types[] = {
>> +    [TEMPERATURE_C] = hwmon_temp,
>> +    [VOLTAGE] = hwmon_in,
>> +    [CURRENT] = hwmon_curr,
>> +    [POWER] = hwmon_power,
>> +    [ENERGY] = hwmon_energy,
>> +};
>> +
>> +static u64 scmi_hwmon_scale(const struct scmi_sensor_info *sensor,
>> u64 value)
>> +{
>> +    u64 scaled_value = value;
> 
> I don't think that variable is necessary.
> 
>> +    s8 desired_scale;
> 
> Just scale ? Also, you could assign scale here directly, and subtract
> the offset below. Then "n" would not be necessary.
> Such as
>     s8 scale = sensor->scale;    // assuming scale is s8
>     ...
>     case CURRENT:
>         scale += 3;
>     ...
> 
> That would also be less confusing, since it would avoid the double
> negation.
> 
>> +    int n, p;
> 
>> +
>> +    switch (sensor->type) {
>> +    case TEMPERATURE_C:
>> +    case VOLTAGE:
>> +    case CURRENT:
>> +        /* fall through */
> Unnecessary comment

Is not removing the comment going to upset gcc when using
-Wimplicit-fallthrough?

> 
>> +        desired_scale = -3;
>> +        break;
>> +    case POWER:
>> +    case ENERGY:
>> +        /* fall through */
> Unnecessary comment.
> 
>> +        desired_scale = -6;
>> +        break;
>> +    default:
>> +        return scaled_value;
> 
> Here we presumably want a scale of 0. However, if the scale passed
> from SCMI is, say, -5 or +5, we return the original (unadjusted)
> value. Seems to me we would still want to adjust the value to match
> hwmon expectations. Am I missing something ?

You raise a valid point, not that could happen today because if the
sensor type has a value we don't recognize, we have not registered it,
so we would not even try to read rom it, but let's be future proof.

> 
>> +    }
>> +
>> +    n = (s8)sensor->scale - desired_scale;
>> +        if (n == 0)
> 
> Indentation seems off here.
> 
>> +                return scaled_value;
>> +
>> +    for (p = 0; p < abs(n); p++) {
>> +        /* Need to scale up from sensor to HWMON */
>> +        if (n > 0)
>> +            scaled_value *= 10;
>> +        else
>> +            do_div(scaled_value, 10);
>> +    }
> 
> Something like
> 
>     factor = pow10(abs(scale));
>     if (scale > 0)
>         value *= factor;
>     else
>         do_div(value, factor);
> 
> would avoid the repeated abs() and do_div(). Unfortunately there is
> no pow10() helper, so you would have to write that. Still, I think
> that would be much more efficient.

Sounds reasonable. Thanks for your feedback!
-- 
Florian
