Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABB8C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7891021734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 08:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgABI4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 03:56:04 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:35566 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgABI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 03:56:04 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5E9A220023;
        Thu,  2 Jan 2020 09:55:59 +0100 (CET)
Date:   Thu, 2 Jan 2020 09:55:57 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] panel: simple: Add Ivo M133NWF4 R0
Message-ID: <20200102085557.GA29446@ravnborg.org>
References: <20191229060658.746189-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229060658.746189-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=KKAkSRfTAAAA:8
        a=gSXZn_GVY0joluNFdaoA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn.

On Sat, Dec 28, 2019 at 10:06:58PM -0800, Bjorn Andersson wrote:
> The InfoVision Optoelectronics M133NWF4 R0 panel is a 13.3" 1920x1080
> eDP panel, add support for it in panel-simple.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 31 ++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index ba3f85f36c2f..d7ae0ede2b6e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1806,6 +1806,34 @@ static const struct panel_desc innolux_zj070na_01p = {
>  	},
>  };
>  
> +static const struct drm_display_mode ivo_m133nwf4_r0_mode = {
> +	.clock = 138778,
> +	.hdisplay = 1920,
> +	.hsync_start = 1920 + 24,
> +	.hsync_end = 1920 + 24 + 48,
> +	.htotal = 1920 + 24 + 48 + 88,
> +	.vdisplay = 1080,
> +	.vsync_start = 1080 + 3,
> +	.vsync_end = 1080 + 3 + 12,
> +	.vtotal = 1080 + 3 + 12 + 17,
> +	.vrefresh = 60,
> +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> +};
> +
> +static const struct panel_desc ivo_m133nwf4_r0 = {
> +	.modes = &ivo_m133nwf4_r0_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 294,
> +		.height = 165,
> +	},
> +	.delay = {
> +		.hpd_absent_delay = 200,
> +		.unprepare = 500,
> +	},
> +};

For new bindings - at least add connector_type.
And consider bus_format and bus_flags too.


> +
>  static const struct display_timing koe_tx14d24vm1bpa_timing = {
>  	.pixelclock = { 5580000, 5850000, 6200000 },
>  	.hactive = { 320, 320, 320 },
> @@ -3266,6 +3294,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "innolux,zj070na-01p",
>  		.data = &innolux_zj070na_01p,
> +	}, {
> +		.compatible = "ivo,m133nwf4-r0",
Compatible must be documented in a binding file.
We are discussing a new binding format where it is simple to add
a new panel. But no final conclusion yet.

The comments above (in panel_desc and here) also apply for the
other patch you sent.

	Sam
