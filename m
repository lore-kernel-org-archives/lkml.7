Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFA9C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8BC20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfFGG2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:28:20 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58893 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfFGG2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:28:19 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A363840003;
        Fri,  7 Jun 2019 06:28:03 +0000 (UTC)
Date:   Fri, 7 Jun 2019 08:28:02 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Harald Geyer <harald@ccbib.org>
Cc:     Torsten Duwe <duwe@lst.de>, Vasily Khoruzhick <anarsoul@gmail.com>,
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
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
Message-ID: <20190607062802.m5wslx3imiqooq5a@flea>
References: <20190604122150.29D6468B05@newverein.lst.de>
 <20190604122308.98D4868B20@newverein.lst.de>
 <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
 <20190605101317.GA9345@lst.de>
 <20190605120237.ekmytfxcwbjaqy3x@flea>
 <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 03:59:27PM +0200, Harald Geyer wrote:
> Guys, this discussion is getting heated for no reason. Let's put
> personal frustrations aside and discuss the issue on its merits:
>
> Maxime Ripard writes:
> > On Wed, Jun 05, 2019 at 12:13:17PM +0200, Torsten Duwe wrote:
> > > On Tue, Jun 04, 2019 at 08:08:40AM -0700, Vasily Khoruzhick wrote:
> > > > On Tue, Jun 4, 2019 at 5:23 AM Torsten Duwe <duwe@lst.de> wrote:
> > > > >
> > > > > Teres-I has an anx6345 bridge connected to the RGB666 LCD output, and
> > > > > the I2C controlling signals are connected to I2C0 bus. eDP output goes
> > > > > to an Innolux N116BGE panel.
> > > > >
> > > > > Enable it in the device tree.
> > > > >
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > > > > ---
> > > > >  .../boot/dts/allwinner/sun50i-a64-teres-i.dts      | 65 ++++++++++++++++++++--
> > > > >  1 file changed, 61 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > > > index 0ec46b969a75..a0ad438b037f 100644
> > > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> > > > > @@ -65,6 +65,21 @@
> > > > >                 };
> > > > >         };
> > > > >
> > > > > +       panel: panel {
> > > > > +               compatible ="innolux,n116bge", "simple-panel";
> > > >
> > > > It's still "simple-panel". I believe I already mentioned that Rob
> > > > asked it to be edp-connector.
>
> Actually just dropping the "simple-panel" compatible would be a poor
> choice. Even if "edp-connector" is specified as binding and implemented in a
> driver, there are older kernel versions and other operating systems to
> keep in mind.

Which older kernels? This is a new binding, adding a new driver, so if
an older kernel uses a separate driver with its own binding, good for
them, but we don't have to support it.

> If the HW works with "simple-panel" driver satisfactorily,
> we should definitely keep the compatible as a fall back for cases where
> the edp-connector driver is unavailable.
>
> If think valid compatible properties would be:
> compatible = "innolux,n116bge", "simple-panel";
> compatible = "edp-connector", "simple-panel";

A connector isn't a panel.

> compatible = "innolux,n116bge", "edp-connector", "simple-panel";

And the innolux,n116bge is certainly not a connector either.

> compatible = "edp-connector", "innolux,n116bge", "simple-panel";
>
> I can't make up my mind which one I prefere. However neither of these
> variants requires actually implmenting an edp-connector driver.

No-one asked to do an edp-connector driver. You should use it in your
DT, but if you want to have some code in your driver that parses the
DT directly, I'm totally fine with that.

> And each of these variants is clearly preferable to shipping DTs
> without description of the panel at all and complies with bindings
> after adding a stub for "edp-connector".

I guess you should describe why do you think it's "clear", because I'm
not sure this is obvious for everyone here. eDP allows to discover
which device is on the other side and its supported timings, just like
HDMI for example (or regular DP, for that matter). Would you think
it's clearly preferable to ship a DT with the DP/HDMI monitor
connected on the other side exposed as a panel as well?

> > And the DT is considered an ABI, so yeah, we will witheld everything
> > that doesn't fit what we would like.
>
> I fail to see how the patch in discussion adds new ABI.

The binding itself is the ABI, and we will have to support that
binding for pretty much forever.

> While I understand the need to pester contributors for more work,
> outright blocking DTs, that properly describe the HW

Properly is arguable.

> and comply with existing bindings

And that's bindings meant for another use-case.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
