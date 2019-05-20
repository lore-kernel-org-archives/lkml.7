Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2975C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CE320863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfETU2G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:28:06 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58048 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfETU2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:28:06 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hSot6-0008TP-VJ; Mon, 20 May 2019 22:28:01 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: dts: rockchip: Limit GPU frequency on veyron mickey to 300 MHz when the CPU gets very hot
Date:   Mon, 20 May 2019 22:28:00 +0200
Message-ID: <1695268.0xytyHHoPs@diego>
In-Reply-To: <CAD=FV=VGA_i=vM4_OrqXnv0WC__Fcdced3oOZjzcPO=i8Q+SdA@mail.gmail.com>
References: <20190520170132.91571-1-mka@chromium.org> <CAD=FV=VGA_i=vM4_OrqXnv0WC__Fcdced3oOZjzcPO=i8Q+SdA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 20. Mai 2019, 22:16:46 CEST schrieb Doug Anderson:
> Hi,
> 
> On Mon, May 20, 2019 at 10:01 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > On rk3288 the CPU and GPU temperatures are correlated. Limit the GPU
> > frequency on veyron mickey to 300 MHz for CPU temperatures >= 85°C.
> >
> > This matches the configuration of the downstream Chrome OS 3.14 kernel,
> > the 'official' kernel for mickey.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Note: this patch depends on "ARM: dts: rockchip: Add #cooling-cells
> > entry for rk3288 GPU" (https://lore.kernel.org/patchwork/patch/1075005/)
> > ---
> >  arch/arm/boot/dts/rk3288-veyron-mickey.dts | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> > index d889ab3c8235..f118d92a49d0 100644
> > --- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> > +++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> > @@ -125,6 +125,12 @@
> >                                          <&cpu2 8 THERMAL_NO_LIMIT>,
> >                                          <&cpu3 8 THERMAL_NO_LIMIT>;
> >                 };
> > +
> > +               /* At very hot, don't let GPU go over 300 MHz */
> > +               cpu_very_hot_limit_gpu {
> > +                       trip = <&cpu_alert_very_hot>;
> > +                       cooling-device = <&gpu 2 2>;
> > +               };
> 
> Two things:
> 
> A) If I'm reading things properly, you're actually limiting things to
> 400 MHz.  This is because you don't have <https://crrev.com/c/1574579>
> which deletes the 500 MHz GPU operating point.  So on upstream the
> available points are:
> 
> 0: 600 MHz
> 1: 500 MHz
> 2: 400 MHz
> 3: 300 MHz
> 4: 200 MHz
> 5: 100 MHz
> 
> ...and downstream:
> 
> 0: 600 MHz
> 1: 400 MHz
> 2: 300 MHz
> 3: 200 MHz
> 4: 100 MHz
> 
> Thinking about it more, I bet Heiko would actually be OK deleting the
> 500 MHz GPU operating point for veyron.  Technically it's not needed
> upstream because upstream doesn't have our hacks to allow re-purposing
> NPLL for HDMI (so they _can_ make 500 MHz) but maybe we can make the
> argument that these laptops have only ever been tested with the 500
> MHz operating point removed and also that eventually someonje will
> probably figure out a way to re-purpose NPLL for HDMI even upstream...

Yeah. Dropping the opp sounds sensible ... for the npll-related thing
and also if you're really running into thermal constraints it might be
good to give the system a bit more breathing room?


Heiko


> B) It seems like in the same patch you'd want to introduce
> "cpu_warm_limit_gpu", AKA:
> 
> cpu_warm_limit_gpu {
>   trip = <&cpu_alert_warm>;
>   cooling-device =
>   <&gpu 1 1>;
> };
> 
> 
> -Doug




