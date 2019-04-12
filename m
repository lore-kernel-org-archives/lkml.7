Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC0FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCEF2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNn/sMRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfDLO3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:29:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37655 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfDLO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:29:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so5226913ply.4;
        Fri, 12 Apr 2019 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vASg5JkI2W0DXNvLU0zD/DEqrNgshrSx1kIECTH27ws=;
        b=UNn/sMRWO1iRzHVK73BK17JVxmNrwNvvklz3obwUfUxNmXav8kD0ePMAVNvTMu55na
         Qlt2z1ayDwKQWlQ7LA4AqStY2KCVR5Iabj6MBBgR/PSzrjCswX886ACNRGxfbnfRo/7L
         lD41/gnVqw0iFRN4DOkNfW2TR7nfawlpaze1sbv/hhwp/nv6qGZ6ku1TXxa6YehV5Kej
         /RTNaiCJvN0PWthUG/92qEkV0nE6mrTrm6SV2CaO/7cYuEtuQTzazBlcGlOd3jKTkYCa
         lOW5MG/gPfmwEQ9vYYEuPFOPsPgStULIExGvYXSBOObxg3YGeOTyZuU+A10GNZ7uHcAi
         5OTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vASg5JkI2W0DXNvLU0zD/DEqrNgshrSx1kIECTH27ws=;
        b=ZBFw0u7+lKkSgyvk2xLi2/mqcA1lYlDDXse2wx+MtGfcrczangsTstVyqYHGQCvEeG
         /in94aLHIUzK4LKhzXeaytVrPxRFF9lSQ0dCc0syAiCOVURlAwygVisEl6+nMbKU4Ww7
         xG9l9QZ5s4+Hf9AVD/7RU0DBFx62JzuAyfpSFf63la7fI3J2uo5TvfrSpE3zMiRjnXbX
         M3sHl1jp9Ien20zImyr/qvA4lhXlw5751UYEEGoqsGY/MuYurXwdrpC4KWJ96T1LaJKF
         2pCqGoLsdE3iAJCEpGEpzQDKdOtMAjTzqgpVJVi9KIDgoeXDJeByXYMrDv0pz5MguiF0
         DbYQ==
X-Gm-Message-State: APjAAAXYAPBvCK2nBOFZ5v/ZU9q9Sb74tk5c/u+Hok12RcZ0gU8luczB
        fvMvY3lEJz+NpbtiNx9fb3/3hioJ
X-Google-Smtp-Source: APXvYqzNju7gpPlzfagkh2aODJUl6KrPERaiO0okdDz3Gwdr2ak3mGnbQpZJVE8/+YjMEJ0A1w4zvg==
X-Received: by 2002:a17:902:d83:: with SMTP id 3mr33457160plv.125.1555079348555;
        Fri, 12 Apr 2019 07:29:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k14sm90412480pfb.125.2019.04.12.07.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:29:06 -0700 (PDT)
Subject: Re: [PATCH V5 3/3] hwmon: pwm-fan: Add RPM support via external
 interrupt
To:     Robin Murphy <robin.murphy@arm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
 <1554989411-23666-4-git-send-email-stefan.wahren@i2se.com>
 <20190411165742.GA29395@roeck-us.net>
 <019733e8-6b12-f5c1-e251-fd7eabe2891b@i2se.com>
 <77c56129-d3e7-1518-9d1d-a15a20540269@arm.com>
 <cfde0244-1faf-80cd-b49e-500654e5bad8@roeck-us.net>
 <19616839-f78f-a15f-c7b7-7ef9e7817140@arm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c9616343-baa0-8bda-9190-720bc08eda88@roeck-us.net>
Date:   Fri, 12 Apr 2019 07:29:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <19616839-f78f-a15f-c7b7-7ef9e7817140@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 6:54 AM, Robin Murphy wrote:
> On 12/04/2019 14:50, Guenter Roeck wrote:
>> On 4/12/19 4:50 AM, Robin Murphy wrote:
>>> On 12/04/2019 12:07, Stefan Wahren wrote:
>>>> On 11.04.19 18:57, Guenter Roeck wrote:
>>>>> On Thu, Apr 11, 2019 at 03:30:11PM +0200, Stefan Wahren wrote:
>>>>>> -ATTRIBUTE_GROUPS(pwm_fan);
>>>>>> +static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
>>>>>> +                     int n)
>>>>>> +{
>>>>>> +    struct device *dev = container_of(kobj, struct device, kobj);
>>>>>> +    struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>>>>>> +    struct device_attribute *devattr;
>>>>>> +
>>>>>> +    /* Hide fan_input in case no interrupt is available  */
>>>>>> +    devattr = container_of(a, struct device_attribute, attr);
>>>>> Field day for static analyzers - devattr is no longer used.
>>>>> No need to resend. I'll let the series rest for a couple of days
>>>>> and then apply to hwmon-next (after removing devattr) unless there are
>>>>> additional comments.
>>>>>
>>>> Thank you
>>>
>>> FWIW you can have a
>>>
>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>>
>>> for the whole series. The only minor comment that springs to mind
>>> isn't actually specific to this patch, so is probably best made as
>>> the follow-up below.
>>>
>>> Robin.
>>>
>>
>> Any chance you can send the patch below as separate patch ? I track patches
>> using patchwork, and attachments don't show up there.
> 
> Sure, can do - would you like an explicit R-b on #1 and #2 here for patchwork to pick up as well?
> That would simplify my life a bit, but I can add that part myself to the patches.
I primarily like to have the patches in patchwork to make sure they don't get lost
and that I can pick them up again later if needed.

Thanks,
Guenter

> Robin.
> 
>>
>> Thanks,
>> Guenter
>>
>>> ----->8-----
>>> From: Robin Murphy <robin.murphy@arm.com>
>>> Subject: [PATCH] hwmon: pwm-fan: Report probe errors consistently
>>>
>>> Printing the error code for a failure provides a head-start for
>>> debugging, since it's often sufficient to pinpoint the origin of the
>>> failure. We already do this for some probe-failure messages, so let's
>>> make the rest of them consistent.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/hwmon/pwm-fan.c | 13 ++++++++-----
>>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
>>> index 8c4c5eefd4ca..556db4bef743 100644
>>> --- a/drivers/hwmon/pwm-fan.c
>>> +++ b/drivers/hwmon/pwm-fan.c
>>> @@ -330,7 +330,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>>>
>>>       ret = pwm_apply_state(ctx->pwm, &state);
>>>       if (ret) {
>>> -        dev_err(&pdev->dev, "Failed to configure PWM\n");
>>> +        dev_err(&pdev->dev, "Failed to configure PWM: %d\n", ret);
>>>           goto err_reg_disable;
>>>       }
>>>
>>> @@ -348,7 +348,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
>>>           ret = devm_request_irq(&pdev->dev, ctx->irq, pulse_handler, 0,
>>>                          pdev->name, ctx);
>>>           if (ret) {
>>> -            dev_err(&pdev->dev, "Can't get interrupt working.\n");
>>> +            dev_err(&pdev->dev,
>>> +                "Failed to request interrupt: %d\n", ret);
>>>               goto err_pwm_disable;
>>>           }
>>>           ctx->sample_start = ktime_get();
>>> @@ -358,8 +359,9 @@ static int pwm_fan_probe(struct platform_device *pdev)
>>>       hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
>>>                                  ctx, pwm_fan_groups);
>>>       if (IS_ERR(hwmon)) {
>>> -        dev_err(&pdev->dev, "Failed to register hwmon device\n");
>>>           ret = PTR_ERR(hwmon);
>>> +        dev_err(&pdev->dev,
>>> +            "Failed to register hwmon device: %d\n", ret);
>>>           goto err_del_timer;
>>>       }
>>>
>>> @@ -373,9 +375,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
>>>                                 "pwm-fan", ctx,
>>>                                 &pwm_fan_cooling_ops);
>>>           if (IS_ERR(cdev)) {
>>> -            dev_err(&pdev->dev,
>>> -                "Failed to register pwm-fan as cooling device");
>>>               ret = PTR_ERR(cdev);
>>> +            dev_err(&pdev->dev,
>>> +                "Failed to register pwm-fan as cooling device: %d\n",
>>> +                ret);
>>>               goto err_del_timer;
>>>           }
>>>           ctx->cdev = cdev;
>>>
>>
> 

