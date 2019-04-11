Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B904CC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBD620693
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 22:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDKWGO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 18:06:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33956 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbfDKWGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 18:06:13 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEhpW-0001y4-FF; Fri, 12 Apr 2019 00:05:58 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "elaine.zhang" <zhangqing@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] Revert "clk: rockchip: mark noc and some special clk as critical on rk3288"
Date:   Fri, 12 Apr 2019 00:05:57 +0200
Message-ID: <1820193.6uR021mFLB@diego>
In-Reply-To: <CAD=FV=Ue3C3gMWx9hnQr=+LU77xdemLbsWozFZoCuQAACjiCUg@mail.gmail.com>
References: <20190409204707.150347-1-dianders@chromium.org> <1491b5f1-e9f9-5718-76e5-0a49814ed76d@rock-chips.com> <CAD=FV=Ue3C3gMWx9hnQr=+LU77xdemLbsWozFZoCuQAACjiCUg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 11. April 2019, 17:26:41 CEST schrieb Doug Anderson:
> On Wed, Apr 10, 2019 at 8:27 PM elaine.zhang <zhangqing@rock-chips.com> wrote:
> > 在 2019/4/10 下午11:34, Doug Anderson 写道:
> > On Tue, Apr 9, 2019 at 11:23 PM elaine.zhang <zhangqing@rock-chips.com> wrote:
> > 在 2019/4/10 上午4:47, Douglas Anderson 写道:
> >
> > This reverts commit 55bb6a633c33caf68ab470907ecf945289cb733d.
> >
> > The clocks that were enabled by that patch are pretty questionable.
> > Specifically looking at what has been shipping on rk3288-veyron
> > Chromebooks almost all of these clocks are safely turned off and cause
> > no apparent problems.  If some boards need these clocks turned on for
> > some reason then it seems like we should figure out how to do that at
> > a board level.
> >
> > NOTE: turning these clocks off doesn't seem to do a whole lot in terms
> > of power savings (checking the power on the logic rail).  It appears
> > to save maybe 1-2mW.  ...but still it seems like we should turn the
> > clocks off if they aren't needed.
> >
> > Digging into the clocks here to describe why they shouldn't need to be
> > left on:
> >
> > atclk: No documentation about this clock other than that it goes to
> > the CPU.  CPU functions fine without it on.
> >
> > jtag: Presumably this clock is only needed if you're debugging with
> > JTAG.  It doesn't seem like it makes sense to waste power for every
> > rk3288 user.  Perhaps this could be turned on with a CONFIG option?
> >
> > pclk_dbg, pclk_core_niu: On veyron Chromebooks we turn these two
> > clocks on only during kernel panics in order to access some coresight
> > registers.  Since nothing in the upstream kernel does this we should
> > be able to leave them off safely.
> >
> > hsicphy12m_xin12m: There is no indication of why this clock would need
> > to be turned on for boards that don't use HSIC.
> >
> > pclk_ddrupctl[0-1], pclk_publ0[0-1]: On veyron Chromebooks we turn
> > these 4 clocks on only when doing DDR transitions and they are off
> > otherwise.  I see no reason why they'd need to be on in the upstream
> > kernel which doesn't support DDRFreq.
> >
> > pmu_hclk_otg0: A "chip design defect" is mentioned in the original
> > patch but no details.  This clock has always been gated in shipping
> > veyron Chromebooks so presumably this chip defect doesn't affect all
> > boards.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   drivers/clk/rockchip/clk-rk3288.c | 14 ++++----------
> >   1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> > index 5a67b7869960..06287810474e 100644
> > --- a/drivers/clk/rockchip/clk-rk3288.c
> > +++ b/drivers/clk/rockchip/clk-rk3288.c
> > @@ -313,13 +313,13 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
> >       COMPOSITE_NOMUX(0, "aclk_core_mp", "armclk", CLK_IGNORE_UNUSED,
> >                       RK3288_CLKSEL_CON(0), 4, 4, DFLAGS | CLK_DIVIDER_READ_ONLY,
> >                       RK3288_CLKGATE_CON(12), 6, GFLAGS),
> > -     COMPOSITE_NOMUX(0, "atclk", "armclk", CLK_IGNORE_UNUSED,
> > +     COMPOSITE_NOMUX(0, "atclk", "armclk", 0,
> >                       RK3288_CLKSEL_CON(37), 4, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
> >                       RK3288_CLKGATE_CON(12), 7, GFLAGS),
> >       COMPOSITE_NOMUX(0, "pclk_dbg_pre", "armclk", CLK_IGNORE_UNUSED,
> >                       RK3288_CLKSEL_CON(37), 9, 5, DFLAGS | CLK_DIVIDER_READ_ONLY,
> >                       RK3288_CLKGATE_CON(12), 8, GFLAGS),
> > -     GATE(0, "pclk_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
> > +     GATE(0, "pclk_dbg", "pclk_dbg_pre", 0,
> >                       RK3288_CLKGATE_CON(12), 9, GFLAGS),
> >       GATE(0, "cs_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
> >                       RK3288_CLKGATE_CON(12), 10, GFLAGS),
> > @@ -647,7 +647,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
> >       INVERTER(SCLK_HSADC, "sclk_hsadc", "sclk_hsadc_out",
> >                       RK3288_CLKSEL_CON(22), 7, IFLAGS),
> >
> > -     GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
> > +     GATE(0, "jtag", "ext_jtag", 0,
> >                       RK3288_CLKGATE_CON(4), 14, GFLAGS),
> >
> > CLK_IGNORE_UNUSED:
> > Whether to close the unused clk after clk init complete. not affect
> > there own enable/disable.
> > JTAG is not have device node, when need jtag to debug, may be the system
> > is crashed, there is no way to turn on this clk.
> >
> > As I mentioned in the commit message this seems like the kind of thing
> > that should be controlled by a CONFIG_ option.  It's a debug option
> > that's fine to have on all the time but consumes resources so some
> > people might want to turn it off.
> >
> > Currently,  CONFIG_ option is not implemented. We will refer to this suggestion.
> >
> > For debug,  I don't hope to remove the flag CLK_IGNORE_UNUSED.(The clk static power is very small)
> 
> I'll leave it up to Heiko for what to do here.  I agree that it's not
> tons of power (this whole patch saved 1-2 mW on the INT rail) but I'd
> still prefer for clocks to be off if they can.  In general one could
> also argue that keeping JTAG off by default could be good for
> security.
> 
> ...but I guess I have to wonder how you're doing JTAG on upstream
> kernels without any extra patches anyway.  Automatic JTAG switching is
> turned off in "drivers/soc/rockchip/grf.c".  ...and by default the
> JTAG signals are muxed as the SD Card.  So presumably you've already
> got extra patches in order to make JTAG work.
> 
> I assume that the clocks that are important for JTAG are "atclk",
> "jtag", "pclk_dbg", and "pclk_core_niu".

Isn't JTAG part of the coresight package anyway? The whole coresight
stuff, so in an upstream-context I'd somehow expect it to get activated
through that. Or is it actually separate and only in the debug-diagram
in the TRM mixed into coresight?

In any case I'm with Doug here, for jtag you need to modify your kernel
anyway for pinctrl settings, so could also enable the clock in that case.


> >       COMPOSITE_NODIV(SCLK_USBPHY480M_SRC, "usbphy480m_src", mux_usbphy480m_p, 0,
> > @@ -656,7 +656,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
> >       COMPOSITE_NODIV(SCLK_HSICPHY480M, "sclk_hsicphy480m", mux_hsicphy480m_p, 0,
> >                       RK3288_CLKSEL_CON(29), 0, 2, MFLAGS,
> >                       RK3288_CLKGATE_CON(3), 6, GFLAGS),
> > -     GATE(0, "hsicphy12m_xin12m", "xin12m", CLK_IGNORE_UNUSED,
> > +     GATE(0, "hsicphy12m_xin12m", "xin12m", 0,
> >                       RK3288_CLKGATE_CON(13), 9, GFLAGS),
> >       DIV(0, "hsicphy12m_usbphy", "sclk_hsicphy480m", 0,
> >                       RK3288_CLKSEL_CON(11), 8, 6, DFLAGS),
> > @@ -837,12 +837,6 @@ static const char *const rk3288_critical_clocks[] __initconst = {
> >       "pclk_alive_niu",
> >       "pclk_pd_pmu",
> >       "pclk_pmu_niu",
> > -     "pclk_core_niu",
> > -     "pclk_ddrupctl0",
> > -     "pclk_publ0",
> > -     "pclk_ddrupctl1",
> > -     "pclk_publ1",
> >
> > These clks needed enable, device node not use this clk, so we mark it as
> > critical.
> >
> > What breaks if you don't enable these clocks?  As far as I can tell
> > these clocks only need to be enabled while touching memory controller
> > registers (deep suspend/resume and DDRFreq transitions).  On
> > Chromebooks everything works fine with these clocks only turned on
> > when needed.
> >
> > If need to enable these clks, ddrupctl0/ddrupctl1/publ0/publ1 clks no driver to handle them, so mark these clk as  critical.
> 
> Perhaps it's just a typo, but you say "If need to enable".  I see no
> evidence that these clocks need to be enabled unless there is code
> touching memory controller registers.  Thus we don't need to enable
> them so they don't need to be critical.

yep ... maybe Elaine can clarify in what other activities these clocks
are needed ... I guess any ddr-scaling code would activate them
before touching memory-controller-registers.


> > -     "pmu_hclk_otg0",
> >
> > It's a soc bug, pmu_hclk_otg0 must always on.
> >
> > So you said in your previous commit message.  However we've shipped
> > lots and lots of Chromebooks with this clock off.  Can you explain
> > what is broken?  Is this only needed for gadget mode (which we don't
> > use), for instance?
> >
> > test case:
> >
> > recovery test,  < 1 hour , system crash.
> >
> > log:
> >
> > [  127.569629] I[0:      swapper/0:    0] GOTGCTL        @0xFFFFFF8000B80000 : 0x00400010
> > [  127.569644] I[0:      swapper/0:    0] GOTGINT        @0xFFFFFF8000B80004 : 0x00400010
> > [  127.569659] I[0:      swapper/0:    0] GAHBCFG        @0xFFFFFF8000B80008 : 0x00400010
> > [  127.569673] I[0:      swapper/0:    0] GUSBCFG        @0xFFFFFF8000B8000C : 0x00400010
> > [  127.569688] I[0:      swapper/0:    0] GRSTCTL        @0xFFFFFF8000B80010 : 0x00400010
> > [  127.569702] I[0:      swapper/0:    0] GINTSTS        @0xFFFFFF8000B80014 : 0x00400010
> > [  127.569718] I[0:      swapper/0:    0] GINTMSK        @0xFFFFFF8000B80018 : 0x00400010
> > [  127.569733] I[0:      swapper/0:    0] GRXSTSR        @0xFFFFFF8000B8001C : 0x00400010
> > [  127.569748] I[0:      swapper/0:    0] GRXFSIZ        @0xFFFFFF8000B80024 : 0x00400010
> 
> I don't know what a "recovery test" is and I don't understand your logs.
> 
> Can you explain we do not run into this on Chromebooks?
> 
> 
> > reason:
> >
> > USB OTG controller supports turning off most logic power, and then only one PMU module is left. This clock cannot be turned off, which is similar to the always on module in USB OTG.
> 
> Can't you just add a patch to the dwc2 driver to have it grab this
> clock?  I assume this clock doesn't need to be turned on unless you're
> using the OTG contoller in a certain way?

So far we don't really know where the clock in question is sitting
in the clock hirarchy. For example the kernel got a new interconnect
framework recently, so handling non-device clocks in a device may haunt
us later on.

@Elaine: could you elaborate what pmu_hclk_otg0 actually is for please?


> NOTE: nowhere in your responses did you talk about why
> "hsicphy12m_xin12m" needed to be marked as IGNORE_UNUSED.  I guess
> you're OK with removing that?


Thanks
Heiko



