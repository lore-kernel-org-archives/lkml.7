Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E706FECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC322053B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="m7g5UEjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfJGPTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:19:22 -0400
Received: from vps.xff.cz ([195.181.215.36]:56964 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfJGPTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1570461560; bh=OMxyikXfTnLOBqWm+QEP8j50cJcpiVKIgC8XLUKV570=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=m7g5UEjw7VFuKAAkFVCxO3wEHwsalXDMCOagem7pdBWKPdNT2aYudIhcBhI4kKSu0
         GbYJuS+e2J+VDLiYmdNd6Ec36l6rKDbsQjjr3tw1qU9T+xZiDXsWrGIba54j8J3XVd
         k3PKY59M3+VGq3LLOMSy3EowU+0nwjsLVz5VcsZw=
Date:   Mon, 7 Oct 2019 17:19:19 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 3/3] Revert "drm/sun4i: dsi: Rework a bit
 the hblk calculation"
Message-ID: <20191007151919.4uraoe374lui22gi@core.my.home>
Mail-Followup-To: Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20191001080253.6135-1-icenowy@aosc.io>
 <20191001080253.6135-4-icenowy@aosc.io>
 <CAMty3ZDW4XHyW+6XL_RSVHqTSk79-r749pa0n5e6VbUzowAsiw@mail.gmail.com>
 <58dc94b6371ab2f5b11b13ab707d73ab3fc4cc64.camel@aosc.io>
 <14da3ae768c439e387f6609553bd465e945d4a33.camel@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14da3ae768c439e387f6609553bd465e945d4a33.camel@aosc.io>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Icenowy,

On Sun, Oct 06, 2019 at 11:12:43PM +0800, Icenowy Zheng wrote:
> 在 2019-10-06日的 22:44 +0800，Icenowy Zheng写道：
> > 在 2019-10-03四的 09:53 +0530，Jagan Teki写道：
> > > Hi Wens,
> > > 
> > > On Tue, Oct 1, 2019 at 1:34 PM Icenowy Zheng <icenowy@aosc.io>
> > > wrote:
> > > > This reverts commit 62e7511a4f4dcf07f753893d3424decd9466c98b.
> > > > 
> > > > This commit, although claimed as a refactor, in fact changed the
> > > > formula.
> > > > 
> > > > By expanding the original formula, we can find that the const 10
> > > > is
> > > > not
> > > > substracted, instead it's added to the value (because 10 is
> > > > negative
> > > > when calculating hsa, and hsa itself is negative when calculating
> > > > hblk).
> > > > This breaks the similar pattern to other formulas, so restoring
> > > > the
> > > > original formula is more proper.
> > > > 
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 ++-------
> > > >  1 file changed, 2 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > index 2d3e822a7739..cb5fd19c0d0d 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > > > @@ -577,14 +577,9 @@ static void sun6i_dsi_setup_timings(struct
> > > > sun6i_dsi *dsi,
> > > >                           (mode->hsync_start - mode->hdisplay) *
> > > > Bpp - HFP_PACKET_OVERHEAD);
> > > > 
> > > >                 /*
> > > > -                * The blanking is set using a sync event (4
> > > > bytes)
> > > > -                * and a blanking packet (4 bytes + payload + 2
> > > > -                * bytes). Its minimal size is therefore 10
> > > > bytes.
> > > > +                * hblk seems to be the line + porches length.
> > > >                  */
> > > > -#define HBLK_PACKET_OVERHEAD   10
> > > > -               hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
> > > > -                          (mode->htotal - (mode->hsync_end -
> > > > mode-
> > > > > hsync_start)) * Bpp -
> > > > -                          HBLK_PACKET_OVERHEAD);
> > > > +               hblk = mode->htotal * Bpp - hsa;
> > > 
> > > The original formula is correct according to BSP [1] and work with
> > > my
> > > panels which I have tested before. May be the horizontal timings on
> > > panels you have leads to negative value.
> > 
> > Do you tested the same timing with BSP kernel?
> > 
> > It's quite difficult to get a negative value here, because the value
> > is
> > quite big (includes mode->hdisplay * Bpp).
> 
> By re-checking with the BSP source code, I found that the constant in
> the HFP formula is indeed wrong -- it should be 16, not 6.

I'm not sure if it's relevant to the discussion, but I've recently found
a LCD configuration manual for A10, that may contain some useful info:

See this: https://github.com/pocketbook/Platform_A13/blob/master/Kernel/drivers/video/sun5i/lcd/a10_lcd_config_nanual_v1.0.pdf

regards,
	o.

> > 
> > Strangely, only change the formula here back makes the timing
> > translated from FEX file works (tested on PineTab and PinePhone
> > production ver). The translation rule is from [1].
> > 
> > So I still insist on the patch because it's needed by experiment.
> > 
> > [1] http://linux-sunxi.org/LCD
> > 
> > > [1] 
> > > https://github.com/ayufan-pine64/linux-pine64/blob/my-hacks-1.2-with-drm/drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c#L919
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/14da3ae768c439e387f6609553bd465e945d4a33.camel%40aosc.io.
