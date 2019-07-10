Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D9C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0ACD21019
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hqkoo2XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfGJW4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 18:56:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40036 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfGJW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:56:54 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so8351948iom.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvZvVibciLuoN0XPHn1GQTPO0jZSmghihu4pRgb43gE=;
        b=Hqkoo2XXLEooMC5VZ+gOGg3gxQkocTVvzTmDsnDANF3OvZLlo/WQja4ye0rFzpf83e
         shsMhGUJvVUA4YU0xi/vv+i+XuO2LxUMqoRYnyGtJibDxbKwyeL16AR1P0KokEbKVpus
         TtaPbc8kH0P9xgP/1HkX6qrifSz9Mm/YfZAik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvZvVibciLuoN0XPHn1GQTPO0jZSmghihu4pRgb43gE=;
        b=FGlWkY8BuHXcuXLVB147SUGpQtk6Mb3ys2vcT8GCIDdCsyWfwtCQn2a7m/5cvQ8KY6
         71TT9K1PQkvkMu3aSZG5NJBqIdW1pBdOa/sA7issjs+fJwMpjY8PHzOKJBlRmJadv+MO
         LSXgV+pz8zp6QNAvS9t9GRVpMmuvVm52ZYXjIDqD0Pg7pgnq/y25R3efPE1EBOXtJQf9
         CVoOgXa/8R4pTV11DTHPBk2cXMdTFLfxbfD8XYVHn14reWP28yOaig/+X+hYwbBFFeRE
         75GldE7b/RCqa9h2FZaI1xYjDBMqVoJJTQR9IXyJLcHjIeIsTWIGoRJ80qVfjMTksfd1
         oQsw==
X-Gm-Message-State: APjAAAWwwYbDPN3S5sQL9Ug6NsSlUUiGNGjdzl3BMxoQI0svfRt+13rh
        Q6DlsKv2uVtBfNR0cmJpsXYcoZ1KjQw=
X-Google-Smtp-Source: APXvYqzieaTarY0l9Cjys1irHjDHVNMkkxiwJ1zMj5UqM/lZ3QIXQhzvyGnP29vxGwjhcUetlx7drw==
X-Received: by 2002:a5e:9314:: with SMTP id k20mr670084iom.235.1562799412852;
        Wed, 10 Jul 2019 15:56:52 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id z26sm3745733ioi.85.2019.07.10.15.56.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 15:56:51 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id f4so8378734ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 15:56:51 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr670314iop.58.1562799411159;
 Wed, 10 Jul 2019 15:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org> <20190630202246.GB15102@ravnborg.org>
 <20190630205514.GA17046@ravnborg.org> <CAD=FV=WH4kmhQA0kbKcAUx=oOeqTZiQOFCXYpVWwq+mG7Y7ofA@mail.gmail.com>
 <20190708175606.GB3511@ravnborg.org>
In-Reply-To: <20190708175606.GB3511@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Jul 2019 15:56:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VdkPLwyGhSnrHCcduQAPwby35Mqhk_r=O595bMoMT=6w@mail.gmail.com>
Message-ID: <CAD=FV=VdkPLwyGhSnrHCcduQAPwby35Mqhk_r=O595bMoMT=6w@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] drm/panel: simple: Add ability to override typical timing
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 8, 2019 at 10:56 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Mon, Jul 01, 2019 at 09:39:06AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Sun, Jun 30, 2019 at 1:55 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Douglas.
> > >
> > > > > +
> > > > > +   /* Only add timings if override was not there or failed to validate */
> > > > > +   if (num == 0 && panel->desc->num_timings)
> > > > > +           num = panel_simple_get_timings_modes(panel);
> > > > > +
> > > > > +   /*
> > > > > +    * Only add fixed modes if timings/override added no mode.
> > > >
> > > > This part I fail to understand.
> > > > If we have a panel where we in panel-simple have specified the timings,
> > > > and done so using display_timing so with proper {min, typ, max} then it
> > > > should be perfectly legal to specify a more precise variant in the DT
> > > > file.
> > > > Or what did I miss here?
> > >
> > > Got it now.
> > > If display_mode is used for timings this is what you call "fixed mode".
> > > Hmm, if I got confused someone else may also be confused by this naming.
> >
> > The name "fixed mode" comes from the old code, though I guess in the
> > old code it used to refer to a mode that came from either the
> > display_timing or the display_mode.
> >
> > How about if I call it "panel_simple_get_from_fixed_display_mode"?
> > ...or if you have another suggestion feel free to chime in.
> What we really want to distingush here is the use of display_mode
> and display_timings (if I got the names right).
> That display_mode specify a fixed timing and display_timing specify
> a valid range is something in the semantics of the two types.
> So naming that refer to display_mode versus display_timing will make the
> code simpler to understand. and then a nice comment that when
> display_mode
> is used one looses the possibility to use override_mode.
> That would be fine to have in the struct in the driver.

OK, I can change the names here and try to find a good place to add a comment.


> > NOTE: Since this feedback is minor and this patch has been outstanding
> > for a while (and is blocking other work), I am assuming that the best
> > path forward is for Heiko to land this patch with Thierry's Ack and
> > I'll send a follow-up.  Please yell if you disagree.
> Let's give the patches a spin more as we have passed the possibility for
> the current merge window.

Any way I can convince you to change your mind here?  There are no
functional changes requested so far in your feedback and no bugs--it's
just a few variable names and comments.  By landing the existing
patches as-is:

1. We stop spamming all the people CCed on this whole series (which
includes device tree patches) that might be interested in the series
as a whole but aren't interested in details.

2. We can debate the bikeshed-type issues on their own merit and I
don't have to debate removing existing Acks / Reviewed-by / Tested-by
tags as I make changes.

3. Even if it's not a good time to land the patches right now we know
that these patches will be ready to land as soon as the window opens.
As I mentioned earlier these patches are blocking other work [1] and
landing that patch is actually preventing Matthias from submitting
another series of patches to add support for rk3288-veyron-tiger and
rk3288-veyron-fievel.  Certainly I know that upstream doesn't make a
policy of landing things just to suit the timelines of a downstream
project, but in this case there seems very little downsides to landing
the existing patches and taking a later cleanup patch.


> I am on vacation at the moment and thus slow in responses, but will be back
> at the home office next week and will be more responsive again.
>
>         Sam - who is enjoying the alps in Austria

Hope you have had a great vacation!

[1] https://lkml.kernel.org/r/20190625222629.154619-1-mka@chromium.org

-Doug
