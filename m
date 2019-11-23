Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E83C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267E820679
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 15:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKWPiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 10:38:55 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:55288 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKWPiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 10:38:54 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5595C2008C;
        Sat, 23 Nov 2019 16:29:37 +0100 (CET)
Date:   Sat, 23 Nov 2019 16:29:36 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/panel: simple: Add support for the Frida
 FRD350H54004 panel
Message-ID: <20191123152936.GC27045@ravnborg.org>
References: <20191120171027.1102250-1-paul@crapouillou.net>
 <20191120171027.1102250-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120171027.1102250-3-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=ynqdyZ908_tY_8WrgD8A:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Wed, Nov 20, 2019 at 06:10:27PM +0100, Paul Cercueil wrote:
> The FRD350H54004 is a simple 3.5" 320x240 24-bit TFT panel, found for
> instance inside the Anbernic RG-350 handheld gaming console.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 28fa6ba7b767..8c03f7fe461c 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1378,6 +1378,32 @@ static const struct panel_desc evervision_vgg804821 = {
>  	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
>  };
>  
> +static const struct drm_display_mode frida_frd350h54004_mode = {
> +	.clock = 6777,
> +	.hdisplay = 320,
> +	.hsync_start = 320 + 70,
> +	.hsync_end = 320 + 70 + 50,
> +	.htotal = 320 + 70 + 50 + 10,
> +	.vdisplay = 240,
> +	.vsync_start = 240 + 5,
> +	.vsync_end = 240 + 5 + 1,
> +	.vtotal = 240 + 5 + 1 + 5,
> +	.vrefresh = 60,
> +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> +};
> +
> +static const struct panel_desc frida_frd350h54004 = {
> +	.modes = &frida_frd350h54004_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 77,
> +		.height = 64,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
> +};
> +
>  static const struct drm_display_mode foxlink_fl500wvr00_a0t_mode = {
>  	.clock = 32260,
>  	.hdisplay = 800,
> @@ -3186,6 +3212,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "evervision,vgg804821",
>  		.data = &evervision_vgg804821,
> +	}, {
> +		.compatible = "frida,frd350h54004",
> +		.data = &frida_frd350h54004,
>  	}, {
>  		.compatible = "foxlink,fl500wvr00-a0t",
>  		.data = &foxlink_fl500wvr00_a0t,

In alphabetic order. frida comes after fox.

	Sam
