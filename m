Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D60C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB9222BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Abl1Av9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfGZLAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:00:39 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:51340 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZLAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:00:38 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 0FABA5C02B3;
        Fri, 26 Jul 2019 13:00:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1564138837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYDHF2viGAO7INulhQjnGn1wMlyhHlC54xWBdg+6oIw=;
        b=Abl1Av9XYNIGg7/KWzSis/iAAeoLSkkVbDapmS9iSmxuO/x9+keLZx4mhaq96DkqPNeAE1
        Lg0y2TsF9fLpyY4ZCna4GxpQulihTPQ61oUSrDCCx06gBltqE5dOSXM04sqDOCi6Ses1+u
        MeuI7kqT2SLCl26GU59MynKLg9ZyZuM=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Fri, 26 Jul 2019 13:00:37 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Robert Chiras <robert.chiras@nxp.com>, Marek Vasut <marex@denx.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/mxsfb: Read bus flags from bridge if present
In-Reply-To: <9390060f65f94722cb13101d4835d9048037f7a0.1564134488.git.agx@sigxcpu.org>
References: <cover.1564134488.git.agx@sigxcpu.org>
 <9390060f65f94722cb13101d4835d9048037f7a0.1564134488.git.agx@sigxcpu.org>
Message-ID: <cdf94095134f91656752d4872fea9d3c@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-26 11:49, Guido Günther wrote:
> The bridge might have special requirmentes on the input bus. This
> is e.g. used by the imx-nwl bridge.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Looks good to me.

Reviewed-by: Stefan Agner <stefan@agner.ch>


That is similar to what I sent for the imx DRM driver:

https://lkml.org/lkml/2018/9/12/913

I probably should follow up on that patchset.

--
Stefan

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index e84bac3a541d..3b8eb3ac13b6 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -215,7 +215,7 @@ static void mxsfb_crtc_mode_set_nofb(struct
> mxsfb_drm_private *mxsfb)
>  {
>  	struct drm_device *drm = mxsfb->pipe.crtc.dev;
>  	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
> -	const u32 bus_flags = mxsfb->connector->display_info.bus_flags;
> +	u32 bus_flags = mxsfb->connector->display_info.bus_flags;
>  	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
>  	int err;
>  
> @@ -239,6 +239,9 @@ static void mxsfb_crtc_mode_set_nofb(struct
> mxsfb_drm_private *mxsfb)
>  
>  	clk_set_rate(mxsfb->clk, m->crtc_clock * 1000);
>  
> +	if (mxsfb->bridge && mxsfb->bridge->timings)
> +		bus_flags = mxsfb->bridge->timings->input_bus_flags;
> +
>  	DRM_DEV_DEBUG_DRIVER(drm->dev, "Pixel clock: %dkHz (actual: %dkHz)\n",
>  			     m->crtc_clock,
>  			     (int)(clk_get_rate(mxsfb->clk) / 1000));
