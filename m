Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE481C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E4A20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cjj1sAkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfDJPed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:34:33 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:38120 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDJPec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:34:32 -0400
Received: by mail-vk1-f196.google.com with SMTP id h71so657662vkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DCkgmuJRyXZdE3VExrSJZpNpCAX0uOVpMW/NjqlufYQ=;
        b=Cjj1sAknmWgsaL0lBeZZ31ZanLoyXQoCqqGjuVNf6EhXJVksBOhVEgab8NURbkqxcp
         myXEhssN6Vwwgme6iiddFEsvtVTi67B2ClsnNnHqigSLxYLEqlkhvET4oIJ5Jb0PK+vn
         KZIuc26LgklnpfNcpIg2vYVtRaZlohooZi6SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DCkgmuJRyXZdE3VExrSJZpNpCAX0uOVpMW/NjqlufYQ=;
        b=Id2R0Jcg469H+Ux8mhIgaU2ENL+3BPvN4sU/LNFagcIFsTLibbLlHb06m6na30VyCc
         gWaaPvJ4ystzyRu77zd8+tRnI/2lib1MVzN/RGjfFKaaZ4zq0MjXd+bWqlyRwwxjj3PC
         yNexgi2FQ3xtbDVrNGlsjaiB/THHZkrc/1mRmtiKGRCthnlm5Ax9pN/epoeNwH07wRqf
         NB5SKA1mSmN70nA2ZekT2F7cK2Ev7e7AWs1gItav4GbPZ0lR2h9jhH+3vxzRtkILs6h/
         Cov5YGxDcdk1V2bvtixA5bL9K9/zOzDjQENPHm/sKMnPD/45ob1AivOHMGzLBTBcDyMH
         j2Xw==
X-Gm-Message-State: APjAAAU8A7+bFXXeeaR2r5awD9gTWo3TdFYPIBH4YzZV/XWfy6WOUQYl
        UhIQlJZDvTy6TEua9CMGYuJUJE9WD/w=
X-Google-Smtp-Source: APXvYqzBF7HpZZH1DDqFiKBxjkJoYpkGhcICtn6lbMGCGaDjz5M8HvM+XDAuzLXNWG4B1bP+6W9GZQ==
X-Received: by 2002:a1f:10a0:: with SMTP id 32mr8994973vkq.12.1554910470869;
        Wed, 10 Apr 2019 08:34:30 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id c192sm25939849vka.10.2019.04.10.08.34.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 08:34:29 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id v7so905260uak.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 08:34:29 -0700 (PDT)
X-Received: by 2002:ab0:474c:: with SMTP id i12mr23660228uac.9.1554910468758;
 Wed, 10 Apr 2019 08:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190409204707.150347-1-dianders@chromium.org>
 <20190409204707.150347-2-dianders@chromium.org> <b7093a17-b30c-cdec-b02c-c6bc5a8d08c9@rock-chips.com>
In-Reply-To: <b7093a17-b30c-cdec-b02c-c6bc5a8d08c9@rock-chips.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Apr 2019 08:34:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WXWnYDzGUyyz--JBY6QBcYNEorgAqUAesnctXJqptSBw@mail.gmail.com>
Message-ID: <CAD=FV=WXWnYDzGUyyz--JBY6QBcYNEorgAqUAesnctXJqptSBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Revert "clk: rockchip: mark noc and some special clk
 as critical on rk3288"
To:     "elaine.zhang" <zhangqing@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 9, 2019 at 11:23 PM elaine.zhang <zhangqing@rock-chips.com> wro=
te:
>
> hi,
>
> =E5=9C=A8 2019/4/10 =E4=B8=8A=E5=8D=884:47, Douglas Anderson =E5=86=99=E9=
=81=93:
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
> > diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/c=
lk-rk3288.c
> > index 5a67b7869960..06287810474e 100644
> > --- a/drivers/clk/rockchip/clk-rk3288.c
> > +++ b/drivers/clk/rockchip/clk-rk3288.c
> > @@ -313,13 +313,13 @@ static struct rockchip_clk_branch rk3288_clk_bran=
ches[] __initdata =3D {
> >       COMPOSITE_NOMUX(0, "aclk_core_mp", "armclk", CLK_IGNORE_UNUSED,
> >                       RK3288_CLKSEL_CON(0), 4, 4, DFLAGS | CLK_DIVIDER_=
READ_ONLY,
> >                       RK3288_CLKGATE_CON(12), 6, GFLAGS),
> > -     COMPOSITE_NOMUX(0, "atclk", "armclk", CLK_IGNORE_UNUSED,
> > +     COMPOSITE_NOMUX(0, "atclk", "armclk", 0,
> >                       RK3288_CLKSEL_CON(37), 4, 5, DFLAGS | CLK_DIVIDER=
_READ_ONLY,
> >                       RK3288_CLKGATE_CON(12), 7, GFLAGS),
> >       COMPOSITE_NOMUX(0, "pclk_dbg_pre", "armclk", CLK_IGNORE_UNUSED,
> >                       RK3288_CLKSEL_CON(37), 9, 5, DFLAGS | CLK_DIVIDER=
_READ_ONLY,
> >                       RK3288_CLKGATE_CON(12), 8, GFLAGS),
> > -     GATE(0, "pclk_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
> > +     GATE(0, "pclk_dbg", "pclk_dbg_pre", 0,
> >                       RK3288_CLKGATE_CON(12), 9, GFLAGS),
> >       GATE(0, "cs_dbg", "pclk_dbg_pre", CLK_IGNORE_UNUSED,
> >                       RK3288_CLKGATE_CON(12), 10, GFLAGS),
> > @@ -647,7 +647,7 @@ static struct rockchip_clk_branch rk3288_clk_branch=
es[] __initdata =3D {
> >       INVERTER(SCLK_HSADC, "sclk_hsadc", "sclk_hsadc_out",
> >                       RK3288_CLKSEL_CON(22), 7, IFLAGS),
> >
> > -     GATE(0, "jtag", "ext_jtag", CLK_IGNORE_UNUSED,
> > +     GATE(0, "jtag", "ext_jtag", 0,
> >                       RK3288_CLKGATE_CON(4), 14, GFLAGS),
> CLK_IGNORE_UNUSED:
> Whether to close the unused clk after clk init complete. not affect
> there own enable/disable.
> JTAG is not have device node, when need jtag to debug, may be the system
> is crashed, there is no way to turn on this clk.

As I mentioned in the commit message this seems like the kind of thing
that should be controlled by a CONFIG_ option.  It's a debug option
that's fine to have on all the time but consumes resources so some
people might want to turn it off.


> >       COMPOSITE_NODIV(SCLK_USBPHY480M_SRC, "usbphy480m_src", mux_usbphy=
480m_p, 0,
> > @@ -656,7 +656,7 @@ static struct rockchip_clk_branch rk3288_clk_branch=
es[] __initdata =3D {
> >       COMPOSITE_NODIV(SCLK_HSICPHY480M, "sclk_hsicphy480m", mux_hsicphy=
480m_p, 0,
> >                       RK3288_CLKSEL_CON(29), 0, 2, MFLAGS,
> >                       RK3288_CLKGATE_CON(3), 6, GFLAGS),
> > -     GATE(0, "hsicphy12m_xin12m", "xin12m", CLK_IGNORE_UNUSED,
> > +     GATE(0, "hsicphy12m_xin12m", "xin12m", 0,
> >                       RK3288_CLKGATE_CON(13), 9, GFLAGS),
> >       DIV(0, "hsicphy12m_usbphy", "sclk_hsicphy480m", 0,
> >                       RK3288_CLKSEL_CON(11), 8, 6, DFLAGS),
> > @@ -837,12 +837,6 @@ static const char *const rk3288_critical_clocks[] =
__initconst =3D {
> >       "pclk_alive_niu",
> >       "pclk_pd_pmu",
> >       "pclk_pmu_niu",
> > -     "pclk_core_niu",
> > -     "pclk_ddrupctl0",
> > -     "pclk_publ0",
> > -     "pclk_ddrupctl1",
> > -     "pclk_publ1",
> These clks needed enable, device node not use this clk, so we mark it as
> critical.

What breaks if you don't enable these clocks?  As far as I can tell
these clocks only need to be enabled while touching memory controller
registers (deep suspend/resume and DDRFreq transitions).  On
Chromebooks everything works fine with these clocks only turned on
when needed.


> > -     "pmu_hclk_otg0",
> It's a soc bug, pmu_hclk_otg0 must always on.

So you said in your previous commit message.  However we've shipped
lots and lots of Chromebooks with this clock off.  Can you explain
what is broken?  Is this only needed for gadget mode (which we don't
use), for instance?


-Doug
