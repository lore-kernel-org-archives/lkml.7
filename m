Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E64BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C9E20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfEFLQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 07:16:14 -0400
Received: from [195.159.176.226] ([195.159.176.226]:52154 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfEFLQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 07:16:10 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1hNbbJ-000vSh-Fy
        for linux-kernel@vger.kernel.org; Mon, 06 May 2019 13:16:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 3/3] drm/tegra: Support PM QoS memory bandwidth
 management
Date:   Mon, 6 May 2019 14:15:59 +0300
Message-ID: <e1dc16d2-db9e-6869-81dc-8ffe5d5fd6fe@gmail.com>
References: <20190505173707.29282-1-digetx@gmail.com>
 <20190505173707.29282-4-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <20190505173707.29282-4-digetx@gmail.com>
Content-Language: en-US
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190506111559.UOPH6uoKx7FEWWVpRWtwxBpfNhMop8es0D2WZjeOWps@z>

05.05.2019 20:37, Dmitry Osipenko пишет:
> Display controller (DC) performs isochronous memory transfers and thus
> has a requirement for a minimum memory bandwidth that shall be fulfilled,
> otherwise framebuffer data can't be fetched fast enough and this results
> in a DC's data-FIFO underflow that follows by a visual corruption.
> 
> The External Memory Controller drivers will provide memory bandwidth
> management facility via the generic Power Management QoS API soonish.
> This patch wires up the PM QoS API support for the display driver
> beforehand.
> 
> Display won't have visual corruption on coming up from suspend state when
> devfreq driver is active once all prerequisite bits will get upstreamed.
> The devfreq reaction has a quite significant latency and it also doesn't
> take into account the ISO transfers which may result in assumption about
> lower memory bandwidth requirement than actually needed.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c    | 216 +++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/tegra/dc.h    |   8 ++
>  drivers/gpu/drm/tegra/drm.c   |  18 +++
>  drivers/gpu/drm/tegra/plane.c |   1 +
>  drivers/gpu/drm/tegra/plane.h |   4 +-
>  5 files changed, 245 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 41cb67db6dbc..8c5b9e71ca6f 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -514,6 +514,107 @@ static void tegra_dc_setup_window(struct tegra_plane *plane,
>  		tegra_plane_setup_blending(plane, window);
>  }
>  
> +static unsigned long
> +tegra_plane_memory_bandwidth(struct drm_plane_state *state,
> +			     struct tegra_dc_window *window)
> +{
> +	struct tegra_plane_state *tegra_state;
> +	struct drm_crtc_state *crtc_state;
> +	struct tegra_dc_window win;
> +	unsigned int mul;
> +	unsigned int bpp;
> +	bool planar;
> +	bool yuv;
> +
> +	if (!state->fb || !state->visible)
> +		return 0;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(state->state, state->crtc);
> +	tegra_state = to_tegra_plane_state(state);
> +
> +	if (!window)
> +		window = &win;
> +
> +	window->src.w = drm_rect_width(&state->src) >> 16;
> +	window->src.h = drm_rect_height(&state->src) >> 16;
> +	window->dst.w = drm_rect_width(&state->dst);
> +	window->dst.h = drm_rect_height(&state->dst);
> +	window->format = tegra_state->format;
> +	window->tiling = tegra_state->tiling;
> +
> +	yuv = tegra_plane_format_is_yuv(window->format, &planar);
> +	if (!yuv || !planar)
> +		bpp = state->fb->format->cpp[0] * 8;
> +	else
> +		bpp = 16;

It occurred to me that it will be much better to use the drm_format_*
helpers here to calculate the bits-per-pixel because the above variant
isn't really good for all of possible formats. I'll switch to the
generic helpers in v2.

Thierry, for now I'll wait for awhile for yours comments. Please let me
know if you'll want to see anything else changed in v2. I think there is
a good chance that we could get everything ready in regards to memory
bandwidth management basics for v5.3, please help with reviewing and
getting the patches upstreamed.

-- 
Dmitry

