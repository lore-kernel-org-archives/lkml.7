Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD64C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C95214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568912773;
	bh=FRD3cLqXl21dfjVTSUUFS+CztYthOlCax3P4tSmWNxo=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=igPgD1rzCM6HdCiQSK+UMFnFw+ovwx3mwSK0HApxHtIfOpGCkSYfyck9XwazWn19C
	 D7x6Bz1adMPaNk6NBE4qXYnerUIFpdcroBwq2dEbEzk3qB051zUXblDDcwUxkEPvvM
	 dB9WLfUL0ZjhiCXFnmDbY5sMUzoGCAm/Zll6es6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391521AbfISRGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391343AbfISRGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:06:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 541D620644;
        Thu, 19 Sep 2019 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568912770;
        bh=FRD3cLqXl21dfjVTSUUFS+CztYthOlCax3P4tSmWNxo=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=U6NcaTMNde1Oip6/3oJe2Rq3emdMiuBNKMTvl9ioWGPXRl0567TcrCjB/dvM+62er
         jUqNJLjhOvXukdqRUlbxxk+kS1rPQujQehuR0aGc7kYpxrkx4R0z3jQZwNaBbyDI6H
         BzVl2I+9DajPMLvWU9n4Taf829gZ04Hr9RLjV5FU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1j1rwce8yf.fsf@starbuckisacylon.baylibre.com>
References: <20190919093627.21245-1-narmstrong@baylibre.com> <20190919093809.21364-1-narmstrong@baylibre.com> <1j1rwce8yf.fsf@starbuckisacylon.baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/3] clk: meson: clk-pll: always enable a critical PLL when setting the rate
User-Agent: alot/0.8.1
Date:   Thu, 19 Sep 2019 10:06:09 -0700
Message-Id: <20190919170610.541D620644@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-09-19 06:01:28)
> On Thu 19 Sep 2019 at 11:38, Neil Armstrong <narmstrong@baylibre.com> wro=
te:
>=20
> > Make sure we always enable a PLL on a set_rate() when the PLL is
> > flagged as critical.
> >
> > This fixes the case when the Amlogic G12A SYS_PLL gets disabled by the
> > PSCI firmware when resuming from suspend-to-memory, in the case
> > where the CPU was not clocked by the SYS_PLL, but by the fixed PLL
> > fixed divisors.
> > In this particular case, when changing the PLL rate, CCF doesn't handle
> > the fact the PLL could have been disabled in the meantime and set_rate()
> > only changes the rate and never enables it again.
> >
> > Fixes: d6e81845b7d9 ("clk: meson: clk-pll: check if the clock is alread=
y enabled')
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  drivers/clk/meson/clk-pll.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> > index ddb1e5634739..8c5adccb7959 100644
> > --- a/drivers/clk/meson/clk-pll.c
> > +++ b/drivers/clk/meson/clk-pll.c
> > @@ -379,7 +379,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw=
, unsigned long rate,
> >       }
> > =20
> >       /* If the pll is stopped, bail out now */
> > -     if (!enabled)
> > +     if (!(hw->init->flags & CLK_IS_CRITICAL) && !enabled)
>=20
> This is surely a work around to the issue at hand but:
>=20
> * Enabling the clock, critical or not, should not be done but the
> set_rate() callback. This is not the purpose of this callback.
>=20
> * Enabling the clock in such way does not walk the tree. So, if there is
> ever another PSCI Fw which disable we would get into the same issue
> again. IOW, This is not specific to the PLL driver so it should not have
> to deal with this.

Exactly.

>=20
> Since this clock can change out of CCF maybe it should be marked with
> CLK_GET_RATE_NOCACHE ?

Yes, or figure out a way to make the clk state match what PSCI leaves it
in on resume from suspend.


>=20
> When CCF hits a clock with CLK_GET_RATE_NOCACHE while walking the tree,
> in addition to to calling get_rate(), CCF could also call is_enabled()
> if the clock has CLK_IS_CRITICAL and possibly .enable() ?

This logic should go under a new flag. The CLK_GET_RATE_NOCACHE flag
specifically means get rate shouldn't be a cached operation. It doesn't
relate to the enable state. I hope that you can implement some sort of
resume hook that synchronizes the state though so that you don't need to
rely on clk_set_rate() or clk_get_rate() to trigger a sync.

