Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97CFC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA0C21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 01:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560906869;
	bh=W8xHOUHPVyDuwNWqngNRQAdgLO83szSVCbDG+rTCuqo=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=lefiK1HVtP3KHGAkonh9siExwWJDslqS7RqlVzpvwv/9GF7fvdyEWTky+iFmhO1rq
	 LYE8rOB76uOogi+avRT3HWpOSPCfh7lxBdm1FfGTWI/qS2xJ9t0EvfJbBAPvjXGGdj
	 of6y4jYKr52pjT3izE1Pp9l4S0eMkI/987J6bszo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfFSBO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 21:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbfFSBO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:14:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D632085A;
        Wed, 19 Jun 2019 01:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560906866;
        bh=W8xHOUHPVyDuwNWqngNRQAdgLO83szSVCbDG+rTCuqo=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=kTKamvLQLLOsqN2GxBrzQeJEPROGe5vpgjW1vfM/jRW2fC8lpVmvQEKthI5OwiGzo
         Yl1Ym7LTySZhgLOpLB7/fIwUoLVB0ck7mQvoXDb9aLPGKEf8G6XsRZF5CfAtuRSXt4
         4TmOmDqYTWUknlwMQEFe9DZSp+gTgZYbGZDbybnk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190618122108.GO28892@ulmo>
References: <20190616233551.6838-1-digetx@gmail.com> <20190616233551.6838-2-digetx@gmail.com> <20190618122108.GO28892@ulmo>
To:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 01/10] clk: tegra20/30: Add custom EMC clock implementation
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joseph Lo <josephl@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 18 Jun 2019 18:14:25 -0700
Message-Id: <20190619011426.98D632085A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thierry Reding (2019-06-18 05:21:08)
> On Mon, Jun 17, 2019 at 02:35:42AM +0300, Dmitry Osipenko wrote:
> > A proper External Memory Controller clock rounding and parent selection
> > functionality is required by the EMC drivers. It is not available using
> > the generic clock implementation, hence add a custom one. The clock rate
> > rounding shall be done by the EMC drivers because they have information
> > about available memory timings, so the drivers will have to register a
> > callback that will round the requested rate. EMC clock users won't be a=
ble
> > to request EMC clock by getting -EPROBE_DEFER until EMC driver is probed
> > and the callback is set up. The functionality is somewhat similar to the
> > clk-emc.c which serves Tegra124+ SoC's, the later HW generations support
> > more parent clock sources and the HW configuration and integration with
> > the EMC drivers differs a tad from the older gens, hence it's not really
> > worth to try to squash everything into a single source file.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/clk/tegra/Makefile          |   2 +
> >  drivers/clk/tegra/clk-tegra20-emc.c | 305 ++++++++++++++++++++++++++++
> >  drivers/clk/tegra/clk-tegra20.c     |  55 ++---
> >  drivers/clk/tegra/clk-tegra30.c     |  38 +++-
> >  drivers/clk/tegra/clk.h             |   6 +
> >  include/linux/clk/tegra.h           |  14 ++
> >  6 files changed, 368 insertions(+), 52 deletions(-)
> >  create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
>=20
> Hi Mike, Stephen,
>=20
> The remaining patches of this series have a build-time dependency on
> this clock driver patch. Would you mind if I pick this up into the Tegra
> tree, so that I can resolve the dependency there? I can send a pull
> request of the stable branch with this one patch if we need to resolve a
> conflict between the clk and Tegra trees.
>=20

Sure. I have review comments though so hopefully they can be addressed
first.

