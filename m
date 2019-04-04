Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6507C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC54206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfDDRE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:04:58 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:55350 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:04:57 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id C3E298043C;
        Thu,  4 Apr 2019 19:04:54 +0200 (CEST)
Date:   Thu, 4 Apr 2019 19:04:53 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 1/6] drm: move tinydrm_memcpy() to drm_fb_helper.c
Message-ID: <20190404170453.GB23897@ravnborg.org>
References: <20190404152430.8263-1-kraxel@redhat.com>
 <20190404152430.8263-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404152430.8263-2-kraxel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8
        a=7gkXJVJtAAAA:8 a=L4-8VaEhRMSmCmg8aTYA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd.

On Thu, Apr 04, 2019 at 05:24:25PM +0200, Gerd Hoffmann wrote:
> Also rename to drm_fb_memcpy().
> Pure code motion, no functional change.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_fb_helper.h                   |  3 +++
>  include/drm/tinydrm/tinydrm-helpers.h         |  2 --
>  drivers/gpu/drm/drm_fb_helper.c               | 25 +++++++++++++++++++
>  .../gpu/drm/tinydrm/core/tinydrm-helpers.c    | 24 ------------------
>  drivers/gpu/drm/tinydrm/mipi-dbi.c            |  3 ++-
>  5 files changed, 30 insertions(+), 27 deletions(-)
> 
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index 81ae48a0df48..696017b38add 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -642,4 +642,7 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
>  #endif
>  }
>  
> +void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
> +		   struct drm_rect *clip);
> +
>  #endif
> diff --git a/include/drm/tinydrm/tinydrm-helpers.h b/include/drm/tinydrm/tinydrm-helpers.h
> index ae4a6abc43b5..591ca83330c4 100644
> --- a/include/drm/tinydrm/tinydrm-helpers.h
> +++ b/include/drm/tinydrm/tinydrm-helpers.h
> @@ -46,8 +46,6 @@ int tinydrm_display_pipe_init(struct drm_device *drm,
>  			      const struct drm_display_mode *mode,
>  			      unsigned int rotation);
>  
> -void tinydrm_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
> -		    struct drm_rect *clip);
>  void tinydrm_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
>  		    struct drm_rect *clip);
>  void tinydrm_xrgb8888_to_rgb565(u16 *dst, void *vaddr,
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 03749a24e4dd..22d29834bbe9 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -3353,3 +3353,28 @@ int __init drm_fb_helper_modinit(void)
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_fb_helper_modinit);
> +
> +/**
> + * drm_fb_memcpy - Copy clip buffer
> + * @dst: Destination buffer
> + * @vaddr: Source buffer
> + * @fb: DRM framebuffer
> + * @clip: Clip rectangle area to copy
> + * @dstclip: Clip destination too.
> + */
> +void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
> +		   struct drm_rect *clip)
Function has no parameter named @dstclip.

With this fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
