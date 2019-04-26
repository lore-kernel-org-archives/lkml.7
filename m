Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A978CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781C02084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556239279;
	bh=GsFK9qZuv0FlaRjuXOccExgA31ahiLh6qHJ2B8nDco4=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=GaQU6tNfQLVdPwa9qtbZ29/ys874ajtAm6fNJi05ItWhqON15xXGEoDsZI7VdZ01n
	 ZClKrNUOYqMzuPWNQz5Oq9hmVIGVjkDLCakl8yZiam5Xf0vVejXWAcKZa2GGNfb+BL
	 zIAHRZ2zY2zyv0oCVLNJ5V7cgdCvjSiPYK7Q56ZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDZAlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfDZAlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:41:17 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FDB20878;
        Fri, 26 Apr 2019 00:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556239276;
        bh=GsFK9qZuv0FlaRjuXOccExgA31ahiLh6qHJ2B8nDco4=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=urKxPTmZAR1A/OIF3g68Ro0USKe2/uDQLMKmXtMjcS6VcB5uuoep9gCluxsh3kdEY
         C++nqqMbV5wFNxXzrxFgOiLPorDOLK4rkTtI5RMiYnBvC/0h8kVZh97Up7MgrmZUsa
         Iru7MEnnO8Cj8A4/xZQd9/Y79hujrU1RA6JDSboE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1497cbbe-9748-87f1-2edc-daa54dbf6360@gmail.com>
References: <20190414202009.31268-1-digetx@gmail.com> <20190414202009.31268-2-digetx@gmail.com> <155621927685.15276.16453873579880842057@swboyd.mtv.corp.google.com> <2b4f56cd-caf9-e6b5-6344-a045e08a9c91@gmail.com> <155623110849.15276.13181079281286430446@swboyd.mtv.corp.google.com> <1497cbbe-9748-87f1-2edc-daa54dbf6360@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/4] clk: tegra20/30: Add custom EMC clock implementation
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Message-ID: <155623927513.15276.3011897763001027401@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 17:41:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-25 17:03:11)
> 26.04.2019 1:25, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Quoting Dmitry Osipenko (2019-04-25 14:42:19)
> >> 25.04.2019 22:07, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> Quoting Dmitry Osipenko (2019-04-14 13:20:06)
> >>>> +{
> >>>> +       struct clk *clk =3D __clk_lookup("emc");
> >>>> +       struct tegra_clk_emc *emc;
> >>>> +       struct clk_hw *hw;
> >>>> +
> >>>> +       if (clk) {
> >>>> +               hw =3D __clk_get_hw(clk);
> >>>> +               emc =3D to_tegra_clk_emc(hw);
> >>>> +
> >>>> +               emc->round_cb =3D round_cb;
> >>>> +               emc->arg_cb =3D arg_cb;
> >>>> +       }
> >>>> +}
> >>>> +
> >>>> +bool tegra20_clk_emc_driver_available(void)
> >>>> +{
> >>>> +       struct clk *clk =3D __clk_lookup("emc");
> >>>
> >>> Can we avoid using __clk_lookup()? Maybe by having the clk_hw pointer=
 in
> >>> this driver somehow?
> >>
> >> tegra20_clk_emc_driver_available() is a private function of the Tegra's
> >> clk-core. Please note that prototype of this function is added to the
> >> local "drivers/clk/tegra/clk.h" file.
> >>
> >> It is indeed possible to use clk pointer instead of __clk_lookup() and
> >> I'll change that in v3 since it's causing some confusion.
> >=20
> > Can you use a clk_hw pointer directly? I'd like to see clk provider
> > drivers only use struct clk_hw, and clk consumers only use struct clk.
>=20
> The clk_hw pointers are not stored directly anywhere in the Tegra's
> clk-driver, it will be a quite massive change to make the clk driver's
> code to use clk_hw pointers instead of struct clk.

Well they must be stored in the clk driver somewhere because that's how
the whole clk framework works.

>=20
> I can add a global variable for the tegra_clk_emc pointer, but it is
> not really necessary since there is __clk_get_hw.
>=20
> Could you please explain what's the problem with __clk_get_hw?

If it's a large invasive change then no worries. The thin that's wrong
with __clk_get_hw() is that it's using a struct clk, meaing that most
likely this is a clk consumer driver doing something weird.

>=20
> >>
> >>>> +       struct tegra_clk_emc *emc; +       struct clk_hw *hw; + +
> >>>> if (clk) { +               hw =3D __clk_get_hw(clk);
> >>>
> >>> This gets further to the point, we don't prefer to see drivers use
> >>> __clk_get_hw() unless they absolutely need to. Maybe I don't
> >>> understand the driver structure, but it seems like maybe the
> >>> driver that's providing the callbacks could be the same driver
> >>> that's registering these clks, and thus everything could be inside
> >>> one file so that we don't have to pass around callbacks and clk_hw
> >>> pointers? Commit text says "this is how it's been" but that's not
> >>> a reason to keep doing it.
> >>
> >> Again, tegra20_clk_emc_driver_available() is for the Terga's
> >> clk-core and not for the EMC (External Memory Controller) driver.
> >> This function is used to determine whether EMC driver is ready to
> >> handle clock-rate changes (PRE/POST rate-change notifications), clk
> >> users can't get EMC clock until driver is ready (i.e. the "round"
> >> callback is registered by the driver).
> >=20
> > Who are the other users of the EMC clk? Why does the EMC driver and
> > the clk driver need to be in sync in such a way that requires us to
> > check if some code in the EMC driver is ready before we can hand out
> > clks from this clk provider? It looks like some tight coupling
> > between these two pieces of code on the clk_get() path which is
> > setting off alarms for me.
>=20
> The other EMC clk user is the devfreq driver. We don't want the
> devfreq driver to get and use the EMC clock if memory timing can't be
> programmed.

Alright, got it!

> That is correct.
>=20
> > Is there some other entity that's needing to be deferred while the
> > EMC and clk drivers tell each other that they're probed and ready so
> > that these notifiers all work? Is that entity using clks directly
> > instead of going through the EMC to change frequencies? If so, why
> > can't we funnel that logic through EMC which then goes to the clk
> > driver? That way it's clearly "thing that changes frequency" -> EMC
> > -> clk controller call chain. It might even allow us to get rid of
> > the rate notifiers?
> >=20
>=20
> That entity is the devfreq driver which uses EMC clk directly right
> now.
>=20
>         https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it/tree/drivers/devfreq/tegra-devfreq.c#n484
>=20
> I think we can funnel all the rate-changing logic through the EMC
> drivers using the PM memory bandwidth QoS API, which is currently
> unsupported by the drivers. And then indeed the rate notifiers won't
> be needed.

Why does PM QoS matter here? I'm mostly asking for the chain to be
stacked and the devfreq driver to be the same as the EMC driver and then
have the EMC/devfreq combo driver use clk APIs to set rates and do
things before and after.

>=20
>         https://github.com/grate-driver/linux/commit/2aa2390dd0cb8bca98e4=
cea6a29d7bda64a51bb3
>=20
> Actually it will be the next step to wire up the PM QoS support to all
> relevant drivers that I'm going to implement after the current
> CLK/EMC/DEVFREQ patch sets will land, it's just not realistic to do
> everything in a single hop.

Ok. It doesn't make me feel great but I suppose if you don't disappear
after this code is merged things will work out in the end.

