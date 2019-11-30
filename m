Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26824C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 21:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EB620833
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 21:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfK3Vve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 16:51:34 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:60876 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfK3Vvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 16:51:33 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id BD6322002B;
        Sat, 30 Nov 2019 22:51:29 +0100 (CET)
Date:   Sat, 30 Nov 2019 22:51:28 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 1/2] drm/panel: simple: Add support for AUO G121EAN01.4
 panel
Message-ID: <20191130215128.GB29715@ravnborg.org>
References: <20191107172331.14362-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107172331.14362-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=QX4gbG5DAAAA:8
        a=mHQZmhpCeS4WpH_mRSAA:9 a=CjuIK1q_8ugA:10 a=AbAUZ8qAyYyZVLSsDulk:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian.
On Thu, Nov 07, 2019 at 06:23:30PM +0100, Sebastian Reichel wrote:
> Add timings for the AUO G121EAN01.4 panel.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 28fa6ba7b767..46ca59db6819 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -806,6 +806,29 @@ static const struct panel_desc auo_g104sn02 = {
>  	},
>  };
>  
> +static const struct drm_display_mode auo_g121ean01_mode = {
> +	.clock = 66700,
> +	.hdisplay = 1280,
> +	.hsync_start = 1280 + 58,
> +	.hsync_end = 1280 + 58 + 8,
> +	.htotal = 1280 + 58 + 8 + 70,
> +	.vdisplay = 800,
> +	.vsync_start = 800 + 6,
> +	.vsync_end = 800 + 6 + 4,
> +	.vtotal = 800 + 6 + 4 + 10,
> +	.vrefresh = 60,
> +};
> +
> +static const struct panel_desc auo_g121ean01 = {
> +	.modes = &auo_g121ean01_mode,
> +	.num_modes = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 261,
> +		.height = 163,
> +	},
> +};
> +
>  static const struct display_timing auo_g133han01_timings = {
>  	.pixelclock = { 134000000, 141200000, 149000000 },
>  	.hactive = { 1920, 1920, 1920 },
> @@ -3114,6 +3137,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "auo,g104sn02",
>  		.data = &auo_g104sn02,
> +	}, {
> +		.compatible = "auo,g121ean01.4",
> +		.data = &auo_g121ean01,

I did not find any binding document for this,
so I cannot apply.
If you need to create a new binding then please
use the meta-schema format (.yaml).

	Sam
