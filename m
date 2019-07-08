Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70981C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDC32166E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390572AbfGHR4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:56:12 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:41574 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfGHR4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:56:11 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id B2E35803AA;
        Mon,  8 Jul 2019 19:56:07 +0200 (CEST)
Date:   Mon, 8 Jul 2019 19:56:06 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 2/7] drm/panel: simple: Add ability to override
 typical timing
Message-ID: <20190708175606.GB3511@ravnborg.org>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org>
 <20190630202246.GB15102@ravnborg.org>
 <20190630205514.GA17046@ravnborg.org>
 <CAD=FV=WH4kmhQA0kbKcAUx=oOeqTZiQOFCXYpVWwq+mG7Y7ofA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WH4kmhQA0kbKcAUx=oOeqTZiQOFCXYpVWwq+mG7Y7ofA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=LBenJKLw8faiQqQJsPgA:9 a=IF-Cv_vKzCxN9PTp:21 a=nRygc59OdNG9nXZ-:21
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:39:06AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sun, Jun 30, 2019 at 1:55 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Douglas.
> >
> > > > +
> > > > +   /* Only add timings if override was not there or failed to validate */
> > > > +   if (num == 0 && panel->desc->num_timings)
> > > > +           num = panel_simple_get_timings_modes(panel);
> > > > +
> > > > +   /*
> > > > +    * Only add fixed modes if timings/override added no mode.
> > >
> > > This part I fail to understand.
> > > If we have a panel where we in panel-simple have specified the timings,
> > > and done so using display_timing so with proper {min, typ, max} then it
> > > should be perfectly legal to specify a more precise variant in the DT
> > > file.
> > > Or what did I miss here?
> >
> > Got it now.
> > If display_mode is used for timings this is what you call "fixed mode".
> > Hmm, if I got confused someone else may also be confused by this naming.
> 
> The name "fixed mode" comes from the old code, though I guess in the
> old code it used to refer to a mode that came from either the
> display_timing or the display_mode.
> 
> How about if I call it "panel_simple_get_from_fixed_display_mode"?
> ...or if you have another suggestion feel free to chime in.
What we really want to distingush here is the use of display_mode
and display_timings (if I got the names right).
That display_mode specify a fixed timing and display_timing specify
a valid range is something in the semantics of the two types.
So naming that refer to display_mode versus display_timing will make the
code simpler to understand. and then a nice comment that when
display_mode
is used one looses the possibility to use override_mode.
That would be fine to have in the struct in the driver.

> NOTE: Since this feedback is minor and this patch has been outstanding
> for a while (and is blocking other work), I am assuming that the best
> path forward is for Heiko to land this patch with Thierry's Ack and
> I'll send a follow-up.  Please yell if you disagree.
Let's give the patches a spin more as we have passed the possibility for
the current merge window.

I am on vacation at the moment and thus slow in responses, but will be back
at the home office next week and will be more responsive again.

	Sam - who is enjoying the alps in Austria
