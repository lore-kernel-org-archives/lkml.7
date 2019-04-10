Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA07C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4F320830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="e2nbCP7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfDJJoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:44:46 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:59167 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfDJJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=25ynVbibFybtdYtgianPrWLvZ6ntJmnWNDp8b2gKwLM=;
        b=e2nbCP7P46Cy0w6VYhgGTXYpYpm9iPZp/EDnkI772z8aVsxVxMG/0oyRBep+u2Li3/xwpbDW9Zdh/rScb40H5yrH+piB/DtItLOiUKF84fhZxl98T2ZE/oHfLKRUy3ay+2AuIaCRdDXzU4pVKzLpAAmD17tW5y2DVMDTQFjIRSbz/IZQAcKz9GBOzS+k0fGvJkVDXpWq3nG1LXacd78/ykOtq2Yx3H3IxirSRFSalmb0bRK41jJvysACbpV4SPCdZAUnCE5IqlLKv5Nm/jhvI57ppLWYDYw7EGpkyMyJdZh5RcPJF2W6RykNXI7GXoE4JPoi+gqZ4kJC4O1vSARmcA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:51264 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hE9mc-0001hf-Ak; Wed, 10 Apr 2019 11:44:42 +0200
Subject: Re: [PATCH v2 2/3] drm: switch drm_fb_xrgb8888_to_rgb565_dstclip to
 accept __iomem dst
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
References: <20190410063815.17062-1-kraxel@redhat.com>
 <20190410063815.17062-3-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <8ea50c01-d3bb-c5d4-1ab4-6752654c0e76@tronnes.org>
Date:   Wed, 10 Apr 2019 11:44:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410063815.17062-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 10.04.2019 08.38, skrev Gerd Hoffmann:
> Not all archs have the __io_virt() macro, so cirrus can't simply convert
> pointers that way.  The drm format helpers have to use memcpy_toio()
> instead.
> 
> This patch makes drm_fb_xrgb8888_to_rgb565_dstclip() accept a __iomem
> dst pointer and use memcpy_toio() instead of memcpy().  The helper
> function (drm_fb_xrgb8888_to_rgb565_line) has been changed to process
> a single scanline.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_format_helper.h     |   2 +-
>  drivers/gpu/drm/cirrus/cirrus.c     |   2 +-
>  drivers/gpu/drm/drm_format_helper.c | 113 ++++++++++++++--------------
>  3 files changed, 60 insertions(+), 57 deletions(-)
> 
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
> index bc2e1004e166..d1b8a9ea01b4 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -23,7 +23,7 @@ void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
>  void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
>  			       struct drm_framebuffer *fb,
>  			       struct drm_rect *clip, bool swap);
> -void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
> +void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst, unsigned int dst_pitch,
>  				       void *vaddr, struct drm_framebuffer *fb,
>  				       struct drm_rect *clip, bool swap);
>  void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
> index 0fc3aa31b5a4..ed2f2d8cfb6f 100644
> --- a/drivers/gpu/drm/cirrus/cirrus.c
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -311,7 +311,7 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
>  				      vmap, fb, rect);
>  
>  	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 2)
> -		drm_fb_xrgb8888_to_rgb565_dstclip(__io_virt(cirrus->vram),
> +		drm_fb_xrgb8888_to_rgb565_dstclip(cirrus->vram,
>  						  cirrus->pitch,
>  						  vmap, fb, rect, false);
>  
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index dace05638bc3..c9521af4e90b 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -113,42 +113,22 @@ void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
>  }
>  EXPORT_SYMBOL(drm_fb_swab16);
>  
> -static void drm_fb_xrgb8888_to_rgb565_lines(void *dst, unsigned int dst_pitch,
> -					    void *src, unsigned int src_pitch,
> -					    unsigned int src_linelength,
> -					    unsigned int lines,
> -					    bool swap)
> +static void drm_fb_xrgb8888_to_rgb565_line(u16 *dbuf, u32 *sbuf,
> +					   unsigned int pixels,
> +					   bool swab)

Both here and further down you change the argument name: swap -> swab.
If you want that, you need to fix the function declaration and the docs
as well.

With that sorted out:
Reviewed-by: Noralf Trønnes <noralf@tronnes.org>


>  {
> -	unsigned int linepixels = src_linelength / sizeof(u32);
> -	unsigned int x, y;
> -	u32 *sbuf;
> -	u16 *dbuf, val16;
> +	unsigned int x;
> +	u16 val16;
>  
> -	/*
> -	 * The cma memory is write-combined so reads are uncached.
> -	 * Speed up by fetching one line at a time.
> -	 */
> -	sbuf = kmalloc(src_linelength, GFP_KERNEL);
> -	if (!sbuf)
> -		return;
> -
> -	for (y = 0; y < lines; y++) {
> -		memcpy(sbuf, src, src_linelength);
> -		dbuf = dst;
> -		for (x = 0; x < linepixels; x++) {
> -			val16 = ((sbuf[x] & 0x00F80000) >> 8) |
> -				((sbuf[x] & 0x0000FC00) >> 5) |
> -				((sbuf[x] & 0x000000F8) >> 3);
> -			if (swap)
> -				*dbuf++ = swab16(val16);
> -			else
> -				*dbuf++ = val16;
> -		}
> -		src += src_pitch;
> -		dst += dst_pitch;
> +	for (x = 0; x < pixels; x++) {
> +		val16 = ((sbuf[x] & 0x00F80000) >> 8) |
> +			((sbuf[x] & 0x0000FC00) >> 5) |
> +			((sbuf[x] & 0x000000F8) >> 3);
> +		if (swab)
> +			dbuf[x] = swab16(val16);
> +		else
> +			dbuf[x] = val16;
>  	}
> -
> -	kfree(sbuf);
>  }
>  
>  /**
> @@ -167,23 +147,37 @@ static void drm_fb_xrgb8888_to_rgb565_lines(void *dst, unsigned int dst_pitch,
>   */
>  void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
>  			       struct drm_framebuffer *fb,
> -			       struct drm_rect *clip, bool swap)
> +			       struct drm_rect *clip, bool swab)
>  {
> -	unsigned int src_offset = (clip->y1 * fb->pitches[0])
> -		+ (clip->x1 * sizeof(u32));
> -	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
> -	size_t dst_len = (clip->x2 - clip->x1) * sizeof(u16);
> +	size_t linepixels = clip->x2 - clip->x1;
> +	size_t src_len = linepixels * sizeof(u32);
> +	size_t dst_len = linepixels * sizeof(u16);
> +	unsigned y, lines = clip->y2 - clip->y1;
> +	void *sbuf;
>  
> -	drm_fb_xrgb8888_to_rgb565_lines(dst, dst_len,
> -					vaddr + src_offset, fb->pitches[0],
> -					src_len, clip->y2 - clip->y1,
> -					swap);
> +	/*
> +	 * The cma memory is write-combined so reads are uncached.
> +	 * Speed up by fetching one line at a time.
> +	 */
> +	sbuf = kmalloc(src_len, GFP_KERNEL);
> +	if (!sbuf)
> +		return;
> +
> +	vaddr += clip_offset(clip, fb->pitches[0], sizeof(u32));
> +	for (y = 0; y < lines; y++) {
> +		memcpy(sbuf, vaddr, src_len);
> +		drm_fb_xrgb8888_to_rgb565_line(dst, sbuf, linepixels, swab);
> +		vaddr += fb->pitches[0];
> +		dst += dst_len;
> +	}
> +
> +	kfree(sbuf);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
>  
>  /**
>   * drm_fb_xrgb8888_to_rgb565_dstclip - Convert XRGB8888 to RGB565 clip buffer
> - * @dst: RGB565 destination buffer
> + * @dst: RGB565 destination buffer (iomem)
>   * @dst_pitch: destination buffer pitch
>   * @vaddr: XRGB8888 source buffer
>   * @fb: DRM framebuffer
> @@ -194,22 +188,31 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
>   * support XRGB8888.
>   *
>   * This function applies clipping on dst, i.e. the destination is a
> - * full framebuffer but only the clip rect content is copied over.
> + * full (iomem) framebuffer but only the clip rect content is copied over.
>   */
> -void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
> +void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst, unsigned int dst_pitch,
>  				       void *vaddr, struct drm_framebuffer *fb,
> -				       struct drm_rect *clip, bool swap)
> +				       struct drm_rect *clip, bool swab)
>  {
> -	unsigned int src_offset = (clip->y1 * fb->pitches[0])
> -		+ (clip->x1 * sizeof(u32));
> -	unsigned int dst_offset = (clip->y1 * dst_pitch)
> -		+ (clip->x1 * sizeof(u16));
> -	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
> +	size_t linepixels = clip->x2 - clip->x1;
> +	size_t dst_len = linepixels * sizeof(u16);
> +	unsigned y, lines = clip->y2 - clip->y1;
> +	void *dbuf;
>  
> -	drm_fb_xrgb8888_to_rgb565_lines(dst + dst_offset, dst_pitch,
> -					vaddr + src_offset, fb->pitches[0],
> -					src_len, clip->y2 - clip->y1,
> -					swap);
> +	dbuf = kmalloc(dst_len, GFP_KERNEL);
> +	if (!dbuf)
> +		return;
> +
> +	vaddr += clip_offset(clip, fb->pitches[0], sizeof(u32));
> +	dst += clip_offset(clip, dst_pitch, sizeof(u16));
> +	for (y = 0; y < lines; y++) {
> +		drm_fb_xrgb8888_to_rgb565_line(dbuf, vaddr, linepixels, swab);
> +		memcpy_toio(dst, dbuf, dst_len);
> +		vaddr += fb->pitches[0];
> +		dst += dst_len;
> +	}
> +
> +	kfree(dbuf);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
>  
> 
