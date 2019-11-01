Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B313CA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561EF208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 03:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfKADQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 23:16:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12351 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727332AbfKADQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 23:16:47 -0400
X-UUID: 3572f32397f44b1885d591ee870d0cea-20191101
X-UUID: 3572f32397f44b1885d591ee870d0cea-20191101
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1622121720; Fri, 01 Nov 2019 11:16:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Nov 2019 11:16:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Nov 2019 11:16:34 +0800
Message-ID: <1572578198.10339.15.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: update cursors by using async atomic
 update
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Fri, 1 Nov 2019 11:16:38 +0800
In-Reply-To: <20191025053843.16808-2-bibby.hsieh@mediatek.com>
References: <20191025053843.16808-1-bibby.hsieh@mediatek.com>
         <20191025053843.16808-2-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Fri, 2019-10-25 at 13:38 +0800, Bibby Hsieh wrote:
> Support to async updates of cursors by using the new atomic
> interface for that.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c  | 32 +++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h  |  3 ++
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 44 ++++++++++++++++++++++++
>  3 files changed, 79 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index b07dc9b59ca3..3c96178bd559 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -395,6 +395,38 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>  	}
>  }
>  
> +void mtk_drm_crtc_cursor_update(struct drm_crtc *crtc, struct drm_plane *plane,
> +				struct drm_plane_state *new_state)
> +{
> +	struct mtk_drm_private *priv = crtc->dev->dev_private;
> +	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> +	const struct drm_plane_helper_funcs *plane_helper_funcs =
> +			plane->helper_private;
> +	int i;
> +
> +	if (!mtk_crtc->enabled)
> +		return;
> +
> +	plane_helper_funcs->atomic_update(plane, new_state);

Why do you not call mtk_plane_atomic_update() directly?

> +
> +	for (i = 0; i < mtk_crtc->layer_nr; i++) {
> +		struct drm_plane *plane = &mtk_crtc->planes[i];
> +		struct mtk_plane_state *plane_state;
> +
> +		plane_state = to_mtk_plane_state(plane->state);
> +		if (plane_state->pending.dirty) {
> +			plane_state->pending.config = true;
> +			plane_state->pending.dirty = false;
> +		}
> +	}
> +	mtk_crtc->pending_planes = true;
> +	if (priv->data->shadow_register) {
> +		mtk_disp_mutex_acquire(mtk_crtc->mutex);
> +		mtk_crtc_ddp_config(crtc);
> +		mtk_disp_mutex_release(mtk_crtc->mutex);
> +	}

This part is the same as the part in mtk_drm_crtc_atomic_flush. Separate
the common part to an independent function.

Regards,
CK

> +}
> +
>  static void mtk_drm_crtc_atomic_enable(struct drm_crtc *crtc,
>  				       struct drm_crtc_state *old_state)
>  {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> index fcc134eb00c9..e65d58db201d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> @@ -20,4 +20,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  			const enum mtk_ddp_comp_id *path,
>  			unsigned int path_len);
>  
> +void mtk_drm_crtc_cursor_update(struct drm_crtc *crtc, struct drm_plane *plane,
> +				struct drm_plane_state *plane_state);
> +
>  #endif /* MTK_DRM_CRTC_H */
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> index 584a9ecadce6..f0e91ecb3b4c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> @@ -7,6 +7,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_fourcc.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  
> @@ -70,6 +71,47 @@ static void mtk_drm_plane_destroy_state(struct drm_plane *plane,
>  	kfree(to_mtk_plane_state(state));
>  }
>  
> +static int mtk_plane_atomic_async_check(struct drm_plane *plane,
> +					struct drm_plane_state *state)
> +{
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (plane != state->crtc->cursor)
> +		return -EINVAL;
> +
> +	if (!plane->state)
> +		return -EINVAL;
> +
> +	if (!plane->state->fb)
> +		return -EINVAL;
> +
> +	if (state->state)
> +		crtc_state = drm_atomic_get_existing_crtc_state(state->state,
> +								state->crtc);
> +	else /* Special case for asynchronous cursor updates. */
> +		crtc_state = state->crtc->state;
> +
> +	return drm_atomic_helper_check_plane_state(plane->state, crtc_state,
> +						   DRM_PLANE_HELPER_NO_SCALING,
> +						   DRM_PLANE_HELPER_NO_SCALING,
> +						   true, true);
> +}
> +
> +static void mtk_plane_atomic_async_update(struct drm_plane *plane,
> +					  struct drm_plane_state *new_state)
> +{
> +	plane->state->crtc_x = new_state->crtc_x;
> +	plane->state->crtc_y = new_state->crtc_y;
> +	plane->state->crtc_h = new_state->crtc_h;
> +	plane->state->crtc_w = new_state->crtc_w;
> +	plane->state->src_x = new_state->src_x;
> +	plane->state->src_y = new_state->src_y;
> +	plane->state->src_h = new_state->src_h;
> +	plane->state->src_w = new_state->src_w;
> +
> +	mtk_drm_crtc_cursor_update(new_state->crtc, plane, new_state);
> +}
> +
>  static const struct drm_plane_funcs mtk_plane_funcs = {
>  	.update_plane = drm_atomic_helper_update_plane,
>  	.disable_plane = drm_atomic_helper_disable_plane,
> @@ -151,6 +193,8 @@ static const struct drm_plane_helper_funcs mtk_plane_helper_funcs = {
>  	.atomic_check = mtk_plane_atomic_check,
>  	.atomic_update = mtk_plane_atomic_update,
>  	.atomic_disable = mtk_plane_atomic_disable,
> +	.atomic_async_update = mtk_plane_atomic_async_update,
> +	.atomic_async_check = mtk_plane_atomic_async_check,
>  };
>  
>  int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,


