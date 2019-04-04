Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC7120700
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfDDRJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:09:47 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:55491 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfDDRJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:09:46 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 0348D803E1;
        Thu,  4 Apr 2019 19:09:41 +0200 (CEST)
Date:   Thu, 4 Apr 2019 19:09:40 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 2/6] drm: add dstclip parameter to drm_fb_memcpy()
Message-ID: <20190404170940.GC23897@ravnborg.org>
References: <20190404152430.8263-1-kraxel@redhat.com>
 <20190404152430.8263-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404152430.8263-3-kraxel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8
        a=e5mUnYsNAAAA:8 a=ma_ECkAkj-f6IhxLhs8A:9 a=CjuIK1q_8ugA:10
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd.

Good to see these small incremental patches, and I recognize the parameter
from PATCH 1.

On Thu, Apr 04, 2019 at 05:24:26PM +0200, Gerd Hoffmann wrote:
> When set apply clipping logic to destination too.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_fb_helper.h        | 2 +-
>  drivers/gpu/drm/drm_fb_helper.c    | 6 ++++--
>  drivers/gpu/drm/tinydrm/mipi-dbi.c | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 696017b38add..a57420f40643 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -643,6 +643,6 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
>  }
>  
>  void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
> -		   struct drm_rect *clip);
> +		   struct drm_rect *clip, bool dstclip);
>  
>  #endif
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 22d29834bbe9..fabeb408dce6 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -3363,7 +3363,7 @@ EXPORT_SYMBOL(drm_fb_helper_modinit);
>   * @dstclip: Clip destination too.
>   */
>  void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
> -		   struct drm_rect *clip)
> +		   struct drm_rect *clip, bool dstclip)

Not a huge fan of boolean parameters that decide what a simple
helper function should do.
Would have preferred two small helpers despite the small code duplication:

	drm_fb_memcpy()
	drm_fb_dstclip_memcpy()


>  {
>  	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
>  	unsigned int pitch = fb->pitches[0];
> @@ -3371,10 +3371,12 @@ void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
>  	size_t len = (clip->x2 - clip->x1) * cpp;
>  	unsigned int y;
>  
> +	if (dstclip)
> +		dst += (clip->y1 * pitch) + (clip->x1 * cpp);
Add newline?

>  	for (y = clip->y1; y < clip->y2; y++) {
>  		memcpy(dst, src, len);
>  		src += pitch;
> -		dst += len;
> +		dst += dstclip ? pitch : len;
>  	}
>  }
>  EXPORT_SYMBOL(drm_fb_memcpy);
> diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> index fb7e4582e293..e26fd61360a3 100644
> --- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
> +++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
> @@ -221,7 +221,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
>  		if (swap)
>  			tinydrm_swab16(dst, src, fb, clip);
>  		else
> -			drm_fb_memcpy(dst, src, fb, clip);
> +			drm_fb_memcpy(dst, src, fb, clip, false);
>  		break;
>  	case DRM_FORMAT_XRGB8888:
>  		tinydrm_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
> -- 
> 2.18.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
