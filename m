Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256CDC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4E32089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="ayl3bydt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbfJNUYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:24:55 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:59780 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbfJNUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:24:55 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E5B6D5C1173;
        Mon, 14 Oct 2019 22:24:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1571084693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifyjUFLJ9uzTTzrkMj72r74yQo5VoUndfopoOcl3f6Y=;
        b=ayl3bydti//Ft78EF77JKVgVud3aqxfZUVRuMvkxxAa1IFoCp3dkRn5NwJLsQZZPle7h6C
        5Vt2j+sm4oPWLuS2/XFt4lLAG1myi+QvLayxT8TgtM5RRNelA1XOmaMc7tHIfQT/1WYTlt
        4YpAItIPKcBliTO2mLv6ikb7eM8fheY=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Mon, 14 Oct 2019 22:24:51 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/14] drm/mxsfb: Read bus flags from bridge if present
In-Reply-To: <1567078215-31601-3-git-send-email-robert.chiras@nxp.com>
References: <1567078215-31601-1-git-send-email-robert.chiras@nxp.com>
 <1567078215-31601-3-git-send-email-robert.chiras@nxp.com>
Message-ID: <b5da1f015a4dd87a612e1a9e57fdca7a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-29 13:30, Robert Chiras wrote:
> From: Guido Günther <agx@sigxcpu.org>
> 
> The bridge might have special requirmentes on the input bus. This
> is e.g. used by the imx-nwl bridge.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Stefan Agner <stefan@agner.ch>

Applied to the drm-misc-next branch.

I decided to apply those two since they are independent from the rest.
You can drop them in the next spin of the rest.

--
Stefan


> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index de09b93..b69ace8 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -209,7 +209,7 @@ static void mxsfb_crtc_mode_set_nofb(struct
> mxsfb_drm_private *mxsfb)
>  {
>  	struct drm_device *drm = mxsfb->pipe.crtc.dev;
>  	struct drm_display_mode *m = &mxsfb->pipe.crtc.state->adjusted_mode;
> -	const u32 bus_flags = mxsfb->connector->display_info.bus_flags;
> +	u32 bus_flags = mxsfb->connector->display_info.bus_flags;
>  	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
>  	int err;
>  
> @@ -233,6 +233,9 @@ static void mxsfb_crtc_mode_set_nofb(struct
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
