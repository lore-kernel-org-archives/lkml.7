Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610E2C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38231215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 16:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gelJmfqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgABQew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 11:34:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38223 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgABQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 11:34:52 -0500
Received: by mail-io1-f67.google.com with SMTP id v3so38830663ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 08:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n02NZb1q13MC+D+YIZeKacRc8gevOmHNy1haOLJb4io=;
        b=gelJmfqDyUmjwBH/XMMX/bBXaKDVC6YTmAj8rPELVV13MZipjbHUb7JPhFkSuDop1U
         ByiLKjmlDBsd8mhMeRa6Is5L7PN0Wzk2rxFBkZqRfzxyPP1Bgn9Y5J2iih8/libglJ22
         dOtjW3gXu4mZCdjaMzxLU4AnQWrng2RGMawBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n02NZb1q13MC+D+YIZeKacRc8gevOmHNy1haOLJb4io=;
        b=n5sgnHP4W5QWhpogomUcz2F9RbXu1DBQOAyI3tQNdd7Iwbovww9saBnO1rcZ4LhTkM
         AsON51g4ihviuAxIOA2e+aWJpSxMT31aFgELoVDt1cyL1Seao7s5k2z05khehiynF2Qn
         aIkwKlFz+G/YvpJbcRrwIpW1UPhv9Ykxprf0z3/asgdTD6KLAXmfbbk33rF1zF2hKamj
         yAPZcQBcFFGjUSTrbva4liXOF9wPneUcafjCmYLH7ZDSnTK/r+YD7D0ArThH2Cmw2nX6
         FmSkcaLUKY0ZdPXxJl3gHO8EFQSXagjnP04PB6NGB6HulEmEW184Mz/8swBjjFYfMRf9
         s/0A==
X-Gm-Message-State: APjAAAU664rfO9c45+Ms3IGc3jGLxV9iFHajnW1Rw3JY1CY45qNsMd3P
        PtvdxBqyfw+Kxz3B2EvntCq2d/mV+vqon9l03xWIww==
X-Google-Smtp-Source: APXvYqz8y/GovnsF0D2tm3lNOpYaS0G7+35htjGwpcyBgB9MdOWIe9CYMW8Ole+deE4SlX9aakNc01/kDuMb4EgOvMg=
X-Received: by 2002:a02:b897:: with SMTP id p23mr67001302jam.58.1577982891338;
 Thu, 02 Jan 2020 08:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
 <20191231130528.20669-3-jagan@amarulasolutions.com> <20200102105424.kmte7aooh2gkrcnu@gilmour.lan>
 <CAMty3ZA0e8eJZWvAh0x=KGAZVL3apdao3COvR6j3-ckv0cdvcg@mail.gmail.com> <20200102154703.3prgwcjyo36g5g5u@gilmour.lan>
In-Reply-To: <20200102154703.3prgwcjyo36g5g5u@gilmour.lan>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 2 Jan 2020 22:04:40 +0530
Message-ID: <CAMty3ZB_6GyK=hhJU-8yAQiom1Uq25ojFbKaGrK1fmW8SnDV_A@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] drm/sun4i: tcon: Add TCON LCD support for R40
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 2, 2020 at 9:17 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Jan 02, 2020 at 09:10:31PM +0530, Jagan Teki wrote:
> > On Thu, Jan 2, 2020 at 4:24 PM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Tue, Dec 31, 2019 at 06:35:21PM +0530, Jagan Teki wrote:
> > > > TCON LCD0, LCD1 in allwinner R40, are used for managing
> > > > LCD interfaces like RGB, LVDS and DSI.
> > > >
> > > > Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
> > > > tcon top.
> > > >
> > > > Add support for it, in tcon driver.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > ---
> > > > Changes for v3:
> > > > - none
> > > >
> > > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > index fad72799b8df..69611d38c844 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > > @@ -1470,6 +1470,13 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
> > > >       .has_channel_1          = true,
> > > >  };
> > > >
> > > > +static const struct sun4i_tcon_quirks sun8i_r40_lcd_quirks = {
> > > > +     .supports_lvds          = true,
> > > > +     .has_channel_0          = true,
> > > > +     /* TODO Need to support TCON output muxing via GPIO pins */
> > > > +     .set_mux                = sun8i_r40_tcon_tv_set_mux,
> > >
> > > What is this muking about? And why is it a TODO?
> >
> > Muxing similar like how TCON TOP handle TV0, TV1 I have reused the
> > same so-that it would configure de port selection via
> > sun8i_tcon_top_de_config
> >
> > TCON output muxing have gpio with GPIOD and GPIOH bits, which select
> > which of LCD or TV TCON outputs to the LCD function pins. I have
> > marked these has TODO for further support as mentioned by Chen-Yu in
> > v1[1].
>
> It should be in the commit log.

Make sense.

>
> What's the plan to support that when needed? And that means that the
> LCD and TV outputs are mutually exclusive? We should at the very least
> check that both aren't enabled at the same time.

Yes, LCD or TV within the outselect seems to be mutually exclusive.
Like LCD0 or TV0 can output to GPIOD incase of TV0_OUTSEL and LCD1 or
TV1 can output to GPIOH incase of TV1_OUTSEL. I think checking them
before configuring TCON_TOP_PORT_SEL_REG would make sense, let me know
if you have any suggestions?
