Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40C5C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8818218A0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbfGHRuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:50:16 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:41184 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730936AbfGHRuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:50:15 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6F4BD80636;
        Mon,  8 Jul 2019 19:50:09 +0200 (CEST)
Date:   Mon, 8 Jul 2019 19:50:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 2/7] drm/panel: simple: Add ability to override
 typical timing
Message-ID: <20190708175007.GA3511@ravnborg.org>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org>
 <20190630202246.GB15102@ravnborg.org>
 <CAD=FV=V_wTD1xpkXRe-z2HsZ8QXKq7jmq8CsfhMnFxi-5XDJjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=V_wTD1xpkXRe-z2HsZ8QXKq7jmq8CsfhMnFxi-5XDJjw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=AWgJsaMlI6ysr0MxQJMA:9 a=0846P8UFn4bgp1PN:21 a=puqGkp3IltQWEqwz:21
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dough.

On Mon, Jul 01, 2019 at 09:39:24AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sun, Jun 30, 2019 at 1:22 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > > @@ -91,6 +92,8 @@ struct panel_simple {
> > >       struct i2c_adapter *ddc;
> > >
> > >       struct gpio_desc *enable_gpio;
> > > +
> > > +     struct drm_display_mode override_mode;
> > I fail to see where this poiter is assigned.
> 
> In panel_simple_parse_override_mode().  Specifically:
> 
> drm_display_mode_from_videomode(&vm, &panel->override_mode);

The above code-snippet is only called in the panel has specified display
timings using display_timings - it is not called when display_mode is
used.
So override_mode is only assigned in some cases and not all cases.
This needs to be fixed so we do not reference override_mode unless
it is set.

> 
> 
> > @@ -152,6 +162,44 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
> > >               num++;
> > >       }
> > >
> > > +     return num;
> > > +}
> > > +
> > > +static int panel_simple_get_non_edid_modes(struct panel_simple *panel)
> > > +{
> > > +     struct drm_connector *connector = panel->base.connector;
> > > +     struct drm_device *drm = panel->base.drm;
> > > +     struct drm_display_mode *mode;
> > > +     bool has_override = panel->override_mode.type;
> > This looks suspicious.
> > panel->override_mode.type is an unsigned int that may have a number of
> > bits set.
> > So the above code implicitly convert a .type != 0 to a true.
> > This can be expressed in a much more reader friendly way.
> 
> You would suggest that I add a boolean field to a structure to
> indicate whether an override mode is present?
A simple  bool has_override = panel->override_mode.type != 0;
would do the trick here.
Then there is no hidden conversion from int to a bool.

But as override_mode can be NULL something more needs to be done.

	Sam
