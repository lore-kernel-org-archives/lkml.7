Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62344C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1432081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgAFVTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:19:09 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54270 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgAFVTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:19:08 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ioZm5-00074z-Ah; Mon, 06 Jan 2020 22:18:57 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zheng Yang <zhengyang@rock-chips.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/15] drm/rockchip: vop: limit resolution width to 3840
Date:   Mon, 06 Jan 2020 22:18:56 +0100
Message-ID: <3203294.bEmSZkBOq4@diego>
In-Reply-To: <HE1PR06MB40111E90F5DA4718126E6A92AC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
References: <HE1PR06MB4011254424EDB4485617513CAC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com> <20200106204812.5944-1-jonas@kwiboo.se> <HE1PR06MB40111E90F5DA4718126E6A92AC3C0@HE1PR06MB4011.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

Am Montag, 6. Januar 2020, 21:48:25 CET schrieb Jonas Karlman:
> Using a destination width that is more then 3840 pixels
> is not supported in scl_vop_cal_scl_fac().
> 
> Work around this limitation by filtering all modes with
> a width above 3840 pixels.

could you try to send the whole series to people? I only get this patch6
of a series of 15 and that is way confusing not knowing what you want
to actually achieve.

Hence I can also just point to rk3229, rk3328, rk3368 and rk3399 that
report a max output of 4096x2160 , which would be larger than that
3840 value?


Heiko


> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index d04b3492bdac..f181897cbfad 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1036,6 +1036,15 @@ static void vop_crtc_disable_vblank(struct drm_crtc *crtc)
>  	spin_unlock_irqrestore(&vop->irq_lock, flags);
>  }
>  
> +enum drm_mode_status vop_crtc_mode_valid(struct drm_crtc *crtc,
> +					 const struct drm_display_mode *mode)
> +{
> +	if (mode->hdisplay > 3840)
> +		return MODE_BAD_HVALUE;
> +
> +	return MODE_OK;
> +}
> +
>  static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
>  				const struct drm_display_mode *mode,
>  				struct drm_display_mode *adjusted_mode)
> @@ -1377,6 +1386,7 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
>  }
>  
>  static const struct drm_crtc_helper_funcs vop_crtc_helper_funcs = {
> +	.mode_valid = vop_crtc_mode_valid,
>  	.mode_fixup = vop_crtc_mode_fixup,
>  	.atomic_check = vop_crtc_atomic_check,
>  	.atomic_begin = vop_crtc_atomic_begin,
> 




