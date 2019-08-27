Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07DAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1192173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct0UXygt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfH0Igk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:36:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35745 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfH0Igj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:36:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id h27so8603121lfp.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYGEJ93XPP3XlNiRaHwzesAlOb+UBzf8KsHsim6XvxI=;
        b=Ct0UXygt1kSUuk3nnThiTMEqPxe32CYU1MxV5dvmU5LU6bCGsqWFpyukGY4y2po86m
         h5GqJrtoo+mT42PhpQrodQCupYzjzJwXUQQ6FyPlU2V5CK8mgqEOO/JBffmlF+dJ0yS9
         H1xndqUIwIck3VB+GRR0VJrpMESLRLHoBt1j599nZtN3D1CS27J4b167bKFZ20Jo+BsK
         mdm6nWTfW/GiAfCOzGE9ryKCng4leRfnCynTw5tjn/21ykX+sprrBb7gOF+xMHUDdtDF
         25Du/NxyikkhkPbgQe0o22mwYfxt/ZIn/7KUOwtqXwKXOAhyQ85N+Kx8MMmff5KfYu0h
         mDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYGEJ93XPP3XlNiRaHwzesAlOb+UBzf8KsHsim6XvxI=;
        b=j6yutrm2ziufaRLgwStYzWxEF5EXQmOFZS49cWbf+KPOlALCDY9dLxM/ekINO1y8Em
         aKQUe24PeRtZoTOGA3P9palR+Pq/9BzCC2Cux+s4ZB/sCfDmaeaeVsMsgHLXAQyRyMGp
         h60WItvztzLMx/zyIlJXADZKDiuD+fJKcRsDzj/qR0bZF6jMF6f0lyz2RZAFbR6i6IyL
         hFGRpZMTRiKOXJQS0K1uUayP0SkWgjn8mQSJkcWV+z4TTv6YFBldX5T/yDkiD302B5lw
         ifxbTs0C7ZnRiPBNyfcisnHu70vblKlffzxIO4nI7jNeXPTFilF9zpD5+9lpXTBHXiJd
         YEmw==
X-Gm-Message-State: APjAAAWLYdDs1qk91xZj6y1eUS7ZW/J2hKUFY6P9K2GsTHuQAktZ5q6E
        nkdFfspDgNe/7T2nOSpu+i+NU7OIJbSSeJSdgIFZvQ==
X-Google-Smtp-Source: APXvYqzMRlXMP/h79lMj8x7VcxyCeKa4vaXpALmTduH57IprgLhHb0OOOFWSwRLPh/SWv0zfOViVEeAbKR/rNE7qeP4=
X-Received: by 2002:ac2:5297:: with SMTP id q23mr13197208lfm.78.1566894997978;
 Tue, 27 Aug 2019 01:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190826180734.15801-1-codekipper@gmail.com> <20190826180734.15801-4-codekipper@gmail.com>
 <20190827070101.tastgcqvzrgv3kc5@flea>
In-Reply-To: <20190827070101.tastgcqvzrgv3kc5@flea>
From:   Code Kipper <codekipper@gmail.com>
Date:   Tue, 27 Aug 2019 10:36:26 +0200
Message-ID: <CAEKpxBnCzC5hX+b4UMPpKLzKyABZ0e07RwZvULfauphzC4x7=A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] ASoC: sun4i-i2s: Adjust LRCLK width
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 at 09:01, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Aug 26, 2019 at 08:07:34PM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Some codecs such as i2s based HDMI audio and the Pine64 DAC require
> > a different amount of bit clocks per frame than what is calculated
> > by the sample width. Use the values obtained by the tdm slot bindings
> > to adjust the LRCLK width accordingly.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 056a299c03fb..0965a97c96e5 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -455,7 +455,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> >               break;
> >
> >       case SND_SOC_DAIFMT_I2S:
> > -             lrck_period = params_physical_width(params);
> > +             if (i2s->slot_width)
> > +                     lrck_period = i2s->slot_width;
> > +             else
> > +                     lrck_period = params_physical_width(params);
> >               break;
>
> That would be the case with the DSP formats too, right?

Maybe....but I need a TDM test volunteer!,
CK
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
