Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988DCC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD102081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMU6oJeE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfFDPHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:07:15 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43484 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbfFDPHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:07:14 -0400
Received: by mail-yb1-f196.google.com with SMTP id n145so8065222ybg.10;
        Tue, 04 Jun 2019 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=23p9X9zBoSMLGhknvca0JK5D4XHYNE8yPKnQx10h6s8=;
        b=gMU6oJeE2lr6pV13r9GGAJIls9j+xGhfH0N/YjegqEmi2Wny9VODN1HATKDWkH98BQ
         AG/aum3OvI4aBAZptlFlJRuuWaYXbfX2a87hgMyJuI0gvZOERQUVonoFnJUiZ662yeXv
         e0tnOUb6D+BToERRPNvFqhdSzuECtMnoOHj08NROLZJjMHB9Up8n8x5Z6BZK6UqQfO+T
         8bpCwNyY/n5iEQLE8VHO9WdHjUkWKh0rArmfu0L90LvAxqvCr1ebFUMwQ+LGFUkH8pQO
         wVQXlffY2Jc8XKjEniPGRT4RL79S0+QbXDpwlFVEOVt4cbSaoM5hJaKRi2cMfeMEC6Eb
         0BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=23p9X9zBoSMLGhknvca0JK5D4XHYNE8yPKnQx10h6s8=;
        b=ICa0FN85WZOF5I0bNx4D5koAhvhXQjQUp5d5RmqYBw3MjUzfTAILpGZ3SwwLzJQa8g
         nWjJ57MvSBFXazOvKMvtQWgXYb6UXSz21sefggZfyV74bDYuJ0dFaskF/u8j/+I/xw5R
         /93Rsv0QJYrHe1DfwbsoDeewHIpMIzZvqmtBqdXX1ba+LiQ4e4BZmZB1oj96jnbPg3PI
         S8GM8pRo/gM7GLYp0dP8blUoeTWKzafWJN5r01wCvlP87+dba3hZNUWqAXuI6OGshyTf
         foTwVwLmf5iX4FEs0TbnLGCk4kiZ929t16KagRcc8qEfKGjAALcl1Otw5IiXKc6G0oYk
         Yvzg==
X-Gm-Message-State: APjAAAUp1QLD7b9hpfVuaNBc+SPi5Zp8AqAuTxpnedABtzwyTeXkPtkp
        Anpb85/IAUBwfPNwbJ1HH/oJlMPy4HLxBaroAgY=
X-Google-Smtp-Source: APXvYqyQUaxTBUErXW8OWKn+Up7TUX7BWxL7hCytLPrZDa8lAjAfPNRBZ7nQkbkj0mdpWkAcIxEOHvjkK+ra37fLLBI=
X-Received: by 2002:a25:28e:: with SMTP id 136mr390734ybc.127.1559660833492;
 Tue, 04 Jun 2019 08:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190528161440.27172-1-peron.clem@gmail.com> <20190528161440.27172-4-peron.clem@gmail.com>
 <20190604145430.xqufpyosetgb4bo7@core.my.home>
In-Reply-To: <20190604145430.xqufpyosetgb4bo7@core.my.home>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 4 Jun 2019 17:07:02 +0200
Message-ID: <CAJiuCceqATLiDjpNLTq+gOhUHun40udJdpXYirn=Z=GVQLQzaw@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] media: rc: sunxi: Add A31 compatible
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 4 Jun 2019 at 16:54, Ond=C5=99ej Jirman <megous@megous.com> wrote:
>
> On Tue, May 28, 2019 at 06:14:31PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Allwiner A31 has a different memory mapping so add the compatible
> > we will need it later.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/media/rc/sunxi-cir.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.=
c
> > index d02dcb6fd0a5..0504ebfc831f 100644
> > --- a/drivers/media/rc/sunxi-cir.c
> > +++ b/drivers/media/rc/sunxi-cir.c
> > @@ -343,6 +343,11 @@ static const struct sunxi_ir_quirks sun5i_a13_ir_q=
uirks =3D {
> >       .fifo_size =3D 64,
> >  };
> >
> > +static const struct sunxi_ir_quirks sun6i_a31_ir_quirks =3D {
> > +     .has_reset =3D true,
> > +     .fifo_size =3D 64,
> > +};
> > +
>
> BTW, H6 BSP uses FIFO size 40:
>
> https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/drive=
rs/media/rc/sunxi-ir-dev.c#L290
>
> Have you tried filling the fifo with over 40 words on H6, to see if it wo=
rks?
No I didn't try this, but I trust more the user manual than the driver.
And I don't see why they would have reduce the fifo size in the new generat=
ion.
Anyway, I will be able to test that at the end of the week.

Regards,
Cl=C3=A9ment

> I know it's docummented as having 64 words in the manual, so maybe Allwin=
er
> just didn't care enough to make the driver configurable, and the H6
> FIFO really has that depth.
>
> regards,
>         o.
>
> >  static const struct of_device_id sunxi_ir_match[] =3D {
> >       {
> >               .compatible =3D "allwinner,sun4i-a10-ir",
> > @@ -352,6 +357,10 @@ static const struct of_device_id sunxi_ir_match[] =
=3D {
> >               .compatible =3D "allwinner,sun5i-a13-ir",
> >               .data =3D &sun5i_a13_ir_quirks,
> >       },
> > +     {
> > +             .compatible =3D "allwinner,sun6i-a31-ir",
> > +             .data =3D &sun6i_a31_ir_quirks,
> > +     },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, sunxi_ir_match);
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
