Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08355C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8182084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jqOLuFeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfFQKaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:30:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34321 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfFQKaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:30:02 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so20101446iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A3LvCS5kePEpWEvClGh/PP2SpGvm/yzihiihioMrY5k=;
        b=jqOLuFeF4GE1iGwe0cDirezg+Mb6UQt3wXl2PORtVhgBmE9NFT/nmPOxg0c7AfaGQh
         EgRs0yehyHSaINpG+JBfl2z9p4qjCTaHYSNjRWS7+//YkWGC9Z63BrC4T0eWwes7EQWK
         Pb7HfML/Ga1WpDYchH7O24sH/hoVsOgWkj7So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A3LvCS5kePEpWEvClGh/PP2SpGvm/yzihiihioMrY5k=;
        b=QhQKNzOvAzvu9mTuxBijCBZx9ufKmUtJe+gEnFBorN2/oDDYdTkFVB9OUtN9tKXXXw
         +fiUA0ey/HY+O5rt2w8wRBqvMWIqkC9wVyDBpUi42BttX+kb7/IgaLW5157g/yi7djJ8
         gWDSF6d4PPrAUDQvD3HS1ZZTJEUK9ODe0dd4gyVmj1QWA1IyrYNpueG0aRCRmK3/bz3d
         QvoirsxXmDIXAuBQt+sw12GbfkC0Fe63pn3IvjDr1/INgoa7NRXnWTNllki6yJlFdQWM
         Rl/nhqglm7/H2JBGKLNt1c3Old5WXgDXQiRI9QEK6CIdLBySeCt/5ON55sxhljs6Clqs
         saQQ==
X-Gm-Message-State: APjAAAXW+inKNMzW5TMpN3O/WBUwt82Peq3dTeeYYEAO6AYm+sMWS9c/
        0PrdKDAJn1AeuQV1gdXkvR48K7TSxjWrM0g936hHsA==
X-Google-Smtp-Source: APXvYqwFp+6Q3sGP5PFjt5uFYyYV/cL8x1qFEQcCbsgfGJqgag+OTV6Q8i7mdcX7I9kfq1V+jaLpKIKwbvN+TA1OVNU=
X-Received: by 2002:a02:3217:: with SMTP id j23mr84513181jaa.79.1560767401947;
 Mon, 17 Jun 2019 03:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com> <CAGb2v669MprYgy2wc_a7Kz8VpzzNGZxDxsj0z_Ujx5bV25+AWQ@mail.gmail.com>
In-Reply-To: <CAGb2v669MprYgy2wc_a7Kz8VpzzNGZxDxsj0z_Ujx5bV25+AWQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 17 Jun 2019 15:59:50 +0530
Message-ID: <CAMty3ZDRYBPKrGQxAZoB+trFiDLJ5BxDfNUOnPzgd+UWcpwCoQ@mail.gmail.com>
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

On Sun, Jun 16, 2019 at 11:01 AM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Sat, Jun 15, 2019 at 12:44 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > TCON TOP have clock gates for TV0, TV1, dsi and right
> > now these are register during bind call.
> >
> > Of which, dsi clock gate would required during DPHY probe
> > but same can miss to get since tcon top is not bound at
> > that time.
> >
> > To solve, this circular dependency move the clock gate
> > registration from bind to probe so-that DPHY can get the
> > dsi gate clock on time.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 94 ++++++++++++++------------
> >  1 file changed, 49 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > index 465e9b0cdfee..a8978b3fe851 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> > @@ -124,7 +124,53 @@ static struct clk_hw *sun8i_tcon_top_register_gate(struct device *dev,
> >  static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
> >                                void *data)
> >  {
> > -       struct platform_device *pdev = to_platform_device(dev);
> > +       struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       ret = reset_control_deassert(tcon_top->rst);
> > +       if (ret) {
> > +               dev_err(dev, "Could not deassert ctrl reset control\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = clk_prepare_enable(tcon_top->bus);
> > +       if (ret) {
> > +               dev_err(dev, "Could not enable bus clock\n");
> > +               goto err_assert_reset;
> > +       }
>
> You have to de-assert the reset control and enable the clock before the
> clocks it provides are registered. Otherwise a consumer may come in and
> ask for the provided clock to be enabled, but since the TCON TOP's own
> reset and clock are still disabled, you can't actually access the registers
> that controls the provided clock.

These rst and bus are common reset and bus clocks not tcon top clocks
that are trying to register here. ie reason I have not moved it in
top.
