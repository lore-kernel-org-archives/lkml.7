Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79C7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CDE22327
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfDPNvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:51:01 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49581 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDPNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:51:00 -0400
X-Originating-IP: 90.88.160.238
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 45F49C0003;
        Tue, 16 Apr 2019 13:50:58 +0000 (UTC)
Message-ID: <45faa897686eb390122da5813b92e4d2cd22d970.camel@bootlin.com>
Subject: Re: [PATCH] drm/sun4i: Use DRM_GEM_CMA_VMAP_DRIVER_OPS for GEM
 operations
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Tue, 16 Apr 2019 15:50:57 +0200
In-Reply-To: <20190415161543.13831-1-paul.kocialkowski@bootlin.com>
References: <20190415161543.13831-1-paul.kocialkowski@bootlin.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lundi 15 avril 2019 à 18:15 +0200, Paul Kocialkowski a écrit :
> Our driver makes a typical use of CMA, with GEM object allocated as
> GEM CMA objects. Use DRM_GEM_CMA_VMAP_DRIVER_OPS to describe the ops
> instead of duplicating them.
> 
> Because DRM_GEM_CMA_VMAP_DRIVER_OPS implements a gem_create_object op
> which sets per-object funcs (drm_cma_gem_default_funcs), we can also
> get rid of free_object_unlocked and gem_vm_ops, which are superseded
> by the object funcs.

I'll need to respin this one by moving DRM_GEM_CMA_VMAP_DRIVER_OPS
before our custom dumb_create, otherwise DRM_GEM_CMA_VMAP_DRIVER_OPS's
dumb_create will take effect instead of our own.

Cheers,

Paul

> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 3ebd9f5e2719..453b94f9a5b7 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -53,21 +53,7 @@ static struct drm_driver sun4i_drv_driver = {
>  
>  	/* GEM Operations */
>  	.dumb_create		= drm_sun4i_gem_dumb_create,
> -	.gem_free_object_unlocked = drm_gem_cma_free_object,
> -	.gem_vm_ops		= &drm_gem_cma_vm_ops,
> -
> -	/* PRIME Operations */
> -	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> -	.gem_prime_import	= drm_gem_prime_import,
> -	.gem_prime_export	= drm_gem_prime_export,
> -	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
> -	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
> -	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
> -
> -	/* Frame Buffer Operations */
> +	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>  };
>  
>  static int sun4i_drv_bind(struct device *dev)
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

