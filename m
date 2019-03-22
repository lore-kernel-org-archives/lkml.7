Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEEEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D1D21874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfCVKl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:41:27 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53239 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfCVKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:41:26 -0400
X-Originating-IP: 90.88.33.153
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B0DAF1C0006;
        Fri, 22 Mar 2019 10:41:23 +0000 (UTC)
Message-ID: <56fc5712f080b7e9dbf933acab8870811d4443c9.camel@bootlin.com>
Subject: Re: [PATCH 4/7] drm/vc4: Use drm_printer for the debugfs and
 runtime bo stats output.
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Date:   Fri, 22 Mar 2019 11:41:23 +0100
In-Reply-To: <20190220210343.28157-4-eric@anholt.net>
References: <20190220210343.28157-1-eric@anholt.net>
         <20190220210343.28157-4-eric@anholt.net>
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

Le mercredi 20 février 2019 à 13:03 -0800, Eric Anholt a écrit :
> Now I can extend the stats without more copy and pasting between the
> two.

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/vc4/vc4_bo.c | 48 +++++++++++-------------------------
>  1 file changed, 14 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index 8c509d560bf0..88ebd681d7eb 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -40,7 +40,7 @@ static bool is_user_label(int label)
>  	return label >= VC4_BO_TYPE_COUNT;
>  }
>  
> -static void vc4_bo_stats_dump(struct vc4_dev *vc4)
> +static void vc4_bo_stats_print(struct drm_printer *p, struct vc4_dev *vc4)
>  {
>  	int i;
>  
> @@ -48,21 +48,21 @@ static void vc4_bo_stats_dump(struct vc4_dev *vc4)
>  		if (!vc4->bo_labels[i].num_allocated)
>  			continue;
>  
> -		DRM_INFO("%30s: %6dkb BOs (%d)\n",
> -			 vc4->bo_labels[i].name,
> -			 vc4->bo_labels[i].size_allocated / 1024,
> -			 vc4->bo_labels[i].num_allocated);
> +		drm_printf(p, "%30s: %6dkb BOs (%d)\n",
> +			   vc4->bo_labels[i].name,
> +			   vc4->bo_labels[i].size_allocated / 1024,
> +			   vc4->bo_labels[i].num_allocated);
>  	}
>  
>  	mutex_lock(&vc4->purgeable.lock);
>  	if (vc4->purgeable.num)
> -		DRM_INFO("%30s: %6zdkb BOs (%d)\n", "userspace BO cache",
> -			 vc4->purgeable.size / 1024, vc4->purgeable.num);
> +		drm_printf(p, "%30s: %6zdkb BOs (%d)\n", "userspace BO cache",
> +			   vc4->purgeable.size / 1024, vc4->purgeable.num);
>  
>  	if (vc4->purgeable.purged_num)
> -		DRM_INFO("%30s: %6zdkb BOs (%d)\n", "total purged BO",
> -			 vc4->purgeable.purged_size / 1024,
> -			 vc4->purgeable.purged_num);
> +		drm_printf(p, "%30s: %6zdkb BOs (%d)\n", "total purged BO",
> +			   vc4->purgeable.purged_size / 1024,
> +			   vc4->purgeable.purged_num);
>  	mutex_unlock(&vc4->purgeable.lock);
>  }
>  
> @@ -71,30 +71,9 @@ static int vc4_bo_stats_debugfs(struct seq_file *m, void *unused)
>  	struct drm_info_node *node = (struct drm_info_node *)m->private;
>  	struct drm_device *dev = node->minor->dev;
>  	struct vc4_dev *vc4 = to_vc4_dev(dev);
> -	int i;
> -
> -	mutex_lock(&vc4->bo_lock);
> -	for (i = 0; i < vc4->num_labels; i++) {
> -		if (!vc4->bo_labels[i].num_allocated)
> -			continue;
> -
> -		seq_printf(m, "%30s: %6dkb BOs (%d)\n",
> -			   vc4->bo_labels[i].name,
> -			   vc4->bo_labels[i].size_allocated / 1024,
> -			   vc4->bo_labels[i].num_allocated);
> -	}
> -	mutex_unlock(&vc4->bo_lock);
> +	struct drm_printer p = drm_seq_file_printer(m);
>  
> -	mutex_lock(&vc4->purgeable.lock);
> -	if (vc4->purgeable.num)
> -		seq_printf(m, "%30s: %6zdkb BOs (%d)\n", "userspace BO cache",
> -			   vc4->purgeable.size / 1024, vc4->purgeable.num);
> -
> -	if (vc4->purgeable.purged_num)
> -		seq_printf(m, "%30s: %6zdkb BOs (%d)\n", "total purged BO",
> -			   vc4->purgeable.purged_size / 1024,
> -			   vc4->purgeable.purged_num);
> -	mutex_unlock(&vc4->purgeable.lock);
> +	vc4_bo_stats_print(&p, vc4);
>  
>  	return 0;
>  }
> @@ -473,8 +452,9 @@ struct vc4_bo *vc4_bo_create(struct drm_device *dev, size_t unaligned_size,
>  	}
>  
>  	if (IS_ERR(cma_obj)) {
> +		struct drm_printer p = drm_info_printer(vc4->dev->dev);
>  		DRM_ERROR("Failed to allocate from CMA:\n");
> -		vc4_bo_stats_dump(vc4);
> +		vc4_bo_stats_print(&p, vc4);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  	bo = to_vc4_bo(&cma_obj->base);
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

