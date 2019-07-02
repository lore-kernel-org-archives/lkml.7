Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E5C06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F0A21848
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EXC0a6fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGBPkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:40:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41763 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGBPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:40:39 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so37972731ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AuMos9aOQM3cxcuhv1W60RSW7KPJmo8XlBPpXo9DwCM=;
        b=EXC0a6fl270PfkwfxWzCHOx4R/6yhlO7DJ1l9JUMGtuVKq/y1rC1kLXwgNQzLEEVX9
         GXFXuCSjEmgmkRMe22VN8Si9ND41RT9/KzZzdgDXlCAw4zDfk1zOI/z46qkjn/kGwM46
         b6soIF2xiVhwujyt4rbqlkDPEeXgmw6xb1yJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AuMos9aOQM3cxcuhv1W60RSW7KPJmo8XlBPpXo9DwCM=;
        b=FLtx+Qlv0dSUr4j6V5sxbfZWqfJpv1Vv8wCEdUZhv0qlGTiq6cSJfNrF1ikp38kGXU
         bLNnA3W6BHFmLGk9BbhYRNC4q19r5hVq2t/1GKAMxoR5Q8VpYZOtyXGkCi7uCN/w7Gb0
         ipFHJd3z/EdqWbgaSmM5C1AJkefpgBOnzvmcFwrWSSm5+lMKt8trRPfnkGoII64aN2GZ
         KD+D6xKhFj4udyJaGFPd6puNtcCU6UmzWhqn9ubwJQFzqUJ9JSoy339tWEMWqA842pIA
         jhfkAbmKTcJVDVl6KLmDeu0tqJJb9/VCM0/WGnowVyJlzR80U7WL8BhVGtzyYb2wWWbI
         ug4w==
X-Gm-Message-State: APjAAAVVZWGscjDQwXWlKaWrcj7SjM+ssCgc0Bd9RkLGR3IU89pexVtr
        4Z/A6QHv7UWFAr+8KpZwKlPsMalTlCG4hi2Rx2yDUg==
X-Google-Smtp-Source: APXvYqyQn4ELrVQ+31mi6vxiW6KfqbigRcLe+LAxPCqbDf7gQDuzyI9WP9loYa7CyZvrX79HFV3MP0xrrvEDEhK+XbE=
X-Received: by 2002:a05:6638:3d6:: with SMTP id r22mr35517516jaq.71.1562082037872;
 Tue, 02 Jul 2019 08:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190523204823.mx7l4ozklzdh7npn@flea> <CAMty3ZA0S=+8NBrQZvP6sFdzSYWqhNZL_KjkJAQ0jTc2RVivrw@mail.gmail.com>
 <20190604143016.fcx3ezmga244xakp@flea> <CAMty3ZAAK4RoE6g_LAZ-Q38On_1s_TTOz65YG7PVd88mwp-+4Q@mail.gmail.com>
 <20190613131626.7zbwvrvd4e7eafrc@flea> <CAMty3ZBDkMJkZm8FudNB1wQ+L-q3XVKa3zR2M0wZ5Uncdy_Ayg@mail.gmail.com>
 <20190624130442.ww4l3zctykr4i2e2@flea> <CAMty3ZB+eZUh5mr-LMZuEd_wrwLCN0mbf7arcRQHj8=uUNNq=Q@mail.gmail.com>
 <20190625143747.3czd7sit4waz75b6@flea> <CAMty3ZCh+C9+zgcL633tTw6aPW_WOLnYN7FzJHX+3zu8=8Unpg@mail.gmail.com>
 <20190702152908.fwwf7smt7nh2lxo2@flea>
In-Reply-To: <20190702152908.fwwf7smt7nh2lxo2@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 2 Jul 2019 21:10:26 +0530
Message-ID: <CAMty3ZCBK__VcdNh6xJESjsX7nGrBHxLY3fOWW=5TxOVrwyVXw@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v10 04/11] drm/sun4i: tcon: Compute DCLK
 dividers based on format, lanes
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bhushan Shah <bshah@mykolab.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?B?5Z2a5a6a5YmN6KGM?= <powerpan@qq.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 8:59 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Jul 02, 2019 at 12:30:14AM +0530, Jagan Teki wrote:
> > On Tue, Jun 25, 2019 at 8:07 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > > > > > > BSP has tcon_div and dsi_div. dsi_div is dynamic which depends on
> > > > > > > > > > bpp/lanes and it indeed depends on PLL computation (not tcon_div),
> > > > > > > > > > anyway I have explained again on this initial link you mentioned.
> > > > > > > > > > Please have a look and get back.
> > > > > > > > >
> > > > > > > > > I'll have a look, thanks.
> > > > > > > > >
> > > > > > > > > I've given your patches a try on my setup though, and this patch
> > > > > > > > > breaks it with vblank timeouts and some horizontal lines that looks
> > > > > > > > > like what should be displayed, but blinking and on the right of the
> > > > > > > > > display. The previous ones are fine though.
> > > > > > > >
> > > > > > > > Would you please send me the link of panel driver.
> > > > > > >
> > > > > > > It's drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> > > > > >
> > > > > > Look like this panel work even w/o any vendor sequence. it's similar
> > > > > > to the 4-lane panel I have with RGB888, so the dclk div is 6, is it
> > > > > > working with this divider?
> > > > >
> > > > > It works with 4, it doesn't work with 6.
> > > >
> > > > Can be the pixel clock with associated timings can make this diff.
> > > > Would you send me the pixel clock, pll_rate and timings this panel
> > > > used it from BSP?
> > >
> > > This board never had an Allwinner BSP
> >
> > Running on BSP would help to understand some clue, anyway would you
> > send me the the value PLL_MIPI register (devme 0x1c20040) on this
> > board. I'm trying to understand how it value in your case.
>
> I'm sorry, but I'm not going to port a whole BSP on that board,
> especially for something I haven't been convinced it's the right fix.

Look like a dead lock here, this change has a conclusive evidence from
BSP (which is AW datasheet or open code to outside world) and it is
working with A33, A64 and R40 which was tested in 4 different panels
and I don't understand the reason for not going with this (atleast
check with respect to BSP).

Please suggest, what I can do further, your suggestion is very helpful here.

Jagan.
