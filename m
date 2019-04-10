Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D10C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4352083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvhWXmuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbfDJPZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:25:55 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35860 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbfDJPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:25:53 -0400
Received: by mail-vk1-f193.google.com with SMTP id w140so653584vkd.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OzPOJAHOY1IvQ7ONFgPVHtkhwMD/ZoVgoxvD6uZ6JQ0=;
        b=UvhWXmuQVl2/q9WBKj5DU0VRsfwKuwFrdNjgoreC6YPlSiyFIi2bgUZFFOlULEX/be
         7oKcU/H2zCBWoLsLvK78H6ZbUhrVnxSBFyn7snB5kTWQcqU3LwQJgSphUyb19yhCO07O
         uixQ5xzkLeXODi8kIfJ8ZJs/UoZORMgXZKEvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OzPOJAHOY1IvQ7ONFgPVHtkhwMD/ZoVgoxvD6uZ6JQ0=;
        b=fEe/ZVtBAr40xsAkTMhACVt8K/SLvpEdg/N2cFDhCf6ieqnvv3H4hBmb1BHgbw7xl4
         utCXy8mT48zFugd1mvGW2RJE4VbEOHGTpIxixmokVJdAwCTSaQhSx3iPIDFzmWWjwnjo
         g+azUDXGrEoNfD/Jk2t+VzhPBqJseEdMQmSI7UND83l1SHK7Lc9C9T4T7J1/3PcqGkE6
         FbJk5y2WTQhfYPuPP3OJQwydDibPk4WU/kPnn2cR+2kYVfGwYXaF3RJmXreWWFprWMUn
         uQSs/gwuwewdGc78FfTLwZB3fsXCDp3L0wLP7ifnR66KZ9/HvQ7Z89lCemn1X1DqxmmI
         g2UA==
X-Gm-Message-State: APjAAAWogedg+ol2UQQ1Ad+Xo6isCJ5nN1/TD+bm/43WZQDX15a2qInJ
        1sD3Hcy73dm2vJTD1+7jhHO7fPU0UVs=
X-Google-Smtp-Source: APXvYqxejCAW3oluzWYJmowRBHFN1fo9Tzs6Pwqb6xPSnN5G6piDExIcnIXz7QAVJPQUR8rlZWjAEA==
X-Received: by 2002:a1f:8ec6:: with SMTP id q189mr24425292vkd.54.1554909951579;
        Wed, 10 Apr 2019 08:25:51 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 2sm14136055vke.27.2019.04.10.08.25.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 08:25:50 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id l17so915902uar.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 08:25:50 -0700 (PDT)
X-Received: by 2002:ab0:7212:: with SMTP id u18mr22117478uao.32.1554909949608;
 Wed, 10 Apr 2019 08:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190409204707.150347-1-dianders@chromium.org>
 <20190409204707.150347-3-dianders@chromium.org> <50b744cd-b8d9-79ca-ba2d-6765808aa5e5@rock-chips.com>
In-Reply-To: <50b744cd-b8d9-79ca-ba2d-6765808aa5e5@rock-chips.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Apr 2019 08:25:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vyy4bNJV=t2yALP3dAnm0-QsR55F5B==uUoi-Tp6b7Vg@mail.gmail.com>
Message-ID: <CAD=FV=Vyy4bNJV=t2yALP3dAnm0-QsR55F5B==uUoi-Tp6b7Vg@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: rockchip: Make rkpwm a critical clock on rk3288
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

On Tue, Apr 9, 2019 at 11:42 PM elaine.zhang <zhangqing@rock-chips.com> wro=
te:
>
> hi,
>
> =E5=9C=A8 2019/4/10 =E4=B8=8A=E5=8D=884:47, Douglas Anderson =E5=86=99=E9=
=81=93:
> > Most rk3288-based boards are derived from the EVB and thus use a PWM
> > regulator for the logic rail.  However, most rk3288-based boards don't
> > specify the PWM regulator in their device tree.  We'll deal with that
> > by making it critical.
> >
> > NOTE: it's important to make it critical and not just IGNORE_UNUSED
> > because all PWMs in the system share the same clock.  We don't want
> > another PWM user to turn the clock on and off and kill the logic rail.
> >
> > This change is in preparation for actually having the PWMs in the
> > rk3288 device tree actually point to the proper PWM clock.  Up until
> > now they've all pointed to the clock for the old IP block and they've
> > all worked due to the fact that rkpwm was IGNORE_UNUSED and that the
> > clock rates for both clocks were the same.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   drivers/clk/rockchip/clk-rk3288.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/c=
lk-rk3288.c
> > index 06287810474e..c3321eade23e 100644
> > --- a/drivers/clk/rockchip/clk-rk3288.c
> > +++ b/drivers/clk/rockchip/clk-rk3288.c
> > @@ -697,7 +697,7 @@ static struct rockchip_clk_branch rk3288_clk_branch=
es[] __initdata =3D {
> >       GATE(PCLK_TZPC, "pclk_tzpc", "pclk_cpu", 0, RK3288_CLKGATE_CON(11=
), 3, GFLAGS),
> >       GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK3288_CLKGATE_CON(=
11), 9, GFLAGS),
> >       GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_cpu", 0, RK3288_CLKGA=
TE_CON(11), 10, GFLAGS),
> > -     GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", CLK_IGNORE_UNUSED, RK3=
288_CLKGATE_CON(11), 11, GFLAGS),
> > +     GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", 0, RK3288_CLKGATE_CON(=
11), 11, GFLAGS),
> >
> >       /* ddrctrl [DDR Controller PHY clock] gates */
> >       GATE(0, "nclk_ddrupctl0", "ddrphy", CLK_IGNORE_UNUSED, RK3288_CLK=
GATE_CON(11), 4, GFLAGS),
> > @@ -837,6 +837,7 @@ static const char *const rk3288_critical_clocks[] _=
_initconst =3D {
> >       "pclk_alive_niu",
> >       "pclk_pd_pmu",
> >       "pclk_pmu_niu",
> > +     "pclk_rkpwm",
>
> pwm have device node, can enable and disable it in the pwm drivers.
>
> pwm regulator use pwm node as:
>
> pwms =3D <&pwm2 0 25000 1>
>
> when set Logic voltage:
>
> pwm_regulator_set_voltage()
>
>      --> pwm_apply_state()
>
>          -->clk_enable()
>
>          -->pwm_enable()
>
>          -->pwm_config()
>
>          -->pinctrl_select()
>
>          --....
>
> For mark pclk_rkpwm as critical,do you have any questions, or provides
> some log or more information.

Right, if we actually specify the PWM used for the PWM regulator in
the device tree then there is no need to mark it as a critical clock.
In fact rk3288-veyron devices boot absolutely fine without marking
this clock as critical.  Actually, it seems like the way the PWM
framework works (IIRC it was designed this way specifically to support
PWM regulators) is that even just specifying that pwm1 is "okay" is
enough to keep the clock on even if the PWM regulator isn't specified.

...however...

Take a look at, for instance, the rk3288-evb device tree file.
Nowhere in there does it specify that the PWM used for the PWM
regulator should be on.  Presumably that means that if we don't mark
the clock as critical then rk3288-evb will fail to boot.  That's easy
for me to fix since I have the rk3288-evb schematics, but what about
other rk3288 boards?  We could make educated guesses about each of
them and/or fix things are we hear about breakages.

...but...

All the above would only be worth doing if we thought someone would
get some benefit out of it.  I'd bet that pretty much all rk3288-based
boards use a PWM regulator.  Thus, in reality, everyone will want the
rkpwm clock on all the time anyway.  In that case going through all
that extra work / potentially breaking other boards doesn't seem worth
it.  Just mark the clock as critical.




-Doug
