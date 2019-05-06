Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF2C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B93820830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 11:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4ELULrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEFLQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 07:16:05 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35404 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEFLQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 07:16:05 -0400
Received: by mail-io1-f67.google.com with SMTP id r18so10777591ioh.2;
        Mon, 06 May 2019 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:newsgroups:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ll4tLtKAz5QfqQNpJ8SOOQ8DBmPbzjjbapAWPj5NxaA=;
        b=O4ELULrFzjuXLVhmIJ0iWCRsqi2vpscptwlzxT8ncscRH0fiSg4ocaplwaW1Vq4DS8
         8kknL+jkrRMKRGTlD20UwPPQ5wztsRxHlwnHaSfWjIR8Cz1tEneerB6MPBIm1mSY0f/W
         bDswQ3/9zD164+sFqKRjjLNnLN2ThRE9FZCBJ3aIWN7hldnjnZPR4wFdsthmnJDzbU+q
         VMDf3ulbbylpVBo4K92BKLw6cUEzFrDLDXop3FhLQw/gaxwMT+oSlR2zeHlixCM2ocDf
         HjgkAVh+moZ67ZDzd43pQn0uFNSkzJnm2oMW1Hm76w1L5MrkS2AATYLINtXX/ggJfak+
         6fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:newsgroups:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Ll4tLtKAz5QfqQNpJ8SOOQ8DBmPbzjjbapAWPj5NxaA=;
        b=hRI6RLupc1T0jH5tC+8Zt1Q8xI2PQHt1Ii6mxU/GfXyBkSa6wU4mW2PnwC/DEcioTp
         rcA8xHABC/QVhzqpCFDBP8fhFBeeuka1yAwvyIKBbRQ+1YlcuMxOuK2EU4XaVRfMJUxA
         P+Ih/xG5ym3FvSYgurRHDo9/iQFvjjcuibkFmfdMBMjKBdZ5e6ApuURDVqAc4zna7ciM
         kI9sExpSC4PqPClx0JwtSYwX2l3NbQrLDYI06zqCpw1qTdnQ6XsvsXqnc/XW+XvUWy1O
         /THIDxwnDJzpSSpnKFG3M/2QKRc0ji8pv7SQopfx1IzwqIGULODmp1Is5R6t/Hn8B0NX
         iK5g==
X-Gm-Message-State: APjAAAWgKRDFYCUD1FDwmFUknUpP97Xsm5OPtvM2rRxmwUaQnDLaODcG
        LRSnpvGPtdst3jCtkhQz058MhUkN
X-Google-Smtp-Source: APXvYqzaAZaaReBRZqOTq7QjKFbI3hBW0J8EDh/qu8rPIMmtrAExjTwBy18jZSWfdty949f+TWigcA==
X-Received: by 2002:a5e:d503:: with SMTP id e3mr17129537iom.46.1557141363901;
        Mon, 06 May 2019 04:16:03 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id 12sm8361952itm.2.2019.05.06.04.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 04:16:03 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] drm/tegra: Support PM QoS memory bandwidth
 management
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.comp.video.dri.devel,gmane.linux.ports.tegra
References: <20190505173707.29282-1-digetx@gmail.com>
 <20190505173707.29282-4-digetx@gmail.com>
Message-ID: <e1dc16d2-db9e-6869-81dc-8ffe5d5fd6fe@gmail.com>
Date:   Mon, 6 May 2019 14:15:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505173707.29282-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
