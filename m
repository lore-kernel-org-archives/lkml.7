Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36912C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048A9206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RG4wRfHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfKZIt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:49:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51448 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfKZIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:49:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id g206so2243582wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 00:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUtjpPtkEsRpnKDWBnpzqjjyBxag8OPmqd6JOmJKLE0=;
        b=RG4wRfHxRj9Qb9AR2jkewfbyRygSxuNhmBMPzHw0SgwgvyIf95RyWowW4Ogq5xeClo
         XqrZI9LEeq0dkgOLxKpwtT7E5/7drxB+RAZJrsscD6RAHmXB4qkhq8csKlPJPsopYjQI
         F+oHw6bcRAxFD/vfLcdteppRAx93loxCWp/1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DUtjpPtkEsRpnKDWBnpzqjjyBxag8OPmqd6JOmJKLE0=;
        b=lB2lp+QJx81dAdrBv7VHKbcAonhTbMd5dFOXRMst+OvDp/41R/uR4yp7r5x5/P0GsO
         Hg9+MZlj0HQ/e7np25V0jh6gTTmxy1OfHUzjxoBkfX1OzQJYZilI8TdRkE7Dc9lhec32
         PNhl2yI4La5ZDH+6zZMR5OIYsgnzMm5VbTaTokFsIDHODBtWW2f5eDdlQsnfcaRlipwW
         cII4tOf5KQ9ZGCHsSXFdDRLQk1OfjdVEDXGP87zlmWizshq4eokL1kj1h6GfJU0G311p
         K/u1i+ndKG4kwaQvQAd1PBZ2cGW2P7i55YTCP2lf0RUcC1TBXvHRfXnLsOJ+bVwKEvu9
         SnFQ==
X-Gm-Message-State: APjAAAUhJr5Oblvd+d4WQ36GqUuFOZymN31BDb7q1Hel1t6WaPw0YjWG
        DaOZMI+M77Rj25/g4n4LwPlDCQ==
X-Google-Smtp-Source: APXvYqy5WG5c7JXt9dC40vUTZVQYm+2vxwyYFnAd8BsPjddOuYm1VMvO4MuyIRX+JTtJdP4VDC644A==
X-Received: by 2002:a7b:c01a:: with SMTP id c26mr2919463wmb.160.1574758194415;
        Tue, 26 Nov 2019 00:49:54 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id u203sm2288683wme.34.2019.11.26.00.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 00:49:53 -0800 (PST)
Date:   Tue, 26 Nov 2019 09:49:51 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, tfiga@chromium.org,
        drinkcat@chromium.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com
Subject: Re: [PATCH 1/7] drm/mediatek: fix atomic_state reference counting
Message-ID: <20191126084951.GQ29965@phenom.ffwll.local>
Mail-Followup-To: Bibby Hsieh <bibby.hsieh@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        tfiga@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
References: <20191126062932.19773-1-bibby.hsieh@mediatek.com>
 <20191126062932.19773-2-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126062932.19773-2-bibby.hsieh@mediatek.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 02:29:26PM +0800, Bibby Hsieh wrote:
> The DRM core takes care of all atomic state refcounting.
> However, mediatek drm defers some work that accesses planes
> and plane_states in drm_atomic_state, and must therefore
> keep its own atomic state references until this work complete.
> 
> We take the atomic_state reference in atomic_fulsh() and ensure all the
> information in atomic_state already was updated in hardware for
> showing on screen and then schedules unreference_work to drop references
> on atomic_state.
> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>

This looks strange. For one you implement your own reference counting - if
drivers have a need for drm_atomic_state_put_irq then I
think we should implement this in the core code.

The other bit is that atomic commits are meant to simply wait for
everything to finish - commit_tail doesn't hold locks, it's only ordered
through drm_crtc_commit events (at least with the async implementation in
the helpers), so you can just block there until your interrupt handler is
done processing the commit. Depending how you want to do this you might
want to wait before or after drm_atomic_helper_commit_hw_done().
-Daniel

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 11 +++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 79 +++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  9 +++
>  3 files changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 29d0582e90e9..68b92adc96bb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -7,7 +7,7 @@
>  #include <linux/pm_runtime.h>
>  
>  #include <asm/barrier.h>
> -
> +#include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
> @@ -47,6 +47,7 @@ struct mtk_drm_crtc {
>  	struct mtk_disp_mutex		*mutex;
>  	unsigned int			ddp_comp_nr;
>  	struct mtk_ddp_comp		**ddp_comp;
> +	struct drm_crtc_state		*old_crtc_state;
>  };
>  
>  struct mtk_crtc_state {
> @@ -362,6 +363,7 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_drm_crtc *mtk_crtc)
>  static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>  {
>  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> +	struct drm_atomic_state *atomic_state = mtk_crtc->old_crtc_state->state;
>  	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
>  	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
>  	unsigned int i;
> @@ -399,6 +401,7 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc)
>  			plane_state->pending.config = false;
>  		}
>  		mtk_crtc->pending_planes = false;
> +		mtk_atomic_state_put_queue(atomic_state);
>  	}
>  }
>  
> @@ -494,6 +497,7 @@ static void mtk_drm_crtc_atomic_begin(struct drm_crtc *crtc,
>  static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>  				      struct drm_crtc_state *old_crtc_state)
>  {
> +	struct drm_atomic_state *old_atomic_state = old_crtc_state->state;
>  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
>  	struct mtk_drm_private *priv = crtc->dev->dev_private;
>  	unsigned int pending_planes = 0;
> @@ -512,8 +516,11 @@ static void mtk_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>  			pending_planes |= BIT(i);
>  		}
>  	}
> -	if (pending_planes)
> +	if (pending_planes) {
>  		mtk_crtc->pending_planes = true;
> +		drm_atomic_state_get(old_atomic_state);
> +		mtk_crtc->old_crtc_state = old_crtc_state;
> +	}
>  	if (crtc->state->color_mgmt_changed)
>  		for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
>  			mtk_ddp_gamma_set(mtk_crtc->ddp_comp[i], crtc->state);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 6588dc6dd5e3..6c68283b6124 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -115,10 +115,85 @@ static int mtk_atomic_commit(struct drm_device *drm,
>  	return 0;
>  }
>  
> +struct mtk_atomic_state {
> +	struct drm_atomic_state base;
> +	struct list_head list;
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
> +static struct drm_atomic_state *
> +		mtk_drm_atomic_state_alloc(struct drm_device *dev)
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
> @@ -337,6 +412,10 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	drm_kms_helper_poll_init(drm);
>  	drm_mode_config_reset(drm);
>  
> +	INIT_WORK(&private->unreference.work, mtk_unreference_work);
> +	INIT_LIST_HEAD(&private->unreference.list);
> +	spin_lock_init(&private->unreference.lock);
> +
>  	return 0;
>  
>  err_unset_dma_parms:
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index b6a82728d563..c37d835cf949 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -55,6 +55,13 @@ struct mtk_drm_private {
>  
>  	struct drm_atomic_state *suspend_state;
>  
> +	struct {
> +		struct work_struct	work;
> +		struct list_head	list;
> +		/* lock for unreference list */
> +		spinlock_t		lock;
> +	} unreference;
> +
>  	bool dma_parms_allocated;
>  };
>  
> @@ -66,4 +73,6 @@ extern struct platform_driver mtk_dpi_driver;
>  extern struct platform_driver mtk_dsi_driver;
>  extern struct platform_driver mtk_mipi_tx_driver;
>  
> +void mtk_atomic_state_put_queue(struct drm_atomic_state *state);
> +
>  #endif /* MTK_DRM_DRV_H */
> -- 
> 2.18.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
