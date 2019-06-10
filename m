Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB60C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B32085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMSHvZxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbfFJNCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:02:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37387 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389169AbfFJNCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:02:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id m15so6564895lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvVmgwiazCcMY+QGQrVG7dPwBjyoAsTBZz5XDskINwU=;
        b=EMSHvZxrNj7zSeWW6JUMb1PjD7XA4L2F3EJBWazAQYFiTny584qw5TGz+HoR4WtRPs
         jt0BFoSOGoG5cEKmGnSsVNUFOekU91241Gxig8HqO889e0o8n1mR0IGZzek77ZNEH0nR
         HNZtFC0cMDMDejIk5zmWW2LivA0+TD8QfSWxb873mnou5gQReddEbu9l7uaLLRATj9k6
         J7joALu5V2Uz0HXzTFybC991OzTTITbWKqyzTde8jVHngHRLH1MBiA42vMBZWBfmHdmL
         TtBrP9BIUOsdEwIlfDTfHuA+NE+2ZOKsggvG/+JwOwZa8/YD8lsLqeWXSvXlt6BSuR9U
         fTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvVmgwiazCcMY+QGQrVG7dPwBjyoAsTBZz5XDskINwU=;
        b=MjLa8ITRKrQBT7+5ojvGaZ7cgGg7npT2021nVTUQav1ugkctP4UvNWFIa/EQAJYXdi
         XyLUmrykrGYfdWwT1/gA1nVL+OoKiNdwBpgaT88d2hwMd/EXI+r4BrqwtN6tGNo5rbNh
         TMatumvK7YBCNbDPqXrNaPZp8YNaNNnYbMByvULbC7Sco/nOUpEcQ4vcK69UxqWIwJNw
         fHEcKHUiVisC9QfZSiLBej0fLb/7PoCniLFSAADdPh5lTqMncqOfto+cG+uipfAQI3+6
         3rzdwN8RARfEC9OHw3AcWnNm7WQqgpJtn6cnIQ2m2NSgMuAvKz0nvxg/boOozInVD3pg
         xzfw==
X-Gm-Message-State: APjAAAWYR/pi7pBqLpKb2MCXvPvZO7DpBiAZ6P5PC5PmZL7X5kkllbmM
        qumDqHE24I34cjGNEhal3hM0M2HALyz196bXy/pZDg==
X-Google-Smtp-Source: APXvYqztCweeAg9bUK/19CvnD4JyBvcZjEnwDj3sBiLhrLCK6pXF7PHLmDF1b1+3rnaeDnoReMLep6XRUs3DNxTDDHc=
X-Received: by 2002:a19:f601:: with SMTP id x1mr34368114lfe.182.1560171721490;
 Mon, 10 Jun 2019 06:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190606094736.23970-1-anders.roxell@linaro.org> <20190606105954.GZ2456@sirena.org.uk>
In-Reply-To: <20190606105954.GZ2456@sirena.org.uk>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 10 Jun 2019 15:01:50 +0200
Message-ID: <CADYN=9+5RCiSRQdV+vcUT9cqH6fMAMFpMUmApzT2hRfeivfhHg@mail.gmail.com>
Subject: Re: [PATCH 8/8] drivers: regulator: 88pm800: fix warning same module names
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, marex@denx.de,
        stefan@agner.ch, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, b.zolnierkie@samsung.com,
        a.hajda@samsung.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        p.zabel@pengutronix.de, hkallweit1@gmail.com,
        Lee Jones <lee.jones@linaro.org>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019 at 13:00, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jun 06, 2019 at 11:47:36AM +0200, Anders Roxell wrote:
>
> >  obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
> > -obj-$(CONFIG_REGULATOR_88PM800) += 88pm800.o
> > +obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
> > +88pm800-regulator-objs               := 88pm800.o
>
> Don't do this, no need for this driver to look different to all the
> others in the Makefile - just rename the whole file.

Thank you for your review, I'll rework and resend v2 shortly.

Cheers,
Anders
