Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E4BC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5D5206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLXOMb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:12:31 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:55079 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfLXOMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:12:31 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 3DF8E240007;
        Tue, 24 Dec 2019 14:12:26 +0000 (UTC)
Date:   Tue, 24 Dec 2019 15:12:22 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 3/3] drm/panel: simple: Add Satoz SAT050AT40H12R2
 panel support
Message-ID: <20191224151222.7164810d@xps13>
In-Reply-To: <20191224140551.21227-3-miquel.raynal@bootlin.com>
References: <20191224140551.21227-1-miquel.raynal@bootlin.com>
        <20191224140551.21227-3-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Tue, 24 Dec 2019
15:05:51 +0100:

> Add support for the Satoz SAT050AT40H12R2 RGB panel.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes since v1:
> * Switched to display_timing's instead of display_mode.
> 
>  drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index ac6f6b5d200d..00538553a188 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2559,6 +2559,31 @@ static const struct panel_desc samsung_ltn140at29_301 = {
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
> +	.reset_time = 10,
> +	.reset_wait = 1,

I dit not generate the patch from the right branch: this is a proposal
for the reset GPIO change and should not appear here. Please forget
about this series, I will respin a v3 without these two lines.

Sorry for the noise.

Thanks,
Miquèl
