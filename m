Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C4DC2D0CA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 10:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A27F24687
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 10:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfLNKJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 05:09:17 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:43074 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfLNKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 05:09:17 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8679E80513;
        Sat, 14 Dec 2019 11:09:12 +0100 (CET)
Date:   Sat, 14 Dec 2019 11:09:11 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] drm/panel: simple: Add Satoz SAT050AT40H12R2 panel
 support
Message-ID: <20191214100911.GA2967@ravnborg.org>
References: <20191213182325.27030-1-miquel.raynal@bootlin.com>
 <20191213182325.27030-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213182325.27030-2-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=P-IC7800AAAA:8
        a=-2JWhZF2_wdEBDjv_fEA:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel.

On Fri, Dec 13, 2019 at 07:23:25PM +0100, Miquel Raynal wrote:
> Add support for the Satoz SAT050AT40H12R2 RGB panel.

Google failed to find this display - do you have any pointers to
datasheet?

This turned up: SAT050AT40H12B2
But I failed to find any data sheet.

I wonder if there is any typical, min, max timings - so we could use
display_timing rather than display_mode.

Before the compatible is documented the patch will not be applied.
So you need to submit a binding document too,
which must be in meta-schema syntax (.yaml).

	Sam

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 15dd495c347d..8ae98437cbba 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2557,6 +2557,30 @@ static const struct panel_desc samsung_ltn140at29_301 = {
>  	},
>  };
>  
> +static const struct drm_display_mode satoz_sat050at40h12r2_mode = {
> +	.clock = 33300,
> +	.hdisplay = 800,
> +	.hsync_start = 800 + 210,
> +	.hsync_end = 800 + 210 + 20,
> +	.htotal = 800 + 210 + 420 + 46,
> +	.vdisplay = 480,
> +	.vsync_start = 480 + 23,
> +	.vsync_end = 480 + 23 + 10,
> +	.vtotal = 480 + 23 + 10 + 22,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc satoz_sat050at40h12r2 = {
> +	.modes = &satoz_sat050at40h12r2_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 108,
> +		.height = 65,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +};
> +
>  static const struct drm_display_mode sharp_ld_d5116z01b_mode = {
>  	.clock = 168480,
>  	.hdisplay = 1920,
> @@ -3357,6 +3381,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "samsung,ltn140at29-301",
>  		.data = &samsung_ltn140at29_301,
> +	}, {
> +		.compatible = "satoz,sat050at40h12r2",
> +		.data = &satoz_sat050at40h12r2,
>  	}, {
>  		.compatible = "sharp,ld-d5116z01b",
>  		.data = &sharp_ld_d5116z01b,
> -- 
> 2.20.1
