Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40245C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CA92084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nY+nSvGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbfFTQYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:24:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41020 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbfFTQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:24:25 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so114342ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNuD4VdACopnrNGgSWJtsTfPm3edvtW0rWolSOhGiyc=;
        b=nY+nSvGh/TA5l2F8nSSnZAENkQkGpQfx6bek0QV/T9NadknJHALHIhlvs2+ouc1sPE
         kGBj/iPt/7FY1jpXBo2jwQsYl9GlQ8SC3O8zXz8ShZ+CQwQ7NUSDX9EE1Ua3JBrRo9PZ
         opv4/l/GUuDzk2Xs0i8cEzRduWE7lBsfR9egs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNuD4VdACopnrNGgSWJtsTfPm3edvtW0rWolSOhGiyc=;
        b=IC64DgntxjsnxCOzbQo0U0Z/DGkK115ctkPHRvm9tfvrSu75ryabtLF5CRI/ktos7O
         pF5KjYJeCVlZXe+Rc+9fuVftEmhFgcq181koQIFCUyvjFK1khMPV22g1Sj/WfrFI5wDE
         2S5mOKGjagg+L/r2L/GSnkMMu4J5fl00v0YCBkCvf3fiBp5hPPKSKo89jobCalBKxAqf
         joUifsYZtcli1QO7LTZFdAKXwU29kvjirTyGomhX9HBtbt/g8D5NoOtfKww4c8DIHQOt
         8Q7QJkcG1Y2XLiv2bNCpF0WjDNV2P8Bohpco/D4F4YwfMMNmvg13LPlVZAZWOnWhlRFU
         HQ4w==
X-Gm-Message-State: APjAAAV+bq0gRVRwUaLv6aZDHjfVOOPM9SZwWCKj4vYQ/5z6pgS7Fy/k
        PRBactFx1w1z63VcDZecXqcVZZlQ9HyPO3LOSiV5og==
X-Google-Smtp-Source: APXvYqyNUV5CeyaGRaQdpQdWDTpTGsID5cSsYw56eH2JoFikCUNAexJH578Hl3wrsc6sQfeN/mkYyVGGOPWk5mqmXKY=
X-Received: by 2002:a5e:8618:: with SMTP id z24mr20207431ioj.174.1561047864144;
 Thu, 20 Jun 2019 09:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com> <CAGb2v669MprYgy2wc_a7Kz8VpzzNGZxDxsj0z_Ujx5bV25+AWQ@mail.gmail.com>
 <CAMty3ZDRYBPKrGQxAZoB+trFiDLJ5BxDfNUOnPzgd+UWcpwCoQ@mail.gmail.com>
 <CAGb2v67uNhie9mb2-m04FGEi4Z7q7TYChOogGj2HgmSmEo4Arg@mail.gmail.com>
 <CAMty3ZBUrGEi+e62sFe7GkXinK3q076sGLwpEVz67qeoV+1ZeA@mail.gmail.com>
 <CAGb2v65YRVSv2mFfE2e=vqDOSu4Nie_oLQ-qpaDsTWKJwf-aeA@mail.gmail.com>
 <CAMty3ZA+hV_X0-=b83M3rDUhX=+g5RNC6EU-DzAS_pbvwc54FA@mail.gmail.com> <CAGb2v66onOEDPvXWLsLj7efxbReY0_z1HcQWkG78XUytLvMQ+g@mail.gmail.com>
In-Reply-To: <CAGb2v66onOEDPvXWLsLj7efxbReY0_z1HcQWkG78XUytLvMQ+g@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 20 Jun 2019 21:54:12 +0530
Message-ID: <CAMty3ZC=Mn2po=98onX7WcmTGOmV0aK+ZT5bYFEFw+q+SqK4FA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 5/9] drm/sun4i: tcon_top: Register clock
 gates in probe
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 4:24 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Jun 18, 2019 at 6:34 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Tue, Jun 18, 2019 at 1:23 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Tue, Jun 18, 2019 at 3:45 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > On Tue, Jun 18, 2019 at 12:49 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > > >
> > > > > On Mon, Jun 17, 2019 at 6:30 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > > >
> > > > > > On Sun, Jun 16, 2019 at 11:01 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > > > > > >
> > > > > > > On Sat, Jun 15, 2019 at 12:44 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > > > > >
> > > > > > > > TCON TOP have clock gates for TV0, TV1, dsi and right
> > > > > > > > now these are register during bind call.
> > > > > > > >
> > > > > > > > Of which, dsi clock gate would required during DPHY probe
> > > > > > > > but same can miss to get since tcon top is not bound at
> > > > > > > > that time.
> > > > > > > >
> > > > > > > > To solve, this circular dependency move the clock gate
> > > > > > > > registration from bind to probe so-that DPHY can get the
> > > > > > > > dsi gate clock on time.
> > > > > > > >
> > > > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 94 ++++++++++++++------------
> > > > > > > >  1 file changed, 49 insertions(+), 45 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > > > index 465e9b0cdfee..a8978b3fe851 100644
> > > > > > > > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > > > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > > > @@ -124,7 +124,53 @@ static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
> > > > > > > >  static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> > > > > > > >                                void *data)
> > > > > > > >  {
> > > > > > > > -       struct platform_device *pdev = to_platform_device(dev);
> > > > > > > > +       struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
> > > > > > > > +       int ret;
> > > > > > > > +
> > > > > > > > +       ret = reset_control_deassert(tcon_top->rst);
> > > > > > > > +       if (ret) {
> > > > > > > > +               dev_err(dev, "Could not deassert ctrl reset control\n");
> > > > > > > > +               return ret;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       ret = clk_prepare_enable(tcon_top->bus);
> > > > > > > > +       if (ret) {
> > > > > > > > +               dev_err(dev, "Could not enable bus clock\n");
> > > > > > > > +               goto err_assert_reset;
> > > > > > > > +       }
> > > > > > >
> > > > > > > You have to de-assert the reset control and enable the clock before the
> > > > > > > clocks it provides are registered. Otherwise a consumer may come in and
> > > > > > > ask for the provided clock to be enabled, but since the TCON TOP's own
> > > > > > > reset and clock are still disabled, you can't actually access the registers
> > > > > > > that controls the provided clock.
> > > > > >
> > > > > > These rst and bus are common reset and bus clocks not tcon top clocks
> > > > > > that are trying to register here. ie reason I have not moved it in
> > > > > > top.
> > > > >
> > > > > And you're sure that toggling bits in the TCON TOP block doesn't require
> > > > > the reset to be de-asserted and the bus clock enabled?
> > > > >
> > > > > Somehow I doubt that.
> > > > >
> > > > > Once the driver register the clocks it provides, they absolutely must work.
> > > > > They can't only work after the bind phase when the reset gets de-asserted
> > > > > and the bus clock enabled. Or you should provide proper error reporting
> > > > > in the clock ops. I doubt you want to go that way either.
> > > >
> > > > Why would they won't work after bind phase? unlike tcon top gates,
> > > > these reset, and bus are common like  what we have in other DE block
> > > > so enable them in bind won't be an issue as per as I understand. let
> > > > me know if you want me to check in other directions.
> > >
> > > You misunderstood. When you moved the clock registering parts to the probe
> > > phase, but didn't move the clock enable and reset de-assert parts to go with,
> > > the clock ops will not work as expected between probe and bind time.
> >
> > If I understand correctly, I have moved tcon clock gates, not the bus
> > clock or the reset. Both have independent enablement phase, the bus
> > clock is enable in tcon top bind and the clock gate ("dsi") enable in
> > init call of phy_ops. is both bus clock and clock gates are same and
> > related that is what you are saying?
>
> I am saying that you may need the tcon top bus gates and resets properly
> configured to be able to read/write the tcon top address range. That includes
> enabling/disabling the clocks that the tcon top driver registers.
>
> In other words, the TCON TOP's bus gate and reset control have everything to do
> with what you can do within the TCON TOP block or address range.
>
> > >
> > > Simple way to verify it: Just use devmem to disable the TCON TOP bus gate
> > > and/or assert its reset control. Then try to toggle any of the bits in the
> > > TCON TOP block and see if it works, or if the bits stick.
> >
> > Yes I have verified "dsi" gate enablement before via devmem. Below is
> > the bus, reset disablement and re-enablement and result is similar for
> > the reset, bus clock in bind and even in probe.
> >
> > 00. get the existing value
> >
> > # devmem 0x1c70020
> > 0x00010000
> > # devmem 0x1c20064
> > 0x44021000
> > # devmem 0x1c202c4
> > 0x44021000
> >
> > 01: disable bus, and assert reset
> >
> > # devmem 0x1c20064 32 0x4021000
> > # devmem 0x1c202c4 32 0x4021000
> > # devmem 0x1c20064
> > 0x04021000
> > # devmem 0x1c202c4
> > 0x04021000
> > # devmem 0x1c70020
> > 0x00000000
>
> See here. The value became 0 when it was still 0x10000 in the previous phase.
> Any guesses to why this happened, assuming you didn't touch it?

Yes, I didn't touch anything here. and it indeed expected since the
bus and reset line goes disabled and asserted.

>
> Now if you keep the bus gate disabled and the reset control asserted, and
> try to write some non-zero value to 0x1c70020, and read it back, does the
> value stick?

No, value is not stick. what ever I wrote on on 0x1c70020 it is not taking.

>
> If you don't have the bus gate enabled and the reset control de-asserted,
> any operations you do to the TCON TOP is essentially not happening. Including
> bit operations that the clocks you registered are required to do.
>
> Get what I'm saying?

I understand it, the for accessing tcon space we have bus and reset
line to be enabled and desserted. But the thing is I didn't see any
difference in the behavior even If I enable or deassert the bus and
reset in probe or in bind.

The devmem numbers which I have listed above is same for both the
cases, one with this patch and another one is handle via probe
https://paste.ubuntu.com/p/ndHj9wHzvX/

>
> You need to have the bus gate enabled and the reset control de-asserted
> BEFORE you register the clocks you are providing, or something is going
> to go very wrong.
>
> Worst case scenario: the reset control was left de-asserted by the bootloader
> but the bus gate was disabled. When you register the clocks, the CCF tries
> to read back the current status of the clocks, and the I/O stalls because
> the bus gate wasn't enabled. System stalls.
>
> Do I need to draw a time flow chart for you?

Sure, please.

>
> Also see the very simple example:
>
>     https://elixir.bootlin.com/linux/latest/source/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c#L113
>
> where the bus gate is enabled before registering the clocks. This hardware
> block doesn't have a reset control for it, but the same principle applies.

Got it, thanks.
