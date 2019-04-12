Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E91C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4172084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfDLKpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:45:02 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:42169 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbfDLKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:45:02 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Etg3h0FzHNG8zEtg4hCP62; Fri, 12 Apr 2019 12:45:00 +0200
Subject: Re: [PATCH] media/doc: Allow sizeimage to be set by v4l clients
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190410152128.9811-1-stanimir.varbanov@linaro.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <c55dd3be-7350-f1b0-0d17-492eeaed1e0d@xs4all.nl>
Date:   Fri, 12 Apr 2019 12:44:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410152128.9811-1-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP+DP9B2eDmUgBt5zqtgz8479WIS+eT5kIrp42f9Jivd33X9FNPKBgcZhwOhvsNiqIFX2S4DXghdaUiipvjqTS8FOAWJplniHYyjtw7cBy7Qz1TypMbQ
 zypxmBlzE8TjQihkDyKJYwImOXOYlwAkak1JUcqR9uVWVZ6HKBuvo2c/m4N8jEQ5kYjH/Yx7cc0EgNKViTjIyGPKfZc9o8L4ymUEzal9ME+wSHSxCFgqwIlH
 6ocY9HW3+PFAkYNb9M5+TwLqCOPnaJR4LzNwKSBNI8jxJMc1Rc1p6cbDMk6tSlfwZnlQLjVfnsufsgQYXYW9XvKidtHrOfK5k4X7N2fVau9iNLedgGRbQN6j
 J3MbTF9+OakyiYzg3rXZ9ONr2EdaxKHISLL+ygWgvUUL8+4r2NYbmXSIYSYIAKTzem9zoc2noa35NqRE9WVuwA5aZ8esDw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 5:21 PM, Stanimir Varbanov wrote:
> This changes v4l2_pix_format and v4l2_plane_pix_format sizeimage
> field description to allow v4l clients to set bigger image size
> in case of variable length compressed data.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst | 6 +++++-
>  Documentation/media/uapi/v4l/pixfmt-v4l2.rst        | 4 +++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
> index 5688c816e334..a5cdc4537012 100644
> --- a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
> +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
> @@ -31,7 +31,11 @@ describing all planes of that format.
>  
>      * - __u32
>        - ``sizeimage``
> -      - Maximum size in bytes required for image data in this plane.
> +      - Maximum size in bytes required for image data in this plane,
> +	set by the driver. When the image consists of variable length
> +	compressed data this is the number of bytes required by the
> +	codec to support the worst-case compression scenario. Clients
> +	are allowed to set the sizeimage field, but drivers may modify it.

How about this:

----------------------
Maximum size in bytes required for image data in this plane,
set by the driver. When the image consists of variable length
compressed data this is the number of bytes required by the
codec to support the worst-case compression scenario.

For uncompressed images the driver will set the value. For
variable length compressed data clients are allowed to set
the sizeimage field, but the driver may ignore it and set the
value itself, or it may modify the provided value based on alignment
requirements or minimum/maximum size requirements. If the client wants
to leave this to the driver, then it should set sizeimage to 0.
-----------------------

I think this is more precise, esp. the last bit that clients can set
it to 0 to have the driver provide the value is important in my view.

Regards,

	Hans

>      * - __u32
>        - ``bytesperline``
>        - Distance in bytes between the leftmost pixels in two adjacent
> diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
> index 71eebfc6d853..70e08c58febc 100644
> --- a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
> +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
> @@ -89,7 +89,9 @@ Single-planar format structure
>        - Size in bytes of the buffer to hold a complete image, set by the
>  	driver. Usually this is ``bytesperline`` times ``height``. When
>  	the image consists of variable length compressed data this is the
> -	maximum number of bytes required to hold an image.
> +	number of bytes required by the codec to support the worst-case
> +	compression scenario. Clients are allowed to set the sizeimage
> +	field, but drivers may modify it.
>      * - __u32
>        - ``colorspace``
>        - Image colorspace, from enum :c:type:`v4l2_colorspace`.
> 

