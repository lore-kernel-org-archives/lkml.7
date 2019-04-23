Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F01C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D8B218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556061575;
	bh=7uAIycoYHirFeTIwCI/9YmG4XY3/OWp/IWt9t09frXk=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=VsMstl5llRF3AbKMtfxwXD7LiO8kdBqb2P1viBWJnlbbjqxr8PgPelwHOPd8Y3vdV
	 RnyznD1ilKFCjD7Zog3G6WOYERSbU0d0raHgbyyqClFQudl9ayablLG3zK0m05cKLx
	 G9q4p03KZgF8m/2nX8Za8qwFYejdD/q4fj1hbA0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfDWXTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfDWXTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:19:33 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03B9218D2;
        Tue, 23 Apr 2019 23:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556061572;
        bh=7uAIycoYHirFeTIwCI/9YmG4XY3/OWp/IWt9t09frXk=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=AKi916tbdMICRBrcHhs6oQXyemFVFkBWYywTr2Yhi4nKff0N/bf2HyJFUkP1JDaL3
         nROvgQjZB6BN9T2atN7oXhlilOWlsdLLQd7BO8bVrxcoAcykAyx365OA2pfo0NPoOW
         kbrRE4U0zsu/mgL5/fshh6WBCwtmuF53XFg50TiQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEG3pNB-143Pr_xCTPj=tURhpiTiJqi61xfDGDVdU7zG5H-2tA@mail.gmail.com>
References: <20190325111200.15940-1-jbrunet@baylibre.com> <20190325111200.15940-2-jbrunet@baylibre.com> <155353381842.20095.17915880223118004926@swboyd.mtv.corp.google.com> <8b6f0bc6210834af2aff2de7dc95692dd87db539.camel@baylibre.com> <155389767798.20095.10570017301900287354@swboyd.mtv.corp.google.com> <6ef984dabf626760ae606567facdc5245fbba984.camel@baylibre.com> <CAEG3pNCrANkLBeEA_wVU7n4U57X3sd-1EzhUZ_PHBryqPHoAaQ@mail.gmail.com> <155449701325.20095.2265240732374772927@swboyd.mtv.corp.google.com> <7bd9dd9123779165cc172853ae7ee6d3d63c329f.camel@baylibre.com> <CAEG3pNB-143Pr_xCTPj=tURhpiTiJqi61xfDGDVdU7zG5H-2tA@mail.gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Emilio Lopez <emilio@elopez.com.ar>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/4] clk: meson: mpll: add init callback and regs
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155606157109.15276.17674168789529018388@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 23 Apr 2019 16:19:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Turquette (2019-04-23 10:34:13)
> On Mon, Apr 8, 2019 at 9:38 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> > If removing .init() is important for you, I would prefer to help guys. =
That
> > being said, we need a decent solution to some use case if this is going=
 to
> > work.
> >
> > I'll illustrate with examples from the meson code but I think they repr=
esent
> > fairly common cases:
> >
> > 1) clk-pll: Without the work done init(), the pll just won't lock ...
> >
> > I agree that we would see the problem when the clock is finally enabled=
, so we
> > could do "init" sequence in .prepare() each time it is called. The sequ=
ence
> > might be "long" (with a couple of delays in it) so doing it on each cal=
l to
> > .prepare() is wasting time but it could work.
> >
> > Something like .prepare_once would help for this.
> >
> > 2) clk-mpll: Without the work done in .init(), the fractional part of t=
he
> > divider will not work, only the integer part works =3D> the rate calcul=
ated is
> > off by a significant margin. IOW, until the initial setup is done, the =
result
> > of .recalc_rate() is off and cannot be trusted.
> >
> > .prepare() (and .prepare_once() if called a the same stage) is too late=
. We
> > would need something that runs before any call to .recalc_rate() is mad=
e.
> >
> > We could also think about clocks with the ability to observe and feedba=
ck
> > (read-only) on the actual output signal. Such thing might need an initi=
al()
> > setup as well.
> >
> > 3) sclk: This is a kind of divider which gates when the value is zero. =
We need
> > to save the divider value on .disable() to restore it on .enable(). In
> > .init(), if divider value is 0 (gated) we init cached value to the maxi=
mum
> > divider value. This done so a call to .enable() works, even without pri=
or
> > calls to .set_rate().
> >
> > Here, again, I think .prepare() is a too late.
> >
> > Maybe it is a bit extreme but we could also think about weird muxes not
> > reporting the parent accurately until some prior setting is done. For t=
hose
> > you need something that runs before all the orphan mechanism in the clo=
ck
> > register.

Well I wonder if it would work to do something on clk_get() path. At
that point, we've decided that a consumer is going to be able to use the
clk and so we can clearly define that this is the last moment to do any
final setup/configuration before handing out a pointer to a consumer.
There are still the other cases you talk about though where
.recalc_rate() wouldn't work, and we would need to do this configuration
before we calculate the rate of this clk when registering it. Seems to
be an argument for .init or the rename of it sticking around.

> >
> > Whatever the name we give it, It think it would help if we had a (not
> > discouraged) callback that is guaranteed to run before anything else is=
 called
> > on the clock. This is what I tried to do with 541debae0adf ("clk: call =
the
> > clock init() callback before any other ops callback").
> >
> > Having the counterpart callback, guaranteed to run last, would allow a =
clock
> > to allocate (and de-allocate) stuff. It would be an interesting additio=
n IMO.
> > For clocks which needs to store things (such as sclk), it would allow t=
o take
> > the runtime data out of the init data.
> >
> > What about .register() and .deregister() ? It would map nicely to the C=
CF API
> > ?
>=20
> I like .register & .deregister.
>=20
> I propose that we merge your .init to keep things moving BUT ONLY if
> you pinky swear to follow up with .register & .deregister conversion
> and convert all existing .init users over to .register. Deal?
>=20
> Stephen, thoughts?
>=20

Ok. I'd like to see the semantics of .register and .deregister
(.unregister?) be well defined, especially around what locks are held
when the op is called (do both prepare and enable locks need to be
held?) and what state the clk is in (can it be an orphan?).
Alternatively, we can retroactively do that for the .init op and then
introduce the other ops if drivers don't need this. Then we're just
making .init more official and not shunned, which is also fine.

This crude grep only finds a few clks that use the init op.

$ git grep -W 'struct clk_ops .*=3D' | grep "\.init =3D"
drivers/clk/mmp/clk-frac.c-     .init =3D clk_factor_init,
drivers/clk/mmp/clk-mix.c-      .init =3D mmp_clk_mix_init,
drivers/clk/qcom/clk-hfpll.c-   .init =3D clk_hfpll_init,
drivers/clk/rockchip/clk-pll.c- .init =3D rockchip_rk3036_pll_init,
drivers/clk/rockchip/clk-pll.c- .init =3D rockchip_rk3066_pll_init,
drivers/clk/rockchip/clk-pll.c- .init =3D rockchip_rk3399_pll_init,
drivers/clk/rockchip/clk.c-             frac_mux->hw.init =3D &init;

