Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE21EC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B9420727
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh9JCCcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfKQPOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 10:14:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44471 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfKQPOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 10:14:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id az9so8172904plb.11;
        Sun, 17 Nov 2019 07:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ohIww/0HlLZvHNlD7QGqumPEU6d625wQgkeBIpVoTF8=;
        b=Sh9JCCcgFUBuQzANZRUtv3exuxaNHn42FMioYvi6veXrHYrefVqkGbTVDRZoU4vAoA
         /7T5QOHkKGuedZlNhyCQtdB3ePddOAdYXaFsYKaiYKSjJVUDLFuCtAYmwpduFgXvGF+K
         aiwTfmwxOvnRw94LOpaSuKhdVD3MRY08GYoMcoRMUBCNSM3Fc7ULkvFtjNtmsQgkeJ/8
         mXdCUrJk6QnNxQZsg3yvtkLpBwdCkrhBM2debyKjAZcg5yfwbeSeNJNhhaHrYNZ/akmS
         iRvjSj1CZq/Hg6OCgwxP03Lt69fjR7vlUjpUgij3lwAAW2FBKYuJm3ZU8iCQxcTZOnJC
         JIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohIww/0HlLZvHNlD7QGqumPEU6d625wQgkeBIpVoTF8=;
        b=Bcj8UYS+LGYBhXRcSA3s42by5OBMvq+I9nbFSwa2fbeGLx+NA+gmqUu1TUc0rEKmF4
         7E2e3O1iQPr4YFvCq+gV2MS89Dr+SI4Qjmmq4GRAcaJvqueDvXlDQAbKBuMYy12V3UJc
         DemrMGVArkJxTIGCw84syQuxkTUeN3x6fFBBI3f/uCAGcL8tDvNie4VodRBPE62Q24Nk
         m+CCt3EVXIkVguKhR4kY0u0GhkbDHBhkYArS2byWFetXjqWZjf3Up0Ig/IK4s82w0AcS
         GlY1ElZeET38iz52NnnTg6kwfADD1QySV/lCdBN/r2/o2OGgGyAzosnAlnN0c5kVkDcb
         y3Kw==
X-Gm-Message-State: APjAAAU4uyKuwYPogltWxJtl9d871Jms1zGG7Eur8qU4NqwF8Yxig09t
        B+aWNJ6X3nDc1U6VWcQJZ282J2y/
X-Google-Smtp-Source: APXvYqwNVG2PifjveIwAxehVwyOe+yLO5axkZPjfLvUWL+n0Zbj3+JFoEYntuJB4sjsrmE97u41E2w==
X-Received: by 2002:a17:90a:1b69:: with SMTP id q96mr33454663pjq.89.1574003658972;
        Sun, 17 Nov 2019 07:14:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i123sm22468546pfe.145.2019.11.17.07.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 07:14:17 -0800 (PST)
Subject: Re: [PATCH v3] dell-smm-hwmon: Add support for disabling automatic
 BIOS fan control
To:     Giovanni Mascellani <gio@debian.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191116173610.208358-1-gio@debian.org>
 <3a10f96a-06e1-39f4-74a6-908d25b1f496@roeck-us.net>
 <371da137-6073-00f4-7520-c990da6be40e@debian.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <280fd587-fb59-f52e-015b-b9b534c44794@roeck-us.net>
Date:   Sun, 17 Nov 2019 07:14:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <371da137-6073-00f4-7520-c990da6be40e@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/19 12:02 AM, Giovanni Mascellani wrote:
> Hi,
> 
> Il 16/11/19 23:08, Guenter Roeck ha scritto:
>>> +    mutex_lock(&i8k_mutex);
>>> +    err = i8k_enable_fan_auto_mode(enable);
>>> +    mutex_unlock(&i8k_mutex);
>>> +
>>> +    return err ? -EIO : count;
>>
>> Why override the error code ? i8k_enable_fan_auto_mode()
>> can return -EINVAL.
>>
>> I can see that the rest of the driver has the same bad habit,
>> but that is not a reason to continue it.
> 
> Ok, I thought it was the appropriate thing to do just because it was
> done elsewhere. If it's not a good idea, do you think a patch removing
> the other instances of this construct would be appropriate?
> 

In general it is never a good idea to override error codes. "I have seen
it elsewhere" is vener a good argument - you'll find examples for everything
in the Linux kernel.

As for fixing up the other instances in this driver, sure, if you feel like
it, but that would have to be a separate patch.

>>> +}
>>> +
>>>    static SENSOR_DEVICE_ATTR_RO(temp1_input, i8k_hwmon_temp, 0);
>>>    static SENSOR_DEVICE_ATTR_RO(temp1_label, i8k_hwmon_temp_label, 0);
>>>    static SENSOR_DEVICE_ATTR_RO(temp2_input, i8k_hwmon_temp, 1);
>>> @@ -749,12 +794,15 @@ static SENSOR_DEVICE_ATTR_RO(temp10_label,
>>> i8k_hwmon_temp_label, 9);
>>>    static SENSOR_DEVICE_ATTR_RO(fan1_input, i8k_hwmon_fan, 0);
>>>    static SENSOR_DEVICE_ATTR_RO(fan1_label, i8k_hwmon_fan_label, 0);
>>>    static SENSOR_DEVICE_ATTR_RW(pwm1, i8k_hwmon_pwm, 0);
>>> +static SENSOR_DEVICE_ATTR_WO(pwm1_enable, i8k_hwmon_pwm_enable, 0);
>>>    static SENSOR_DEVICE_ATTR_RO(fan2_input, i8k_hwmon_fan, 1);
>>>    static SENSOR_DEVICE_ATTR_RO(fan2_label, i8k_hwmon_fan_label, 1);
>>>    static SENSOR_DEVICE_ATTR_RW(pwm2, i8k_hwmon_pwm, 1);
>>> +static SENSOR_DEVICE_ATTR_WO(pwm2_enable, i8k_hwmon_pwm_enable, 0);
>>>    static SENSOR_DEVICE_ATTR_RO(fan3_input, i8k_hwmon_fan, 2);
>>>    static SENSOR_DEVICE_ATTR_RO(fan3_label, i8k_hwmon_fan_label, 2);
>>>    static SENSOR_DEVICE_ATTR_RW(pwm3, i8k_hwmon_pwm, 2);
>>> +static SENSOR_DEVICE_ATTR_WO(pwm3_enable, i8k_hwmon_pwm_enable, 0);
>>
>> Having three attributes do all the same is not very valuable.
>> I would suggest to stick with pwm1_enable and document that it applies
>> to all pwm channels.
> 
> I had no idea what is the convention here. No problem changing this thing.
> 
>>> @@ -1200,6 +1291,14 @@ static int __init i8k_probe(void)
>>>        i8k_fan_max = fan_max ? : I8K_FAN_HIGH;    /* Must not be 0 */
>>>        i8k_pwm_mult = DIV_ROUND_UP(255, i8k_fan_max);
>>>    +    fan_control = dmi_first_match(i8k_whitelist_fan_control);
>>> +    if (fan_control && fan_control->driver_data) {
>>> +        const struct i8k_fan_control_data *fan_control_data =
>>> fan_control->driver_data;
>>> +        manual_fan = fan_control_data->manual_fan;
>>> +        auto_fan = fan_control_data->auto_fan;
>>> +        pr_info("enabling experimental BIOS fan control support\n");
>>
>> That isn't entirely accurate. What this enables is the ability
>> to select automatic or manual fan control.
> 
> Hmm, it sounds right to me: there is a feature which is "BIOS fan
> control" and this driver can "support" it or not, i.e., be aware of it
> and interact with it or not. And all of this is "experimental". The

"experimental" is fine, and I understand that those involved in this
exchange are aware what the message means. It does, however, not help
others not involved.

> wording seems to capture this to me. However, no problem with changing
> it. How would "enabling support for setting automatic/manual fan
> control" work? Can you suggest a wording?
> 

"enabling experimental support for ... " sounds good to me.

Thanks,
Guenter

> Thanks, Giovanni.
> 

