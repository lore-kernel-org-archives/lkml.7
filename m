Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE6CC3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4585C24672
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgADPSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:18:39 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:38724 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgADPSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:18:39 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id EC59B80622;
        Sat,  4 Jan 2020 16:18:35 +0100 (CET)
Date:   Sat, 4 Jan 2020 16:18:34 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/3] drm/panel: simple: Add Satoz SAT050AT40H12R2
 panel support
Message-ID: <20200104151834.GD17768@ravnborg.org>
References: <20191224141905.22780-1-miquel.raynal@bootlin.com>
 <20191224141905.22780-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224141905.22780-3-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=P-IC7800AAAA:8
        a=6d4WGEFEbrAP5ViGYu4A:9 a=CjuIK1q_8ugA:10 a=d3PnA9EDa4IxuAV0gXij:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel.

On Tue, Dec 24, 2019 at 03:19:05PM +0100, Miquel Raynal wrote:
> Add support for the Satoz SAT050AT40H12R2 RGB panel.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes since v2:
> * Dropped two uneeded lines which would fail the build.
> 
> Changes since v1:
> * Switched to display_timing's instead of display_mode.
> 
>  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index ac6f6b5d200d..cc1595c5633a 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2559,6 +2559,29 @@ static const struct panel_desc samsung_ltn140at29_301 = {
>  	},
>  };
>  
> +static const struct display_timing satoz_sat050at40h12r2_timing = {
> +	.pixelclock = { 33300000, 33300000, 50000000 },
> +	.hactive = {800, 800, 800},
> +	.hfront_porch = {16, 210, 354},
> +	.hback_porch = {46, 46, 46},
> +	.hsync_len = {1, 1, 40},
> +	.vactive = {480, 480, 480},
> +	.vfront_porch = {7, 22, 147},
> +	.vback_porch = {23, 23, 23},
> +	.vsync_len = {1, 1, 20},
> +};
> +
> +static const struct panel_desc satoz_sat050at40h12r2 = {
> +	.timings = &satoz_sat050at40h12r2_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 108,
> +		.height = 65,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> +};
Please add connector_type as well.
This is mandatory for all new panels.

	Sam
