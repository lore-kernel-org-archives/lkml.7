Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7232CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9200F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zuiLR9ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfJ3PKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:10:37 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39959 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJ3PKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:10:37 -0400
Received: by mail-ua1-f65.google.com with SMTP id i13so791481uaq.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWPvK2c6OyfVAzdkhOXR9vFmByKTbx2YLS3Y29+afB4=;
        b=zuiLR9ai+hclT9+gwgqH0OqEi9Pd7dVRwQNDKVvY0EhBOLUCH3P0UiTqHUEXd/9bIo
         39mGEcFR2pZf/6vm/H0RoPat1+r9ropVskZU0VeM1tCVTdr42PL11wLJI3CqL2Kt6QPu
         gXzi32Ty2JjjIO4GfAI92xHtepkfGZDvbzKaUBKQRPHVf59P26N4e52n+zE7KWKSLIgn
         TFkUagCeRZ8edR9CeWUh+J8THTj1gPBvPskSsZ+G6OB8wi2ou+hUAhhCemNyAzTOavI0
         z+IPXYh39UsJVpMLXvwfulPJZvgMQm4bM5oFq62630edcJ+K2gHYvtou+ijEa7+co3lG
         QimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWPvK2c6OyfVAzdkhOXR9vFmByKTbx2YLS3Y29+afB4=;
        b=NCDNRzqqGEVKIfBpKmif2rJ8A/rK7oKjxib83g/a+6M/EjW1iSJq32WD5CYmaj+pFs
         lFErthD+EylpGpLxqhHJVrr1POpQvufyLr4V90885Kwrg9kFglFzsQoOxKwDzKF9bePW
         cpGvkw8XIZFFpX3UblOV5ZD0T1X6YSHyzbpNwulf8DnSEqbQHPb1Dl1u1XqM7uAo2FFw
         Fla1yvqpcMnj15SEVB1lAAgPwaXT50AhwKknDyxIyr+oGJCegP0VnyICRFKbIj3PvTxD
         MtzuG9IojBLO8TGnxVpRhsdG10ATX4To5xlNnYvSzx4HzuxVA8eVRcuqVYB0tOeexpyG
         31aA==
X-Gm-Message-State: APjAAAUhLwuv8dBqtpbHBy7WhZxq2IfUCAG+dheNd8AreXXbHrbyZITa
        GTLvw9+nzKvVPAWNsvEVbMzEYXlttoTgomPg/M3i2A==
X-Google-Smtp-Source: APXvYqyN7EMi9zEVMgWyfpCXNVxROb40i9/Ejprhx08G0ucwyOjmrTjTzCNWCO/6pYP/j7+DITGa5pFj59ti5wgdlH8=
X-Received: by 2002:ab0:2258:: with SMTP id z24mr75332uan.100.1572448234841;
 Wed, 30 Oct 2019 08:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191018131338.11713-1-hslester96@gmail.com> <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
 <20191023153313.GB5153@kunai>
In-Reply-To: <20191023153313.GB5153@kunai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Oct 2019 16:09:58 +0100
Message-ID: <CAPDyKFo9wYwhdy-1BDcRMJKTjADappsT-gBaKZE7hTLE4obxiA@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 at 17:33, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Oct 21, 2019 at 04:32:49PM +0200, Ulf Hansson wrote:
> > On Fri, 18 Oct 2019 at 15:13, Chuhong Yuan <hslester96@gmail.com> wrote:
> > >
> > > renesas_sdhi_probe misses checks for pinctrl_lookup_state and may miss
> > > failures.
> > > Add checks for them to fix the problem.
> > >
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > >  drivers/mmc/host/renesas_sdhi_core.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> > > index d4ada5cca2d1..dc5ad6632df3 100644
> > > --- a/drivers/mmc/host/renesas_sdhi_core.c
> > > +++ b/drivers/mmc/host/renesas_sdhi_core.c
> > > @@ -694,8 +694,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
> > >         if (!IS_ERR(priv->pinctrl)) {
> > >                 priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
> > >                                                 PINCTRL_STATE_DEFAULT);
> > > +               if (IS_ERR(priv->pins_default))
> > > +                       return PTR_ERR(priv->pins_default);
> > > +
> > >                 priv->pins_uhs = pinctrl_lookup_state(priv->pinctrl,
> > >                                                 "state_uhs");
> > > +               if (IS_ERR(priv->pins_uhs))
> > > +                       return PTR_ERR(priv->pins_uhs);
> > >         }
> >
> > This looks correct to me, as I guess if there is a pinctrl specified
> > for device node of the controller, it means that it should be used!?
> >
> > I understand that this is only used for those variants that supports
> > UHS-I via the renesas_sdhi_start_signal_voltage_switch(). Wolfram, is
> > this fine you think?
>
> Well, I don't like to bail out because this error is not fatal for basic
> operations. How about releasing priv->pinctrl again with an additional
> warning that pinctrl settings are broken and will prevent 1.8v modes?
>
> Opinions?

Hmm, from a mmc driver probe point of view, I don't quite share this approach.

I would rather fail as it forces the DTB to be corrected immediately,
rather than trusting some developer to look at a warning in a log. The
point is, in such a case it may never get fixed, if the product is
shipped with the wrong DTB.

My concern at this point is rather to break existing DTBs, but it
seems that should not be an issue, right?

Kind regards
Uffe
