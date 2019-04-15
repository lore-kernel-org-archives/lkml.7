Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D01C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DAF20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="VxmFrN3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfDOOW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:22:26 -0400
Received: from vps.xff.cz ([195.181.215.36]:39680 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOOW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555338143; bh=hrlGzSLgt392fv600ih6xjES/JjeZrW2yh9H69B8EX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VxmFrN3kistM806DUD6T25awxoC4wVOQfclMHkNU2ZrhsXI7KfyRzjydTiZ0//rkx
         0QqXtqRtgx7d0rebU50mfXIH2COHXo63sjLq4p/6WFUuyqLS93jlQnvcUtxhb3eAvV
         mhQLzEKKx0940aoFq+iMGmYbqAPr3uuNTRolBqTU=
Date:   Mon, 15 Apr 2019 16:22:22 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 0/3] Add basic support for RTC on Allwinner
 H6 SoC
Message-ID: <20190415142222.cytlvz7z3mjf7slm@core.my.home>
Mail-Followup-To: Chen-Yu Tsai <wens@csie.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20190412120730.473-1-megous@megous.com>
 <CAGb2v66cbpsoHJoiFJkBwhZ5SbO+uO+Kf6gtnA3kPFQZq0329Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v66cbpsoHJoiFJkBwhZ5SbO+uO+Kf6gtnA3kPFQZq0329Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChenYu,

On Mon, Apr 15, 2019 at 04:18:12PM +0800, Chen-Yu Tsai wrote:
> On Fri, Apr 12, 2019 at 8:07 PM megous via linux-sunxi
> <linux-sunxi@googlegroups.com> wrote:
> >
> > From: Ondrej Jirman <megous@megous.com>
> >
> > I went through the datasheets for H6 and H5, and compared the differences.
> > RTCs are largely similar, but not entirely compatible. Incompatibilities
> > are in details not yet implemented by the rtc driver though.
> >
> > I also corrected the clock tree in H6 DTSI.
> 
> Please also add DCXO clock input/output and XO clock input to the bindings
> and DT, and also fix up the clock tree. You can skip them in the driver for
> now, but please add a TODO. As long as you don't change the clock-output-name
> of osc24M, everything should work as before.

That's a bit confusing. There's no clock-output-name for osc24M, nor for input
clock used in the dt-bindings or the driver. Perhaps you meant osc32k? Maybe
I'm misunderstanding something?

If you look at the datasheet page 349, it looks like RTC provides "hosc"
clock (to plls and the system) either from XO or DCXO oscillators.
The default selection depends on the voltage level on external PAD.

So based on what you wrote, I suggest these actual changes/names:

1) Add DT docs for HOSC clock provided at index 3:

  - 3: HOSC, 24MHz clock that clocks the PLLs and most of the SoC (H6 only)

2) Add bindings description for "osc24M-dc", "osc24M-m" input clocks in
   addition to existing support for "osc32k". Name "osc24M-m" is based on
   X24MIN/MOUT pins and datasheet's "clk_24mxo" name.

3) The RTC driver would now just registers a fixed HOSC clock with a name
   gathered from the clock-output-names index 3 (if enabled by the new 
   export_hosc flag - only enabled on H6).

   The driver would ignore the "osc24M-dc", "osc24M-m" input clocks. Or perhaps
   it could just support a case where only one of these are used and make it the
   only parent of the HOSC clock?

   HOSC default source selection is done based on external PAD setup, and
   there's no need for runtime access/selection of HOSC source at the moment.

4) In the future the RTC driver would be extended to support more refined
   setup/muxing/runtime selection of osc24M-dc/osc24M-m. PRCM driver would
   provide the osc24M-m clock, to be able for kernel to know how to gate it.

The board's DTSI would have to link either "osc24M-dc", "osc24M-m" to nodes
describing an external crystal (or to PRCM clock in the future). It's a boards
choice  on what crystals are actually used. 3 configs are possible - with one or
two crystals, connected to either one of XIN/XOUT X24MIN/X24MOUT pins or both.

Would that work?

DT would still probably need a re-work in the future, if the PRCM clock
modeling the gate would be needed.

regards,
  o.

> We just want the DT to describe what is actually there. For the XO input,
> you could just directly reference the external crystal node. The gate for
> it is likely somewhere in the PRCM block, which we don't have docs for.
> 
> > There's a small detail here, that's not described absolutely correctly in
> > DTSI, but the difference is not really that material. ext_osc32k is
> > originally modelled as a fixed clock that feeds into RTC module, but in
> > reality it's the RTC module that implements via its registers enabling and
> > disabling of this oscillator/clock.
> >
> > Though:
> > - there's no other possible user of ext_osc32k than RTC module
> > - there's no other possible external configuration for the crystal
> >   circuit that would need to be handled in the dts per board
> >
> > So I guess, while the description is not perfect, this patch series still
> > improves the current situation. Or maybe I'm misunderstanding something,
> > and &ext_osc32k node just describes a fact that there's a crystal on
> > the board. Then, everything is perhaps fine. :)
> 
> Correct. The external clock nodes are modeling the crystal, not the internal
> clock gate / distributor.
> 
> Were the vendor to not include the crystal (for whatever reasons), the DT
> should be able to describe it via the absence of the clock input, and the
> driver should correctly use the internal (inaccurate) oscillator. I realize
> the clocks property is required, and the driver doesn't handle this case
> either, so we might have to fix that if it were to appear in the wild.
>
> > For now, the enable bit for this oscillator is toggled by the re-parenting
> > code automatically, as needed.
> 
> That's fine. No need to increase the clock tree depth.
> 
> ChenYu
> 
> > This patchset is necessary for implementing the WiFi/Bluetooth support
> > on boards using H6 SoC.
> >
> > Please take a look.
> >
> > Thank you and regards,
> >   Ondrej Jirman
> >
> > Ondrej Jirman (3):
> >   dt-bindings: Add compatible for H6 RTC
> >   rtc: sun6i: Add support for H6 RTC
> >   arm64: dts: sun50i-h6: Add support for RTC and fix the clock tree
> >
> >  .../devicetree/bindings/rtc/sun6i-rtc.txt     |  1 +
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 30 +++++++-------
> >  drivers/rtc/rtc-sun6i.c                       | 40 ++++++++++++++++++-
> >  3 files changed, 55 insertions(+), 16 deletions(-)
> >
> > --
> > 2.21.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > For more options, visit https://groups.google.com/d/optout.
