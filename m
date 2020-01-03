Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C596CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E7721D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leOOQHhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgACFeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 00:34:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38066 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACFeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:34:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id x185so23063953pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 21:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bDjKFqnEc5rR/oxlZF7gmCvyShgs1hNiVY4NgOn+4HA=;
        b=leOOQHhjDy4DBo5vLTBMb3ON49SxV7dlM+nLIDV5jgg/A938TDw470FpBHkfMF5LMo
         2KLvwy8WWuGY6UxhG0FaK/M9gSATXQSpdrWmaG9RZ3ySYXnpSp5VB3Ff4d0ndMM1bfJv
         tVE5gBkPkeqIGAxZcgz0P/JASFIBgADMQGk6FJiPV3Ujyv9CgkgPr+KqXmfKxN5R5IGV
         yBQKC39aqMELQUMw9l4TnKjVFI5HWpfk6NxC1QgCRUR7LZ9KjqvIrzxvXNkz/DEsEwei
         Q+XUrkxyHMHc3rn55Mut+Dg7NIr3BfST0D06f/+6H99R5gZfKYrOeEMH5lOI/5wl76NY
         7eOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bDjKFqnEc5rR/oxlZF7gmCvyShgs1hNiVY4NgOn+4HA=;
        b=h/Z9pU5WK/pU/PbiKerlp16LfDNnG8MuhRREXpNwCXYdweVGz6aH9X7qvd1ZNZW2S5
         FhlF6JO7q8ltMp1N8tPGTh3C8siqqv1BxYFjouQzVaRzZiAi4gXHMgqIMZOFFY+Kb2kA
         eNWiXGYP2vAJBDaV+yv5TQc44JNb5JOuDLcqLLWVe2KJQ0oFG4CMYXWLiAJm6QCHsHE+
         XxB7ySGmD0vSQ66i4GfYFnPBBUNJkWrkADMpdbZBTHbzJAZG74D0w+t6wUTP0O94HzI+
         zbme14n6JyNxkmj1iyFvXPiISuoSYM5HSi2Z857vpsoLDMu+13RtUHlZaXaTbzarfvp7
         Kp6w==
X-Gm-Message-State: APjAAAUO4N+ujOMl1VrmaRxfThuV7VGEGlP7cM+bxsvtUfqWKDk4M0pX
        nfEg9apyiUMKtdY+xKCIulNmjw==
X-Google-Smtp-Source: APXvYqw01Mk2UnLpuuSD4hXiHUkrKtsnZuPZOtZokYUsL3OKvjbi5AoZEMma4j0uGAspkSfOSSo1hg==
X-Received: by 2002:a63:f5c:: with SMTP id 28mr95454017pgp.348.1578029664658;
        Thu, 02 Jan 2020 21:34:24 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s24sm12780879pjp.17.2020.01.02.21.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 21:34:23 -0800 (PST)
Date:   Thu, 2 Jan 2020 21:34:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] panel: simple: Add Ivo M133NWF4 R0
Message-ID: <20200103053420.GT549437@yoga>
References: <20191229060658.746189-1-bjorn.andersson@linaro.org>
 <20200102085557.GA29446@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102085557.GA29446@ravnborg.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02 Jan 00:55 PST 2020, Sam Ravnborg wrote:

> Hi Bjorn.
> 
> On Sat, Dec 28, 2019 at 10:06:58PM -0800, Bjorn Andersson wrote:
> > The InfoVision Optoelectronics M133NWF4 R0 panel is a 13.3" 1920x1080
> > eDP panel, add support for it in panel-simple.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 31 ++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index ba3f85f36c2f..d7ae0ede2b6e 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1806,6 +1806,34 @@ static const struct panel_desc innolux_zj070na_01p = {
> >  	},
> >  };
> >  
> > +static const struct drm_display_mode ivo_m133nwf4_r0_mode = {
> > +	.clock = 138778,
> > +	.hdisplay = 1920,
> > +	.hsync_start = 1920 + 24,
> > +	.hsync_end = 1920 + 24 + 48,
> > +	.htotal = 1920 + 24 + 48 + 88,
> > +	.vdisplay = 1080,
> > +	.vsync_start = 1080 + 3,
> > +	.vsync_end = 1080 + 3 + 12,
> > +	.vtotal = 1080 + 3 + 12 + 17,
> > +	.vrefresh = 60,
> > +	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> > +};
> > +
> > +static const struct panel_desc ivo_m133nwf4_r0 = {
> > +	.modes = &ivo_m133nwf4_r0_mode,
> > +	.num_modes = 1,
> > +	.bpc = 8,
> > +	.size = {
> > +		.width = 294,
> > +		.height = 165,
> > +	},
> > +	.delay = {
> > +		.hpd_absent_delay = 200,
> > +		.unprepare = 500,
> > +	},
> > +};
> 
> For new bindings - at least add connector_type.
> And consider bus_format and bus_flags too.
> 

Sure thing, will update the two patches.

> 
> > +
> >  static const struct display_timing koe_tx14d24vm1bpa_timing = {
> >  	.pixelclock = { 5580000, 5850000, 6200000 },
> >  	.hactive = { 320, 320, 320 },
> > @@ -3266,6 +3294,9 @@ static const struct of_device_id platform_of_match[] = {
> >  	}, {
> >  		.compatible = "innolux,zj070na-01p",
> >  		.data = &innolux_zj070na_01p,
> > +	}, {
> > +		.compatible = "ivo,m133nwf4-r0",
> Compatible must be documented in a binding file.
> We are discussing a new binding format where it is simple to add
> a new panel. But no final conclusion yet.
> 

Okay, will spin some DT bindings for these as well.

Thanks,
Bjorn

> The comments above (in panel_desc and here) also apply for the
> other patch you sent.
> 
> 	Sam
