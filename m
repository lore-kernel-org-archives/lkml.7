Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948DAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E1620661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IrX1prBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfCFTCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:02:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36420 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfCFTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:02:21 -0500
Received: by mail-io1-f68.google.com with SMTP id r136so11154597iod.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 11:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86lW/Wm2q4Ws32VTquhpzqCLZ253jgoHq9cwIH7xDMI=;
        b=IrX1prBEXUFLlcuYjYG74lkkGOg2o0U1Z5bQp/xXtvlixF0j34f9aMUgGo6+zaRacW
         K+EHduVOcbosvcrcm3EP5+SbZZglfcCM0xpX8vA/AIvjgKTs8kUds6uvSoC0BBicX5dC
         wmk8jbV/UIIDnxQLUatji3wmnm/y8sX+WSt3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86lW/Wm2q4Ws32VTquhpzqCLZ253jgoHq9cwIH7xDMI=;
        b=Y2N5I6+6cwMWS+OZ006QziyV6mKlGL2oeC+sv3Wf0VVc8f4Xr5a7bFhOjSC2nQIZeJ
         zyTjudli9UXZfo5mZXwiG6oo9ccnm1a8dDe3joQYCCTXog2yb31uXbJoYtU5AulLElTx
         l/rrjf2AAMTmBzJ0QmByMSz3qGMCzxhtsKKV2sEVQSqqQ6xAqLijTS6nyY0CsqVi9y6b
         D6fxaxnuI4ppFT5tB98PuN9PoznQvhJb3nMwVSWy+qnkSQUzpWTWevRbj+WAYIGK28n6
         AioaYvNqd/IXXdGafdfRrL22tLmw8vGwE3VtR6bJcOEJaGROOTmlg+3z4LmUxY8a3ogX
         JjWQ==
X-Gm-Message-State: APjAAAVOJbOtGIaoWTaniZaGWRAgTTMeWj1+e0j/5yjPhgVFk07H4REt
        pY8ECykemSTtmETh3r1K7gz3PiuXMM5TgfUAVe7Niw==
X-Google-Smtp-Source: APXvYqxBzh8FnMdntdV84Pa9qvPqHFij+cMRBMA01kVMlg7UlooRau4OnBjmMg+woEazNvdMjGTZvqP1fsV13CudWEk=
X-Received: by 2002:a5e:c605:: with SMTP id f5mr4174797iok.252.1551898940253;
 Wed, 06 Mar 2019 11:02:20 -0800 (PST)
MIME-Version: 1.0
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <20190303173527.31055-2-jagan@amarulasolutions.com> <20190304155444.rwslksn57uggpazw@flea>
In-Reply-To: <20190304155444.rwslksn57uggpazw@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 7 Mar 2019 00:32:09 +0530
Message-ID: <CAMty3ZAD8qGV7tsgZiO9cQrZaiui1-E7Xzfq5o95BUoDoBEOkw@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] drm/sun4i: sun6i_mipi_dsi: Fix hsync_porch overflow
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 9:24 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Mar 03, 2019 at 11:05:23PM +0530, Jagan Teki wrote:
> > Loop N1 instruction delay for burst mode devices are computed
> > based on horizontal sync and porch timing values.
> >
> > The current driver is using u16 type for computing this hsync_porch
> > value, which would failed to fit within the u16 type for large sync
> > and porch timings devices. This would result in hsync_porch overflow
> > and eventually computed wrong instruction delay value.
> >
> > Example, timings, where it produces the overflow
> > {
> >       .hdisplay       = 1080,
> >       .hsync_start    = 1080 + 408,
> >         .hsync_end      = 1080 + 408 + 4,
> >         .htotal         = 1080 + 408 + 4 + 38,
> > }
> >
> > It reproduces the desired delay value 65487 but the correct working
> > value should be 7.
> >
> > So, Fix it by computing hsync_porch value separately with u32 type.
> >
> > Fixes: 1c1a7aa3663c ("drm/sun4i: dsi: Add burst support")
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index 6ff585055a07..465e7fc57899 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -457,8 +457,9 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
> >       u16 delay = 50 - 1;
> >
> >       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
> > -             delay = (mode->htotal - mode->hdisplay) * 150;
> > -             delay /= (mode->clock / 1000) * 8;
> > +             u32 hsync_porch = (mode->htotal - mode->hdisplay);
> > +
> > +             delay = ((hsync_porch * 150) / ((mode->clock / 1000) * 8));
>
> shouldn't we keep the multiplication by 150 in the u32 assignation?

Yes, ie true.  will move it.
