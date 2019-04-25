Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC1CC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C189206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556231112;
	bh=GACxoLulNU5OtRBVh4C6+vAfmx59bpYIT7euqG9Hw2Y=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=ZdBpYxTzTp5XuMwf4e/YqEAr/H2g0ppGKqS9U5yqr0jBP1XAR3MnnWK+3p26cVpPw
	 uOEf2TJRkHLtBTdpSb5fMEJS+uWq0+aQ3JLznEZaWPXrL39wVYKEysdBvmf+hskscl
	 QykQB+EF6ft5UY0E9gPsuA4NRy/oGTiJKadqJ5Hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfDYWZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfDYWZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:25:11 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FBB8206C0;
        Thu, 25 Apr 2019 22:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556231109;
        bh=GACxoLulNU5OtRBVh4C6+vAfmx59bpYIT7euqG9Hw2Y=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=DMYI5upH/y40N2SBRYu4goleLc1jZrvfgr9RR8EfGg0iWKAhU2va1VsChK4Yo8PXb
         oMCdTznx/mSN0XthQHnRgWaK5fAQf/nNxEgEEjtgTzlg39afRqqwrlbgEZ6UcNcLjE
         7rABNeOTlgayruhzdulEHDAGjEu/Eg7HiIMHw3Do=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2b4f56cd-caf9-e6b5-6344-a045e08a9c91@gmail.com>
References: <20190414202009.31268-1-digetx@gmail.com> <20190414202009.31268-2-digetx@gmail.com> <155621927685.15276.16453873579880842057@swboyd.mtv.corp.google.com> <2b4f56cd-caf9-e6b5-6344-a045e08a9c91@gmail.com>
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
Message-ID: <155623110849.15276.13181079281286430446@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 15:25:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-25 14:42:19)
> 25.04.2019 22:07, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Quoting Dmitry Osipenko (2019-04-14 13:20:06)
> >> diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/c=
lk-tegra20-emc.c
> >> new file mode 100644
> >> index 000000000000..35b67a9989c8
> >> --- /dev/null
> >> +++ b/drivers/clk/tegra/clk-tegra20-emc.c
> >> @@ -0,0 +1,307 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include <linux/bits.h>
> >> +#include <linux/clk/tegra.h>
> >=20
> > Include clk-provider.h as this is a clk provider driver.
>=20
> Okay, although clk-provider.h is also included by clk.h below.

We prefer explicit includes instead of implicit ones. Failing to do that
leads to changes like the one I'm making now to push out linux/io.h to
all the users who are relying on clk-provider.h to provide it for them.

>=20
> >> +{
> >> +       struct clk *clk =3D __clk_lookup("emc");
> >> +       struct tegra_clk_emc *emc;
> >> +       struct clk_hw *hw;
> >> +
> >> +       if (clk) {
> >> +               hw =3D __clk_get_hw(clk);
> >> +               emc =3D to_tegra_clk_emc(hw);
> >> +
> >> +               emc->round_cb =3D round_cb;
> >> +               emc->arg_cb =3D arg_cb;
> >> +       }
> >> +}
> >> +
> >> +bool tegra20_clk_emc_driver_available(void)
> >> +{
> >> +       struct clk *clk =3D __clk_lookup("emc");
> >=20
> > Can we avoid using __clk_lookup()? Maybe by having the clk_hw pointer in
> > this driver somehow?
>=20
> tegra20_clk_emc_driver_available() is a private function of the Tegra's
> clk-core. Please note that prototype of this function is added to the
> local "drivers/clk/tegra/clk.h" file.
>=20
> It is indeed possible to use clk pointer instead of __clk_lookup() and
> I'll change that in v3 since it's causing some confusion.

Can you use a clk_hw pointer directly? I'd like to see clk provider
drivers only use struct clk_hw, and clk consumers only use struct clk.

>=20
> >> +       struct tegra_clk_emc *emc;
> >> +       struct clk_hw *hw;
> >> +
> >> +       if (clk) {
> >> +               hw =3D __clk_get_hw(clk);
> >=20
> > This gets further to the point, we don't prefer to see drivers use
> > __clk_get_hw() unless they absolutely need to. Maybe I don't understand
> > the driver structure, but it seems like maybe the driver that's
> > providing the callbacks could be the same driver that's registering
> > these clks, and thus everything could be inside one file so that we
> > don't have to pass around callbacks and clk_hw pointers? Commit text
> > says "this is how it's been" but that's not a reason to keep doing it.
>=20
> Again, tegra20_clk_emc_driver_available() is for the Terga's clk-core
> and not for the EMC (External Memory Controller) driver. This function
> is used to determine whether EMC driver is ready to handle clock-rate
> changes (PRE/POST rate-change notifications), clk users can't get EMC
> clock until driver is ready (i.e. the "round" callback is registered by
> the driver).

Who are the other users of the EMC clk? Why does the EMC driver and the
clk driver need to be in sync in such a way that requires us to check if
some code in the EMC driver is ready before we can hand out clks from
this clk provider? It looks like some tight coupling between these two
pieces of code on the clk_get() path which is setting off alarms for me.

>=20
> Please see tegra20_clk_src_onecell_get() changes in this patch and
> drivers/memory/tegra/tegra20-emc.c for clarity.
>=20
> It is not possible to register clk from the EMC driver without having
> some custom integration with the clk-core because CLK and EMC are
> different hardware units and hence EMC driver doesn't have direct access
> to the CLK registers. I think it is better to keep CLK and memory-timing
> programming logically separated simply for consistency, although I'm
> open to suggestions.

Sorry, I'm really confused and it's probably because I'm not taking the
time to read all the Tegra code right now. I'm trying to understand the
overall memory controller frequency logic.

I understand that there's a memory controller, and a clk controller, and
they're different hardware blocks. Presumably the clk controller can't
change frequencies without informing the memory controller that it's
going to change something so the memory controller can fix timings in
the EMC register space.

Is there some other entity that's needing to be deferred while the EMC
and clk drivers tell each other that they're probed and ready so that
these notifiers all work? Is that entity using clks directly instead of
going through the EMC to change frequencies? If so, why can't we funnel
that logic through EMC which then goes to the clk driver? That way it's
clearly "thing that changes frequency" -> EMC -> clk controller call
chain. It might even allow us to get rid of the rate notifiers?

