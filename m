Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CBFC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC4A204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xkg3tPCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfEZTAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:00:42 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36956 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEZTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:00:42 -0400
Received: by mail-yw1-f67.google.com with SMTP id 186so5804965ywo.4;
        Sun, 26 May 2019 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ozbpBHH7tRCrsdtMEQjsQDlxSXHNruEgExveiJhJ0fo=;
        b=Xkg3tPCAZXTRWbYvkia1rPlSLig1Y7GQZ4mFLN0JUZWf8a7xttjpv80JLmoXWsOBbI
         0z5tsEfJ5nw5U0tJswI6KRnYhiqLRxuwKaeoE6H4UWUH/smXoDXabl5oLPh2ynvTLh8c
         wnqxAo2TCmsdS+P71y14Di7yBEB7eOjOMPlaJWe9hUW39slwAWULG8sF7qwmdNQWv/sj
         HzjypXp6N0DZ270bB+5GuMoPT4yQI8gq860sBzESkWOj82dBBSZ2n+2pp8Heap0BI9u7
         dzm4duCz3dWwXIQ5z/MCEiOFu/09RivNT5GdjFnr2W5UnUxoBL2neIt5NZ8/hy8oXPRy
         i2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ozbpBHH7tRCrsdtMEQjsQDlxSXHNruEgExveiJhJ0fo=;
        b=hUhQ+HKZCJRQNPdFvhKSXujj3YmbpjTGXxsHDnLJyVzvElPjS3chwLd4fopP6JAcSO
         ggCXuBafLpJ5BKEo0Bdd5gu7P5mA6OeVo9C48qGcGH0K9KgYjJUqp1/OgpEDA5owLei5
         ZuGAAxWklNVH8i6D1WWYRStfKQAmANymAkNNmWxwIpMENr1uCu4CR42Fz98AR6WMIA8I
         m3wAbl696vnXN6Yupe1EVOd90a3xjXsiEh9gv1ALT5Um1pdNJt4IwWOSHiTynUu512EW
         EpOnk8hr6cAW4XUKWK0LJN59vd/NrbUvyFtO68yvjofGD+eXAuVRKCC4sywCdch2NHWt
         F9lg==
X-Gm-Message-State: APjAAAVu8q9GcbOBv2fzYs1XaNeqTNjeysyEEWVZfkjdL5ORf8oUYNdL
        GdOHWmrHMg7EEigbksw3roaq96Fhe69Nplfo9A4=
X-Google-Smtp-Source: APXvYqwkYlyYZ5uwbz25lwZOwmW3dEb1r4wBA/RfRkCDhUCYp59oYMFH5GkzlWv0BwlS71J2R9iK0ZxtOpmwQ6F8a0g=
X-Received: by 2002:a81:997:: with SMTP id 145mr7897486ywj.457.1558897241180;
 Sun, 26 May 2019 12:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190525162323.20216-1-peron.clem@gmail.com> <20190525162323.20216-4-peron.clem@gmail.com>
 <20190526182410.soqb6bne6w66d5j6@flea>
In-Reply-To: <20190526182410.soqb6bne6w66d5j6@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 26 May 2019 21:00:30 +0200
Message-ID: <CAJiuCce8UNbA+Ljkbw92ZJu3Ni6N9ciFKGsLtBYJ0_J8E1Gi2g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-spdif: Add TX fifo bit flush quirks
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Sun, 26 May 2019 at 20:24, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Sat, May 25, 2019 at 06:23:19PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Allwinner H6 has a different bit to flush the TX FIFO.
> >
> > Add a quirks to prepare introduction of H6 SoC.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-spdif.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdi=
f.c
> > index b6c66a62e915..8317bbee0712 100644
> > --- a/sound/soc/sunxi/sun4i-spdif.c
> > +++ b/sound/soc/sunxi/sun4i-spdif.c
> > @@ -166,10 +166,12 @@
> >   *
> >   * @reg_dac_tx_data: TX FIFO offset for DMA config.
> >   * @has_reset: SoC needs reset deasserted.
> > + * @reg_fctl_ftx: TX FIFO flush bitmask.
>
> It's a bit weird to use the same prefix for a register offset
> (reg_dac_tx_data) and a value (reg_fctl_ftx).

I just look at sun4i-codec and they use a regmap, But I think it's a
bit overkill no?

What do you think about val_fctl_ftx ?

Thanks for your review,
Cl=C3=A9ment

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
