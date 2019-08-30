Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F3CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D09B2397F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfH3IgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:36:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55653 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727234AbfH3IgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:36:01 -0400
X-UUID: 8a4f7bad47934e6aa052e8c8afb70867-20190830
X-UUID: 8a4f7bad47934e6aa052e8c8afb70867-20190830
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1261851753; Fri, 30 Aug 2019 16:35:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 16:35:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 16:35:55 +0800
Message-ID: <1567154150.13325.2.camel@mtksdaap41>
Subject: Re: [PATCH 1/2] drm/mediatek: Only block updates to CRTCs that have
 a pending update
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
        Daniel Kurtz <djkurtz@chromium.org>
Date:   Fri, 30 Aug 2019 16:35:50 +0800
In-Reply-To: <20190830073819.16566-2-bibby.hsieh@mediatek.com>
References: <20190830073819.16566-1-bibby.hsieh@mediatek.com>
         <20190830073819.16566-2-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 6A96CFC89D33F5FA5F20A3018DA500853F5365A8A16AA1784E06D7C60982FE4B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Fri, 2019-08-30 at 15:38 +0800, Bibby Hsieh wrote:
> Currently we use a single mutex to allow only a single atomic
> update at a time. In truth, though, we really only want to
> ensure that only a single atomic update is allowed per CRTC.
> 
> In other words, for each atomic update, we only block if there
> is a pending update for the CRTCs involved, and don't block if
> there are only pending updates for other CRTCs.

I don't know why this patch is so complicated. The original problem is
that one mutex for whole drm would block different crtc. So I think each
crtc has its own mutex would solve this problem and we need not the
event waiting. Do I miss something?

Regards,
CK

> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  14 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 182 +++++++++++++++++++++---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  12 +-
>  3 files changed, 184 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index b55970a2869d..7697b40baac0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -5,6 +5,7 @@
>  
>  #include <asm/barrier.h>
>  #include <drm/drmP.h>
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
> @@ -45,6 +46,8 @@ struct mtk_drm_crtc {
>  	struct mtk_disp_mutex		*mutex;
>  	unsigned int			ddp_comp_nr;
>  	struct mtk_ddp_comp		**ddp_comp;
> +
> +	struct drm_crtc_state		*old_crtc_state;
>  };
>  
>  struct mtk_crtc_state {
> @@ -343,6 +346,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
>  static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>  {
>  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> +	struct drm_atomic_state *atomic_state = mtk_crtc->old_crtc_state->state;
>  	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
>  	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>  	unsigned int i;
> @@ -382,6 +386,7 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>  			}
>  		}
>  		mtk_crtc->pending_planes = false;
> +		mtk_atomic_state_put_queue(atomic_state);
>  	}
>  }
>  
> @@ -451,6 +456,7 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
>  static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>  				      struct drm_crtc_state *old_crtc_state)
>  {
> +	struct drm_atomic_state *old_atomic_state = old_crtc_state->state;
>  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
>  	struct mtk_drm_private *priv = crtc->dev->dev_private;
>  	unsigned int pending_planes = 0;
> @@ -469,8 +475,13 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>  			pending_planes |= BIT(i);
>  		}
>  	}
> -	if (pending_planes)
> +
> +	if (pending_planes) {
>  		mtk_crtc->pending_planes = true;
> +		drm_atomic_state_get(old_atomic_state);
> +		mtk_crtc->old_crtc_state = old_crtc_state;
> +	}
> +
>  	if (crtc->state->color_mgmt_changed)
>  		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
>  			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
> @@ -526,6 +537,7 @@ static int mtk_drm_crtc_init(struct drm_device *drm,
>  
>  void mtk_crtc_ddp_irq(struct drm_crtc *crtc, struct mtk_ddp_comp *comp)
>  {
> +
>  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
>  	struct mtk_drm_private *priv = crtc->dev->dev_private;
>  
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index c0928b69dc43..b0308a3a7483 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -31,11 +31,120 @@
>  #define DRIVER_MAJOR 1
>  #define DRIVER_MINOR 0
>  
> -static void mtk_atomic_schedule(struct mtk_drm_private *private,
> +struct mtk_atomic_state {
> +	struct drm_atomic_state base;
> +	struct list_head list;
> +	struct work_struct work;
> +};
> +
> +static inline struct mtk_atomic_state *to_mtk_state(struct drm_atomic_state *s)
> +{
> +	return container_of(s, struct mtk_atomic_state, base);
> +}
> +
> +void mtk_atomic_state_put_queue(struct drm_atomic_state *state)
> +{
> +	struct drm_device *drm = state->dev;
> +	struct mtk_drm_private *mtk_drm = drm->dev_private;
> +	struct mtk_atomic_state *mtk_state = to_mtk_state(state);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mtk_drm->unreference.lock, flags);
> +	list_add_tail(&mtk_state->list, &mtk_drm->unreference.list);
> +	spin_unlock_irqrestore(&mtk_drm->unreference.lock, flags);
> +
> +	schedule_work(&mtk_drm->unreference.work);
> +}
> +
> +static uint32_t mtk_atomic_crtc_mask(struct drm_device *drm,
> +				     struct drm_atomic_state *state)
> +{
> +	uint32_t crtc_mask;
> +	int i;
> +
> +	for (i = 0, crtc_mask = 0; i < drm->mode_config.num_crtc; i++) {
> +		struct drm_crtc *crtc = state->crtcs[i].ptr;
> +
> +		if (crtc)
> +			crtc_mask |= (1 << drm_crtc_index(crtc));
> +	}
> +
> +	return crtc_mask;
> +}
> +
> +/*
> + * Block until specified crtcs are no longer pending update, and atomically
> + * mark them as pending update.
> + */
> +static int mtk_atomic_get_crtcs(struct drm_device *drm,
> +				struct drm_atomic_state *state)
> +{
> +	struct mtk_drm_private *private = drm->dev_private;
> +	uint32_t crtc_mask;
> +	int ret;
> +
> +	crtc_mask = mtk_atomic_crtc_mask(drm, state);
> +
> +	/*
> +	 * Wait for all pending updates to complete for the set of crtcs being
> +	 * changed in this atomic commit
> +	 */
> +	spin_lock(&private->commit.crtcs_event.lock);
> +	ret = wait_event_interruptible_locked(private->commit.crtcs_event,
> +			!(private->commit.crtcs & crtc_mask));
> +	if (ret == 0)
> +		private->commit.crtcs |= crtc_mask;
> +	spin_unlock(&private->commit.crtcs_event.lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * Mark specified crtcs as no longer pending update.
> + */
> +static void mtk_atomic_put_crtcs(struct drm_device *drm,
> +				 struct drm_atomic_state *state)
> +{
> +	struct mtk_drm_private *private = drm->dev_private;
> +	uint32_t crtc_mask;
> +
> +	crtc_mask = mtk_atomic_crtc_mask(drm, state);
> +
> +	spin_lock(&private->commit.crtcs_event.lock);
> +	private->commit.crtcs &= ~crtc_mask;
> +	wake_up_all_locked(&private->commit.crtcs_event);
> +	spin_unlock(&private->commit.crtcs_event.lock);
> +}
> +
> +static void mtk_unreference_work(struct work_struct *work)
> +{
> +	struct mtk_drm_private *mtk_drm = container_of(work,
> +			struct mtk_drm_private, unreference.work);
> +	unsigned long flags;
> +	struct mtk_atomic_state *state, *tmp;
> +
> +	/*
> +	 * framebuffers cannot be unreferenced in atomic context.
> +	 * Therefore, only hold the spinlock when iterating unreference_list,
> +	 * and drop it when doing the unreference.
> +	 */
> +	spin_lock_irqsave(&mtk_drm->unreference.lock, flags);
> +	list_for_each_entry_safe(state, tmp, &mtk_drm->unreference.list, list) {
> +		list_del(&state->list);
> +		spin_unlock_irqrestore(&mtk_drm->unreference.lock, flags);
> +		drm_atomic_state_put(&state->base);
> +		spin_lock_irqsave(&mtk_drm->unreference.lock, flags);
> +	}
> +	spin_unlock_irqrestore(&mtk_drm->unreference.lock, flags);
> +}
> +
> +
> +static void mtk_atomic_schedule(struct drm_device *drm,
>  				struct drm_atomic_state *state)
>  {
> -	private->commit.state = state;
> -	schedule_work(&private->commit.work);
> +	struct mtk_atomic_state *mtk_state = to_mtk_state(state);
> +
> +	schedule_work(&mtk_state->work);
>  }
>  
>  static void mtk_atomic_wait_for_fences(struct drm_atomic_state *state)
> @@ -48,13 +157,10 @@ static void mtk_atomic_wait_for_fences(struct drm_atomic_state *state)
>  		mtk_fb_wait(new_plane_state->fb);
>  }
>  
> -static void mtk_atomic_complete(struct mtk_drm_private *private,
> +static void mtk_atomic_complete(struct drm_device *drm,
>  				struct drm_atomic_state *state)
>  {
> -	struct drm_device *drm = private->drm;
> -
>  	mtk_atomic_wait_for_fences(state);
> -
>  	/*
>  	 * Mediatek drm supports runtime PM, so plane registers cannot be
>  	 * written when their crtc is disabled.
> @@ -77,53 +183,86 @@ static void mtk_atomic_complete(struct mtk_drm_private *private,
>  	drm_atomic_helper_wait_for_vblanks(drm, state);
>  
>  	drm_atomic_helper_cleanup_planes(drm, state);
> +	mtk_atomic_put_crtcs(drm, state);
> +
>  	drm_atomic_state_put(state);
>  }
>  
>  static void mtk_atomic_work(struct work_struct *work)
>  {
> -	struct mtk_drm_private *private = container_of(work,
> -			struct mtk_drm_private, commit.work);
> +	struct mtk_atomic_state *mtk_state = container_of(work,
> +			struct mtk_atomic_state, work);
> +	struct drm_atomic_state *state = &mtk_state->base;
> +	struct drm_device *drm = state->dev;
>  
> -	mtk_atomic_complete(private, private->commit.state);
> +	mtk_atomic_complete(drm, state);
>  }
>  
>  static int mtk_atomic_commit(struct drm_device *drm,
>  			     struct drm_atomic_state *state,
>  			     bool async)
>  {
> -	struct mtk_drm_private *private = drm->dev_private;
>  	int ret;
>  
>  	ret = drm_atomic_helper_prepare_planes(drm, state);
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&private->commit.lock);
> -	flush_work(&private->commit.work);
> +	ret = mtk_atomic_get_crtcs(drm, state);
> +	if (ret) {
> +		drm_atomic_helper_cleanup_planes(drm, state);
> +		return ret;
> +	}
>  
>  	ret = drm_atomic_helper_swap_state(state, true);
>  	if (ret) {
> -		mutex_unlock(&private->commit.lock);
>  		drm_atomic_helper_cleanup_planes(drm, state);
>  		return ret;
>  	}
>  
>  	drm_atomic_state_get(state);
>  	if (async)
> -		mtk_atomic_schedule(private, state);
> +		mtk_atomic_schedule(drm, state);
>  	else
> -		mtk_atomic_complete(private, state);
> -
> -	mutex_unlock(&private->commit.lock);
> +		mtk_atomic_complete(drm, state);
>  
>  	return 0;
>  }
>  
> +static struct drm_atomic_state *mtk_drm_atomic_state_alloc(
> +		struct drm_device *dev)
> +{
> +	struct mtk_atomic_state *mtk_state;
> +
> +	mtk_state = kzalloc(sizeof(*mtk_state), GFP_KERNEL);
> +	if (!mtk_state)
> +		return NULL;
> +
> +	if (drm_atomic_state_init(dev, &mtk_state->base) < 0) {
> +		kfree(mtk_state);
> +		return NULL;
> +	}
> +
> +	INIT_LIST_HEAD(&mtk_state->list);
> +	INIT_WORK(&mtk_state->work, mtk_atomic_work);
> +
> +	return &mtk_state->base;
> +}
> +
> +static void mtk_drm_atomic_state_free(struct drm_atomic_state *state)
> +{
> +	struct mtk_atomic_state *mtk_state = to_mtk_state(state);
> +
> +	drm_atomic_state_default_release(state);
> +	kfree(mtk_state);
> +}
> +
>  static const struct drm_mode_config_funcs mtk_drm_mode_config_funcs = {
>  	.fb_create = mtk_drm_mode_fb_create,
>  	.atomic_check = drm_atomic_helper_check,
>  	.atomic_commit = mtk_atomic_commit,
> +	.atomic_state_alloc = mtk_drm_atomic_state_alloc,
> +	.atomic_state_free = mtk_drm_atomic_state_free
>  };
>  
>  static const enum mtk_ddp_comp_id mt2701_mtk_ddp_main[] = {
> @@ -319,6 +458,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	drm_kms_helper_poll_init(drm);
>  	drm_mode_config_reset(drm);
>  
> +	INIT_WORK(&private->unreference.work, mtk_unreference_work);
> +	INIT_LIST_HEAD(&private->unreference.list);
> +	spin_lock_init(&private->unreference.lock);
> +	init_waitqueue_head(&private->commit.crtcs_event);
> +
>  	return 0;
>  
>  err_component_unbind:
> @@ -504,8 +648,6 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  	if (!private)
>  		return -ENOMEM;
>  
> -	mutex_init(&private->commit.lock);
> -	INIT_WORK(&private->commit.work, mtk_atomic_work);
>  	private->data = of_device_get_match_data(dev);
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index 823ba4081c18..0934f83b860d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -48,12 +48,16 @@ struct mtk_drm_private {
>  	const struct mtk_mmsys_driver_data *data;
>  
>  	struct {
> -		struct drm_atomic_state *state;
> -		struct work_struct work;
> -		struct mutex lock;
> +		uint32_t crtcs;
> +		wait_queue_head_t crtcs_event;
>  	} commit;
>  
>  	struct drm_atomic_state *suspend_state;
> +	struct {
> +		struct work_struct	work;
> +		struct list_head	list;
> +		spinlock_t		lock;
> +	} unreference;
>  };
>  
>  extern struct platform_driver mtk_ddp_driver;
> @@ -64,4 +68,6 @@ extern struct platform_driver mtk_dpi_driver;
>  extern struct platform_driver mtk_dsi_driver;
>  extern struct platform_driver mtk_mipi_tx_driver;
>  
> +void mtk_atomic_state_put_queue(struct drm_atomic_state *state);
> +
>  #endif /* MTK_DRM_DRV_H */


