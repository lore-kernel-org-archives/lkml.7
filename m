Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D2AC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B102070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E1YxsQwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfFRKeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:34:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38918 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:34:19 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so22592928iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpQoG1Wc0XjuCAWhAB/s5GQOkrEUqtdWSybZNMgnLQo=;
        b=E1YxsQwklgb6VllZvWHSagrfUhBjoGsarhcjZOymEGPZQ99/5hS/nnHF84NGch8SZV
         CLBAmR5tEXQud+tNxydBa5d9QFQ4l+rZD4kUaGIymeyuVR9+deirqszWB2Id6vl1aXzU
         h6lw+s3ddlsDTKeC3GqGCMfI2FE4dJ3eSRuLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpQoG1Wc0XjuCAWhAB/s5GQOkrEUqtdWSybZNMgnLQo=;
        b=aHfwXj2IeChfB/Ho0I33EjsVvZc1l69aUp3CDQ9ATAFQibRWJpONTFmRHOCCyETL0N
         wzHZcN3TscjfT2Cg2DVm5xKqZzYQ09+4qABZUIYJDLfJYKjypSrHUKR+vRW8WRlthfEn
         IiVZC5aenrycAyZkjYvwR27Ik9Imot0fwNgB3cce1U3mxwtHweyHli/2vbKObkvvMC/K
         yGMvFT+PyNiy93TaA+MyqagQkf8QMDvJ3aww5Q7WQjO/eDZ74xFHaPZauBip08r40Un6
         DQy2k4ccnJb74c6fezhUz1CPYMNmwPZKVXAs2/drcG0LKr04MspanRDTYg247I2iOnj3
         rtyQ==
X-Gm-Message-State: APjAAAW2NlOxlk+4YgKDsjY4FWVUVknzZJWVbcz7izSSEvDp/puq2mBx
        iBh9wA/uGVnnag6y+H4oTWCKiAvP3v3SN1AArodhsQ==
X-Google-Smtp-Source: APXvYqzO0nEX3fm1soaUqMo2bDslLyQffr3PNruZK0DCUBUy/ns1rEi9fPAESKSl/J4H4H1lmzd5kNngA/KmgcxyfnQ=
X-Received: by 2002:a5d:9ad6:: with SMTP id x22mr4603238ion.136.1560854058150;
 Tue, 18 Jun 2019 03:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com> <CAGb2v669MprYgy2wc_a7Kz8VpzzNGZxDxsj0z_Ujx5bV25+AWQ@mail.gmail.com>
 <CAMty3ZDRYBPKrGQxAZoB+trFiDLJ5BxDfNUOnPzgd+UWcpwCoQ@mail.gmail.com>
 <CAGb2v67uNhie9mb2-m04FGEi4Z7q7TYChOogGj2HgmSmEo4Arg@mail.gmail.com>
 <CAMty3ZBUrGEi+e62sFe7GkXinK3q076sGLwpEVz67qeoV+1ZeA@mail.gmail.com> <CAGb2v65YRVSv2mFfE2e=vqDOSu4Nie_oLQ-qpaDsTWKJwf-aeA@mail.gmail.com>
In-Reply-To: <CAGb2v65YRVSv2mFfE2e=vqDOSu4Nie_oLQ-qpaDsTWKJwf-aeA@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 18 Jun 2019 16:04:06 +0530
Message-ID: <CAMty3ZA+hV_X0-=b83M3rDUhX=+g5RNC6EU-DzAS_pbvwc54FA@mail.gmail.com>
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

On Tue, Jun 18, 2019 at 1:23 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Jun 18, 2019 at 3:45 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Tue, Jun 18, 2019 at 12:49 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Mon, Jun 17, 2019 at 6:30 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > On Sun, Jun 16, 2019 at 11:01 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > > > >
> > > > > On Sat, Jun 15, 2019 at 12:44 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > > >
> > > > > > TCON TOP have clock gates for TV0, TV1, dsi and right
> > > > > > now these are register during bind call.
> > > > > >
> > > > > > Of which, dsi clock gate would required during DPHY probe
> > > > > > but same can miss to get since tcon top is not bound at
> > > > > > that time.
> > > > > >
> > > > > > To solve, this circular dependency move the clock gate
> > > > > > registration from bind to probe so-that DPHY can get the
> > > > > > dsi gate clock on time.
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 94 ++++++++++++++------------
> > > > > >  1 file changed, 49 insertions(+), 45 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > index 465e9b0cdfee..a8978b3fe851 100644
> > > > > > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > > > > @@ -124,7 +124,53 @@ static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
> > > > > >  static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> > > > > >                                void *data)
> > > > > >  {
> > > > > > -       struct platform_device *pdev = to_platform_device(dev);
> > > > > > +       struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
> > > > > > +       int ret;
> > > > > > +
> > > > > > +       ret = reset_control_deassert(tcon_top->rst);
> > > > > > +       if (ret) {
> > > > > > +               dev_err(dev, "Could not deassert ctrl reset control\n");
> > > > > > +               return ret;
> > > > > > +       }
> > > > > > +
> > > > > > +       ret = clk_prepare_enable(tcon_top->bus);
> > > > > > +       if (ret) {
> > > > > > +               dev_err(dev, "Could not enable bus clock\n");
> > > > > > +               goto err_assert_reset;
> > > > > > +       }
> > > > >
> > > > > You have to de-assert the reset control and enable the clock before the
> > > > > clocks it provides are registered. Otherwise a consumer may come in and
> > > > > ask for the provided clock to be enabled, but since the TCON TOP's own
> > > > > reset and clock are still disabled, you can't actually access the registers
> > > > > that controls the provided clock.
> > > >
> > > > These rst and bus are common reset and bus clocks not tcon top clocks
> > > > that are trying to register here. ie reason I have not moved it in
> > > > top.
> > >
> > > And you're sure that toggling bits in the TCON TOP block doesn't require
> > > the reset to be de-asserted and the bus clock enabled?
> > >
> > > Somehow I doubt that.
> > >
> > > Once the driver register the clocks it provides, they absolutely must work.
> > > They can't only work after the bind phase when the reset gets de-asserted
> > > and the bus clock enabled. Or you should provide proper error reporting
> > > in the clock ops. I doubt you want to go that way either.
> >
> > Why would they won't work after bind phase? unlike tcon top gates,
> > these reset, and bus are common like  what we have in other DE block
> > so enable them in bind won't be an issue as per as I understand. let
> > me know if you want me to check in other directions.
>
> You misunderstood. When you moved the clock registering parts to the probe
> phase, but didn't move the clock enable and reset de-assert parts to go with,
> the clock ops will not work as expected between probe and bind time.

If I understand correctly, I have moved tcon clock gates, not the bus
clock or the reset. Both have independent enablement phase, the bus
clock is enable in tcon top bind and the clock gate ("dsi") enable in
init call of phy_ops. is both bus clock and clock gates are same and
related that is what you are saying?

>
> Simple way to verify it: Just use devmem to disable the TCON TOP bus gate
> and/or assert its reset control. Then try to toggle any of the bits in the
> TCON TOP block and see if it works, or if the bits stick.

Yes I have verified "dsi" gate enablement before via devmem. Below is
the bus, reset disablement and re-enablement and result is similar for
the reset, bus clock in bind and even in probe.

00. get the existing value

# devmem 0x1c70020
0x00010000
# devmem 0x1c20064
0x44021000
# devmem 0x1c202c4
0x44021000

01: disable bus, and assert reset

# devmem 0x1c20064 32 0x4021000
# devmem 0x1c202c4 32 0x4021000
# devmem 0x1c20064
0x04021000
# devmem 0x1c202c4
0x04021000
# devmem 0x1c70020
0x00000000

02: enable bus, and dessert reset

# devmem 0x1c20064 32 0x44021000
# devmem 0x1c202c4 32 0x44021000
# devmem 0x1c20064
0x44021000
# devmem 0x1c202c4
0x44021000
# devmem 0x1c70020
0x00000000

03: enable gate

# devmem 0x1c70020 32 0x00010000
# devmem 0x1c70020
0x00010000

>
> Whether another driver actually does so is not the question. It is just bad
> implementation.

Not sure, I understand this.
