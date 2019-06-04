Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F5CC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA5E23CCA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="gg+XXo5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfFDQVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:21:47 -0400
Received: from vps.xff.cz ([195.181.215.36]:36852 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbfFDQVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1559665305; bh=qm5r7h8IIEdRL40O9VMAH9oDefKlLBdaHOgDq3xcAx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gg+XXo5YGTIbCkKbpbL3v8FG0/Jel8Q4iepzwyWg0wYkRjoNxyYP0/4SxXfYhN2yH
         So04IwaJWADhd4PF9Ku/DQaA0uhU4TggtAkiHQvYXkgOb+zXVTzxsFa5xy2Acgzwf2
         GpteETgWrKs2aV143FMJGHL+6CqDtmNnO5TXleg8=
Date:   Tue, 4 Jun 2019 18:21:44 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH v2] clk: sunxi-ng: sun50i-h6-r: Fix
 incorrect W1 clock gate register
Message-ID: <20190604162144.hba5bmkdnidco7pf@core.my.home>
Mail-Followup-To: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190604154036.23211-1-megous@megous.com>
 <CAJiuCcda0ZDDrbdOF7TpTeoUOgt7GeS6wcgy45DRCo_U2XX6bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcda0ZDDrbdOF7TpTeoUOgt7GeS6wcgy45DRCo_U2XX6bQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On Tue, Jun 04, 2019 at 06:14:15PM +0200, Clément Péron wrote:
> Hi Ondrej,
> 
> On Tue, 4 Jun 2019 at 17:40, megous via linux-sunxi
> <linux-sunxi@googlegroups.com> wrote:
> >
> > From: Ondrej Jirman <megous@megous.com>
> >
> > The current code defines W1 clock gate to be at 0x1cc, overlaying it
> > with the IR gate.
> >
> > Clock gate for r-apb1-w1 is at 0x1ec. This fixes issues with IR receiver
> > causing interrupt floods on H6 (because interrupt flags can't be cleared,
> > due to IR module's bus being disabled).
> >
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > Fixes: b7c7b05065aa77ae ("clk: sunxi-ng: add support for H6 PRCM CCU")
> > ---
> >  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > index 27554eaf6929..8d05d4f1f8a1 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> > @@ -104,7 +104,7 @@ static SUNXI_CCU_GATE(r_apb2_i2c_clk,       "r-apb2-i2c",   "r-apb2",
> >  static SUNXI_CCU_GATE(r_apb1_ir_clk,   "r-apb1-ir",    "r-apb1",
> >                       0x1cc, BIT(0), 0);
> >  static SUNXI_CCU_GATE(r_apb1_w1_clk,   "r-apb1-w1",    "r-apb1",
> > -                     0x1cc, BIT(0), 0);
> > +                     0x1ec, BIT(0), 0);
> Just for information where did you find this information?
> Using the vendor kernel or user manual?

Informed guess. All gates and resets are in the same register. And
you can see below that reset register for w1 is 0x1ec. (reset register
for ir is 0x1cc)

regards,
	o.

> Thanks,
> Clément
> 
> >
> >  /* Information of IR(RX) mod clock is gathered from BSP source code */
> >  static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" };
> > --
> > 2.21.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190604154036.23211-1-megous%40megous.com.
> > For more options, visit https://groups.google.com/d/optout.
