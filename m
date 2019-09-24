Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F4C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6C2214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569356417;
	bh=1CorAmS8XtFV4yXtNftl8NnpMjYiQ/U6EHGYysnVmmQ=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=TMHi/UxY+hQt1SzCQi5mbO9Y0iC8BztPWnZLosk9G/f7xaPhJyBCqhS5Bv7Z1m56N
	 r5mc+cr0i/2OD1blbD0WJ5owNKywAjRm1lMHrmnc+4POfslpyemRPasOw4CVTzhsAp
	 rTdTFXiQgpJxp4TMpKAPNhQIcamk+W1r1u7UCAsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbfIXUUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 16:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbfIXUUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:20:16 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFEBF20640;
        Tue, 24 Sep 2019 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569356416;
        bh=1CorAmS8XtFV4yXtNftl8NnpMjYiQ/U6EHGYysnVmmQ=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=T3Vd7fmkABMggKs4QJTa2QS19/Mp7JeXBuGWJlrfj3AFrKdWzVDNxkS27ltN080+7
         PForK+42VCuwL8nN5QWwd2rPhWVhehGEznqoSpWz83fT9hZnFIx4GKMAy5tJp/gpMe
         MuKGeKUfk4UUuysJNCgXkDzyWtCaFhrUZebjkbOI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190924122147.fojcu5u44letrele@pengutronix.de>
References: <20190920153906.20887-1-alexandre.belloni@bootlin.com> <20190924122147.fojcu5u44letrele@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <u.kleine-koenig@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: avoid sleeping early
User-Agent: alot/0.8.1
Date:   Tue, 24 Sep 2019 13:20:15 -0700
Message-Id: <20190924202015.EFEBF20640@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe  (2019-09-24 05:21:47)
> On Fri, Sep 20, 2019 at 05:39:06PM +0200, Alexandre Belloni wrote:
> > Note that this was already discussed a while ago and Arnd said this app=
roach was
> > reasonable:
> >   https://lore.kernel.org/lkml/6120818.MyeJZ74hYa@wuerfel/
> >=20
> >  drivers/clk/at91/clk-main.c |  5 ++++-
> >  drivers/clk/at91/sckc.c     | 20 ++++++++++++++++----
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-main.c
> > index f607ee702c83..ccd48e7a3d74 100644
> > --- a/drivers/clk/at91/clk-main.c
> > +++ b/drivers/clk/at91/clk-main.c
> > @@ -293,7 +293,10 @@ static int clk_main_probe_frequency(struct regmap =
*regmap)
> >               regmap_read(regmap, AT91_CKGR_MCFR, &mcfr);
> >               if (mcfr & AT91_PMC_MAINRDY)
> >                       return 0;
> > -             usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT);
> > +             if (system_state < SYSTEM_RUNNING)
> > +                     udelay(MAINF_LOOP_MIN_WAIT);
> > +             else
> > +                     usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_=
WAIT);
>=20
> Given that this construct is introduced several times, I wonder if we
> want something like:
>=20
>         static inline void early_usleep_range(unsigned long min, unsigned=
 long max)
>         {
>                 if (system_state < SYSTEM_RUNNING)
>                         udelay(min);
>                 else
>                         usleep_range(min, max);
>         }
>=20

Maybe, but I think the intent is to not encourage this behavior? So
providing a wrapper will make it "easy" and then we'll have to tell
users to stop calling it. Another idea would be to make usleep_range()
"do the right thing" and call udelay if the system isn't running. And
another idea from tlgx[1] is to pull the delay logic into another clk op
that we can call to see when the enable or prepare is done. That may be
possible by introducing another clk_ops callback that when present
indicates we should sleep or delay for so much time while waiting for
the prepare or enable to complete.

[1] https://lkml.kernel.org/r/alpine.DEB.2.11.1606061448010.28031@nanos

