Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EB8C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1C52083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfDKTUT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:20:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:32858 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKTUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:20:18 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEfF4-0001Hj-1F; Thu, 11 Apr 2019 21:20:10 +0200
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
Subject: Re: [PATCH 2/3] clk: rockchip: Make rkpwm a critical clock on rk3288
Date:   Thu, 11 Apr 2019 21:20:09 +0200
Message-ID: <3228689.801YVuiu6B@diego>
In-Reply-To: <CAD=FV=VYYU1ZJfCaNdM--B_8jRRDR3prbmMzj2_3UJO9NbeaPw@mail.gmail.com>
References: <20190409204707.150347-1-dianders@chromium.org> <43b5ef8c-4617-bdc5-7109-35eac228b8f9@rock-chips.com> <CAD=FV=VYYU1ZJfCaNdM--B_8jRRDR3prbmMzj2_3UJO9NbeaPw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug, Elaine,

Am Donnerstag, 11. April 2019, 16:42:23 CEST schrieb Doug Anderson:
> On Wed, Apr 10, 2019 at 8:42 PM elaine.zhang <zhangqing@rock-chips.com> wrote:
> > 在 2019/4/10 下午11:25, Doug Anderson 写道:
> > > On Tue, Apr 9, 2019 at 11:42 PM elaine.zhang <zhangqing@rock-chips.com> wrote:
> > >> 在 2019/4/10 上午4:47, Douglas Anderson 写道:
> > >>> Most rk3288-based boards are derived from the EVB and thus use a PWM
> > >>> regulator for the logic rail.  However, most rk3288-based boards don't
> > >>> specify the PWM regulator in their device tree.  We'll deal with that
> > >>> by making it critical.
> > >>>
> > >>> NOTE: it's important to make it critical and not just IGNORE_UNUSED
> > >>> because all PWMs in the system share the same clock.  We don't want
> > >>> another PWM user to turn the clock on and off and kill the logic rail.
> > >>>
> > >>> This change is in preparation for actually having the PWMs in the
> > >>> rk3288 device tree actually point to the proper PWM clock.  Up until
> > >>> now they've all pointed to the clock for the old IP block and they've
> > >>> all worked due to the fact that rkpwm was IGNORE_UNUSED and that the
> > >>> clock rates for both clocks were the same.
> > >>>
> > >>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > >>> ---
> > >>>
> > >>>    drivers/clk/rockchip/clk-rk3288.c | 3 ++-
> > >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> > >>> index 06287810474e..c3321eade23e 100644
> > >>> --- a/drivers/clk/rockchip/clk-rk3288.c
> > >>> +++ b/drivers/clk/rockchip/clk-rk3288.c
> > >>> @@ -697,7 +697,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[] __initdata = {
> > >>>        GATE(PCLK_TZPC, "pclk_tzpc", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 3, GFLAGS),
> > >>>        GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 9, GFLAGS),
> > >>>        GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 10, GFLAGS),
> > >>> -     GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 11, GFLAGS),
> > >>> +     GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", 0, RK3288_CLKGATE_CON(11), 11, GFLAGS),
> > >>>
> > >>>        /* ddrctrl [DDR Controller PHY clock] gates */
> > >>>        GATE(0, "nclk_ddrupctl0", "ddrphy", CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(11), 4, GFLAGS),
> > >>> @@ -837,6 +837,7 @@ static const char *const rk3288_critical_clocks[] __initconst = {
> > >>>        "pclk_alive_niu",
> > >>>        "pclk_pd_pmu",
> > >>>        "pclk_pmu_niu",
> > >>> +     "pclk_rkpwm",
> > >> pwm have device node, can enable and disable it in the pwm drivers.
> > >>
> > >> pwm regulator use pwm node as:
> > >>
> > >> pwms = <&pwm2 0 25000 1>
> > >>
> > >> when set Logic voltage:
> > >>
> > >> pwm_regulator_set_voltage()
> > >>
> > >>       --> pwm_apply_state()
> > >>
> > >>           -->clk_enable()
> > >>
> > >>           -->pwm_enable()
> > >>
> > >>           -->pwm_config()
> > >>
> > >>           -->pinctrl_select()
> > >>
> > >>           --....
> > >>
> > >> For mark pclk_rkpwm as critical,do you have any questions, or provides
> > >> some log or more information.
> > > Right, if we actually specify the PWM used for the PWM regulator in
> > > the device tree then there is no need to mark it as a critical clock.
> > > In fact rk3288-veyron devices boot absolutely fine without marking
> > > this clock as critical.  Actually, it seems like the way the PWM
> > > framework works (IIRC it was designed this way specifically to support
> > > PWM regulators) is that even just specifying that pwm1 is "okay" is
> > > enough to keep the clock on even if the PWM regulator isn't specified.
> > >
> > > ...however...
> > >
> > > Take a look at, for instance, the rk3288-evb device tree file.
> > > Nowhere in there does it specify that the PWM used for the PWM
> > > regulator should be on.  Presumably that means that if we don't mark
> > > the clock as critical then rk3288-evb will fail to boot.  That's easy
> > > for me to fix since I have the rk3288-evb schematics, but what about
> > > other rk3288 boards?  We could make educated guesses about each of
> > > them and/or fix things are we hear about breakages.
> > >
> > > ...but...
> > >
> > > All the above would only be worth doing if we thought someone would
> > > get some benefit out of it.  I'd bet that pretty much all rk3288-based
> > > boards use a PWM regulator.  Thus, in reality, everyone will want the
> > > rkpwm clock on all the time anyway.  In that case going through all
> > > that extra work / potentially breaking other boards doesn't seem worth
> > > it.  Just mark the clock as critical.
> >
> > I have no problem with changing it like this, but I think it is better
> > to modify dts:
> >
> > vdd_log: vdd-log {
> >          compatible = "pwm-regulator";
> >          rockchip,pwm_id = <2>; //for rk uboot
> >          rockchip,pwm_voltage = <900000>; // for rk uboot
> >          pwms = <&pwm2 0 25000 1>;
> >          regulator-name = "vdd_log";
> >          regulator-min-microvolt = <800000>;//hw logic min voltage
> >          regulator-max-microvolt = <1400000>;//hw logic max voltage
> >          regulator-always-on;
> >          regulator-boot-on;
> >      };
> >
> > Maybe we did not push the modification of this part in rk3288-evb, I
> > will push to deal with this.(rk3229-evb.dts and rk3399 has been already
> > pushed)
> 
> Heiko: do you have advice for how you'd like this to proceed?  We
> could certainly land patch #3 in this series without patch #2 and then
> pick up the pieces as we find boards that no longer boot.  As I've
> argued I'm not sure that's worth the effort, but I'll leave it up to
> you.

So I've skimmed through a number of rk3288 device-schematics and
at least there pwm-based logic-regulator is only part of some of the
rk808-based designs. All the act8846-based boards use one of its
regulator-outputs for the logic supply. So this matters for at least the
veyron-boards and the rk3288-evb ... but not the phycore.

But it also is part of a vital system for veyron and they won't really like
if somewhere during probe the pwm-clock gets turned off ;-) .

So I tend to agree with Doug and will just apply the make-critical patch.
If Stephen's "handoff" clock-type [critical until a driver claims it]
materializes some-time, we can switch to that.


Heiko


