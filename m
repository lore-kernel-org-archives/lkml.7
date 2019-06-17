Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C71C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCB9206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfFQNcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:32:16 -0400
Received: from foss.arm.com ([217.140.110.172]:50142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfFQNcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:32:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3CC8344;
        Mon, 17 Jun 2019 06:32:14 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A43BE3F246;
        Mon, 17 Jun 2019 06:32:14 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 67DD5682413; Mon, 17 Jun 2019 14:32:13 +0100 (BST)
Date:   Mon, 17 Jun 2019 14:32:13 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James (Qian) Wang" <james.qian.wang@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/komeda: fix size_t format string
Message-ID: <20190617133213.GY4173@e110455-lin.cambridge.arm.com>
References: <20190617125002.1312331-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190617125002.1312331-1-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Jun 17, 2019 at 02:49:18PM +0200, Arnd Bergmann wrote:
> The debug output uses the wrong format string for printing a size_t:
> 
> In file included from include/drm/drm_mm.h:49,
>                  from include/drm/drm_vma_manager.h:26,
>                  from include/drm/drm_gem.h:40,
>                  from drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c:9:
> drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c: In function 'komeda_fb_afbc_size_check':
> drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c:96:17: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.\n",
> 
> This is harmless in the kernel as size_t and long are always the same
> width, but it's always better to use the correct format string
> to shut up the warning.
> 
> Fixes: 9ccf536e53cb ("drm/komeda: Added AFBC support for komeda driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for the patch! I did see the warning email sent by the build bots and
I've had the same fix in my stash, but then I've looked at the code using
min_size and I'm not happy with it, so I've asked James to come up with a patch
to fix things in a better way.

So, if you don't mind, I will delay this patch until James comes up with a fix
in the next couple of days. If he is not, then I'll pull the patch into mali-dp
tree (shared with komeda).

Best regards,
Liviu


> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index abc8c0ccc053..58ff34e718d0 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -93,7 +93,7 @@ komeda_fb_afbc_size_check(struct komeda_fb *kfb, struct drm_file *file,
>  			       AFBC_SUPERBLK_ALIGNMENT);
>  	min_size = kfb->afbc_size + fb->offsets[0];
>  	if (min_size > obj->size) {
> -		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%lx. min_size 0x%x.\n",
> +		DRM_DEBUG_KMS("afbc size check failed, obj_size: 0x%zx. min_size 0x%x.\n",
>  			      obj->size, min_size);
>  		goto check_failed;
>  	}
> @@ -137,7 +137,7 @@ komeda_fb_none_afbc_size_check(struct komeda_dev *mdev, struct komeda_fb *kfb,
>  		min_size = komeda_fb_get_pixel_addr(kfb, 0, fb->height, i)
>  			 - to_drm_gem_cma_obj(obj)->paddr;
>  		if (obj->size < min_size) {
> -			DRM_DEBUG_KMS("The fb->obj[%d] size: %ld lower than the minimum requirement: %d.\n",
> +			DRM_DEBUG_KMS("The fb->obj[%d] size: %zd lower than the minimum requirement: %d.\n",
>  				      i, obj->size, min_size);
>  			return -EINVAL;
>  		}
> -- 
> 2.20.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
