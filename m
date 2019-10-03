Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC71C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2118020865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="VFo/UhVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbfJCShh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:37:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40459 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbfJCShh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:37:37 -0400
Received: by mail-yb1-f193.google.com with SMTP id g9so1258058ybi.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRve0gQAap+NyS4R5cGqN5gZf1m0JfC50dL6OWcjlS8=;
        b=VFo/UhVWMJ46I+cw8Cqf4FdNEV4cUHIYDpmGpjsQ26GGF2iKhzVRWx3+nkaiBylKwM
         /5BiWDSWgpJcU4GvVXK9NdlhlVJEMUOb9A0RWAy6F8hbpo+eArV78k4Z1Ounrc7vXUGk
         mckllj7uM9HsQdbUyP3dd6MTIs7PcCQHm3NVn3Odlrnxsk/n2Dan3pNWRFbJHT7CP0D9
         bX8s+n4Nsh8bNCNJ9zmOAd5MweqxxTLYguBsfaSxInIYkBu4AyjcAhxNEj2aMkVDI/4B
         lJkWAqrdqUWWItoCpFD6FwiGtxlW90tlSGeRHNBTrzbN5Mcoik8k3sdlkoYXgw5i0IW6
         8iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRve0gQAap+NyS4R5cGqN5gZf1m0JfC50dL6OWcjlS8=;
        b=DpheySVVxE4ENZ7wyUjvSwoYJYUX6zhNfLmplhrasNVNHgc4CamZ08nC1zNb5RDqIQ
         bRatRhlqvvmnLgl8iA99QiNDK/foXGRhHmvLxJpdV4BgEO/6zjCq+7glsfrcUCrr1daK
         B2lGuJRYD71te4p85h0ANnHDVMmzbbzlaWm7j9vEMz3BoiFg79MEAqDJswa86s/45KCa
         xTnhQY245twiaQO1IlGt4J/9JQVmZa3/NvF54wrdT1337VCyjeCXcPCJCwdLRqJE+ek9
         nMCGRWI3pnCQLl2BrTYe1YIg6bS/oRXyyY86Zwl5nmtAt2sST5XcJEIUiqSffdvumYEb
         t4Ag==
X-Gm-Message-State: APjAAAWFjFukVQKqst5nedgVXJOMNf33gc3gQMW3/XCd51tfi3rmDc3s
        +/Ax53qUpHzWtAVkzWGYPUu8rVxISSLKYs/LV4dg9w==
X-Google-Smtp-Source: APXvYqwarBwi4Z2CGTBW+OLutBFjri+qnC5uPYU8hnI80vZSHK7FDugxSGkwK64f3/0mTlnN+9FiUKkb+Jlw2NrF/ME=
X-Received: by 2002:a25:2548:: with SMTP id l69mr6812439ybl.159.1570127855623;
 Thu, 03 Oct 2019 11:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191003102003.1.Ib233b3e706cf6317858384264d5b0ed35657456e@changeid>
In-Reply-To: <20191003102003.1.Ib233b3e706cf6317858384264d5b0ed35657456e@changeid>
From:   Sean Paul <sean@poorly.run>
Date:   Thu, 3 Oct 2019 14:36:58 -0400
Message-ID: <CAMavQKKTdsJmVy1wz8K66qyZ_iONqStM8JXJwX=9XspVAKT28A@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: Round up _before_ giving to the clock framework
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>, ryandcase@chromium.org,
        Tomasz Figa <tfiga@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 1:20 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> I'm embarassed to say that even though I've touched
> vop_crtc_mode_fixup() twice and I swear I tested it, there's still a
> stupid glaring bug in it.  Specifically, on veyron_minnie (with all
> the latest display timings) we want to be setting our pixel clock to
> 66,666,666.67 Hz and we tell userspace that's what we set, but we're
> actually choosing 66,000,000 Hz.  This is confirmed by looking at the
> clock tree.
>
> The problem is that in drm_display_mode_from_videomode() we convert
> from Hz to kHz with:
>
>   dmode->clock = vm->pixelclock / 1000;
>
> ...so when the device tree specifies a clock of 66666667 for the panel
> then DRM translates that to 66666000.  The clock framework will always
> pick a clock that is _lower_ than the one requested, so it will refuse
> to pick 66666667 and we'll end up at 66000000.
>
> While we could try to fix drm_display_mode_from_videomode() to round
> to the nearest kHz and it would fix our problem,

I got a bit confused reading this and Doug straightened me out in a
sideband conversation.

To summarize, the drm_display_mode_from_videomode() call referenced
above is from panel-simple, and this downslotting is specific to
rockchip's clock driver. So I've asked to clarify these 2 points so
it's clear from the commit message that this patch is the best
solution. With that addressed,

Reviewed-by: Sean Paul <seanpaul@chromium.org>


> it wouldn't help if
> the clock we actually needed was 60,000,001 Hz.  We could
> alternatively have DRM always round up, but maybe this would break
> someone else who already baked in the assumption that DRM rounds down.
>
> Let's solve this by just adding 999 Hz before calling
> clk_round_rate().  This should be safe and work everywhere.
>
> NOTE: if this is picked to stable, it's probably easiest to first pick
> commit 527e4ca3b6d1 ("drm/rockchip: Base adjustments of the mode based
> on prev adjustments") which shouldn't hurt in stable.
>
> Fixes: b59b8de31497 ("drm/rockchip: return a true clock rate to adjusted_mode")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 37 +++++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 613404f86668..84e3decb17b1 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1040,10 +1040,41 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
>                                 struct drm_display_mode *adjusted_mode)
>  {
>         struct vop *vop = to_vop(crtc);
> +       unsigned long rate;
>
> -       adjusted_mode->clock =
> -               DIV_ROUND_UP(clk_round_rate(vop->dclk,
> -                                           adjusted_mode->clock * 1000), 1000);
> +       /*
> +        * Clock craziness.
> +        *
> +        * Key points:
> +        *
> +        * - DRM works in in kHz.
> +        * - Clock framework works in Hz.
> +        * - Rockchip's clock driver picks the clock rate that is the
> +        *   same _OR LOWER_ than the one requested.
> +        *
> +        * Action plan:
> +        *
> +        * 1. When DRM gives us a mode, we should add 999 Hz to it.  That way
> +        *    if the clock we need is 60000001 Hz (~60 MHz) and DRM tells us to
> +        *    make 60000 kHz then the clock framework will actually give us
> +        *    the right clock.
> +        *
> +        *    NOTE: if the PLL (maybe through a divider) could actually make
> +        *    a clock rate 999 Hz higher instead of the one we want then this
> +        *    could be a problem.  Unfortunately there's not much we can do
> +        *    since it's baked into DRM to use kHz.  It shouldn't matter in
> +        *    practice since Rockchip PLLs are controlled by tables and
> +        *    even if there is a divider in the middle I wouldn't expect PLL
> +        *    rates in the table that are just a few kHz different.
> +        *
> +        * 2. Get the clock framework to round the rate for us to tell us
> +        *    what it will actually make.
> +        *
> +        * 3. Store the rounded up rate so that we don't need to worry about
> +        *    this in the actual clk_set_rate().
> +        */
> +       rate = clk_round_rate(vop->dclk, adjusted_mode->clock * 1000 + 999);
> +       adjusted_mode->clock = DIV_ROUND_UP(rate, 1000);
>
>         return true;
>  }
> --
> 2.23.0.444.g18eeb5a265-goog
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
