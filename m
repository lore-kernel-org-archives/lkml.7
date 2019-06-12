Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BITCOIN_SPAM_02,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF2AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A1D206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560445373;
	bh=5Vu+qIakj6K13EA6KsH9d6NLQoT/91Tkr/3Jblfzyy4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=T8DELg1AXbFQNUw7b/LrZ1niWMaXqqgSYSYU6iPpDXwt95jxposTH7l/JTRxTBZxq
	 Sgo82ij7RqVZqM/1d0GqiM2h/0eDaQp4GjEWyKkeqdkXm+RzEOyna1G7t+5aaXuX1E
	 eIDrmNwjJZxQVkjB60AOOKFqK258PaDt0sl/9YJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfFMRCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:02:52 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55565 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbfFLXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:04:16 -0400
Received: by mail-it1-f195.google.com with SMTP id i21so13659386ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xXTsl9abuCJP4gMkG5zbGPKcEw/zSKuHmG+emo/prKw=;
        b=Y2OL6auF7oqK2mhZntML81cQMd7aEghXbMGNkTISj+me2jhT/RmN+um0VcQm8fKypg
         mqwU7R9MrBBwRFqV51j9wq3FQgaxdm/mYHPDZZwE0jf/EDum3Po5fuGXb0vFulxYkFZL
         nE3dleL5HcgGdE5jWPqNkTye/TUOhHNe7uwKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xXTsl9abuCJP4gMkG5zbGPKcEw/zSKuHmG+emo/prKw=;
        b=O6HHjIDzKkF0H5AA0JC3uRxVDsKg/I38KJA/WBqu2b07GtI4iruZDDQ8BW8WmwXqlR
         4shdyeBV2jNW3YVCi9k/PDUOpsU8ygZC0btVrBf/ZjF9YjKcC6O6zL+9oFS/nVs2cPER
         4odPdzjU90inc0Lbf91J41uFedmE721b0hcg9+sGWI4VQYPZgBd5WzMQdGW8v2RVfAtI
         lLG2LtMx3yM/eeifr6BG1iT5ryjZcMk7xv8kbLmox7b7aHWgVkGYImUfYdQuRmbQpIEW
         aT1oc5/Sr+P+/h3eSYrodNyAEB7SCH88AnMlUv2c4DwXOVnsaZXfQdd4HbmCfbf8OIN4
         Sn7Q==
X-Gm-Message-State: APjAAAWPPs/e3Je0qBmBmR8Ojc8rjCRUOxKXmDzncrtiZNs+STwzdPQD
        R+hz0deFb33NqYCBLpVlF8r0ZQ==
X-Google-Smtp-Source: APXvYqzAChvmhnqCnuAGx0CRA159GDYS6DtCqUXh1HjwHgCtLP+8HSINmvJsYj+qqrL9kOEZnRfmag==
X-Received: by 2002:a02:ccdc:: with SMTP id k28mr8409969jaq.41.1560380655147;
        Wed, 12 Jun 2019 16:04:15 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r185sm558413itd.42.2019.06.12.16.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 16:04:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] media: v4l2-core: Shifting signed 32-bit value by 31
 bits error
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, ezequiel@collabora.com,
        paul.kocialkowski@bootlin.com
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <cover.1559764506.git.skhan@linuxfoundation.org>
 <bac3ee3b10de409b6cdf7286e0e84737e63662ee.1559764506.git.skhan@linuxfoundation.org>
 <8cc03625-f41d-6009-d50c-823e5f498dca@infradead.org>
 <7819cae4-58e5-cbe1-ac9d-bca00d390066@xs4all.nl>
 <d5aea86a-b556-aae4-0b97-9add8878f99f@linuxfoundation.org>
 <6b4654b1-7cd5-8fea-8c08-472ade8f3ebb@xs4all.nl>
 <9f925e72-4d55-0cfc-ace6-dfe69bbc6903@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0dbeb68c-592c-1665-35fb-6b1a3aa98160@linuxfoundation.org>
Date:   Wed, 12 Jun 2019 17:04:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9f925e72-4d55-0cfc-ace6-dfe69bbc6903@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 4:27 PM, Shuah Khan wrote:
> On 6/11/19 2:50 PM, Hans Verkuil wrote:
>> On 6/11/19 9:42 PM, Shuah Khan wrote:
>>> On 6/6/19 12:33 AM, Hans Verkuil wrote:
>>>> On 6/6/19 5:22 AM, Randy Dunlap wrote:
>>>>> On 6/5/19 2:53 PM, Shuah Khan wrote:
>>>>>> Fix the following cppcheck error:
>>>>>>
>>>>>> Checking drivers/media/v4l2-core/v4l2-ioctl.c ...
>>>>>> [drivers/media/v4l2-core/v4l2-ioctl.c:1370]: (error) Shifting 
>>>>>> signed 32-bit value by 31 bits is undefined behaviour
>>>>>>
>>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>>> ---
>>>>>>    drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c 
>>>>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> index 6859bdac86fe..333e387bafeb 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>> @@ -1364,7 +1364,7 @@ static void v4l_fill_fmtdesc(struct 
>>>>>> v4l2_fmtdesc *fmt)
>>>>>>                        (char)((fmt->pixelformat >> 8) & 0x7f),
>>>>>>                        (char)((fmt->pixelformat >> 16) & 0x7f),
>>>>>>                        (char)((fmt->pixelformat >> 24) & 0x7f),
>>>>>> -                    (fmt->pixelformat & (1 << 31)) ? "-BE" : "");
>>>>>> +                    (fmt->pixelformat & BIT(31)) ? "-BE" : "");
>>>>>>                break;
>>>>>>            }
>>>>>>        }
>>>>>>
>>>>>
>>>>> If this builds, I guess #define BIT(x) got pulled in indirectly
>>>>> since bits.h nor bitops.h is currently #included in that source file.
>>>>>
>>>
>>> It does build. You are right that I should have included bitops.h
>>>
>>>>> Documentation/process/submit-checklist.rst rule #1 says:
>>>>> 1) If you use a facility then #include the file that defines/declares
>>>>>      that facility.  Don't depend on other header files pulling in 
>>>>> ones
>>>>>      that you use.
>>>>>
>>>>> Please add #include <linux/bits or bitops.h>
>>>>>
>>>>
>>>> I'm not sure about this patch. '1 << 31' is used all over in the 
>>>> kernel,
>>>> including in public headers (e.g. media.h, videodev2.h).
>>>>
>>>> It seems arbitrary to change it only here, but not anywhere else.
>>>>
>>>
>>> Right. We have several places in the kernel that do that.
>>>
>>>> In this particular example for the fourcc handling I would prefer to 
>>>> just
>>>> use '1U << 31', both in v4l2-ioctl.c and videodev2.h.
>>>>
>>>
>>> If you would like to take the patch, I can send v2 fixing it using
>>> 1U << 31 - This is simpler since it doesn't nee additional includes.
>>
>> I would like to have this cleaned up in the public media APIs. Those 
>> can be
>> used by other compilers as well and it makes sense to me not to have
>> undefined behavior in those headers.
>>
> 
> Great. That is a good point. I will start looking at the public media
> APIs.
> 
>>>
>>>> A separate patch doing the same for MEDIA_ENT_ID_FLAG_NEXT in 
>>>> media.h would
>>>> probably be a good idea either: that way the public API at least 
>>>> will do
>>>> the right thing.
>>>>
> 
> Sounds good.
> 
>>>
>>> I should have explained it better. I wanted to start with one or two
>>> places first to see if it is worth our time to fix these:
>>>
>>> The full kernel cppcheck log for "Shifting signed 32-bit value by 31
>>> bits is undefined behaviour" can be found at:
>>>
>>> https://drive.google.com/file/d/19Xu7UqBGJ7BpzxEp92ZQYb6F8UPrk3z3/view
>>
>> I don't think it makes sense to fix this for drivers. If gcc would do 
>> this
>> wrong, we'd have noticed it ages ago.
> 

Did some research into this. We are fine with gcc, however looks like
clang had the problem which has been fixed very recently in late 2018
in 6.0 release. This will be a problem even for kernel/drivers if older
clang is used to build it.

I am sending the two header fixes (media.h, and videodev2.h) to start
with.

thanks,
-- Shuah
