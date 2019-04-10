Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86076C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1D420818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZrBZO6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbfDJOwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:52:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45545 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732871AbfDJOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:52:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so2387210ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0aoA1chJe6y6wRR0IjU4b6fBj+IPDBc4N9Fb0jI/w2w=;
        b=tZrBZO6Wj4bPGa7U8g35R9gYerpbinR6/YvmceUAPbhEkQ+N3srb+g7ttGelS4BgrS
         WEaK7B1Y/Z2Z2Gjbafqs6uW0vIPlt3zfGdX0Pu9h9i4sh3tGjW9dkjFcNgE3FEzg5JmP
         0FHZBXiC4/QxVzBSooywh7LJxP7xcydnynI/u8lEqaQokQJ/aXzc6nXzSmN6Xwsv5AyO
         T7Q+xPdjZcbq+p9OIIduGHAmPysDzz+9YuXHJiip6EHBL9p3pdn25+kr35DC71kHPbkP
         YcblLUKZcn/ZEPfr/rFn/Z1Ad8yi28PMv+gen9TjMtD+rVoaFHNpxb0BWrVVDFJEib3F
         p3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0aoA1chJe6y6wRR0IjU4b6fBj+IPDBc4N9Fb0jI/w2w=;
        b=e4gD529sSmj5b2Cn4snG4xbZ/8KSE/BOT0OhHh+xNCw45csAwIYP102McIL+dTyDmG
         1XcLZHYupQQdzvNUoofFM50Iy68mKYY0z4sFvQGp/mBSUb4fAxzRr+9rvRoE9x6L+rUV
         cH8WyMtyp4+S851qnzdlfWNw+uaKoNabBtYK8Dp/8FJL7fIb8amxlam6u8ZR1PhYAfwY
         ToVSvvWzwHVE3JQjv2BD2d5por/SA+YIC4svenxwGHxyRi1bqVFxfDNepOAGnlhFADNa
         xmQDm/0aizqilSVTSDl3gksIjvnyxHDIXjiZI8ZcvDTwm3NXDqd9/1uF47pFHC5C9Oa8
         e6mg==
X-Gm-Message-State: APjAAAW+G7T9fN3tVp7wQkhQeF2z4C8f+cpQbPpZ67tDraUKs5SmGZlR
        JUGbVMw9OIYQENv0RW5a1oncOg==
X-Google-Smtp-Source: APXvYqwznuo69H+1fIh9ffh9+/9UyiaiGUm5D5IeEsox8cpr7X0fws3aYmVfg/exK5j6dhKGHs/5BQ==
X-Received: by 2002:a2e:9703:: with SMTP id r3mr14490635lji.88.1554907960633;
        Wed, 10 Apr 2019 07:52:40 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id o7sm7242890ljj.23.2019.04.10.07.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 07:52:39 -0700 (PDT)
Subject: Re: [RFC PATCH] media/doc: Allow sizeimage to be set by v4l clients
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
References: <20190116123701.10344-1-stanimir.varbanov@linaro.org>
 <299e8aeb-6deb-b383-8f63-cf2cbf5d2e9f@xs4all.nl>
 <adecdc4e-1aed-fc33-b14b-083322797c70@linaro.org>
 <c103b0d8-0020-17e0-4584-e5c3ca6bbc51@xs4all.nl>
 <b6a231ea-c039-d276-313d-1b6dd19cab14@linaro.org>
 <f374662e-64f8-d280-21f8-892c70b6b29e@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <9e2f7a44-8bcf-05aa-827c-d7ba7bffd6ca@linaro.org>
Date:   Wed, 10 Apr 2019 17:52:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f374662e-64f8-d280-21f8-892c70b6b29e@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/19 5:39 PM, Hans Verkuil wrote:
> On 4/10/19 4:21 PM, Stanimir Varbanov wrote:
>> Hi Hans,
>>
>> On 3/14/19 3:11 PM, Hans Verkuil wrote:
>>> On 1/21/19 11:48 AM, Stanimir Varbanov wrote:
>>>> Hi Hans,
>>>>
>>>> On 1/18/19 11:13 AM, Hans Verkuil wrote:
>>>>> On 1/16/19 1:37 PM, Stanimir Varbanov wrote:
>>>>>> This changes v4l2_pix_format and v4l2_plane_pix_format sizeimage
>>>>>> field description to allow v4l clients to set bigger image size
>>>>>> in case of variable length compressed data.
>>>>>>
>>>>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>>>>> ---
>>>>>>  Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst | 5 ++++-
>>>>>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst        | 3 ++-
>>>>>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
>>>>>> index 7f82dad9013a..dbe0b74e9ba4 100644
>>>>>> --- a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
>>>>>> +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
>>>>>> @@ -30,7 +30,10 @@ describing all planes of that format.
>>>>>>  
>>>>>>      * - __u32
>>>>>>        - ``sizeimage``
>>>>>> -      - Maximum size in bytes required for image data in this plane.
>>>>>> +      - Maximum size in bytes required for image data in this plane,
>>>>>> +        set by the driver. When the image consists of variable length
>>>>>> +        compressed data this is the maximum number of bytes required
>>>>>> +        to hold an image, and it is allowed to be set by the client.
>>>>>>      * - __u32
>>>>>>        - ``bytesperline``
>>>>>>        - Distance in bytes between the leftmost pixels in two adjacent
>>>>>> diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
>>>>>> index 71eebfc6d853..54b6d2b67bd7 100644
>>>>>> --- a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
>>>>>> +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
>>>>>> @@ -89,7 +89,8 @@ Single-planar format structure
>>>>>>        - Size in bytes of the buffer to hold a complete image, set by the
>>>>>>  	driver. Usually this is ``bytesperline`` times ``height``. When
>>>>>>  	the image consists of variable length compressed data this is the
>>>>>> -	maximum number of bytes required to hold an image.
>>>>>> +	maximum number of bytes required to hold an image, and it is
>>>>>> +	allowed to be set by the client.
>>>>>>      * - __u32
>>>>>>        - ``colorspace``
>>>>>>        - Image colorspace, from enum :c:type:`v4l2_colorspace`.
>>>>>>
>>>>>
>>>>> Hmm. "maximum number of bytes required to hold an image": that's not actually true
>>>>> for bitstream formats like MPEG. It's just the size of the buffer used to store the
>>>>> bitstream, i.e. one buffer may actually contain multiple compressed images, or a
>>>>> compressed image is split over multiple buffers.
>>>>>
>>>>
>>>> Do you want me to change something in the current documentation, i.e.
>>>> the quoted above?
>>>
>>> Hmm, it looks like this discussion stalled (i.e. I forgot to reply).
>>>
>>> How about this:
>>>
>>> "When the image consists of variable length compressed data this is the
>>> number of bytes required by the encoder to support the worst-case
>>
>> I don't think 'encoder' is the right word here:
>>
>> s/encoder/encoder or decoder
> 
> or perhaps just 'codec'? Either is fine by me.

OK, then just 'codec'.

> 
>>
>>> compression scenario. Clients are allowed to set this field. However,
>>> drivers may ignore the value or modify it."
>>
>> Can we rephrase to:
>>
>> "Clients are allowed to set sizeimage field, but however drivers my
>> ignore the value or modify it."
>>
> 
> How about this:
> 
> "Clients are allowed to set the sizeimage field, but drivers may
>  modify it."

I'm fine with that.

I'll send with those changes and as regular patch. Thanks!

> 
> 'ignore the value' isn't right, since that suggests that the sizeimage
> value that is returned may not be in actual use. Since sizeimage can now
> be set by userspace, this means that a sanity check is needed in drivers
> as well (i.e. what if userspace sets sizeimage to ~0?)
> 
> This should be tested in v4l2-compliance as well.
> 
> Regards,
> 
> 	Hans
> 

-- 
regards,
Stan
