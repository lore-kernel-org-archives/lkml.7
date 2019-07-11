Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C14C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687E20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JHCJ6Nkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfGKIVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:21:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34955 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:21:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id w20so4879904edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 01:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8WLxEYKvp+G8KVX29UoMgnN82gOfXefm67IW7Lz3ELM=;
        b=JHCJ6NkfSauIaS7Bo2XYssW3dhuhO/NV0eotPKteo5zLIaB9b7e3IA+Y/QeAgV4Pei
         GQdbYgkUoo7ykifVmSN1xww1gmuVSU84cqx+KY7d0p0mgMCDFWknSKzmvbbT9r1xCle/
         dRKacixn3HqsZyDeWUFzylwCk5+vpFeZtmAEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=8WLxEYKvp+G8KVX29UoMgnN82gOfXefm67IW7Lz3ELM=;
        b=n540rpmC8Ja5COc2xW5KvF/ULdk4UMPpcZbZyaGhUQWns29WFNGXu6X3cx0SHXfr5g
         Dj8zm0d2X/lIz5mvY7JgaUfm9jc5RTo8dixqTQVfLQSsWaWGGdiOwMn1hAlU87vm+9nF
         FS6Pzth8PEPJITMVMZmLIzXwtZjVyE3zZdGNqPEiF1oOKYFQ4QavsB9joTsAOiVqG/Xp
         Lwooe5Dq4ZTLpNhOYvHN6hfnS+q/JTAujFMWOml6tcv0kPQt7WnO1KzzxPwgzclNieBF
         vrCSiZgNxTjeKYgZ5t0QZKBc4ElB4Ot6yKC0DhSl0Ir0+NkwQctDAoHYvPVErRz/RCvQ
         hT6w==
X-Gm-Message-State: APjAAAVxSLrKS3+CHcoyiqueqXbVLAe9rka90D/lC+qyuTX5UETcWorZ
        W+n7q2xJnrJcJyRfqJUEkmI=
X-Google-Smtp-Source: APXvYqxTHd8KSqi16wrHTqcM+LyLoZpCL/IQ+COZ9g2UG8zZBuEvORHbRxJBqYrz5yHutJ6G8Pb26Q==
X-Received: by 2002:a17:906:4d88:: with SMTP id s8mr1946987eju.225.1562833268556;
        Thu, 11 Jul 2019 01:21:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c48sm1499881edb.10.2019.07.11.01.21.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 01:21:07 -0700 (PDT)
Date:   Thu, 11 Jul 2019 10:21:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] drm/vkms: Compute CRC without change input data
Message-ID: <20190711082105.GI15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <ea7e3a0daa4ee502d8ec67a010120d53f88fa06b.1561491964.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea7e3a0daa4ee502d8ec67a010120d53f88fa06b.1561491964.git.rodrigosiqueiramelo@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 10:38:31PM -0300, Rodrigo Siqueira wrote:
> The compute_crc() function is responsible for calculating the
> framebuffer CRC value; due to the XRGB format, this function has to
> ignore the alpha channel during the CRC computation. Therefore,
> compute_crc() set zero to the alpha channel directly in the input
> framebuffer, which is not a problem since this function receives a copy
> of the original buffer. However, if we want to use this function in a
> context without a buffer copy, it will change the initial value. This
> patch makes compute_crc() calculate the CRC value without modifying the
> input framebuffer.

Uh why? For writeback we're writing the output too, so we can write
whatever we want to into the alpha channel. For writeback we should never
accept a pixel format where alpha actually matters, that doesn't make
sense. You can't see through a real screen either, they are all opaque :-)
-Daniel

> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 31 +++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 51a270514219..8126aa0f968f 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -6,33 +6,40 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  
> +static u32 get_pixel_from_buffer(int x, int y, const u8 *buffer,
> +				 const struct vkms_composer *composer)
> +{
> +	int src_offset = composer->offset + (y * composer->pitch)
> +					  + (x * composer->cpp);
> +
> +	return *(u32 *)&buffer[src_offset];
> +}
> +
>  /**
>   * compute_crc - Compute CRC value on output frame
>   *
> - * @vaddr_out: address to final framebuffer
> + * @vaddr: address to final framebuffer
>   * @composer: framebuffer's metadata
>   *
>   * returns CRC value computed using crc32 on the visible portion of
>   * the final framebuffer at vaddr_out
>   */
> -static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
> +static uint32_t compute_crc(const u8 *vaddr,
> +			    const struct vkms_composer *composer)
>  {
> -	int i, j, src_offset;
> +	int x, y;
>  	int x_src = composer->src.x1 >> 16;
>  	int y_src = composer->src.y1 >> 16;
>  	int h_src = drm_rect_height(&composer->src) >> 16;
>  	int w_src = drm_rect_width(&composer->src) >> 16;
> -	u32 crc = 0;
> +	u32 crc = 0, pixel = 0;
>  
> -	for (i = y_src; i < y_src + h_src; ++i) {
> -		for (j = x_src; j < x_src + w_src; ++j) {
> -			src_offset = composer->offset
> -				     + (i * composer->pitch)
> -				     + (j * composer->cpp);
> +	for (y = y_src; y < y_src + h_src; ++y) {
> +		for (x = x_src; x < x_src + w_src; ++x) {
>  			/* XRGB format ignores Alpha channel */
> -			memset(vaddr_out + src_offset + 24, 0,  8);
> -			crc = crc32_le(crc, vaddr_out + src_offset,
> -				       sizeof(u32));
> +			pixel = get_pixel_from_buffer(x, y, vaddr, composer);
> +			bitmap_clear((void *)&pixel, 0, 8);
> +			crc = crc32_le(crc, (void *)&pixel, sizeof(u32));
>  		}
>  	}
>  
> -- 
> 2.21.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
