Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EC2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC73920675
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Op+HqQ47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfDOJbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:31:25 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34889 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfDOJbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:31:25 -0400
Received: by mail-ed1-f67.google.com with SMTP id y67so778367ede.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SqoKT3suq9lSU9YSbOxRmd9QNgpDO/uNSAM+0loAP3g=;
        b=Op+HqQ47+vX3uCQbl9/qCb1ykPSbyUVE5YMlo3kQKeuf81ea7izlLhsfli6bqPxE2g
         DzwvpnkLnzwXJz6sRJt8NvWpVKumlsDHEpBgcBsKZPn7bozaZqvvj3FiKK7wDqONfPhA
         sADg30XyHtUVa+h2pn7zdaWDVoppG3u/wEU+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SqoKT3suq9lSU9YSbOxRmd9QNgpDO/uNSAM+0loAP3g=;
        b=ElaIFbGw/Ar1oc9hwEOfQroJbRgZBDXASN3Ee0Jzfvc6+H4fD1dFnxqO3FFzxGbGAv
         wq1Zow2eBWm5XAuEFVBBRwlzS6mnj6cl2KCO9oJpHXV8qbKXrexgBI7TvPJmwRyB2q33
         2ZzulBnj5gXJRnEVAsy0BlhJj/RPea9K6kr+ZjPAuF2gpMLg1NTfkAZoJQhurZg1DVD/
         U+GIt7vxgnU8RyaWNUJ+yWPbrv2tF63CrzCSWFk8fjoRzh7cgOiJgzTCrey6hKhZ06ek
         KQBFGGV4+7o85OsxXp3s6g2eG7R1HmDLG3l0vhaFDlMyHBtIe1jvVZoEnXHjEFyxK8mV
         WfwA==
X-Gm-Message-State: APjAAAXbBcTqUMMjXaDhOibdZeek8OyXLRx5Y/1q2jleCvpQAUDxxBMh
        PxvoXoYU5Wj2E5bKuE5Xfp3nyQ==
X-Google-Smtp-Source: APXvYqxWYq43wb8wNEVf5am3CJ1wiYM/SCqJ0d0d82D67S8QG6LP34uWfMgfo+0M/vPKw0FqmmyDEQ==
X-Received: by 2002:a50:a5f7:: with SMTP id b52mr15041870edc.84.1555320682592;
        Mon, 15 Apr 2019 02:31:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id op3sm8143287ejb.61.2019.04.15.02.31.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 02:31:21 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:31:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, noralf@tronnes.org,
        sam@ravnborg.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Lechner <david@lechnology.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] drm: move tinydrm format conversion helpers to
 new drm_format_helper.c
Message-ID: <20190415093119.GY2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, noralf@tronnes.org,
        sam@ravnborg.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        David Lechner <david@lechnology.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20190405095219.9231-1-kraxel@redhat.com>
 <20190405095219.9231-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405095219.9231-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 11:52:15AM +0200, Gerd Hoffmann wrote:
> Also rename them from tinydrm_* to drm_fb_*
> Pure code motion, no functional change.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_format_helper.h               |  26 +++
>  include/drm/tinydrm/tinydrm-helpers.h         |  10 -
>  drivers/gpu/drm/drm_format_helper.c           | 180 ++++++++++++++++++
>  .../gpu/drm/tinydrm/core/tinydrm-helpers.c    | 158 ---------------
>  drivers/gpu/drm/tinydrm/mipi-dbi.c            |   7 +-
>  drivers/gpu/drm/tinydrm/repaper.c             |   3 +-
>  drivers/gpu/drm/tinydrm/st7586.c              |   3 +-
>  drivers/gpu/drm/Makefile                      |   3 +-
>  8 files changed, 216 insertions(+), 174 deletions(-)
>  create mode 100644 include/drm/drm_format_helper.h
>  create mode 100644 drivers/gpu/drm/drm_format_helper.c

Please also pull in your shiny new kerneldoc into
Documenation/gpu/drm-kms-helpers.rst, and make sure the output parses
correctly and the links all work using

$ make htmldocs

Thanks, Daniel

> 
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
> new file mode 100644
> index 000000000000..5a7ada6b0bef
> --- /dev/null
> +++ b/include/drm/drm_format_helper.h
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright (C) 2016 Noralf Trønnes
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __LINUX_DRM_FORMAT_HELPER_H
> +#define __LINUX_DRM_FORMAT_HELPER_H
> +
> +struct drm_framebuffer;
> +struct drm_rect;
> +
> +void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
> +		   struct drm_rect *clip);
> +void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
> +		   struct drm_rect *clip);
> +void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
> +			       struct drm_framebuffer *fb,
> +			       struct drm_rect *clip, bool swap);
> +void drm_fb_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
> +			      struct drm_rect *clip);
> +
> +#endif /* __LINUX_DRM_FORMAT_HELPER_H */
> diff --git a/include/drm/tinydrm/tinydrm-helpers.h b/include/drm/tinydrm/tinydrm-helpers.h
> index ae4a6abc43b5..7d259acb8826 100644
> --- a/include/drm/tinydrm/tinydrm-helpers.h
> +++ b/include/drm/tinydrm/tinydrm-helpers.h
> @@ -46,16 +46,6 @@ int tinydrm_display_pipe_init(struct drm_device *drm,
>  			      const struct drm_display_mode *mode,
>  			      unsigned int rotation);
>  
> -void tinydrm_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
> -		    struct drm_rect *clip);
> -void tinydrm_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
> -		    struct drm_rect *clip);
> -void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
> -				struct drm_framebuffer *fb,
> -				struct drm_rect *clip, bool swap);
> -void tinydrm_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
> -			       struct drm_rect *clip);
> -
>  size_t tinydrm_spi_max_transfer_size(struct spi_device *spi, size_t max_len);
>  bool tinydrm_spi_bpw_supported(struct spi_device *spi, u8 bpw);
>  int tinydrm_spi_transfer(struct spi_device *spi, u32 speed_hz,
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> new file mode 100644
> index 000000000000..62bb4913d6f6
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -0,0 +1,180 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2016 Noralf Trønnes
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include <drm/drm_format_helper.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_rect.h>
> +
> +/**
> + * drm_fb_memcpy - Copy clip buffer
> + * @dst: Destination buffer
> + * @vaddr: Source buffer
> + * @fb: DRM framebuffer
> + * @clip: Clip rectangle area to copy
> + */
> +void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
> +		   struct drm_rect *clip)
> +{
> +	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
> +	unsigned int pitch = fb->pitches[0];
> +	void *src = vaddr + (clip->y1 * pitch) + (clip->x1 * cpp);
> +	size_t len = (clip->x2 - clip->x1) * cpp;
> +	unsigned int y;
> +
> +	for (y = clip->y1; y < clip->y2; y++) {
> +		memcpy(dst, src, len);
> +		src += pitch;
> +		dst += len;
> +	}
> +}
> +EXPORT_SYMBOL(drm_fb_memcpy);
> +
> +/**
> + * drm_fb_swab16 - Swap bytes into clip buffer
> + * @dst: RGB565 destination buffer
> + * @vaddr: RGB565 source buffer
> + * @fb: DRM framebuffer
> + * @clip: Clip rectangle area to copy
> + */
> +void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
> +		   struct drm_rect *clip)
> +{
> +	size_t len = (clip->x2 - clip->x1) * sizeof(u16);
> +	unsigned int x, y;
> +	u16 *src, *buf;
> +
> +	/*
> +	 * The cma memory is write-combined so reads are uncached.
> +	 * Speed up by fetching one line at a time.
> +	 */
> +	buf = kmalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return;
> +
> +	for (y = clip->y1; y < clip->y2; y++) {
> +		src = vaddr + (y * fb->pitches[0]);
> +		src += clip->x1;
> +		memcpy(buf, src, len);
> +		src = buf;
> +		for (x = clip->x1; x < clip->x2; x++)
> +			*dst++ = swab16(*src++);
> +	}
> +
> +	kfree(buf);
> +}
> +EXPORT_SYMBOL(drm_fb_swab16);
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
> +	/*
> +	 * The cma memory is write-combined so reads are uncached.
> +	 * Speed up by fetching one line at a time.
> +	 */
> +	buf = kmalloc(len, GFP_KERNEL);
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
> +
> +/**
> + * drm_fb_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
> + * @dst: 8-bit grayscale destination buffer
> + * @vaddr: XRGB8888 source buffer
> + * @fb: DRM framebuffer
> + * @clip: Clip rectangle area to copy
> + *
> + * Drm doesn't have native monochrome or grayscale support.
> + * Such drivers can announce the commonly supported XR24 format to userspace
> + * and use this function to convert to the native format.
> + *
> + * Monochrome drivers will use the most significant bit,
> + * where 1 means foreground color and 0 background color.
> + *
> + * ITU BT.601 is used for the RGB -> luma (brightness) conversion.
> + */
> +void drm_fb_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
> +			       struct drm_rect *clip)
> +{
> +	unsigned int len = (clip->x2 - clip->x1) * sizeof(u32);
> +	unsigned int x, y;
> +	void *buf;
> +	u32 *src;
> +
> +	if (WARN_ON(fb->format->format != DRM_FORMAT_XRGB8888))
> +		return;
> +	/*
> +	 * The cma memory is write-combined so reads are uncached.
> +	 * Speed up by fetching one line at a time.
> +	 */
> +	buf = kmalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return;
> +
> +	for (y = clip->y1; y < clip->y2; y++) {
> +		src = vaddr + (y * fb->pitches[0]);
> +		src += clip->x1;
> +		memcpy(buf, src, len);
> +		src = buf;
> +		for (x = clip->x1; x < clip->x2; x++) {
> +			u8 r = (*src & 0x00ff0000) >> 16;
> +			u8 g = (*src & 0x0000ff00) >> 8;
> +			u8 b =  *src & 0x000000ff;
> +
> +			/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
> +			*dst++ = (3 * r + 6 * g + b) / 10;
> +			src++;
> +		}
> +	}
> +
> +	kfree(buf);
> +}
> +EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray8);
> +
> diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
> index d7b38dfb6438..6d540d93758f 100644
> --- a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
> +++ b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
> @@ -26,164 +26,6 @@ static unsigned int spi_max;
>  module_param(spi_max, uint, 0400);
>  MODULE_PARM_DESC(spi_max, "Set a lower SPI max transfer size");
>  
> -/**
> - * tinydrm_memcpy - Copy clip buffer
> - * @dst: Destination buffer
> - * @vaddr: Source buffer
> - * @fb: DRM framebuffer
> - * @clip: Clip rectangle area to copy
> - */
> -void tinydrm_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
> -		    struct drm_rect *clip)
> -{
> -	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
> -	unsigned int pitch = fb->pitches[0];
> -	void *src = vaddr + (clip->y1 * pitch) + (clip->x1 * cpp);
> -	size_t len = (clip->x2 - clip->x1) * cpp;
> -	unsigned int y;
> -
> -	for (y = clip->y1; y < clip->y2; y++) {
> -		memcpy(dst, src, len);
> -		src += pitch;
> -		dst += len;
> -	}
> -}
> -EXPORT_SYMBOL(tinydrm_memcpy);
> -
> -/**
> - * tinydrm_swab16 - Swap bytes into clip buffer
> - * @dst: RGB565 destination buffer
> - * @vaddr: RGB565 source buffer
> - * @fb: DRM framebuffer
> - * @clip: Clip rectangle area to copy
> - */
> -void tinydrm_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
> -		    struct drm_rect *clip)
> -{
> -	size_t len = (clip->x2 - clip->x1) * sizeof(u16);
> -	unsigned int x, y;
> -	u16 *src, *buf;
> -
> -	/*
> -	 * The cma memory is write-combined so reads are uncached.
> -	 * Speed up by fetching one line at a time.
> -	 */
> -	buf = kmalloc(len, GFP_KERNEL);
> -	if (!buf)
> -		return;
> -
> -	for (y = clip->y1; y < clip->y2; y++) {
> -		src = vaddr + (y * fb->pitches[0]);
> -		src += clip->x1;
> -		memcpy(buf, src, len);
> -		src = buf;
> -		for (x = clip->x1; x < clip->x2; x++)
> -			*dst++ = swab16(*src++);
> -	}
> -
> -	kfree(buf);
> -}
> -EXPORT_SYMBOL(tinydrm_swab16);
> -
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
> -/**
> - * tinydrm_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
> - * @dst: 8-bit grayscale destination buffer
> - * @vaddr: XRGB8888 source buffer
> - * @fb: DRM framebuffer
> - * @clip: Clip rectangle area to copy
> - *
> - * Drm doesn't have native monochrome or grayscale support.
> - * Such drivers can announce the commonly supported XR24 format to userspace
> - * and use this function to convert to the native format.
> - *
> - * Monochrome drivers will use the most significant bit,
> - * where 1 means foreground color and 0 background color.
> - *
> - * ITU BT.601 is used for the RGB -> luma (brightness) conversion.
> - */
> -void tinydrm_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
> -			       struct drm_rect *clip)
> -{
> -	unsigned int len = (clip->x2 - clip->x1) * sizeof(u32);
> -	unsigned int x, y;
> -	void *buf;
> -	u32 *src;
> -
> -	if (WARN_ON(fb->format->format != DRM_FORMAT_XRGB8888))
> -		return;
> -	/*
> -	 * The cma memory is write-combined so reads are uncached.
> -	 * Speed up by fetching one line at a time.
> -	 */
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
> -			u8 r = (*src & 0x00ff0000) >> 16;
> -			u8 g = (*src & 0x0000ff00) >> 8;
> -			u8 b =  *src & 0x000000ff;
> -
> -			/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
> -			*dst++ = (3 * r + 6 * g + b) / 10;
> -			src++;
> -		}
> -	}
> -
> -	kfree(buf);
> -}
> -EXPORT_SYMBOL(tinydrm_xrgb8888_to_gray8);
> -
>  #if IS_ENABLED(CONFIG_SPI)
>  
>  /**
> diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> index 869c8f56da3b..85761b4abb83 100644
> --- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
> +++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> @@ -21,6 +21,7 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_format_helper.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_vblank.h>
> @@ -218,12 +219,12 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
>  	switch (fb->format->format) {
>  	case DRM_FORMAT_RGB565:
>  		if (swap)
> -			tinydrm_swab16(dst, src, fb, clip);
> +			drm_fb_swab16(dst, src, fb, clip);
>  		else
> -			tinydrm_memcpy(dst, src, fb, clip);
> +			drm_fb_memcpy(dst, src, fb, clip);
>  		break;
>  	case DRM_FORMAT_XRGB8888:
> -		tinydrm_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
> +		drm_fb_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
>  		break;
>  	default:
>  		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
> diff --git a/drivers/gpu/drm/tinydrm/repaper.c b/drivers/gpu/drm/tinydrm/repaper.c
> index 3f3632457079..a29b8278324b 100644
> --- a/drivers/gpu/drm/tinydrm/repaper.c
> +++ b/drivers/gpu/drm/tinydrm/repaper.c
> @@ -31,6 +31,7 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_format_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_rect.h>
> @@ -566,7 +567,7 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb)
>  			goto out_free;
>  	}
>  
> -	tinydrm_xrgb8888_to_gray8(buf, cma_obj->vaddr, fb, &clip);
> +	drm_fb_xrgb8888_to_gray8(buf, cma_obj->vaddr, fb, &clip);
>  
>  	if (import_attach) {
>  		ret = dma_buf_end_cpu_access(import_attach->dmabuf,
> diff --git a/drivers/gpu/drm/tinydrm/st7586.c b/drivers/gpu/drm/tinydrm/st7586.c
> index d99957bac532..560d7ac0cadc 100644
> --- a/drivers/gpu/drm/tinydrm/st7586.c
> +++ b/drivers/gpu/drm/tinydrm/st7586.c
> @@ -22,6 +22,7 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fb_cma_helper.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_format_helper.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_rect.h>
> @@ -77,7 +78,7 @@ static void st7586_xrgb8888_to_gray332(u8 *dst, void *vaddr,
>  	if (!buf)
>  		return;
>  
> -	tinydrm_xrgb8888_to_gray8(buf, vaddr, fb, clip);
> +	drm_fb_xrgb8888_to_gray8(buf, vaddr, fb, clip);
>  	src = buf;
>  
>  	for (y = clip->y1; y < clip->y2; y++) {
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 6c7e8d162b4e..74c1d4c51088 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -38,7 +38,8 @@ drm_kms_helper-y := drm_crtc_helper.o drm_dp_helper.o drm_dsc.o drm_probe_helper
>  		drm_kms_helper_common.o drm_dp_dual_mode_helper.o \
>  		drm_simple_kms_helper.o drm_modeset_helper.o \
>  		drm_scdc_helper.o drm_gem_framebuffer_helper.o \
> -		drm_atomic_state_helper.o drm_damage_helper.o
> +		drm_atomic_state_helper.o drm_damage_helper.o \
> +		drm_format_helper.o
>  
>  drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
>  drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
