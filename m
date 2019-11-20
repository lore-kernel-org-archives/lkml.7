Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE718C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2B9217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbfKTOpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:45:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40569 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfKTOpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:45:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id o49so29175944qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 06:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GwAVa55iMTrwGMjeJr4lNS+CHjUgQR8e0SPlkLri/s=;
        b=O0VPiQJ+ozdyCI5kTvthCQgHYsu4dQO+zcLyf/U0tqVl5V682iCUMfRKFVxN4PFMul
         RcF9GBNgW9Lrx9ubanNdvDi661MQS/12+6Fj57kIkTM2iAO7xaulSYxjw/rG6uob5PY3
         VFZg8wwK3oAVCJ+OKYIDG2fxHWpiaukbPXAphkH5mQrvxBt3qmON9c4Tp4mHUdvSSP6c
         EmX13wohPVtplRJ28tLWICNCfMIbSJlmI8CfBlxLMKm1GKze96pAQsynArH2zw61eteN
         1jUm2TCHC+ZtBfvBUr+Wxjrnswef7/hAutY2QJ1bqCQaBLyed+a6JRrjfj5ezwNGeRGI
         IZ8Q==
X-Gm-Message-State: APjAAAVrFLeGmAj4n0PVzXia0A972QsJIz6MR+02qJWwuGYwUXY3EzVl
        QMmcNa0uICCXLYyEO5yIIxp6nc3Q0JUWS2JIiRb19A==
X-Google-Smtp-Source: APXvYqx8Y5w8yh03sD1NTG8wQhJsB2kTUtR5MH/DJBe6WTyWQgXZZvX8kFc/4VdYlbzRdrawaDiL5wc7a7jb/vIdn9o=
X-Received: by 2002:ac8:35c4:: with SMTP id l4mr2921352qtb.151.1574261121184;
 Wed, 20 Nov 2019 06:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20191120142614.29180-1-geert+renesas@glider.be>
 <20191120142614.29180-2-geert+renesas@glider.be> <f5edcd3d1f8b196a4de584d935636a4b5b247121.camel@pengutronix.de>
In-Reply-To: <f5edcd3d1f8b196a4de584d935636a4b5b247121.camel@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Nov 2019 15:45:09 +0100
Message-ID: <CAMuHMdVXeRo49Xk3_DyU2TXhkyhiAV2Wiyc22LP8udJS5=zZ9w@mail.gmail.com>
Subject: Re: [PATCH 1/3] reset: Do not register resource data for missing resets
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Wed, Nov 20, 2019 at 3:43 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Wed, 2019-11-20 at 15:26 +0100, Geert Uytterhoeven wrote:
> > When an optional reset is not present, __devm_reset_control_get() and
> > devm_reset_control_array_get() still register resource data to release
> > the non-existing reset on cleanup, which is futile.
> >
> > Fix this by skipping NULL reset control pointers.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/reset/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index ca1d49146f611435..55245f485b3819da 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> > @@ -787,7 +787,7 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
> >               return ERR_PTR(-ENOMEM);
> >
> >       rstc = __reset_control_get(dev, id, index, shared, optional, acquired);
> > -     if (!IS_ERR(rstc)) {
> > +     if (rstc && !IS_ERR(rstc)) {
>
> Could you change this to use IS_ERR_OR_NULL, both here and below?

Sure. Silly me...
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
