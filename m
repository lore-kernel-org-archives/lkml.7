Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D0C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1C621473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZcN2e49m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFNMGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:06:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43569 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfFNMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:06:38 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so5093678ios.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 05:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dV/TN56tvtkshednW+FR3TYUMeR7LNkhJIJyPcztGuQ=;
        b=ZcN2e49mct35/m0fC0Bk4nbq0vVLZywYLxKLRo2uHlF5EhUnLtkkIv355WOKHFKGgb
         J01Wq8pOvuHMiwJThf2Ejb05s3co10a3TNB8r+QvphUXGbk5Uh7rpEB7QSCE8XU4sE1I
         2zCGaCefXOtG5SsSDzfDmE7oQrrECjcqoTUow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dV/TN56tvtkshednW+FR3TYUMeR7LNkhJIJyPcztGuQ=;
        b=f8GdDHRQ2jbpzHmqFvWUlKcTAIf+Wci4Aeqc9wWJoKCpeGKVNkIRxefILTKvzvxS1M
         rCNbTtZ0L2CLu1f4xYnb1BxIYRLzu98ktdetv+IjFPPQtjKq2waEQjicrfiXTpsr54gj
         NNzgd4NwF0Qfpe2Fee+scGnDbdW41BUHOfl5CUpkr+kUyeK4IihhtoWjIkeKPAl/jX8y
         +9Px8SiARcGHA3FvKfd6pDdnZaYnm211oKd57SqqV+NOLhG05UyZZuG3QQvxdeEweLC3
         5AHWMcI1QuZrIaGh/gz7OZvcGauVK6kDJynSyust08tJPcoj2QzpvQiTyrAwLRfrGvHn
         4JyA==
X-Gm-Message-State: APjAAAVz3ZdtqznrcAiaWt4kek++YqKME5OogZrQyg0YQXv79EG6gp9d
        MZtzuIsIE4LVWcb8F8ZfnSMc58LYxJ4NLJF78sqyfQ==
X-Google-Smtp-Source: APXvYqzd3RL+iPjapmaxAdyvWMQJF7lG1MDH2O7AA77mNOJAARM4fauuhUSG4Vu+ikv2M3ZUTkZw+Wyq92aI3r6eLBo=
X-Received: by 2002:a6b:5115:: with SMTP id f21mr5692335iob.173.1560513997259;
 Fri, 14 Jun 2019 05:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
 <20190613185241.22800-3-jagan@amarulasolutions.com> <CAGb2v65xuXc4C1jOyM1GbEFVDam5P-6NN0ZhtzwzA7qU5F3nJQ@mail.gmail.com>
 <CAGb2v67DY534hXrx2H4jnZXA7jJS7sq2UwYCqw1iAgyLKdNzgA@mail.gmail.com>
 <CAMty3ZBc-AqbNGZCxRhOPw46iMvEZxoq1oATA46=K29gRYi4Sg@mail.gmail.com> <CAGb2v6466QSF1wJ_wJsVwAgHsnLXD9GAwbPQtXcTDq4aqAeEfQ@mail.gmail.com>
In-Reply-To: <CAGb2v6466QSF1wJ_wJsVwAgHsnLXD9GAwbPQtXcTDq4aqAeEfQ@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 14 Jun 2019 17:36:26 +0530
Message-ID: <CAMty3ZC39yQs+_Cytp25xJO9Da0FWkC9g1VwYmzQZSGNoWc-yw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/9] drm/sun4i: tcon: Add TCON LCD support
 for R40
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

On Fri, Jun 14, 2019 at 4:32 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Fri, Jun 14, 2019 at 6:56 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Fri, Jun 14, 2019 at 9:05 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Fri, Jun 14, 2019 at 11:19 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > > >
> > > > On Fri, Jun 14, 2019 at 2:53 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > > >
> > > > > TCON LCD0, LCD1 in allwinner R40, are used for managing
> > > > > LCD interfaces like RGB, LVDS and DSI.
> > > > >
> > > > > Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
> > > > > tcon top.
> > > > >
> > > > > Add support for it, in tcon driver.
> > > > >
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > >
> > > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > >
> > > I take that back.
> > >
> > > The TCON output muxing (which selects whether TCON LCD or TCON TV
> > > outputs to the GPIO pins)
> > > is not supported yet. Please at least add TODO notes, or ideally,
> >
> > Are you referring about port selection? it is support in
> > sun8i_tcon_top_de_config.
>
> No. That's supported as you already pointed out. That only selects
> which mixer outputs to which TCON.
>
> I'm talking about the GPIOD and GPIOH bits, which select which of
> LCD or TV TCON outputs to the LCD function pins. Keep in mind that
> the TV TCON's H/V SYNC signals are used in combination with the
> TV encoder RGB outputs for VGA.

Got it, so do I need to add TODO on sun8i_r40_lcd_quirks struct?
