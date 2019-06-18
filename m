Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB8CC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE912084B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TBXn5NHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbfFRJ1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:27:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41403 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbfFRJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:27:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so20647812eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ui/BzLNa6wvXLsPsurjOjVu8WC6QRyBQbt6hZ7KPEOU=;
        b=TBXn5NHklI2eEWguR3Yl2FEmK46zYkTMTZyy3xIpig0j/IQlAv9OMqtM8pRiUmOUjv
         HtVRxPX8W7yGYL4BDrCDagO9ZG/W8mNPOQBld9ls9+svZ9j7Qieq36uwsK5TroIg1FTo
         tXgFCwSESncMNCU/omydAKCKAike5ANebeJg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ui/BzLNa6wvXLsPsurjOjVu8WC6QRyBQbt6hZ7KPEOU=;
        b=EN16ikWRC+FRsE+fFKP5KLqKDgJZtEaiSHDFqQEIO+1nktcTS4tCg9DxnfNrNHK5W8
         Yv0ZYYUSzjO6ML2WSw4VqNvuXKIXbQHkg2RBJavoSe6tv6LcgjBxeQdg6/w5Ury/Mw7T
         /yj1BZI/ejcI//Br4YRduQK2o3YSR/ABf27g/WxvGUvc8IWNQoJ2bFVzprWjrO0gbMf9
         /7NUz/YlQuqc6BAnsctpuGY72lybMASf7/HzreM+f0vczjpiCfLEGk0fbDXNsN4cItkk
         fsyTw5uXKDciA0AzafKe+wi3rd/v4TKJ1Ui8s7wXEyYOCVGvrscrbc98LN4Xw47YSr2r
         9cJA==
X-Gm-Message-State: APjAAAVde1nfQgqzkU0KYS4aI4Dq9N1EQvangraCAxraTP6w4ynwUod7
        bRPOm/+3CD4ojttJ54aI57tq9g==
X-Google-Smtp-Source: APXvYqyeCeOpkcu7agLefsQcHTxiauFG4f43uh0M6maMqCFA7aB8x0O3RSCZTuqRvwxLisGm9v5qqA==
X-Received: by 2002:a17:907:2130:: with SMTP id qo16mr23273141ejb.235.1560850036799;
        Tue, 18 Jun 2019 02:27:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g2sm475855edg.81.2019.06.18.02.27.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:27:16 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:27:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/5] drm/vkms: Move functions from vkms_crc to
 vkms_composer
Message-ID: <20190618092714.GP12905@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
 <408a662d504db1cfe13919688a4e9f7f7a6d8489.1560820888.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408a662d504db1cfe13919688a4e9f7f7a6d8489.1560820888.git.rodrigosiqueiramelo@gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:42:33PM -0300, Rodrigo Siqueira wrote:
> The vkms_crc file has functions related to compose operations which are
> not directly associated with CRC. This patch, move those function for a
> new file named vkms_composer.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>

I guess my suggestion wasn't quite clear: I thought we should rename the
entire file from vkms_crc.c to vkms_composor.c. And then adjust functions
and datastructures to use vkms_composer instead of vkms_crc as the prefix.
-Daniel

> ---
>  drivers/gpu/drm/vkms/Makefile        |  9 +++-
>  drivers/gpu/drm/vkms/vkms_composer.c | 69 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_composer.h | 12 +++++
>  drivers/gpu/drm/vkms/vkms_crc.c      | 65 +-------------------------
>  4 files changed, 90 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/gpu/drm/vkms/vkms_composer.c
>  create mode 100644 drivers/gpu/drm/vkms/vkms_composer.h
> 
> diff --git a/drivers/gpu/drm/vkms/Makefile b/drivers/gpu/drm/vkms/Makefile
> index 89f09bec7b23..b4c040854bd6 100644
> --- a/drivers/gpu/drm/vkms/Makefile
> +++ b/drivers/gpu/drm/vkms/Makefile
> @@ -1,4 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -vkms-y := vkms_drv.o vkms_plane.o vkms_output.o vkms_crtc.o vkms_gem.o vkms_crc.o
> +vkms-y := \
> +	vkms_drv.o \
> +	vkms_plane.o \
> +	vkms_output.o \
> +	vkms_crtc.o \
> +	vkms_gem.o \
> +	vkms_composer.o \
> +	vkms_crc.o
>  
>  obj-$(CONFIG_DRM_VKMS) += vkms.o
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> new file mode 100644
> index 000000000000..3d7c5e316d6e
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "vkms_drv.h"
> +#include "vkms_composer.h"
> +#include <drm/drm_gem_framebuffer_helper.h>
> +
> +/**
> + * blend - belnd value at vaddr_src with value at vaddr_dst
> + * @vaddr_dst: destination address
> + * @vaddr_src: source address
> + * @dest: destination framebuffer's metadata
> + * @src: source framebuffer's metadata
> + *
> + * Blend value at vaddr_src with value at vaddr_dst.
> + * Currently, this function write value at vaddr_src on value
> + * at vaddr_dst using buffer's metadata to locate the new values
> + * from vaddr_src and their distenation at vaddr_dst.
> + *
> + * Todo: Use the alpha value to blend vaddr_src with vaddr_dst
> + *	 instead of overwriting it.
> + */
> +void blend(void *vaddr_dst, void *vaddr_src, struct vkms_crc_data *dest,
> +	   struct vkms_crc_data *src)
> +{
> +	int i, j, j_dst, i_dst;
> +	int offset_src, offset_dst;
> +
> +	int x_src = src->src.x1 >> 16;
> +	int y_src = src->src.y1 >> 16;
> +
> +	int x_dst = src->dst.x1;
> +	int y_dst = src->dst.y1;
> +	int h_dst = drm_rect_height(&src->dst);
> +	int w_dst = drm_rect_width(&src->dst);
> +
> +	int y_limit = y_src + h_dst;
> +	int x_limit = x_src + w_dst;
> +
> +	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
> +		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
> +			offset_dst = dest->offset
> +				     + (i_dst * dest->pitch)
> +				     + (j_dst++ * dest->cpp);
> +			offset_src = src->offset
> +				     + (i * src->pitch)
> +				     + (j * src->cpp);
> +
> +			memcpy(vaddr_dst + offset_dst,
> +			       vaddr_src + offset_src, sizeof(u32));
> +		}
> +		i_dst++;
> +	}
> +}
> +
> +void compose_cursor(struct vkms_crc_data *cursor,
> +		    struct vkms_crc_data *primary, void *vaddr_out)
> +{
> +	struct drm_gem_object *cursor_obj;
> +	struct vkms_gem_object *cursor_vkms_obj;
> +
> +	cursor_obj = drm_gem_fb_get_obj(&cursor->fb, 0);
> +	cursor_vkms_obj = drm_gem_to_vkms_gem(cursor_obj);
> +
> +	if (WARN_ON(!cursor_vkms_obj->vaddr))
> +		return;
> +
> +	blend(vaddr_out, cursor_vkms_obj->vaddr, primary, cursor);
> +}
> +
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.h b/drivers/gpu/drm/vkms/vkms_composer.h
> new file mode 100644
> index 000000000000..53fdee17a632
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/vkms_composer.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef _VKMS_COMPOSER_H_
> +#define _VKMS_COMPOSER_H_
> +
> +void blend(void *vaddr_dst, void *vaddr_src, struct vkms_crc_data *dest,
> +	   struct vkms_crc_data *src);
> +
> +void compose_cursor(struct vkms_crc_data *cursor,
> +		    struct vkms_crc_data *primary, void *vaddr_out);
> +
> +#endif /* _VKMS_COMPOSER_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
> index 4b3146d83265..3c6a35aba494 100644
> --- a/drivers/gpu/drm/vkms/vkms_crc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  
>  #include "vkms_drv.h"
> +#include "vkms_composer.h"
>  #include <linux/crc32.h>
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -39,70 +40,6 @@ static uint32_t compute_crc(void *vaddr_out, struct vkms_crc_data *crc_out)
>  	return crc;
>  }
>  
> -/**
> - * blend - belnd value at vaddr_src with value at vaddr_dst
> - * @vaddr_dst: destination address
> - * @vaddr_src: source address
> - * @crc_dst: destination framebuffer's metadata
> - * @crc_src: source framebuffer's metadata
> - *
> - * Blend value at vaddr_src with value at vaddr_dst.
> - * Currently, this function write value at vaddr_src on value
> - * at vaddr_dst using buffer's metadata to locate the new values
> - * from vaddr_src and their distenation at vaddr_dst.
> - *
> - * Todo: Use the alpha value to blend vaddr_src with vaddr_dst
> - *	 instead of overwriting it.
> - */
> -static void blend(void *vaddr_dst, void *vaddr_src,
> -		  struct vkms_crc_data *crc_dst,
> -		  struct vkms_crc_data *crc_src)
> -{
> -	int i, j, j_dst, i_dst;
> -	int offset_src, offset_dst;
> -
> -	int x_src = crc_src->src.x1 >> 16;
> -	int y_src = crc_src->src.y1 >> 16;
> -
> -	int x_dst = crc_src->dst.x1;
> -	int y_dst = crc_src->dst.y1;
> -	int h_dst = drm_rect_height(&crc_src->dst);
> -	int w_dst = drm_rect_width(&crc_src->dst);
> -
> -	int y_limit = y_src + h_dst;
> -	int x_limit = x_src + w_dst;
> -
> -	for (i = y_src, i_dst = y_dst; i < y_limit; ++i) {
> -		for (j = x_src, j_dst = x_dst; j < x_limit; ++j) {
> -			offset_dst = crc_dst->offset
> -				     + (i_dst * crc_dst->pitch)
> -				     + (j_dst++ * crc_dst->cpp);
> -			offset_src = crc_src->offset
> -				     + (i * crc_src->pitch)
> -				     + (j * crc_src->cpp);
> -
> -			memcpy(vaddr_dst + offset_dst,
> -			       vaddr_src + offset_src, sizeof(u32));
> -		}
> -		i_dst++;
> -	}
> -}
> -
> -static void compose_cursor(struct vkms_crc_data *cursor_crc,
> -			   struct vkms_crc_data *primary_crc, void *vaddr_out)
> -{
> -	struct drm_gem_object *cursor_obj;
> -	struct vkms_gem_object *cursor_vkms_obj;
> -
> -	cursor_obj = drm_gem_fb_get_obj(&cursor_crc->fb, 0);
> -	cursor_vkms_obj = drm_gem_to_vkms_gem(cursor_obj);
> -
> -	if (WARN_ON(!cursor_vkms_obj->vaddr))
> -		return;
> -
> -	blend(vaddr_out, cursor_vkms_obj->vaddr, primary_crc, cursor_crc);
> -}
> -
>  static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
>  			      struct vkms_crc_data *cursor_crc)
>  {
> -- 
> 2.21.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
