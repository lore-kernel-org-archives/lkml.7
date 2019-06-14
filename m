Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65CFC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A6621473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfFNLCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:02:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39674 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfFNLCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:02:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so2914558edv.6;
        Fri, 14 Jun 2019 04:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L90M1yJRaEbJvP50zlp+g8JncxyhlOF+tsQgaXRymkc=;
        b=KBq6Hqu3T1ZsCKgQkIqQhXwYXs71219YICJwOKi+vOL3T7Uhm2dBVm/fpoxul+O7Wq
         2j7XAE8WJ0Itcns0kUzzLuOdP/lgotrEiM+G5cIwB6uVLV6YigK1ih+zV3CJSaGhMNO3
         htxB5a4l9WN0vpzTeVpfWKcmxxo+tDUmpkP6W1K3xWgCgzOWFGPuCEsw9zN46IMSqOTI
         uDD//oWtmnvqKjm+nKJtY84OioSq1mi24LyELUy4Wx2QJGluCStIBbaO8dhSBqagiuXW
         WmdlnMY9GT0fVZdcRiwLenbr0+mkakY4Y3DjwT1J6Ae0md4wDrfeJLpT1YkwL5mtosTd
         KUnw==
X-Gm-Message-State: APjAAAUX7QgIxAAYPVhcj0DnCf8xHahMkgb7I2rE+c9psBcLZykyfZFB
        8D6drOXhyRDuUC+vXBQuYNJnK+E9AD8=
X-Google-Smtp-Source: APXvYqyuFtXUCDQvwr66Ih64AQc43cDHtJjSbYhIWePDVG/9PGD95hlO2lP2sGlr8NPEQ4M8iqJztg==
X-Received: by 2002:a17:906:7c92:: with SMTP id w18mr55710134ejo.116.1560510152279;
        Fri, 14 Jun 2019 04:02:32 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id d44sm787079eda.75.2019.06.14.04.02.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 04:02:31 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id s3so1896266wms.2;
        Fri, 14 Jun 2019 04:02:31 -0700 (PDT)
X-Received: by 2002:a1c:c545:: with SMTP id v66mr7776405wmf.51.1560510151032;
 Fri, 14 Jun 2019 04:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
 <20190613185241.22800-3-jagan@amarulasolutions.com> <CAGb2v65xuXc4C1jOyM1GbEFVDam5P-6NN0ZhtzwzA7qU5F3nJQ@mail.gmail.com>
 <CAGb2v67DY534hXrx2H4jnZXA7jJS7sq2UwYCqw1iAgyLKdNzgA@mail.gmail.com> <CAMty3ZBc-AqbNGZCxRhOPw46iMvEZxoq1oATA46=K29gRYi4Sg@mail.gmail.com>
In-Reply-To: <CAMty3ZBc-AqbNGZCxRhOPw46iMvEZxoq1oATA46=K29gRYi4Sg@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 14 Jun 2019 19:02:18 +0800
X-Gmail-Original-Message-ID: <CAGb2v6466QSF1wJ_wJsVwAgHsnLXD9GAwbPQtXcTDq4aqAeEfQ@mail.gmail.com>
Message-ID: <CAGb2v6466QSF1wJ_wJsVwAgHsnLXD9GAwbPQtXcTDq4aqAeEfQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 2/9] drm/sun4i: tcon: Add TCON LCD support
 for R40
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

On Fri, Jun 14, 2019 at 6:56 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Fri, Jun 14, 2019 at 9:05 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Fri, Jun 14, 2019 at 11:19 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Fri, Jun 14, 2019 at 2:53 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > > >
> > > > TCON LCD0, LCD1 in allwinner R40, are used for managing
> > > > LCD interfaces like RGB, LVDS and DSI.
> > > >
> > > > Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
> > > > tcon top.
> > > >
> > > > Add support for it, in tcon driver.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >
> > I take that back.
> >
> > The TCON output muxing (which selects whether TCON LCD or TCON TV
> > outputs to the GPIO pins)
> > is not supported yet. Please at least add TODO notes, or ideally,
>
> Are you referring about port selection? it is support in
> sun8i_tcon_top_de_config.

No. That's supported as you already pointed out. That only selects
which mixer outputs to which TCON.

I'm talking about the GPIOD and GPIOH bits, which select which of
LCD or TV TCON outputs to the LCD function pins. Keep in mind that
the TV TCON's H/V SYNC signals are used in combination with the
TV encoder RGB outputs for VGA.

ChenYu
