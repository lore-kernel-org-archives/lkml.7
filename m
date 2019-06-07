Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0642EC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D187B20684
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 09:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfFGJlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 05:41:00 -0400
Received: from verein.lst.de ([213.95.11.211]:55092 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfFGJk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 05:40:59 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 931BF68C65; Fri,  7 Jun 2019 11:40:30 +0200 (CEST)
Date:   Fri, 7 Jun 2019 11:40:30 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Harald Geyer <harald@ccbib.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345
 bridge on Teres-I
Message-ID: <20190607094030.GA12373@lst.de>
References: <20190604122150.29D6468B05@newverein.lst.de> <20190604122308.98D4868B20@newverein.lst.de> <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com> <20190605101317.GA9345@lst.de> <20190605120237.ekmytfxcwbjaqy3x@flea> <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at> <20190607062802.m5wslx3imiqooq5a@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607062802.m5wslx3imiqooq5a@flea>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 08:28:02AM +0200, Maxime Ripard wrote:
> On Thu, Jun 06, 2019 at 03:59:27PM +0200, Harald Geyer wrote:
> >
> > If think valid compatible properties would be:
> > compatible = "innolux,n116bge", "simple-panel";
> > compatible = "edp-connector", "simple-panel";
> 
> A connector isn't a panel.
> 
> > compatible = "innolux,n116bge", "edp-connector", "simple-panel";
> 
> And the innolux,n116bge is certainly not a connector either.
> 
> > compatible = "edp-connector", "innolux,n116bge", "simple-panel";
> >
> > I can't make up my mind which one I prefere. However neither of these
> > variants requires actually implmenting an edp-connector driver.
> 
> No-one asked to do an edp-connector driver. You should use it in your
> DT, but if you want to have some code in your driver that parses the
> DT directly, I'm totally fine with that.

I must admit I fail to understand what that extra node would be good for.
Logically, the eDP far side is connected to the well-known n116bge.
Inside the laptop case it might as well be a flat ribbon cable or
soldered directly.
In good intention, that's all I wanted to express in the DT. I don't
know whether the relevant mechanical dimensions of the panel and the
connector are standardised, so whether one could in theory assemble it
with a different panel than the one it came with.

OTOH, as I checked during the discussion with anarsoul, the panel's
supply voltage is permanently connected to the main 3.3V rail.
We already agreed that the eDP output port must not neccessarily be
specified, this setup is a good example why: because the panel is
always powered, the anx6345 can always pull valid EDID data from it
so at this stage there's no need for any OS driver to reach beyond
the bridge. IIRC even the backlight got switched off for the blank
screen without.

All I wanted to say is that "there's usually an n116bge behind it";
but this is mostly redundant.

So, shall we just drop the output port specification (along with the
panel node) in order to get one step further?

> I guess you should describe why do you think it's "clear", because I'm
> not sure this is obvious for everyone here. eDP allows to discover
> which device is on the other side and its supported timings, just like
> HDMI for example (or regular DP, for that matter). Would you think
> it's clearly preferable to ship a DT with the DP/HDMI monitor
> connected on the other side exposed as a panel as well?

Well, as I wrote: "in good intention". That's the panel that comes with
the kit but it is very well detected automatically, just like you describe.

So, just leave it out?

	Torsten

