Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53A22075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfDOOgG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:36:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33098 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOOgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:36:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id d55so14117209ede.0;
        Mon, 15 Apr 2019 07:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=Is/ROkUMxoj6uAm+SAA3PnrEYqYSelRvNitd1y8NtLw=;
        b=DCL1EeTmtDHuhdaHmjtJzPibj8Vc/yGorw8KVNLQGUxhHQOgRAViXyxnXROYTU1Do6
         Jf0wnGc5Jbzt32tnHhlc6sxYz8JdXrnd3y4TdAwnAjaZACxscOvOqVA2zibPGEPyQqSd
         xuhGFvV2fQcCivQJEb94DnAlLJmKDo5jNSL7NL7VpHVjMXgx6gwzYqpKPgd8KHWCCLul
         VSksQpu+EklJjai+wd6dCGUZsnJFTYdWP4QV+6g0oNszDt5WrtN4E+euGlEmnbc0iKUk
         GJ5pXBZgqzmCcue5mshAeAep/Ou+eKjPBQstO4tjtKEakPsNvxj7WmLY2rTbxlL4/S+7
         xBwg==
X-Gm-Message-State: APjAAAWuevbB8C5zjQUF4EXnzjmeVnovJnXeKGByQyvqroD7ZACoOQrd
        wpecWdaXlaiCom7m8Xn9wlcnobPAIDs=
X-Google-Smtp-Source: APXvYqwicB/YQ4Y9AH5YYhev8hhO401p7PvXoVT62cOIfREGwHFVIegZykyKNMW0uXFO1/NWY2m+mw==
X-Received: by 2002:a50:9816:: with SMTP id g22mr13967162edb.236.1555338962344;
        Mon, 15 Apr 2019 07:36:02 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id y5sm8742824eds.7.2019.04.15.07.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:36:01 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id p10so22300237wrq.1;
        Mon, 15 Apr 2019 07:36:00 -0700 (PDT)
X-Received: by 2002:a5d:6889:: with SMTP id h9mr24067198wru.12.1555338960223;
 Mon, 15 Apr 2019 07:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190412120730.473-1-megous@megous.com> <CAGb2v66cbpsoHJoiFJkBwhZ5SbO+uO+Kf6gtnA3kPFQZq0329Q@mail.gmail.com>
 <20190415142222.cytlvz7z3mjf7slm@core.my.home>
In-Reply-To: <20190415142222.cytlvz7z3mjf7slm@core.my.home>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 15 Apr 2019 22:35:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v67XBGhoJWho16A3+2axBuTsY+SkYkg1hwQJ0XyPvPeoOw@mail.gmail.com>
Message-ID: <CAGb2v67XBGhoJWho16A3+2axBuTsY+SkYkg1hwQJ0XyPvPeoOw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 0/3] Add basic support for RTC on Allwinner
 H6 SoC
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:22 PM 'Ondřej Jirman' via linux-sunxi
<linux-sunxi@googlegroups.com> wrote:
>
> Hi ChenYu,
>
> On Mon, Apr 15, 2019 at 04:18:12PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Apr 12, 2019 at 8:07 PM megous via linux-sunxi
> > <linux-sunxi@googlegroups.com> wrote:
> > >
> > > From: Ondrej Jirman <megous@megous.com>
> > >
> > > I went through the datasheets for H6 and H5, and compared the differences.
> > > RTCs are largely similar, but not entirely compatible. Incompatibilities
> > > are in details not yet implemented by the rtc driver though.
> > >
> > > I also corrected the clock tree in H6 DTSI.
> >
> > Please also add DCXO clock input/output and XO clock input to the bindings
> > and DT, and also fix up the clock tree. You can skip them in the driver for
> > now, but please add a TODO. As long as you don't change the clock-output-name
> > of osc24M, everything should work as before.
>
> That's a bit confusing. There's no clock-output-name for osc24M, nor for input
> clock used in the dt-bindings or the driver. Perhaps you meant osc32k? Maybe
> I'm misunderstanding something?

I meant the clock-output-names in the device node of the external 24M crystal.

> If you look at the datasheet page 349, it looks like RTC provides "hosc"
> clock (to plls and the system) either from XO or DCXO oscillators.
> The default selection depends on the voltage level on external PAD.
>
> So based on what you wrote, I suggest these actual changes/names:
>
> 1) Add DT docs for HOSC clock provided at index 3:
>
>   - 3: HOSC, 24MHz clock that clocks the PLLs and most of the SoC (H6 only)

Correct.

> 2) Add bindings description for "osc24M-dc", "osc24M-m" input clocks in
>    addition to existing support for "osc32k". Name "osc24M-m" is based on
>    X24MIN/MOUT pins and datasheet's "clk_24mxo" name.
>
> 3) The RTC driver would now just registers a fixed HOSC clock with a name
>    gathered from the clock-output-names index 3 (if enabled by the new
>    export_hosc flag - only enabled on H6).

You don't need to do this part yet. Since the CCU drivers are hard-wired
(suprise) to use the global clock name "osc24M" as hosc source. The DT
references are only for show ATM, so it doesn't matter if you implement
the clocks in the RTC driver.

However we want the DT to be correct, so that when we do get around to
doing it, we won't have to update the DT again.

It's up to you though. If you want to implement basic support, that's
fine by me. However you won't be able to test it without hacking the
CCU driver.

After describing this, it seems that when we get to doing the clk parent
rework, we'll be in a bad situation if we don't get rtc changes in before
the CCU changes.

>    The driver would ignore the "osc24M-dc", "osc24M-m" input clocks. Or perhaps
>    it could just support a case where only one of these are used and make it the
>    only parent of the HOSC clock?

They should just be DCXO and XO, based on the diagram. The names are local
to the RTC, so they don't need to be globally unique. Whatever matches the
datasheet is best.

>    HOSC default source selection is done based on external PAD setup, and
>    there's no need for runtime access/selection of HOSC source at the moment.

Is it even possible to change it?

> 4) In the future the RTC driver would be extended to support more refined
>    setup/muxing/runtime selection of osc24M-dc/osc24M-m. PRCM driver would
>    provide the osc24M-m clock, to be able for kernel to know how to gate it.
>
> The board's DTSI would have to link either "osc24M-dc", "osc24M-m" to nodes
> describing an external crystal (or to PRCM clock in the future). It's a boards
> choice  on what crystals are actually used. 3 configs are possible - with one or
> two crystals, connected to either one of XIN/XOUT X24MIN/X24MOUT pins or both.

AFAIK, osc24M-dc would link directly to the external crystal, while osc24M-m
would link to the external crystal first, then PRCM if it gets implemented.

> Would that work?
>
> DT would still probably need a re-work in the future, if the PRCM clock
> modeling the gate would be needed.

Yeah. We'll deal with that when we get to it.


To summarize, the goal is to get the DT right the first time.

Regards
ChenYu


> regards,
>   o.
>
> > We just want the DT to describe what is actually there. For the XO input,
> > you could just directly reference the external crystal node. The gate for
> > it is likely somewhere in the PRCM block, which we don't have docs for.
> >
> > > There's a small detail here, that's not described absolutely correctly in
> > > DTSI, but the difference is not really that material. ext_osc32k is
> > > originally modelled as a fixed clock that feeds into RTC module, but in
> > > reality it's the RTC module that implements via its registers enabling and
> > > disabling of this oscillator/clock.
> > >
> > > Though:
> > > - there's no other possible user of ext_osc32k than RTC module
> > > - there's no other possible external configuration for the crystal
> > >   circuit that would need to be handled in the dts per board
> > >
> > > So I guess, while the description is not perfect, this patch series still
> > > improves the current situation. Or maybe I'm misunderstanding something,
> > > and &ext_osc32k node just describes a fact that there's a crystal on
> > > the board. Then, everything is perhaps fine. :)
> >
> > Correct. The external clock nodes are modeling the crystal, not the internal
> > clock gate / distributor.
> >
> > Were the vendor to not include the crystal (for whatever reasons), the DT
> > should be able to describe it via the absence of the clock input, and the
> > driver should correctly use the internal (inaccurate) oscillator. I realize
> > the clocks property is required, and the driver doesn't handle this case
> > either, so we might have to fix that if it were to appear in the wild.
> >
> > > For now, the enable bit for this oscillator is toggled by the re-parenting
> > > code automatically, as needed.
> >
> > That's fine. No need to increase the clock tree depth.
> >
> > ChenYu
> >
> > > This patchset is necessary for implementing the WiFi/Bluetooth support
> > > on boards using H6 SoC.
> > >
> > > Please take a look.
> > >
> > > Thank you and regards,
> > >   Ondrej Jirman
> > >
> > > Ondrej Jirman (3):
> > >   dt-bindings: Add compatible for H6 RTC
> > >   rtc: sun6i: Add support for H6 RTC
> > >   arm64: dts: sun50i-h6: Add support for RTC and fix the clock tree
> > >
> > >  .../devicetree/bindings/rtc/sun6i-rtc.txt     |  1 +
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 30 +++++++-------
> > >  drivers/rtc/rtc-sun6i.c                       | 40 ++++++++++++++++++-
> > >  3 files changed, 55 insertions(+), 16 deletions(-)
> > >
> > > --
> > > 2.21.0
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > > For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
