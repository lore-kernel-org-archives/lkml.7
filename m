Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3E8C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D782072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbgAIQAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:00:31 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:60802 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbgAIQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:00:30 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 2FF0280645;
        Thu,  9 Jan 2020 17:00:27 +0100 (CET)
Date:   Thu, 9 Jan 2020 17:00:25 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 1/1] drm/panel: Add support for BOE NV140FHM-N49 panel
 to panel-simple
Message-ID: <20200109160025.GA17071@ravnborg.org>
References: <20200109112952.2620-1-t.schramm@manjaro.org>
 <20200109112952.2620-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109112952.2620-2-t.schramm@manjaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=rveBo4_EAAAA:8
        a=q4xGkG3yCbrZFByMRZAA:9 a=CjuIK1q_8ugA:10 a=HW1wDYKO1DgdHvS0FfdB:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias.

On Thu, Jan 09, 2020 at 12:29:52PM +0100, Tobias Schramm wrote:
> This patch adds support for the BOE NV140FHM-N49 panel to the panel-simple
> driver. The panel is used by the pine64 Pinebook Pro.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

Applied to drm-misc-next togher with the bindings patch.
Thanks for the quick r-b.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-simple.c | 35 ++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 5d487686d25c..6320df9765f3 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1036,6 +1036,38 @@ static const struct panel_desc boe_nv101wxmn51 = {
>  	},
>  };
>  
> +static const struct drm_display_mode boe_nv140fhmn49_modes[] = {
> +	{
> +		.clock = 148500,
> +		.hdisplay = 1920,
> +		.hsync_start = 1920 + 48,
> +		.hsync_end = 1920 + 48 + 32,
> +		.htotal = 2200,
> +		.vdisplay = 1080,
> +		.vsync_start = 1080 + 3,
> +		.vsync_end = 1080 + 3 + 5,
> +		.vtotal = 1125,
> +		.vrefresh = 60,
> +	},
> +};
> +
> +static const struct panel_desc boe_nv140fhmn49 = {
> +	.modes = boe_nv140fhmn49_modes,
> +	.num_modes = ARRAY_SIZE(boe_nv140fhmn49_modes),
> +	.bpc = 6,
> +	.size = {
> +		.width = 309,
> +		.height = 174,
> +	},
> +	.delay = {
> +		.prepare = 210,
> +		.enable = 50,
> +		.unprepare = 160,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> +	.connector_type = DRM_MODE_CONNECTOR_eDP,
> +};
> +
>  static const struct drm_display_mode cdtech_s043wq26h_ct7_mode = {
>  	.clock = 9000,
>  	.hdisplay = 480,
> @@ -3161,6 +3193,9 @@ static const struct of_device_id platform_of_match[] = {
>  	}, {
>  		.compatible = "boe,nv101wxmn51",
>  		.data = &boe_nv101wxmn51,
> +	}, {
> +		.compatible = "boe,nv140fhmn49",
> +		.data = &boe_nv140fhmn49,
>  	}, {
>  		.compatible = "cdtech,s043wq26h-ct7",
>  		.data = &cdtech_s043wq26h_ct7,
> -- 
> 2.24.1
