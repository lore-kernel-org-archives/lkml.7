Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3946BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06761207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568998366;
	bh=TYstjFpPpmJlXXPM8BgcwsN3SWwWCF707s2P3uizfwk=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=oJGhzyfke+g2yKyqiGXLsxfgBsSpCeIe0Ml2hbDgGGm6lE0dSVp3PgOGjqfS1CdG8
	 e4ytQsVtbiJVEPdDfHp//VHeuJsm96M32ZSL/GLPsODq9GL1zD8BAxWei1g+Sl4dbz
	 5PmGemSP2Lvp1dTN/oKSD6eA5WMKiwawcX70k8/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405217AbfITQwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404658AbfITQwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:52:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C8BB207FC;
        Fri, 20 Sep 2019 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568998363;
        bh=TYstjFpPpmJlXXPM8BgcwsN3SWwWCF707s2P3uizfwk=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=0JoVOOxQBmIIvROvdiQqjgNG0IVfCMPOzHRIqpFM4J+X8aI3tOc6/GqDoGvuAD7b+
         W1N1tvawHZdnGOKDoCELxkcxaAbcB5W7P2pDeIVG0L0cx9EZm934l+NS0DiT84+T48
         yTDO8/XrcVZmt9fc2wBxlbAaT1M2AOWZq2xDww8g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2551a729-5379-e039-4d5a-a83fa877fb14@baylibre.com>
References: <20190919093627.21245-1-narmstrong@baylibre.com> <20190919093809.21364-1-narmstrong@baylibre.com> <1j1rwce8yf.fsf@starbuckisacylon.baylibre.com> <20190919170610.541D620644@mail.kernel.org> <2551a729-5379-e039-4d5a-a83fa877fb14@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/3] clk: meson: clk-pll: always enable a critical PLL when setting the rate
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 09:52:42 -0700
Message-Id: <20190920165243.2C8BB207FC@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2019-09-20 01:06:58)
> Hi Stephen,
>=20
> On 19/09/2019 19:06, Stephen Boyd wrote:
> > Quoting Jerome Brunet (2019-09-19 06:01:28)
> >> On Thu 19 Sep 2019 at 11:38, Neil Armstrong <narmstrong@baylibre.com> =
wrote:
> >>
> >>> Make sure we always enable a PLL on a set_rate() when the PLL is
> >>> flagged as critical.
> >>>
> >>> This fixes the case when the Amlogic G12A SYS_PLL gets disabled by the
> >>> PSCI firmware when resuming from suspend-to-memory, in the case
> >>> where the CPU was not clocked by the SYS_PLL, but by the fixed PLL
> >>> fixed divisors.
> >>> In this particular case, when changing the PLL rate, CCF doesn't hand=
le
> >>> the fact the PLL could have been disabled in the meantime and set_rat=
e()
> >>> only changes the rate and never enables it again.
> >>>
> >>> Fixes: d6e81845b7d9 ("clk: meson: clk-pll: check if the clock is alre=
ady enabled')
> >>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >>> ---
> >>>  drivers/clk/meson/clk-pll.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> >>> index ddb1e5634739..8c5adccb7959 100644
> >>> --- a/drivers/clk/meson/clk-pll.c
> >>> +++ b/drivers/clk/meson/clk-pll.c
> >>> @@ -379,7 +379,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *=
hw, unsigned long rate,
> >>>       }
> >>> =20
> >>>       /* If the pll is stopped, bail out now */
> >>> -     if (!enabled)
> >>> +     if (!(hw->init->flags & CLK_IS_CRITICAL) && !enabled)
> >>
> >> This is surely a work around to the issue at hand but:
> >>
> >> * Enabling the clock, critical or not, should not be done but the
> >> set_rate() callback. This is not the purpose of this callback.
> >>
> >> * Enabling the clock in such way does not walk the tree. So, if there =
is
> >> ever another PSCI Fw which disable we would get into the same issue
> >> again. IOW, This is not specific to the PLL driver so it should not ha=
ve
> >> to deal with this.
> >=20
> > Exactly.
> >=20
> >>
> >> Since this clock can change out of CCF maybe it should be marked with
> >> CLK_GET_RATE_NOCACHE ?
> >=20
> > Yes, or figure out a way to make the clk state match what PSCI leaves it
> > in on resume from suspend.
> >=20
> >=20
> >>
> >> When CCF hits a clock with CLK_GET_RATE_NOCACHE while walking the tree,
> >> in addition to to calling get_rate(), CCF could also call is_enabled()
> >> if the clock has CLK_IS_CRITICAL and possibly .enable() ?
> >=20
> > This logic should go under a new flag. The CLK_GET_RATE_NOCACHE flag
> > specifically means get rate shouldn't be a cached operation. It doesn't
> > relate to the enable state. I hope that you can implement some sort of
> > resume hook that synchronizes the state though so that you don't need to
> > rely on clk_set_rate() or clk_get_rate() to trigger a sync.
> >=20
>=20
> It's exactly the goal of [1] where I resync a clock tree after a resume.

Ok. I haven't looked at that series yet. We can move this discussion
there if you like.

>=20
> But I don't check the enable state, would you mean that:
> if core->ops->enable && core->enable_count > 0 && !clk_core_is_enabled(co=
re)
>     core->ops->enable(core->hw)
>=20
> along the parent/rate resync ?
>=20
> Isn't that dangerous ?
>=20

Why is it dangerous? If the clk state is lost across suspend/resume we
need to restore the state of the clk somehow. One way would be to have
the clk driver tell the framework that this clk is now off and to drop
the enable counts for any consumers. Then consumers will need to call
clk_enable() again to turn the clk back on in the consumer resume
callback. Or we can try to be smarter/nicer and restore the clk state to
what the consumer is expecting across suspend/resume. I haven't thought
about what is better or worse.

On the one hand, device drivers already handle some things not being
saved/restored during system low power modes. But on the other hand I
don't know what the policy is for external resources that a device uses,
such as clks or regulators or pinctrl muxing, etc.

