Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182E8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CBF20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hx6ZV+Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbfDJOV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:21:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39899 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfDJOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:21:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so2298955ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLB/b2pOS2qjAZIHID6WWU8DteGiud0CLQ/s4pp2XXA=;
        b=Hx6ZV+VjxrRoS1mirD5EKhbyeRD/tlOx3eLU+uDDm7hR+CccFR0W0aV7R5WxKhj2Nv
         HLTSjL3FROxQDXE29X0SOtDbwXSjRo+4wpSkJw2NNHY2vHL23+f2huXC1D9xOljXcfSY
         wBuCJC/MeLCqP4rHlggagkqkbvk3BTC6bBxwsM3sVQUsf3TOM2J+Uqg9TGlrW8I09f8l
         5+RaEDV7pyBVEdpGa+/Mb2spkq/VdZGiGl7mWMjqR/u3X1vjKBAJ5D9gmq4suLA5N1PG
         jYhg+ykU4XYvnHNWs9FN5bbkaYXho6/fVXGeyeUrZucAKZ/iza156STap+Rx889nqngi
         eDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLB/b2pOS2qjAZIHID6WWU8DteGiud0CLQ/s4pp2XXA=;
        b=BlnfedlhQakZtgEAWCR0Q5WNbyuAnkQStgdjju+bqlX5BI7z7zc0nCnh+zBuUer8mJ
         naSfTdqNklnsAE1694uB8MLXuufIgldtn+wGIWWytTMsmITftHiO4nGG/bjagjYz91Fu
         oZuwP9LsNdMeoenCR6FyizzciTbwUqdCezSNoWX84Arqv7EeTdt5bcePYLrAWH3WZlJ/
         Vkl4TixpJmQ+Wpr74sOb2rxthkAKEan8RO6TfLK03PDU5brK807aVXTTkACO27gvWkSD
         Hca61DrS3sMtaOZkgX5/1LMVuyIP27hXM7qKiiEG+FK4s1bI/21FixiJgnCcDoip2GAl
         VOdg==
X-Gm-Message-State: APjAAAXVvlhv2nct5m1Z8ozshZLZsORZID2PHsGY+34DboJe1niaN0i4
        nm5hJ6ud4dyLo5bVFav/76VZQA==
X-Google-Smtp-Source: APXvYqxwA0J50W11YZnFpnZ4kokkrNyYCZCyBm0SKAjjL9PW0t6FHLeEef2qSPRo4jSR8MFihMnDiA==
X-Received: by 2002:a2e:974d:: with SMTP id f13mr23120907ljj.140.1554906085216;
        Wed, 10 Apr 2019 07:21:25 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id g6sm7273389lja.64.2019.04.10.07.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 07:21:24 -0700 (PDT)
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
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b6a231ea-c039-d276-313d-1b6dd19cab14@linaro.org>
Date:   Wed, 10 Apr 2019 17:21:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c103b0d8-0020-17e0-4584-e5c3ca6bbc51@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 3/14/19 3:11 PM, Hans Verkuil wrote:
> On 1/21/19 11:48 AM, Stanimir Varbanov wrote:
>> Hi Hans,
>>
>> On 1/18/19 11:13 AM, Hans Verkuil wrote:
>>> On 1/16/19 1:37 PM, Stanimir Varbanov wrote:
>>>> This changes v4l2_pix_format and v4l2_plane_pix_format sizeimage
>>>> field description to allow v4l clients to set bigger image size
>>>> in case of variable length compressed data.
>>>>
>>>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>>>> ---
>>>>  Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst | 5 ++++-
>>>>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst        | 3 ++-
>>>>  2 files changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
>>>> index 7f82dad9013a..dbe0b74e9ba4 100644
>>>> --- a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
>>>> +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
>>>> @@ -30,7 +30,10 @@ describing all planes of that format.
>>>>  
>>>>      * - __u32
>>>>        - ``sizeimage``
>>>> -      - Maximum size in bytes required for image data in this plane.
>>>> +      - Maximum size in bytes required for image data in this plane,
>>>> +        set by the driver. When the image consists of variable length
>>>> +        compressed data this is the maximum number of bytes required
>>>> +        to hold an image, and it is allowed to be set by the client.
>>>>      * - __u32
>>>>        - ``bytesperline``
>>>>        - Distance in bytes between the leftmost pixels in two adjacent
>>>> diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
>>>> index 71eebfc6d853..54b6d2b67bd7 100644
>>>> --- a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
>>>> +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
>>>> @@ -89,7 +89,8 @@ Single-planar format structure
>>>>        - Size in bytes of the buffer to hold a complete image, set by the
>>>>  	driver. Usually this is ``bytesperline`` times ``height``. When
>>>>  	the image consists of variable length compressed data this is the
>>>> -	maximum number of bytes required to hold an image.
>>>> +	maximum number of bytes required to hold an image, and it is
>>>> +	allowed to be set by the client.
>>>>      * - __u32
>>>>        - ``colorspace``
>>>>        - Image colorspace, from enum :c:type:`v4l2_colorspace`.
>>>>
>>>
>>> Hmm. "maximum number of bytes required to hold an image": that's not actually true
>>> for bitstream formats like MPEG. It's just the size of the buffer used to store the
>>> bitstream, i.e. one buffer may actually contain multiple compressed images, or a
>>> compressed image is split over multiple buffers.
>>>
>>
>> Do you want me to change something in the current documentation, i.e.
>> the quoted above?
> 
> Hmm, it looks like this discussion stalled (i.e. I forgot to reply).
> 
> How about this:
> 
> "When the image consists of variable length compressed data this is the
> number of bytes required by the encoder to support the worst-case

I don't think 'encoder' is the right word here:

s/encoder/encoder or decoder

> compression scenario. Clients are allowed to set this field. However,
> drivers may ignore the value or modify it."

Can we rephrase to:

"Clients are allowed to set sizeimage field, but however drivers my
ignore the value or modify it."

-- 
regards,
Stan
