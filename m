Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8CBC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB942077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 07:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QjTTPpKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgAIHlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 02:41:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37596 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbgAIHlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 02:41:05 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so4810675edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 23:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tc2D6Fddcx4jsd+C+veXGGQQuxMll3GdXqPaTOZ3Rv8=;
        b=QjTTPpKdzKtvc8m2GWDyHtt0EbLVlhhr8Pu5etCFNi+g/bA76m/0AIgVN9cNi8DsHN
         9EY+zNdSWzPrUt+ii0aUmfHxG109EUt3JrD3RBZMKrx+3AMTf2OJKh/JvPru2ETZXfpZ
         Bj5qTOA0dLNp5e/aRdDHOHjUlPsxq3poG0thL2F4FH3et14KwMCRCRCsZwzOFulVRzeJ
         PG6n6n5shWPwGGKyLbzWMsCsHcE1Q+leV47bIKpgge/Y5KWixieuOaUfC954msHUvnGl
         ry1NiYRy91fBEnsBKR4xLxS4FSD0qbFksu/IalZCkBmb2Gt1ukg/4gwlKX6cMaAFcxWS
         3IDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tc2D6Fddcx4jsd+C+veXGGQQuxMll3GdXqPaTOZ3Rv8=;
        b=rigq0vU/Y9QWTkC70BV5dceZmCrmFVjH8Lfq58fDSOfosncceJfUQfWBU+o24DkwsS
         yNc0qSlOK5diV8Iprn4OlawCPnE+tzB/408LN+ah8CBRBV5VUyqERPPhrsbCU0vqiXGF
         HXd/jJw46CxJ+EYhruoN7eT5uGCsXZVPE5DSC4k+PUj98s7zSEKpZ3/jwTEdBZUl+DUG
         DHlTZT6upE9XvLR+zM4vMaxmf2XdFl5s8vDtYfk8WvAxkNfI4x+0CwoLWDwJ0ty1jJiR
         Mr81aIyb7jEAlVLu93oDRUIjnMp2SQWynwUbwPXFTXzLAlAW6/uOwBBUXHbsvswNkCHp
         PwvA==
X-Gm-Message-State: APjAAAXY9PCTfCkS1EivvyTZ9YOyfPzXIJcRd9hsXd7efRi5pfVHjgSt
        T4QOS/Lg2TVOPU4w2PnhLOCcbw==
X-Google-Smtp-Source: APXvYqxexeYCvUclhR2/21VigWRLKTkpkK7LqIRm2opKYvdDcU7Dc38V3W5WB8bMCIHYHs3MIZ3eEw==
X-Received: by 2002:a17:906:944d:: with SMTP id z13mr9156035ejx.4.1578555662883;
        Wed, 08 Jan 2020 23:41:02 -0800 (PST)
Received: from [192.168.1.13] (hst-221-28.medicom.bg. [84.238.221.28])
        by smtp.googlemail.com with ESMTPSA id m6sm99623ejj.19.2020.01.08.23.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 23:41:02 -0800 (PST)
Subject: Re: [PATCH v4 04/12] v4l: Add source event change for bit-depth
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>, dikshita@codeaurora.org
References: <20200106154929.4331-1-stanimir.varbanov@linaro.org>
 <20200106154929.4331-5-stanimir.varbanov@linaro.org>
 <c3b02589-1d7a-a476-7d33-7e555fbe276d@xs4all.nl>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <ae233eb1-69fc-6723-0224-0c1fcf786156@linaro.org>
Date:   Thu, 9 Jan 2020 09:41:00 +0200
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

Hi Hans,

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

What you mean by "but not a resolution change" here? Resolution change
and bit-depth change cannot occur on the same time, or something else.

I would say that for Venus (and probably others) on initialization time
both could be changed on the same time, because we cannot predict the
resolution and bit-depth before parsing bitstream headers.

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
> 
> Regards,
> 
> 	Hans
> 
>>  
>>  Return Value
>>  ============
>> diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentation/media/videodev2.h.rst.exceptions
>> index cb6ccf91776e..209709114378 100644
>> --- a/Documentation/media/videodev2.h.rst.exceptions
>> +++ b/Documentation/media/videodev2.h.rst.exceptions
>> @@ -490,6 +490,7 @@ replace define V4L2_EVENT_CTRL_CH_FLAGS ctrl-changes-flags
>>  replace define V4L2_EVENT_CTRL_CH_RANGE ctrl-changes-flags
>>  
>>  replace define V4L2_EVENT_SRC_CH_RESOLUTION src-changes-flags
>> +replace define V4L2_EVENT_SRC_CH_COLOR_DEPTH src-changes-flags
>>  
>>  replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
>>  
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 5f9357dcb060..1d349c9d57a7 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -2332,6 +2332,7 @@ struct v4l2_event_frame_sync {
>>  };
>>  
>>  #define V4L2_EVENT_SRC_CH_RESOLUTION		(1 << 0)
>> +#define V4L2_EVENT_SRC_CH_COLOR_DEPTH		(1 << 1)
>>  
>>  struct v4l2_event_src_change {
>>  	__u32 changes;
>>
> 

-- 
regards,
Stan
