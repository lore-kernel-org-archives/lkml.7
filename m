Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F82C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083BB2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="fpYfibG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDITkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:40:14 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:39521 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDITkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=9WdSrjnAd41V1IOMB8YXCj8EZHL+jmsS8nPtXKPbRR8=;
        b=fpYfibG1wGpkf7XTkxoTtn7Zz77VS89Pbvtj7UUyDQJ9CB2h8KAzfPTLJMu2TRBm0vNHJ2Vw5eWtkpMcMpDibP1FYxsAgdUjA93fRWS40d6GN3rui/VO6bETBK/5ZbAw1FWbPvdQyYLqvvex117szLGW00uYj71N6CpNYwmw9FHA0xkDJKI9Ea7iTyQekNZljvqOEtaVnkyTSfy1OGQ6jvSVzw8UAYHe78PJJ2NOljBG/iDis57YYdeCSzhZ7llrdLHmCtTmI5qUYA+gciBwUA41vJTgOoZiHuGZI96StVz6VerXnWX20HRAOPPr9UgSkLz9ikP5QqvxEjFVjjYI4Q==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:60176 helo=[192.168.10.179])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1hDwbK-0004sE-3e; Tue, 09 Apr 2019 21:40:10 +0200
Subject: Re: [PATCH 2/4] drm: use convert_lines() in xrgb8888_to_rgb565
 helpers.
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     sam@ravnborg.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20190409115913.3468-1-kraxel@redhat.com>
 <20190409115913.3468-3-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <12a38d65-1d8d-6870-13e7-32089d8c93b0@tronnes.org>
Date:   Tue, 9 Apr 2019 21:40:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409115913.3468-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 09.04.2019 13.59, skrev Gerd Hoffmann:
> Also add two conversion functions for the swab / not swab cases.
> That way we have to check the swab flag only once.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 117 +++++++++++++++-------------
>  1 file changed, 62 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index f32e0173600c..b8d17cd0a9f8 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -38,6 +38,46 @@ static struct drm_format_convert convert_swab16 = {
>  	.func = convert_swab16_fn,
>  };
>  
> +static void convert_xrgb8888_to_rgb565_fn(void *dst, void *src, u32 pixels)
> +{
> +	u32 *sbuf = src;
> +	u16 *dbuf = dst;
> +	u32 x;
> +
> +	for (x = 0; x < pixels; x++) {
> +		dbuf[x] = ((sbuf[x] & 0x00F80000) >> 8) |
> +			((sbuf[x] & 0x0000FC00) >> 5) |
> +			((sbuf[x] & 0x000000F8) >> 3);
> +	}
> +}
> +
> +static struct drm_format_convert convert_xrgb8888_to_rgb565 = {
> +	.dst_cpp = 2,
> +	.src_cpp = 4,
> +	.func = convert_xrgb8888_to_rgb565_fn,
> +};
> +
> +static void convert_xrgb8888_to_rgb565_swab_fn(void *dst, void *src, u32 pixels)
> +{
> +	u32 *sbuf = src;
> +	u16 *dbuf = dst;
> +	u16 val16;
> +	u32 x;
> +
> +	for (x = 0; x < pixels; x++) {
> +		val16 = ((sbuf[x] & 0x00F80000) >> 8) |
> +			((sbuf[x] & 0x0000FC00) >> 5) |
> +			((sbuf[x] & 0x000000F8) >> 3);
> +		dbuf[x] = swab16(val16);
> +	}
> +}
> +
> +static struct drm_format_convert convert_xrgb8888_to_rgb565_swap = {
> +	.dst_cpp = 2,
> +	.src_cpp = 4,
> +	.func = convert_xrgb8888_to_rgb565_swab_fn,
> +};
> +

I find that drm_format_convert makes the code more difficult to read.
The only shared code is the xrgb8888 to rgb565 conversion.

Can we do something like this instead:

static void drm_fb_xrgb8888_to_rgb565_line(u16 *dst, u32 *src, unsigned
int width, bool swap)
{
	unsigned int x;

	for (x = 0; x < width; x++) {
		u16 val = ((*src & 0x00F80000) >> 8) |
			  ((*src & 0x0000FC00) >> 5) |
			  ((*src & 0x000000F8) >> 3);
		src++;
		if (swap)
			*dst++ = swab16(val);
		else
			*dst++ = val;
	}
}

void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
			       struct drm_framebuffer *fb,
			       struct drm_rect *clip, bool swap)
{
	void *src = vaddr + clip_offset(clip, fb->pitches[0], 4);
	unsigned width = clip->x2 - clip->x1;
	unsigned height = clip->y2 - clip->y1;
	size_t src_clip_pitch = width * 4;
	size_t dst_clip_pitch = width * 2;
	unsigned int y;
	void *sbuf;

	/*
	 * The cma memory is write-combined so reads are uncached.
	 * Speed up by fetching one line at a time.
	 */
	sbuf = kmalloc(src_clip_pitch, GFP_KERNEL);
	if (!sbuf)
		return;

	for (y = 0; y < height; y++) {
		memcpy(sbuf, src, src_clip_pitch);

		drm_fb_xrgb8888_to_rgb565_line(dst, sbuf, width, swap);

		src += fb->pitches[0];
		dst += dst_clip_pitch;
	}

	kfree(sbuf);
}
EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);

void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst,
				       unsigned int dst_pitch,
				       void *vaddr, struct drm_framebuffer *fb,
				       struct drm_rect *clip, bool swap)
{
	void *src = vaddr + clip_offset(clip, fb->pitches[0], 4);
	unsigned width = clip->x2 - clip->x1;
	unsigned height = clip->y2 - clip->y1;
	size_t dst_clip_pitch = width * 2;
	unsigned int y;
	void *dbuf;

	dst += clip_offset(clip, dst_pitch, 2);

	dbuf = kmalloc(dst_clip_pitch, GFP_KERNEL);
	if (!dbuf)
		return;

	for (y = 0; y < height; y++) {
		drm_fb_xrgb8888_to_rgb565_line(dbuf, src, width, swap);

		memcpy_toio(dst, dbuf, dst_clip_pitch);

		src += fb->pitches[0];
		dst += dst_pitch;
	}

	kfree(dbuf);
}
EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);


Other things I noticed:

drm_fb_memcpy() is just a wrapper around drm_fb_memcpy_lines() and
drm_fb_memcpy_dstclip() around drm_fb_memcpy_lines_toio(). They can be
merged.

checkpatch gave this:

WARNING: Use #include <linux/io.h> instead of <asm/io.h>
#50: FILE: drivers/gpu/drm/drm_format_helper.c:14:
+#include <asm/io.h>

Noralf.

>  static void convert_lines(void *dst, unsigned int dst_pitch,
>  			  void *src, unsigned int src_pitch,
>  			  unsigned int pixels,
> @@ -152,44 +192,6 @@ void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
>  }
>  EXPORT_SYMBOL(drm_fb_swab16);
>  
> -static void drm_fb_xrgb8888_to_rgb565_lines(void *dst, unsigned int dst_pitch,
> -					    void *src, unsigned int src_pitch,
> -					    unsigned int src_linelength,
> -					    unsigned int lines,
> -					    bool swap)
> -{
> -	unsigned int linepixels = src_linelength / sizeof(u32);
> -	unsigned int x, y;
> -	u32 *sbuf;
> -	u16 *dbuf, val16;
> -
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
> -	}
> -
> -	kfree(sbuf);
> -}
> -
>  /**
>   * drm_fb_xrgb8888_to_rgb565 - Convert XRGB8888 to RGB565 clip buffer
>   * @dst: RGB565 destination buffer
> @@ -208,15 +210,17 @@ void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
>  			       struct drm_framebuffer *fb,
>  			       struct drm_rect *clip, bool swap)
>  {
> -	unsigned int src_offset = (clip->y1 * fb->pitches[0])
> -		+ (clip->x1 * sizeof(u32));
> -	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
> -	size_t dst_len = (clip->x2 - clip->x1) * sizeof(u16);
> +	struct drm_format_convert *conv = swap
> +		? &convert_xrgb8888_to_rgb565_swap
> +		: &convert_xrgb8888_to_rgb565;
> +	unsigned int src_offset =
> +		clip_offset(clip, fb->pitches[0], conv->src_cpp);
> +	size_t pixels = (clip->x2 - clip->x1);
> +	size_t lines = (clip->y2 - clip->y1);
>  
> -	drm_fb_xrgb8888_to_rgb565_lines(dst, dst_len,
> -					vaddr + src_offset, fb->pitches[0],
> -					src_len, clip->y2 - clip->y1,
> -					swap);
> +	convert_lines(dst, pixels * conv->dst_cpp,
> +		      vaddr + src_offset, fb->pitches[0],
> +		      pixels, lines, conv);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
>  
> @@ -239,16 +243,19 @@ void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
>  				       void *vaddr, struct drm_framebuffer *fb,
>  				       struct drm_rect *clip, bool swap)
>  {
> -	unsigned int src_offset = (clip->y1 * fb->pitches[0])
> -		+ (clip->x1 * sizeof(u32));
> -	unsigned int dst_offset = (clip->y1 * dst_pitch)
> -		+ (clip->x1 * sizeof(u16));
> -	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
> +	struct drm_format_convert *conv = swap
> +		? &convert_xrgb8888_to_rgb565_swap
> +		: &convert_xrgb8888_to_rgb565;
> +	unsigned int src_offset =
> +		clip_offset(clip, fb->pitches[0], conv->src_cpp);
> +	unsigned int dst_offset =
> +		clip_offset(clip, dst_pitch, conv->dst_cpp);
> +	size_t pixels = (clip->x2 - clip->x1);
> +	size_t lines = (clip->y2 - clip->y1);
>  
> -	drm_fb_xrgb8888_to_rgb565_lines(dst + dst_offset, dst_pitch,
> -					vaddr + src_offset, fb->pitches[0],
> -					src_len, clip->y2 - clip->y1,
> -					swap);
> +	convert_lines(dst + dst_offset, dst_pitch,
> +		      vaddr + src_offset, fb->pitches[0],
> +		      pixels, lines, conv);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
>  
> 
