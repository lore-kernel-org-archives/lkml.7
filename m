Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B3AC06508
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B104208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfF3IVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 04:21:55 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:38764 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3IVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:21:54 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 19C0220063;
        Sun, 30 Jun 2019 10:21:52 +0200 (CEST)
Date:   Sun, 30 Jun 2019 10:21:50 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] DRM: ingenic: Add support for panels with 8-bit
 serial bus
Message-ID: <20190630082150.GE5081@ravnborg.org>
References: <20190627182114.27299-1-paul@crapouillou.net>
 <20190627182114.27299-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627182114.27299-3-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8 a=co-eyZKPhihzPdF-lREA:9
        a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 08:21:14PM +0200, Paul Cercueil wrote:
> Add support for the LCD panels with a serial 8-bit bus, where the color
> components of each 24-bit pixel are sent sequentially.

There are strange bus formats...

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index da966f3dc1f7..ce1fae3a78a9 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -426,6 +426,9 @@ static void ingenic_drm_encoder_atomic_mode_set(struct drm_encoder *encoder,
>  			case MEDIA_BUS_FMT_RGB888_1X24:
>  				cfg |= JZ_LCD_CFG_MODE_GENERIC_24BIT;
>  				break;
> +			case MEDIA_BUS_FMT_RGB888_3X8:
> +				cfg |= JZ_LCD_CFG_MODE_8BIT_SERIAL;
> +				break;
>  			default:
>  				break;
>  			}
> @@ -451,6 +454,7 @@ static int ingenic_drm_encoder_atomic_check(struct drm_encoder *encoder,
>  	case MEDIA_BUS_FMT_RGB565_1X16:
>  	case MEDIA_BUS_FMT_RGB666_1X18:
>  	case MEDIA_BUS_FMT_RGB888_1X24:
> +	case MEDIA_BUS_FMT_RGB888_3X8:
>  		return 0;
>  	default:
>  		return -EINVAL;
> -- 
> 2.21.0.593.g511ec345e18
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
