Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A19C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293A420644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXPDYZK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfEHPeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:34:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39665 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfEHPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:34:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id q10so17882559ljc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ya6765I7eRj8Rx/DaT0VUYdAp2NnJ3zmVyvErjY22Ig=;
        b=qXPDYZK+JFCcNTkBdxsbPmQ9pn4aDMqc0A+/wE4LRK3qkU3ALSbN7sII3E38HGVwXl
         3JF1AJPI1s06sVFTF8X6vzTcv63Im24+L3UPzUm3YAD6Ej4R9F7ycIN60YIPkpaaLipb
         owV4S/VyQ8BSj5fhSdWMUiBrOdwqT0Cf8nDLZKYpFZ/50HCjgcRtzCelBGTrGx+g/JaH
         9HB06T+JcNi7KgQp+3lqxAvOLxQdoTsogwv6sn9kYlIsOcybDxeJnxqSicea0rsaUF+B
         HmGi6myHu38UxGQa5Rr8KaGi93B6TDZnfmSG+b+p1RYVg8CRfzAMnNQB41Irhl+c4s6g
         V79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ya6765I7eRj8Rx/DaT0VUYdAp2NnJ3zmVyvErjY22Ig=;
        b=CoURmOYxGBIuWA7QXCjR4TttEw8aBV9fs48dhZq7R6VserSiJiiDofEPMp9lGps66Z
         be4THXVVVLu7sU1O75YPGQfEPLEFFIcd86TMMg+ntt8qQPQCc9LibLPAkuGfIKdN32UQ
         2EGYBMJMWwNeYUctEBrPl+6gSGxVyBmjdhD7iacG6H3DTIoqkPkUL6LluxKKhSW5wNk9
         iXdaBR3/mKIolk6TzLgmWIWARqe6Uh59KG8p4ycLYMmOV1vWZBln01xqneYZqCtKf6w2
         1HUDFcWTjH0W6FsqPMCgLel8O0bkd1CMNPBDrp+R8GiDneaopQhYH5ZG/o6vqnS77K9t
         2FtA==
X-Gm-Message-State: APjAAAW5thF6pXpFapZrJk/l8nw70BwmbqUuKDJTqpGgaOBrSaLi6jpq
        pi/SA/DWcI9goCDn3o9sonftjw==
X-Google-Smtp-Source: APXvYqwtO1LWOvX3zaMVyJoeq3eC0U9SOppwQWkjW6TGjcYs03jFKjHOXIXN8w0H4dJXhZne0ghATA==
X-Received: by 2002:a2e:3c06:: with SMTP id j6mr19493500lja.99.1557329663115;
        Wed, 08 May 2019 08:34:23 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id u11sm3689552lfb.60.2019.05.08.08.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:34:22 -0700 (PDT)
Subject: Re: [PATCH v2] v4l: Add source event change for bit-depth
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20190508113759.19168-1-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <d6dcee9a-0308-855c-9819-3e7413cb617d@linaro.org>
Date:   Wed, 8 May 2019 18:34:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508113759.19168-1-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 5/8/19 2:37 PM, Stanimir Varbanov wrote:
> This event indicate that the source bit-depth is changed during
> run-time. The client must get the new format and re-allocate buffers
> for it. This can usually happens with video decoder (encoders) when
> the bit-stream depth is changed from 8 to 10bits or vice versa.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
> Change since v1: s/BITDEPTH/BIT_DEPTH
> 
>  Documentation/media/uapi/v4l/vidioc-dqevent.rst | 7 +++++++
>  Documentation/media/videodev2.h.rst.exceptions  | 1 +
>  include/uapi/linux/videodev2.h                  | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
> index dea9c0cc00ab..f7782cbddc5f 100644
> --- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
> +++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
> @@ -397,6 +397,13 @@ call.
>  	that many devices are not able to recover from a temporary loss of
>  	signal and so restarting streaming I/O is required in order for the
>  	hardware to synchronize to the video signal.
> +    * - ``V4L2_EVENT_SRC_CH_BIT_DEPTH``

I started to wonder isn't COLOR_DEPTH more appropriate? Bit-depth
doesn't describe what is actually deep.

-- 
regards,
Stan
