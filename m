Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50304C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F86E2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EoZXmPKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDKOmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 10:42:37 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45047 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfDKOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 10:42:37 -0400
Received: by mail-vk1-f194.google.com with SMTP id q189so1411443vkq.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xxMqs+pS5IYXSx3b84qH3v+S95G6HDau8KARz3TsU1w=;
        b=EoZXmPKH7OUFf5sJpwrOuS1VM0j+mcxvjXOD5wQvpXu3DShEairOt2CVEs98zo41av
         t8jDAYznj7kh3EYLyqCWQ1KNKTIG7VYjHaFpABSQzBp8T4fJWYFULFrrE4BIHKDzIzYT
         M1eBVtkqsfmxlGpWBwDvVqEG7ATKu0fBt0NZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xxMqs+pS5IYXSx3b84qH3v+S95G6HDau8KARz3TsU1w=;
        b=DRwxQq3Da4DbkndgvcyPSw42NXCkoTekKacZkaIWzFUEfJ6SLngvo0+3A/GOPh/rgT
         rdW8yoUCqhzG9o8vGNCvre/awSmx99aMM6P1PKRkJrdeVrnCa+ZeUuM4l9jdguVkArlO
         7hR1X1gowVcpGRxMpuaKpRML7OZ259VKY33d5X7BqpUncDgnkJnMMz6lhoZtItWS5DUX
         caj4VTGT5fVUJAARGiPb9Rb8ohEl5C4NN8OgQms/CMe1oJ1EXJoaReTae01zFiAcblQy
         pb3TqVYacXsQS+ltaDBdNAMplRcwbJ99i78immor2DRQkTOuCycvpxpY48NTEZaf48xs
         l7rw==
X-Gm-Message-State: APjAAAWJHwUc5yPrTm3GnPs8/VaP8zNbM8VVIG04g/4979h4uQCxrWac
        oVm6/B0yz+x6hzE6zGykvbmK3h94rhA=
X-Google-Smtp-Source: APXvYqwIAu6g6XiWrVCmlf+dJP92F3xjLDX4oyM3Ot1GWqhlu2Ji8sJbbO/kLrpzR7WTnDEKTRtfNA==
X-Received: by 2002:a1f:2d90:: with SMTP id t138mr27910133vkt.14.1554993755755;
        Thu, 11 Apr 2019 07:42:35 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id d193sm6386557vkd.41.2019.04.11.07.42.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 07:42:34 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id n4so3627269vsm.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 07:42:34 -0700 (PDT)
X-Received: by 2002:a67:ed84:: with SMTP id d4mr5656142vsp.207.1554993753644;
 Thu, 11 Apr 2019 07:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190409204707.150347-1-dianders@chromium.org>
 <20190409204707.150347-3-dianders@chromium.org> <50b744cd-b8d9-79ca-ba2d-6765808aa5e5@rock-chips.com>
 <CAD=FV=Vyy4bNJV=t2yALP3dAnm0-QsR55F5B==uUoi-Tp6b7Vg@mail.gmail.com> <43b5ef8c-4617-bdc5-7109-35eac228b8f9@rock-chips.com>
In-Reply-To: <43b5ef8c-4617-bdc5-7109-35eac228b8f9@rock-chips.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Apr 2019 07:42:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VYYU1ZJfCaNdM--B_8jRRDR3prbmMzj2_3UJO9NbeaPw@mail.gmail.com>
Message-ID: <CAD=FV=VYYU1ZJfCaNdM--B_8jRRDR3prbmMzj2_3UJO9NbeaPw@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: rockchip: Make rkpwm a critical clock on rk3288
To:     "elaine.zhang" <zhangqing@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
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

On Wed, Apr 10, 2019 at 8:42 PM elaine.zhang <zhangqing@rock-chips.com> wro=
te:
>
> hi,
>
> =E5=9C=A8 2019/4/10 =E4=B8=8B=E5=8D=8811:25, Doug Anderson =E5=86=99=E9=
=81=93:
> > Hi,
> >
> > On Tue, Apr 9, 2019 at 11:42 PM elaine.zhang <zhangqing@rock-chips.com>=
 wrote:
> >> hi,
> >>
> >> =E5=9C=A8 2019/4/10 =E4=B8=8A=E5=8D=884:47, Douglas Anderson =E5=86=99=
=E9=81=93:
> >>> Most rk3288-based boards are derived from the EVB and thus use a PWM
> >>> regulator for the logic rail.  However, most rk3288-based boards don'=
t
> >>> specify the PWM regulator in their device tree.  We'll deal with that
> >>> by making it critical.
> >>>
> >>> NOTE: it's important to make it critical and not just IGNORE_UNUSED
> >>> because all PWMs in the system share the same clock.  We don't want
> >>> another PWM user to turn the clock on and off and kill the logic rail=
.
> >>>
> >>> This change is in preparation for actually having the PWMs in the
> >>> rk3288 device tree actually point to the proper PWM clock.  Up until
> >>> now they've all pointed to the clock for the old IP block and they've
> >>> all worked due to the fact that rkpwm was IGNORE_UNUSED and that the
> >>> clock rates for both clocks were the same.
> >>>
> >>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>> ---
> >>>
> >>>    drivers/clk/rockchip/clk-rk3288.c | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip=
/clk-rk3288.c
> >>> index 06287810474e..c3321eade23e 100644
> >>> --- a/drivers/clk/rockchip/clk-rk3288.c
> >>> +++ b/drivers/clk/rockchip/clk-rk3288.c
> >>> @@ -697,7 +697,7 @@ static struct rockchip_clk_branch rk3288_clk_bran=
ches[] __initdata =3D {
> >>>        GATE(PCLK_TZPC, "pclk_tzpc", "pclk_cpu", 0, RK3288_CLKGATE_CON=
(11), 3, GFLAGS),
> >>>        GATE(PCLK_UART2, "pclk_uart2", "pclk_cpu", 0, RK3288_CLKGATE_C=
ON(11), 9, GFLAGS),
> >>>        GATE(PCLK_EFUSE256, "pclk_efuse_256", "pclk_cpu", 0, RK3288_CL=
KGATE_CON(11), 10, GFLAGS),
> >>> -     GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", CLK_IGNORE_UNUSED, R=
K3288_CLKGATE_CON(11), 11, GFLAGS),
> >>> +     GATE(PCLK_RKPWM, "pclk_rkpwm", "pclk_cpu", 0, RK3288_CLKGATE_CO=
N(11), 11, GFLAGS),
> >>>
> >>>        /* ddrctrl [DDR Controller PHY clock] gates */
> >>>        GATE(0, "nclk_ddrupctl0", "ddrphy", CLK_IGNORE_UNUSED, RK3288_=
CLKGATE_CON(11), 4, GFLAGS),
> >>> @@ -837,6 +837,7 @@ static const char *const rk3288_critical_clocks[]=
 __initconst =3D {
> >>>        "pclk_alive_niu",
> >>>        "pclk_pd_pmu",
> >>>        "pclk_pmu_niu",
> >>> +     "pclk_rkpwm",
> >> pwm have device node, can enable and disable it in the pwm drivers.
> >>
> >> pwm regulator use pwm node as:
> >>
> >> pwms =3D <&pwm2 0 25000 1>
> >>
> >> when set Logic voltage:
> >>
> >> pwm_regulator_set_voltage()
> >>
> >>       --> pwm_apply_state()
> >>
> >>           -->clk_enable()
> >>
> >>           -->pwm_enable()
> >>
> >>           -->pwm_config()
> >>
> >>           -->pinctrl_select()
> >>
> >>           --....
> >>
> >> For mark pclk_rkpwm as critical,do you have any questions, or provides
> >> some log or more information.
> > Right, if we actually specify the PWM used for the PWM regulator in
> > the device tree then there is no need to mark it as a critical clock.
> > In fact rk3288-veyron devices boot absolutely fine without marking
> > this clock as critical.  Actually, it seems like the way the PWM
> > framework works (IIRC it was designed this way specifically to support
> > PWM regulators) is that even just specifying that pwm1 is "okay" is
> > enough to keep the clock on even if the PWM regulator isn't specified.
> >
> > ...however...
> >
> > Take a look at, for instance, the rk3288-evb device tree file.
> > Nowhere in there does it specify that the PWM used for the PWM
> > regulator should be on.  Presumably that means that if we don't mark
> > the clock as critical then rk3288-evb will fail to boot.  That's easy
> > for me to fix since I have the rk3288-evb schematics, but what about
> > other rk3288 boards?  We could make educated guesses about each of
> > them and/or fix things are we hear about breakages.
> >
> > ...but...
> >
> > All the above would only be worth doing if we thought someone would
> > get some benefit out of it.  I'd bet that pretty much all rk3288-based
> > boards use a PWM regulator.  Thus, in reality, everyone will want the
> > rkpwm clock on all the time anyway.  In that case going through all
> > that extra work / potentially breaking other boards doesn't seem worth
> > it.  Just mark the clock as critical.
>
> I have no problem with changing it like this, but I think it is better
> to modify dts:
>
> vdd_log: vdd-log {
>          compatible =3D "pwm-regulator";
>          rockchip,pwm_id =3D <2>; //for rk uboot
>          rockchip,pwm_voltage =3D <900000>; // for rk uboot
>          pwms =3D <&pwm2 0 25000 1>;
>          regulator-name =3D "vdd_log";
>          regulator-min-microvolt =3D <800000>;//hw logic min voltage
>          regulator-max-microvolt =3D <1400000>;//hw logic max voltage
>          regulator-always-on;
>          regulator-boot-on;
>      };
>
> Maybe we did not push the modification of this part in rk3288-evb, I
> will push to deal with this.(rk3229-evb.dts and rk3399 has been already
> pushed)

Heiko: do you have advice for how you'd like this to proceed?  We
could certainly land patch #3 in this series without patch #2 and then
pick up the pieces as we find boards that no longer boot.  As I've
argued I'm not sure that's worth the effort, but I'll leave it up to
you.


-Doug
