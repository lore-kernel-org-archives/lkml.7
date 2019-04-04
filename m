Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05565C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7D5206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="ciRBTwGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfDDSmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:42:08 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:42367 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729779AbfDDSmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=cebV4gXiMEIYd3IUOZG84+zTi822WzXfGTxNKOmICwM=;
        b=ciRBTwGvQ8Fc3qSUqhoTsZfAodVQLNA7BVNBnD3WBoHJT05IABPpfJxTFFdnA1tJW8M+pBYqlRPVRT+svG1aaZf+0L1JE/4htFUXAc502n/DI/CutOXQJfEBx/613Aar8/amrizWrT0COmWo73oDRFakIN6AeTyHhpKWQDk90MD6T91D17uoR9ha9RBNoqLHfDzegBVtEWSEKblyiiRCzIJmJPu2oOt4lv9DqzYKbBwVvFbsBPDDk4iH02zOuciwPKmiy4O/wBDFEPSYrAhBgMFVOACc2tRSCNs1vsDgrQRlmx/zyn0l572gVfF1pf4UXf6S8BEN26QJxl4T3Xq1dg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51047 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hC7JN-0001yi-NJ; Thu, 04 Apr 2019 20:42:05 +0200
Subject: Re: [PATCH v2 3/6] drm: move tinydrm_xrgb8888_to_rgb565() to
 drm_fb_helper.c
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20190404152430.8263-1-kraxel@redhat.com>
 <20190404152430.8263-4-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <e7a4a6e7-7e31-6172-dee1-7f52a4274588@tronnes.org>
Date:   Thu, 4 Apr 2019 20:42:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404152430.8263-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 04.04.2019 17.24, skrev Gerd Hoffmann:
> Also rename to drm_fb_xrgb8888_to_rgb565().
> Pure code motion, no functional change.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---


> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index fabeb408dce6..087e49741094 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -3380,3 +3380,48 @@ void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
>  	}
>  }
>  EXPORT_SYMBOL(drm_fb_memcpy);
> +
> +/**
> + * drm_fb_xrgb8888_to_rgb565 - Convert XRGB8888 to RGB565 clip buffer
> + * @dst: RGB565 destination buffer
> + * @vaddr: XRGB8888 source buffer
> + * @fb: DRM framebuffer
> + * @clip: Clip rectangle area to copy
> + * @swap: Swap bytes
> + *
> + * Drivers can use this function for RGB565 devices that don't natively
> + * support XRGB8888.
> + */
> +void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
> +			       struct drm_framebuffer *fb,
> +			       struct drm_rect *clip, bool swap)
> +{
> +	size_t len = (clip->x2 - clip->x1) * sizeof(u32);
> +	unsigned int x, y;
> +	u32 *src, *buf;
> +	u16 val16;
> +
> +	buf = kmalloc(len, GFP_KERNEL);

It's not obvious what purpose this buffer serves and there's no help
from the surrounding functions either (tinydrm_swab16() has a comment).

I think we need a comment, something along these lines:

	/*
	 * Write-combined buffers have uncached reads.
	 * Speed up by fetching one line at a time.
	 */

Noralf.

> +	if (!buf)
> +		return;
> +
> +	for (y = clip->y1; y < clip->y2; y++) {
> +		src = vaddr + (y * fb->pitches[0]);
> +		src += clip->x1;
> +		memcpy(buf, src, len);
> +		src = buf;
> +		for (x = clip->x1; x < clip->x2; x++) {
> +			val16 = ((*src & 0x00F80000) >> 8) |
> +				((*src & 0x0000FC00) >> 5) |
> +				((*src & 0x000000F8) >> 3);
> +			src++;
> +			if (swap)
> +				*dst++ = swab16(val16);
> +			else
> +				*dst++ = val16;
> +		}
> +	}
> +
> +	kfree(buf);
> +}
> +EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
> diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
> index f5c6f35e6161..f4b84b15da75 100644
> --- a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
> +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
> @@ -61,51 +61,6 @@ void tinydrm_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
>  }
>  EXPORT_SYMBOL(tinydrm_swab16);
>  
> -/**
> - * tinydrm_xrgb8888_to_rgb565 - Convert XRGB8888 to RGB565 clip buffer
> - * @dst: RGB565 destination buffer
> - * @vaddr: XRGB8888 source buffer
> - * @fb: DRM framebuffer
> - * @clip: Clip rectangle area to copy
> - * @swap: Swap bytes
> - *
> - * Drivers can use this function for RGB565 devices that don't natively
> - * support XRGB8888.
> - */
> -void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
> -				struct drm_framebuffer *fb,
> -				struct drm_rect *clip, bool swap)
> -{
> -	size_t len = (clip->x2 - clip->x1) * sizeof(u32);
> -	unsigned int x, y;
> -	u32 *src, *buf;
> -	u16 val16;
> -
> -	buf = kmalloc(len, GFP_KERNEL);
> -	if (!buf)
> -		return;
> -
> -	for (y = clip->y1; y < clip->y2; y++) {
> -		src = vaddr + (y * fb->pitches[0]);
> -		src += clip->x1;
> -		memcpy(buf, src, len);
> -		src = buf;
> -		for (x = clip->x1; x < clip->x2; x++) {
> -			val16 = ((*src & 0x00F80000) >> 8) |
> -				((*src & 0x0000FC00) >> 5) |
> -				((*src & 0x000000F8) >> 3);
> -			src++;
> -			if (swap)
> -				*dst++ = swab16(val16);
> -			else
> -				*dst++ = val16;
> -		}
> -	}
> -
> -	kfree(buf);
> -}
> -EXPORT_SYMBOL(tinydrm_xrgb8888_to_rgb565);
> -
>  /**
>   * tinydrm_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
>   * @dst: 8-bit grayscale destination buffer
> diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> index e26fd61360a3..cf8df5fb7494 100644
> --- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
> +++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> @@ -224,7 +224,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
>  			drm_fb_memcpy(dst, src, fb, clip, false);
>  		break;
>  	case DRM_FORMAT_XRGB8888:
> -		tinydrm_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
> +		drm_fb_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
>  		break;
>  	default:
>  		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
> 
