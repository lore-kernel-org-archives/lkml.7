Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB4CA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1A921744
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572274498;
	bh=bDAkpnmPbY0ZEBQT9bdhKA6sZJqE13qWHCAXPLM5+Zc=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=dl3Yr7wER/Zjg0r/qC0QIIFRrxtItzh8MbtgfcAzOYCXl2fKr3hfk146jvjmQRYZl
	 5ShRlpHIFEretKjMwngIi5IJBa9XGxp28hZ5sHpWG0tc7OMIDSWNIa9DvO6sRUI6js
	 5yhP7vzYNukhA12jWkPx76DQbd45AQ9eqkOZS1Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390400AbfJ1Oy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:54:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfJ1Oy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:54:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD1C208C0;
        Mon, 28 Oct 2019 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572274496;
        bh=bDAkpnmPbY0ZEBQT9bdhKA6sZJqE13qWHCAXPLM5+Zc=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=G8qf+aG5E6ldgTjwdWHE20INP+M/SELSiDe4GvmI/hK2p3D/89WvwEef/IijeN5oi
         QaAYABonL9IlTYVfWZVrAadRdr5eCdUOrhy7wUz8/ewOxgBxrSZDa73NnLaA7zvoH9
         jKCjw+Rq1/nQDzxl8EpspAyAIZICYMWdE1LURhAk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191005200521.GB4254@piout.net>
References: <20190920153906.20887-1-alexandre.belloni@bootlin.com> <20190924122147.fojcu5u44letrele@pengutronix.de> <20190924202015.EFEBF20640@mail.kernel.org> <20191005200521.GB4254@piout.net>
Cc:     u.kleine-koenig@pengutronix.de,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: avoid sleeping early
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
User-Agent: alot/0.8.1
Date:   Mon, 28 Oct 2019 07:54:55 -0700
Message-Id: <20191028145455.ECD1C208C0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-10-05 13:05:21)
> On 24/09/2019 13:20:15-0700, Stephen Boyd wrote:
> > Quoting Uwe  (2019-09-24 05:21:47)
> > > On Fri, Sep 20, 2019 at 05:39:06PM +0200, Alexandre Belloni wrote:
> > > > Note that this was already discussed a while ago and Arnd said this=
 approach was
> > > > reasonable:
> > > >   https://lore.kernel.org/lkml/6120818.MyeJZ74hYa@wuerfel/
> > > >=20
> > > >  drivers/clk/at91/clk-main.c |  5 ++++-
> > > >  drivers/clk/at91/sckc.c     | 20 ++++++++++++++++----
> > > >  2 files changed, 20 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/drivers/clk/at91/clk-main.c b/drivers/clk/at91/clk-mai=
n.c
> > > > index f607ee702c83..ccd48e7a3d74 100644
> > > > --- a/drivers/clk/at91/clk-main.c
> > > > +++ b/drivers/clk/at91/clk-main.c
> > > > @@ -293,7 +293,10 @@ static int clk_main_probe_frequency(struct reg=
map *regmap)
> > > >               regmap_read(regmap, AT91_CKGR_MCFR, &mcfr);
> > > >               if (mcfr & AT91_PMC_MAINRDY)
> > > >                       return 0;
> > > > -             usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_MAX_WAIT=
);
> > > > +             if (system_state < SYSTEM_RUNNING)
> > > > +                     udelay(MAINF_LOOP_MIN_WAIT);
> > > > +             else
> > > > +                     usleep_range(MAINF_LOOP_MIN_WAIT, MAINF_LOOP_=
MAX_WAIT);
> > >=20
> > > Given that this construct is introduced several times, I wonder if we
> > > want something like:
> > >=20
> > >         static inline void early_usleep_range(unsigned long min, unsi=
gned long max)
> > >         {
> > >                 if (system_state < SYSTEM_RUNNING)
> > >                         udelay(min);
> > >                 else
> > >                         usleep_range(min, max);
> > >         }
> > >=20
> >=20
> > Maybe, but I think the intent is to not encourage this behavior? So
> > providing a wrapper will make it "easy" and then we'll have to tell
> > users to stop calling it. Another idea would be to make usleep_range()
> > "do the right thing" and call udelay if the system isn't running. And
> > another idea from tlgx[1] is to pull the delay logic into another clk op
> > that we can call to see when the enable or prepare is done. That may be
> > possible by introducing another clk_ops callback that when present
> > indicates we should sleep or delay for so much time while waiting for
> > the prepare or enable to complete.
> >=20
> > [1] https://lkml.kernel.org/r/alpine.DEB.2.11.1606061448010.28031@nanos
> >=20
>=20
> Do you want me to implement that now or are you planning to apply the
> patch in the meantime ?
>=20
>=20
=20
I'll just apply this for now to clk-fixes and merge it up next week. It
would be great to do the other idea though, as a long term effort to
reduce all the busy loop code we have in clk drivers. No worries, I'll
put it on the todo list.

