Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718EAC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37ED920818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ESu+LZ2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfDOPRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:17:08 -0400
Received: from vps.xff.cz ([195.181.215.36]:40262 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfDOPRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1555341424; bh=8xwXVT3LW+zlhYrvlwYKn2Ag5zy2XOFiSQX1MCcT+mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESu+LZ2EEFWJEUmjvnv67TA4Iukv2ySu4cSoZ7rk9c1cvWuONCMhtWl+n3nzYKfy/
         FC01GXLI7qMM+Xs40cK8QnsaqJiACtc4k+kQd6ORlqds9v/951vC7LF/JjwSOFuu3u
         VYNubqZ+LHm0Ack/xV8uVCzg8kLGyew46MyC28eA=
Date:   Mon, 15 Apr 2019 17:17:03 +0200
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
Message-ID: <20190415151703.svdosn3wbhk625jm@core.my.home>
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
 <20190415142222.cytlvz7z3mjf7slm@core.my.home>
 <CAGb2v67XBGhoJWho16A3+2axBuTsY+SkYkg1hwQJ0XyPvPeoOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v67XBGhoJWho16A3+2axBuTsY+SkYkg1hwQJ0XyPvPeoOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:35:47PM +0800, Chen-Yu Tsai wrote:
> On Mon, Apr 15, 2019 at 10:22 PM 'Ondřej Jirman' via linux-sunxi
> <linux-sunxi@googlegroups.com> wrote:
> >
> > Hi ChenYu,
> >
> > On Mon, Apr 15, 2019 at 04:18:12PM +0800, Chen-Yu Tsai wrote:
> > > On Fri, Apr 12, 2019 at 8:07 PM megous via linux-sunxi
> > > <linux-sunxi@googlegroups.com> wrote:
> > > >
> > > > From: Ondrej Jirman <megous@megous.com>
> > > >
> > > > I went through the datasheets for H6 and H5, and compared the differences.
> > > > RTCs are largely similar, but not entirely compatible. Incompatibilities
> > > > are in details not yet implemented by the rtc driver though.
> > > >
> > > > I also corrected the clock tree in H6 DTSI.
> > >
> > > Please also add DCXO clock input/output and XO clock input to the bindings
> > > and DT, and also fix up the clock tree. You can skip them in the driver for
> > > now, but please add a TODO. As long as you don't change the clock-output-name
> > > of osc24M, everything should work as before.
> >
> > That's a bit confusing. There's no clock-output-name for osc24M, nor for input
> > clock used in the dt-bindings or the driver. Perhaps you meant osc32k? Maybe
> > I'm misunderstanding something?
> 
> I meant the clock-output-names in the device node of the external 24M crystal.
> 
> > If you look at the datasheet page 349, it looks like RTC provides "hosc"
> > clock (to plls and the system) either from XO or DCXO oscillators.
> > The default selection depends on the voltage level on external PAD.
> >
> > So based on what you wrote, I suggest these actual changes/names:
> >
> > 1) Add DT docs for HOSC clock provided at index 3:
> >
> >   - 3: HOSC, 24MHz clock that clocks the PLLs and most of the SoC (H6 only)
> 
> Correct.
> 
> > 2) Add bindings description for "osc24M-dc", "osc24M-m" input clocks in
> >    addition to existing support for "osc32k". Name "osc24M-m" is based on
> >    X24MIN/MOUT pins and datasheet's "clk_24mxo" name.
> >
> > 3) The RTC driver would now just registers a fixed HOSC clock with a name
> >    gathered from the clock-output-names index 3 (if enabled by the new
> >    export_hosc flag - only enabled on H6).
> 
> You don't need to do this part yet. Since the CCU drivers are hard-wired
> (suprise) to use the global clock name "osc24M" as hosc source. The DT
> references are only for show ATM, so it doesn't matter if you implement
> the clocks in the RTC driver.

Ah, so that's how it works. And that's what "clock parent rework" refers
to! :)

> However we want the DT to be correct, so that when we do get around to
> doing it, we won't have to update the DT again.

Ok, so I'll try to come up with a new set of patches, and we'll see if
I'll get the description right.

> It's up to you though. If you want to implement basic support, that's
> fine by me. However you won't be able to test it without hacking the
> CCU driver.
> 
> After describing this, it seems that when we get to doing the clk parent
> rework, we'll be in a bad situation if we don't get rtc changes in before
> the CCU changes.

Yeah.

> >    The driver would ignore the "osc24M-dc", "osc24M-m" input clocks. Or perhaps
> >    it could just support a case where only one of these are used and make it the
> >    only parent of the HOSC clock?
> 
> They should just be DCXO and XO, based on the diagram. The names are local
> to the RTC, so they don't need to be globally unique. Whatever matches the
> datasheet is best.

Ok.

> >    HOSC default source selection is done based on external PAD setup, and
> >    there's no need for runtime access/selection of HOSC source at the moment.
> 
> Is it even possible to change it?

Hmm. Looks like the answer is no:

DCXO_CTRL_REG:
  - OSC_CLK_SRC_SEL bit:
    (Pad select)
    Read/Write column contains 'U' not (R/W)

> > 4) In the future the RTC driver would be extended to support more refined
> >    setup/muxing/runtime selection of osc24M-dc/osc24M-m. PRCM driver would
> >    provide the osc24M-m clock, to be able for kernel to know how to gate it.
> >
> > The board's DTSI would have to link either "osc24M-dc", "osc24M-m" to nodes
> > describing an external crystal (or to PRCM clock in the future). It's a boards
> > choice  on what crystals are actually used. 3 configs are possible - with one or
> > two crystals, connected to either one of XIN/XOUT X24MIN/X24MOUT pins or both.
> 
> AFAIK, osc24M-dc would link directly to the external crystal, while osc24M-m
> would link to the external crystal first, then PRCM if it gets implemented.

Ok.

thank you,
	o.

> > Would that work?
> >
> > DT would still probably need a re-work in the future, if the PRCM clock
> > modeling the gate would be needed.
> 
> Yeah. We'll deal with that when we get to it.
> 
> 
> To summarize, the goal is to get the DT right the first time.
> 
> Regards
> ChenYu
> 
> 
> > regards,
> >   o.
> >
> > > We just want the DT to describe what is actually there. For the XO input,
> > > you could just directly reference the external crystal node. The gate for
> > > it is likely somewhere in the PRCM block, which we don't have docs for.
> > >
> > > > There's a small detail here, that's not described absolutely correctly in
> > > > DTSI, but the difference is not really that material. ext_osc32k is
> > > > originally modelled as a fixed clock that feeds into RTC module, but in
> > > > reality it's the RTC module that implements via its registers enabling and
> > > > disabling of this oscillator/clock.
> > > >
> > > > Though:
> > > > - there's no other possible user of ext_osc32k than RTC module
> > > > - there's no other possible external configuration for the crystal
> > > >   circuit that would need to be handled in the dts per board
> > > >
> > > > So I guess, while the description is not perfect, this patch series still
> > > > improves the current situation. Or maybe I'm misunderstanding something,
> > > > and &ext_osc32k node just describes a fact that there's a crystal on
> > > > the board. Then, everything is perhaps fine. :)
> > >
> > > Correct. The external clock nodes are modeling the crystal, not the internal
> > > clock gate / distributor.
> > >
> > > Were the vendor to not include the crystal (for whatever reasons), the DT
> > > should be able to describe it via the absence of the clock input, and the
> > > driver should correctly use the internal (inaccurate) oscillator. I realize
> > > the clocks property is required, and the driver doesn't handle this case
> > > either, so we might have to fix that if it were to appear in the wild.
> > >
> > > > For now, the enable bit for this oscillator is toggled by the re-parenting
> > > > code automatically, as needed.
> > >
> > > That's fine. No need to increase the clock tree depth.
> > >
> > > ChenYu
> > >
> > > > This patchset is necessary for implementing the WiFi/Bluetooth support
> > > > on boards using H6 SoC.
> > > >
> > > > Please take a look.
> > > >
> > > > Thank you and regards,
> > > >   Ondrej Jirman
> > > >
> > > > Ondrej Jirman (3):
> > > >   dt-bindings: Add compatible for H6 RTC
> > > >   rtc: sun6i: Add support for H6 RTC
> > > >   arm64: dts: sun50i-h6: Add support for RTC and fix the clock tree
> > > >
> > > >  .../devicetree/bindings/rtc/sun6i-rtc.txt     |  1 +
> > > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 30 +++++++-------
> > > >  drivers/rtc/rtc-sun6i.c                       | 40 ++++++++++++++++++-
> > > >  3 files changed, 55 insertions(+), 16 deletions(-)
> > > >
> > > > --
> > > > 2.21.0
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > > > For more options, visit https://groups.google.com/d/optout.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > For more options, visit https://groups.google.com/d/optout.
