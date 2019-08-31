Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F8C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 00:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A837822CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 00:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfHaAE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 20:04:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27670 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727304AbfHaAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 20:04:59 -0400
X-UUID: 67bc2bb3223f4ab19a3e4abadc4fed6e-20190831
X-UUID: 67bc2bb3223f4ab19a3e4abadc4fed6e-20190831
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 136419460; Sat, 31 Aug 2019 08:04:53 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 31 Aug 2019 08:04:56 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 31 Aug 2019 08:04:50 +0800
Message-ID: <1567209886.18937.5.camel@mtksdaap41>
Subject: Re: [PATCH 2/2] drm/mediatek: Bypass atomic helpers for cursor
 updates
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
Date:   Sat, 31 Aug 2019 08:04:46 +0800
In-Reply-To: <20190830073819.16566-3-bibby.hsieh@mediatek.com>
References: <20190830073819.16566-1-bibby.hsieh@mediatek.com>
         <20190830073819.16566-3-bibby.hsieh@mediatek.com>
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

On Fri, 2019-08-30 at 15:38 +0800, Bibby Hsieh wrote:
> Moving the driver to atomic helpers regressed cursor responsiveness,
> because cursor updates need their own atomic commits, which have to be
> serialized with other commits, that might include fence waits. To avoid
> this, in certain conditions, we can bypass the atomic helpers for legacy
> cursor update IOCTLs. Currently the conditions are:
>  - no asynchronous mode setting commit pending,
>  - no asynchronous commit that updates the cursor plane is pending.
> With the above two conditions met, we know that the manual cursor state
> update will not conflict with any scheduled update.
> 
> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c  | 41 ++++++++++++-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h  |  2 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 34 ++++++++++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h   |  3 +
>  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 73 +++++++++++++++++++++++-
>  5 files changed, 148 insertions(+), 5 deletions(-)
> 

[snip]

> +
> +static int mtk_plane_update(struct drm_plane *plane,
> +			    struct drm_crtc *crtc,
> +			    struct drm_framebuffer *fb,
> +			    int crtc_x, int crtc_y,
> +			    unsigned int crtc_w, unsigned int crtc_h,
> +			    uint32_t src_x, uint32_t src_y,
> +			    uint32_t src_w, uint32_t src_h,
> +			    struct drm_modeset_acquire_ctx *ctx)
> +{
> +	struct mtk_drm_private *private = plane->dev->dev_private;
> +	uint32_t crtc_mask = (1 << drm_crtc_index(crtc));
> +
> +	if (crtc && plane == crtc->cursor &&
> +	    plane->state->crtc == crtc &&
> +	    !(private->commit.flush_for_cursor & crtc_mask))
> +		return mtk_plane_cursor_update(plane, crtc, fb,
> +				crtc_x, crtc_y, crtc_w, crtc_h,
> +				src_x, src_y, src_w, src_h);
> +
> +	return drm_atomic_helper_update_plane(plane, crtc, fb,
> +					      crtc_x, crtc_y, crtc_w, crtc_h,
> +					      src_x, src_y, src_w, src_h, ctx);
> +}
> +
>  static const struct drm_plane_funcs mtk_plane_funcs = {
> -	.update_plane = drm_atomic_helper_update_plane,
> +	.update_plane = mtk_plane_update,

I think drm core has already process cursor async problem. In [1], you
could search 'legacy_cursor_update' and it need driver to implement
atomic_async_check() and atomic_async_update() callback function. You
could refer to [2] for the implementation. 


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/drm_atomic_helper.c?h=v5.3-rc6
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/rockchip/rockchip_drm_vop.c?h=v5.3-rc6#n955

Regards,
CK

>  	.disable_plane = drm_atomic_helper_disable_plane,
>  	.destroy = drm_plane_cleanup,
>  	.reset = mtk_plane_reset,
> @@ -90,7 +154,12 @@ static int mtk_plane_atomic_check(struct drm_plane *plane,
>  	if (!state->crtc)
>  		return 0;
>  
> -	crtc_state = drm_atomic_get_crtc_state(state->state, state->crtc);
> +	if (state->state)
> +		crtc_state = drm_atomic_get_existing_crtc_state(state->state,
> +								state->crtc);
> +	else /* Special case for asynchronous cursor updates. */
> +		crtc_state = state->crtc->state;
> +
>  	if (IS_ERR(crtc_state))
>  		return PTR_ERR(crtc_state);
>  


