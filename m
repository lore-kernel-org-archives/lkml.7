Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD14C33CA3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217292070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0PY+8gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgAHQnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:43:35 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42356 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgAHQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:43:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id e10so3089613edv.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z/DDsWY474Xa+zjcBfFKboi75muYRoVjaBuY1De3KlQ=;
        b=d0PY+8gs+HppL0imKZQf9JDw/zoiES1fhKiECfj7S/QbLBKu0w/7ps+rKWud6Y/PBA
         8kOmrptJp4r94SNEW8rIXv//t/ucQ8L+YxYUh7Dc3POsVKpY0jYfjWh144b837vdBKYT
         pWB6xf3875XlMzVKIZfVsm0+VJ0Ay8CSUIfgnwMXK8y/yYajD7jvLpQRvxFpaTT/DHDF
         wUeKmf4Bpy0wSt88XBR1eEOeVlfqW6ng1DVAqiPIqTwycBrkQ92MrlrLSCD6IHQK82qJ
         WMW3okyIvXD9vV2Fo27Fl9DsplLhxb9wh+fc5OpCKrhqFAP+31wT7FHpMwfqGiAvl0AU
         /M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z/DDsWY474Xa+zjcBfFKboi75muYRoVjaBuY1De3KlQ=;
        b=pKJ0TAsCyuhDNhsNNToVjxXkLEZMMm1Cg55sbA3q+JU0p3dKV5+EYyZZ+UX7bZpPMd
         N+RTfBCd16bJAqBykOjBK0hggz65CqLE/XdjsB+bYsVlrl2ECneyzckmVh2aOaSrBUFB
         /jybb8zzq6Q5w/BUy+sIZ+zz4yWZAlhE/B/0aZGIhyR6F+HJxQDzym7l55n6nOvwFcFB
         JvoJr+O8pVtPvRZ57wJ8YTkCxL6EyWxgeaN6vu0X0VYljhvIQrFh2Hq9hhLeYHuEK6Uk
         s1YBc1oS55xr2LMkwAQyh6aMC6bJIqeQ8B8SRxeBXgYauTqu8dutl+DGmeSJxk4D+Msv
         rrbg==
X-Gm-Message-State: APjAAAXhV/h40RI7CZD3isng4xwNtjEUdXQ0nT7/ZiQewDFnCTHFiTNt
        5moFzJHzTKvNO6DRf+O8AzsSWw==
X-Google-Smtp-Source: APXvYqxr0RdezdAcqeIeYXVWxfETnNalCciJvWAc/XKAhpVVfT5KGkf5rLQqPjO9CLHl27QGEhPhVQ==
X-Received: by 2002:a05:6402:3132:: with SMTP id dd18mr6394995edb.118.1578501812283;
        Wed, 08 Jan 2020 08:43:32 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.193])
        by smtp.googlemail.com with ESMTPSA id d22sm81627edp.28.2020.01.08.08.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 08:43:31 -0800 (PST)
Subject: Re: [PATCH v4 04/12] v4l: Add source event change for bit-depth
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
 <20200106154929.4331-5-stanimir.varbanov@linaro.org>
 <c3b02589-1d7a-a476-7d33-7e555fbe276d@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <da434e7b-ffc6-2d59-76a7-a2ddeaf54657@linaro.org>
Date:   Wed, 8 Jan 2020 18:43:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c3b02589-1d7a-a476-7d33-7e555fbe276d@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/20 6:09 PM, Hans Verkuil wrote:
> On 1/6/20 4:49 PM, Stanimir Varbanov wrote:
>> This event indicate that the source color bit-depth is changed
>> during run-time. The client must get the new format and re-allocate
>> buffers for it. This can usually happens with video decoder (encoders)
>> when the bit-stream color bit-depth is changed from 8 to 10bits
>> or vice versa.
>>
>> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  Documentation/media/uapi/v4l/vidioc-dqevent.rst | 8 +++++++-
>>  Documentation/media/videodev2.h.rst.exceptions  | 1 +
>>  include/uapi/linux/videodev2.h                  | 1 +
>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>> index 42659a3d1705..fad853d440cf 100644
>> --- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>> +++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>> @@ -402,7 +402,13 @@ call.
>>  	that many Video Capture devices are not able to recover from a temporary
>>  	loss of signal and so restarting streaming I/O is required in order for
>>  	the hardware to synchronize to the video signal.
>> -
>> +    * - ``V4L2_EVENT_SRC_CH_COLOR_DEPTH``
>> +      - 0x0002
>> +      - This event gets triggered when color bit-depth change is detected
>> +	from a video decoder. Applications will have to query the new pixel
>> +	format and re-negotiate the queue. In most cases the streaming must be
>> +	stopped and restarted (:ref:`VIDIOC_STREAMOFF <VIDIOC_STREAMON>`
>> +	followed by :ref:`VIDIOC_STREAMON <VIDIOC_STREAMON>`).
> 
> I think this is too specific for decoders. Something similar to the
> CH_RESOLUTION description would be more appropriate:
> 
>       - This event gets triggered when a color bit-depth change (but not a
> 	resolution change!) is detected	at an input. This can come from an
> 	input connector or from a video decoder. Applications will have to query
> 	the new pixel format and re-negotiate the queue.
> 
> 	For stateful decoders follow the guidelines in :ref:`decoder`.
> 	Video capture devices will in most cases have to stop and restart
> 	streaming (:ref:`VIDIOC_STREAMOFF <VIDIOC_STREAMON>` followed by
> 	:ref:`VIDIOC_STREAMON <VIDIOC_STREAMON>`).
> 
> And update dev-decoder.rst where needed with this new event flag.
> 
> As to your question on irc: once I've acked this patch it can be merged
> via a venus PR.

Sounds good, thank you.

-- 
regards,
Stan
