Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD5C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AEF20856
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391534AbfEXMOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:14:25 -0400
Received: from verein.lst.de ([213.95.11.211]:53563 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391311AbfEXMOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:14:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id E333268B02; Fri, 24 May 2019 14:13:59 +0200 (CEST)
Date:   Fri, 24 May 2019 14:13:59 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
Message-ID: <20190524121359.GE15685@lst.de>
References: <20190523065013.2719D68B05@newverein.lst.de> <20190523065404.BB60F68B20@newverein.lst.de> <CA+E=qVdh-=C5zOYWYj95jLN51EaXFS6B+CQ101-f64q5QmgN3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=qVdh-=C5zOYWYj95jLN51EaXFS6B+CQ101-f64q5QmgN3g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 07:48:03AM -0700, Vasily Khoruzhick wrote:
> On Wed, May 22, 2019 at 11:54 PM Torsten Duwe <duwe@lst.de> wrote:
> >
> >
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > @@ -65,6 +65,21 @@
> >                 };
> >         };
> >
> > +       panel: panel {
> > +               compatible ="innolux,n116bge", "simple-panel";
> 
> IIRC Rob wanted it to be edp-connector, not simple-panel. Also you
> need to introduce edp-connector binding.

This line is identically found in
arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi and
arch/arm64/boot/dts/nvidia/tegra132-norrin.dts

> > +               status = "okay";
> > +               power-supply = <&reg_dcdc1>;
> > +               backlight = <&backlight>;
> > +
> > +               ports {
> > +                       panel_in: port {
> > +                               panel_in_edp: endpoint {
> > +                                       remote-endpoint = <&anx6345_out>;
> > +                               };
> > +                       };
> > +               };

The whole node is the same as in rk3288-veyron-chromebook.dtsi; I only adapted
the power-supply and remote-endpoint properties.

Is there anything wrong with that?

	Torsten

