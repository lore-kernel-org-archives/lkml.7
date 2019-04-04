Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C8DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DF0206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfDDRRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:17:23 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:55898 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbfDDRRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:17:22 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 2AA838037F;
        Thu,  4 Apr 2019 19:17:20 +0200 (CEST)
Date:   Thu, 4 Apr 2019 19:17:18 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 4/6] drm: add dstclip parameter to
 drm_fb_xrgb8888_to_rgb565()
Message-ID: <20190404171718.GF23897@ravnborg.org>
References: <20190404152430.8263-1-kraxel@redhat.com>
 <20190404152430.8263-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404152430.8263-5-kraxel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8
        a=cXxxXYB-JrVh0EPT2CgA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 05:24:28PM +0200, Gerd Hoffmann wrote:
> When set apply clipping logic to destination too.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_fb_helper.h        | 3 ++-
>  drivers/gpu/drm/drm_fb_helper.c    | 8 +++++++-
>  drivers/gpu/drm/tinydrm/mipi-dbi.c | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 0350c7e9d6ba..1406057e1a93 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -646,6 +646,7 @@ void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
>  		   struct drm_rect *clip, bool dstclip);
>  void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
>  			       struct drm_framebuffer *fb,
> -			       struct drm_rect *clip, bool swap);
> +			       struct drm_rect *clip,
> +			       bool swap, bool dstclip);
>  
>  #endif
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 087e49741094..2c9286702c3f 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -3388,13 +3388,15 @@ EXPORT_SYMBOL(drm_fb_memcpy);
>   * @fb: DRM framebuffer
>   * @clip: Clip rectangle area to copy
>   * @swap: Swap bytes
> + * @dstclip: Clip destination too.
>   *
>   * Drivers can use this function for RGB565 devices that don't natively
>   * support XRGB8888.
>   */
>  void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
>  			       struct drm_framebuffer *fb,
> -			       struct drm_rect *clip, bool swap)
> +			       struct drm_rect *clip,
> +			       bool swap, bool dstclip)
>  {
>  	size_t len = (clip->x2 - clip->x1) * sizeof(u32);
>  	unsigned int x, y;
> @@ -3405,6 +3407,8 @@ void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
>  	if (!buf)
>  		return;
>  
> +	if (dstclip)
> +		dst += clip->y1 * fb->width + clip->x1;
>  	for (y = clip->y1; y < clip->y2; y++) {
>  		src = vaddr + (y * fb->pitches[0]);
>  		src += clip->x1;
> @@ -3420,6 +3424,8 @@ void drm_fb_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
>  			else
>  				*dst++ = val16;
>  		}
> +		if (dstclip)
> +			dst += fb->width - (clip->x2 - clip->x1);
>  	}

Same story as before with dstclip and boolean parameters to functions.
A small helper and you had two functions with and without clip.

	Sam
