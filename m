Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D2C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5382080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfFRHT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:19:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43060 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFRHT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:19:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so20067246edr.10;
        Tue, 18 Jun 2019 00:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGRhkqGQodehH6nOoVQY2z539WKIaQS1uhzFQI2YTfU=;
        b=WzKsDHIEFHczbq/J2T/YOkqRNTa36biQLm6LHr/8Jwt+JTl5zG66QuilQfQdV9TqiT
         VG7eVTaaaXk1BM/XLK6oif4DoJ+LqW5GXJ+YUiwNdHHLDXp19EnLNHdi8jHGGS6FlSLb
         ULn+dLPxqFDS3KggbLqMyvPMM2CGju/CJidJNDb1o4jq/8FfZE2siDMrLMa3BMp2HMhk
         EUrTHaRGOQkR6ddUaOd9ldBkGqMKOlkI0Oz0eJ3Ela14yu9F7KYoR0Fbdq88vUzT+MiF
         CFDACafRCF8RHbyMrqu/QmJHLDKBMFmVcb4xTYcfS1UT/a4OdFeKvATMmWOiiU7D1khL
         Y9XQ==
X-Gm-Message-State: APjAAAUgsiK4su2d4/VwIdUwLc+3+l0i8UKDWt2IDZwHPVvOVIj/bqBT
        yhfjm6CrKWjC4mUGMnOMzy4MoC/C40s=
X-Google-Smtp-Source: APXvYqzcG3APtYOZnBeiAD13Yn7O3Vg7wtLwG5Gu4gHTUzOTigqxXsownapKhFF24hrU8g0psCUEOQ==
X-Received: by 2002:a50:cac1:: with SMTP id f1mr121475009edi.97.1560842396545;
        Tue, 18 Jun 2019 00:19:56 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id a9sm4608267edc.44.2019.06.18.00.19.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 00:19:55 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id k11so12700785wrl.1;
        Tue, 18 Jun 2019 00:19:55 -0700 (PDT)
X-Received: by 2002:adf:fc85:: with SMTP id g5mr79869381wrr.324.1560842394887;
 Tue, 18 Jun 2019 00:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com> <CAGb2v669MprYgy2wc_a7Kz8VpzzNGZxDxsj0z_Ujx5bV25+AWQ@mail.gmail.com>
 <CAMty3ZDRYBPKrGQxAZoB+trFiDLJ5BxDfNUOnPzgd+UWcpwCoQ@mail.gmail.com>
In-Reply-To: <CAMty3ZDRYBPKrGQxAZoB+trFiDLJ5BxDfNUOnPzgd+UWcpwCoQ@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 18 Jun 2019 15:19:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v67uNhie9mb2-m04FGEi4Z7q7TYChOogGj2HgmSmEo4Arg@mail.gmail.com>
Message-ID: <CAGb2v67uNhie9mb2-m04FGEi4Z7q7TYChOogGj2HgmSmEo4Arg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 5/9] drm/sun4i: tcon_top: Register clock
 gates in probe
To:     Jagan Teki <jagan@amarulasolutions.com>
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

On Mon, Jun 17, 2019 at 6:30 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Sun, Jun 16, 2019 at 11:01 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Sat, Jun 15, 2019 at 12:44 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > TCON TOP have clock gates for TV0, TV1, dsi and right
> > > now these are register during bind call.
> > >
> > > Of which, dsi clock gate would required during DPHY probe
> > > but same can miss to get since tcon top is not bound at
> > > that time.
> > >
> > > To solve, this circular dependency move the clock gate
> > > registration from bind to probe so-that DPHY can get the
> > > dsi gate clock on time.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 94 ++++++++++++++------------
> > >  1 file changed, 49 insertions(+), 45 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > index 465e9b0cdfee..a8978b3fe851 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > > @@ -124,7 +124,53 @@ static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
> > >  static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> > >                                void *data)
> > >  {
> > > -       struct platform_device *pdev = to_platform_device(dev);
> > > +       struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
> > > +       int ret;
> > > +
> > > +       ret = reset_control_deassert(tcon_top->rst);
> > > +       if (ret) {
> > > +               dev_err(dev, "Could not deassert ctrl reset control\n");
> > > +               return ret;
> > > +       }
> > > +
> > > +       ret = clk_prepare_enable(tcon_top->bus);
> > > +       if (ret) {
> > > +               dev_err(dev, "Could not enable bus clock\n");
> > > +               goto err_assert_reset;
> > > +       }
> >
> > You have to de-assert the reset control and enable the clock before the
> > clocks it provides are registered. Otherwise a consumer may come in and
> > ask for the provided clock to be enabled, but since the TCON TOP's own
> > reset and clock are still disabled, you can't actually access the registers
> > that controls the provided clock.
>
> These rst and bus are common reset and bus clocks not tcon top clocks
> that are trying to register here. ie reason I have not moved it in
> top.

And you're sure that toggling bits in the TCON TOP block doesn't require
the reset to be de-asserted and the bus clock enabled?

Somehow I doubt that.

Once the driver register the clocks it provides, they absolutely must work.
They can't only work after the bind phase when the reset gets de-asserted
and the bus clock enabled. Or you should provide proper error reporting
in the clock ops. I doubt you want to go that way either.

ChenYu
