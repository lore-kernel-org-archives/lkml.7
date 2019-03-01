Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABB9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C3B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfCAWYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:24:44 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:36978 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfCAWYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:24:44 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B1DAE8037F;
        Fri,  1 Mar 2019 23:24:40 +0100 (CET)
Date:   Fri, 1 Mar 2019 23:24:39 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/panel: simple: Add Sharp LS020B1DD01D panel
 support
Message-ID: <20190301222439.GA30998@ravnborg.org>
References: <20190228185854.11824-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228185854.11824-1-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=p6pI0oa4AAAA:8
        a=qjnVdcPuHVWR2abhlcEA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=9cw2y2bKwytFd151gpuR:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Thu, Feb 28, 2019 at 03:58:52PM -0300, Paul Cercueil wrote:
> The Sharp LS020B1DD01D is a simple 2.0" 240x160 16-bit TFT panel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 9e8218f6a3f2..3ab604f5477e 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2278,6 +2278,31 @@ static const struct panel_desc sharp_lq150x1lg11 = {
>  	.bus_format = MEDIA_BUS_FMT_RGB565_1X16,
>  };
>  
> +static const struct display_timing sharp_ls020b1dd01d_timing = {
> +	.pixelclock = { 2000000, 4200000, 5000000 },
> +	.hactive = { 240, 240, 240 },
> +	.hfront_porch = { 66, 66, 66 },
> +	.hback_porch = { 1, 1, 1 },
> +	.hsync_len = { 1, 1, 1 },
> +	.vactive = { 160, 160, 160 },
> +	.vfront_porch = { 52, 52, 52 },
> +	.vback_porch = { 6, 6, 6 },
> +	.vsync_len = { 10, 10, 10 },
> +	.flags = DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_LOW,
> +};
> +
> +static const struct panel_desc sharp_ls020b1dd01d = {
> +	.timings = &sharp_ls020b1dd01d_timing,
> +	.num_timings = 1,
> +	.bpc = 6,
> +	.size = {
> +		.width = 42,
> +		.height = 28,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB565_1X16,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_NEGEDGE,
> +};
> +
>  static const struct drm_display_mode shelly_sca07010_bfn_lnn_mode = {
>  	.clock = 33300,
>  	.hdisplay = 800,
> @@ -2767,6 +2792,9 @@ static const struct of_device_id platform_of_match[] = {
>  		.compatible = "sharp,lq150x1lg11",
>  		.data = &sharp_lq150x1lg11,
>  	}, {
> +		.compatible = "sharp,ls020b1dd01d",
> +		.data = &sharp_ls020b1dd01d,
> +	}, {
For all three patches I am missing dt-bindings documentation.

also for all three patches you get a "+1" for adding all of
.flags, .bus_format, .bus_flags.

	Sam
