Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E9CC74A22
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C652064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562765019;
	bh=ptwe1rDFfCle9mAd7yUbzwHCUIplmYHPvUm9uxzozYw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l2tIN3pJcnWp8LQsN2JyzEbxMARLXuE5cpCxVJMpFBvqZt6LlJmcX+PowlY8FfS7I
	 RxUPKckiXrSfmoNnq9u3KcOZA0Q7trrF3un5hqrKTwSCYzutqD4kGqihv6gN/2ywof
	 V0IUdI7ZDj8V5JE+KXD3d4fTME+Ji3RJJwcMdqh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfGJNXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfGJNXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:23:37 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9958A2087F;
        Wed, 10 Jul 2019 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562765016;
        bh=ptwe1rDFfCle9mAd7yUbzwHCUIplmYHPvUm9uxzozYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ygq4G+Z93uqVVpJVD5haYpXwweRb1Aq6snmGvdOmy8F1jygCrILzqs6RgP/d591b9
         nUBz/e/yJa14QCMACtxj8udJ495dRYqX22DoUq4EzdfGme8B1cJHRdf15xPBLV4R4P
         xTiKoIThZpr8n+cZltoJbcnxVtJSmai1XHX+GIJE=
Received: by mail-qt1-f176.google.com with SMTP id w17so2337245qto.10;
        Wed, 10 Jul 2019 06:23:36 -0700 (PDT)
X-Gm-Message-State: APjAAAUohhkzezqI1mEaZbvwMSMtElcocmHgnkWY31pgKb1+oii+cGD6
        0h3R23D3bg1cwpKI1po3gPWojaVKs3oFGXMUig==
X-Google-Smtp-Source: APXvYqz+nKMIXVVlc8oZ0Q2Q8/QxA9fpNLvERwVPUf4Z5TxRc+gsCONhWB7rl/hp6YxNljnWyrHfGZ8KKeLd1yp38pM=
X-Received: by 2002:ac8:3908:: with SMTP id s8mr23635427qtb.224.1562765015828;
 Wed, 10 Jul 2019 06:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190701093826.5472-1-Anson.Huang@nxp.com> <20190701093826.5472-2-Anson.Huang@nxp.com>
 <CAL_JsqKeu-b8mbMJBtnNn1vL=RSvUXbo+g40haZnjXTW11CJ6w@mail.gmail.com> <DB3PR0402MB39167FC68991F071E9E58D81F5F00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39167FC68991F071E9E58D81F5F00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Jul 2019 07:23:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJbHFZ2qcLvhZGk8Q-f80_QhdgQxcHe2TyCjc4GGRNJNQ@mail.gmail.com>
Message-ID: <CAL_JsqJbHFZ2qcLvhZGk8Q-f80_QhdgQxcHe2TyCjc4GGRNJNQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/5] clocksource/drivers/sysctr: Add clock-frequency property
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Carlo Caione <ccaione@baylibre.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 7:30 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Rob
>
> > On Mon, Jul 1, 2019 at 3:47 AM <Anson.Huang@nxp.com> wrote:
> > >
> > > From: Anson Huang <Anson.Huang@nxp.com>
> >
> > 'dt-bindings: timer: ...' for the subject.
>
> OK, I made a mistake.
>
> >
> > >
> > > Systems which use platform driver model for clock driver require the
> > > clock frequency to be supplied via device tree when system counter
> > > driver is enabled.
> >
> > This is a DT binding. What's a platform driver?
>
> It is just trying to explain why we need to introduce this "clock-frequency"
> property, nothing about the binding and platform driver.
>
> >
> > >
> > > This is necessary as in the platform driver model the of_clk
> > > operations do not work correctly because system counter driver is
> > > initialized in early phase of system boot up, and clock driver using
> > > platform driver model is NOT ready at that time, it will cause system
> > > counter driver initialization failed.
> > >
> > > Add clock-frequency property to the device tree bindings of the NXP
> > > system counter, so the driver can tell timer-of driver to get clock
> > > frequency from DT directly instead of doing of_clk operations via clk
> > > APIs.
> >
> > While you've now given a good explanation why you need this, it all sounds
> > like linux specific issues and a DT change should not be necessary.
> >
> > Presumably, 'clocks' points to a fixed-clock node, right? Just parse the 'clocks'
> > phandle and fetch the frequency from that node if you need to get the
> > frequency 'early'.
>
> Sound like a better solution, I will try that, since the system counter's clock is
> from osc_24m and divided by 3, since different platforms may have different divider,
> so maybe I can create a fixed-clock node in DT, then system counter driver can parse
> the clock and fetch the frequency from that node, will redo a V5 patch.

The divide by 3 can be implied by the compatible. If you need a
different divider, add another compatible.

> >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > No change.
> > > ---
> > >  .../devicetree/bindings/timer/nxp,sysctr-timer.txt        | 15 +++++++++------
> > >  1 file changed, 9 insertions(+), 6 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
> > > b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
> > > index d576599..7088a0e 100644
> > > --- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
> > > +++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
> > > @@ -11,15 +11,18 @@ Required properties:
> > >  - reg :             Specifies the base physical address and size of the comapre
> > >                      frame and the counter control, read & compare.
> > >  - interrupts :      should be the first compare frames' interrupt
> > > -- clocks :         Specifies the counter clock.
> > > -- clock-names:             Specifies the clock's name of this module
> > > +- clocks :          Specifies the counter clock, mutually exclusive with clock-
> > frequency.
> > > +- clock-names :     Specifies the clock's name of this module, mutually
> > exclusive with
> > > +                   clock-frequency.
> > > +- clock-frequency : Specifies system counter clock frequency, mutually
> > exclusive with
> > > +                   clocks/clock-names.
> >
> > It doesn't really work to say one or the other is needed unless you make the
> > OS support both cases.
>
> The OS already support both cases now with this patch series.

What about FreeBSD or any other OS?

Rob
