Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E29C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F45208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561753561;
	bh=PXNeQunvQAIold70Ez1G5yMGynCWu5dq2jWJpsqrU+w=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=hQ5D+P2hW+b6Nldfa1LnC4qacF8txw4+h6j3yferPyfIkkxPp6EimOQBMLm5Wx7d8
	 kHe5TkLKH17PI78qPNf1dIepNqPVe1pBdeJDd8LS9rsD5y9bWbX3rWrItZZa0i5Juv
	 YsYTYKyHADfVnL1SxECRBEjXaHh0F7+r9sbzwVLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfF1UZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727095AbfF1UZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 16:25:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D458E208CB;
        Fri, 28 Jun 2019 20:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561753557;
        bh=PXNeQunvQAIold70Ez1G5yMGynCWu5dq2jWJpsqrU+w=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=QyjO9Lg5dNGnTkpaWqnj9H7q675ktml0xIeqhibRkZ7motL3wv+T2OFjPraltubcd
         mK/nR0w3hUR6yhgSrc485vHaJHpw48Z5RjO6DPGM7dvBLGiwWTiHpTpTms/IfnNhn1
         JF/dJfvoXuwc/6W9GcFsqhVbrhcDLv2ZqywWRMCY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <41fd54ba-1acc-eb44-dcb0-0d52e570ae72@topic.nl>
References: <20190424090038.18353-1-mike.looijmans@topic.nl> <155623538292.15276.10999401088770081919@swboyd.mtv.corp.google.com> <20190517132352.31221-1-mike.looijmans@topic.nl> <20190627210633.A21EC2075E@mail.kernel.org> <41fd54ba-1acc-eb44-dcb0-0d52e570ae72@topic.nl>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] clk: Add Si5341/Si5340 driver
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 28 Jun 2019 13:25:57 -0700
Message-Id: <20190628202557.D458E208CB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2019-06-27 23:42:03)
> On 27-06-19 23:06, Stephen Boyd wrote:
> > Quoting Mike Looijmans (2019-05-17 06:23:52)
> >> Adds a driver for the Si5341 and Si5340 chips. The driver does not ful=
ly
> >> support all features of these chips, but allows the chip to be used
> >> without any support from the "clockbuilder pro" software.
> >>
> >> If the chip is preprogrammed, that is, you bought one with some defaul=
ts
> >> burned in, or you programmed the NVM in some way, the driver will just
> >> take over the current settings and only change them on demand. Otherwi=
se
> >> the input must be a fixed XTAL in its most basic configuration (no
> >> predividers, no feedback, etc.).
> >>
> >> The driver supports dynamic changes of multisynth, output dividers and
> >> enabling or powering down outputs and multisynths.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> >> ---
> >=20
> > Applied to clk-next + some fixes. I'm not super thrilled about the kHz
> > thing but we don't have a solution for it right now so might as well
> > come back to it later.
>=20
> Thanks for the fixes. And I'm not exactly proud of that kHz part either.
>=20
> While thinking about a solution, I've also had a use case for less than 1=
Hz=20
> frequency adjustment (a video clock to "follow" another one). These clock=
=20
> generators allow for ridiculous ranges and accuracy, you can request it t=
o=20
> generate a 200000000.0005 Hz clock.
>=20

Right. We need to make a plan to replace unsigned long with u64 in the
clk framework and then figure out how to support whatever use-cases we
can with the extra 32-bits we get on the 32-bit unsigned long platforms.
I had a patch lying around that started to plumb u64 through the core
clock framework code, but I didn't pursue it because it didn't seem
necessary. I've seen some code for display PLLs that need to support
10GHz frequencies for display port too, so you're not alone here.=20

Some questions to get the discussion going:

 1. Do we need to use the clk framework to set these frequencies or can
 it be done via other means in whatever subsystem wants to program these
 frequencies, like a broadcast TV tuner subsystem or the IIO subsystem?

 2. If clk framework must handle these frequencies, does it need to be
 set through the clk consumer APIs or can we manage to set the rates on
 these clks via child dividers, muxes, etc. that have
 CLK_SET_RATE_PARENT flag? This might avoid changing the consumer API
 and be simpler to implement.

 3. What's the maximum frequency and the highest resolution we need to
 support? Maybe we just need to support GHz and not THz (10^12) and have
 a resolution of uHz (micro-Hertz)?

 4. Not really a question, but a goal. We should try to avoid a
 performance hit due to an increase in 64-bit math. If possible we can
 do things differently on different CPU architectures to achieve this or
 we can have the clk providers use different clk ops/flags to indicate
 the max range and precision they require.

Anyway, I'm not going to be working on this topic anytime soon but these
are my rough thoughts. I'm sure others on the list have thought about
this topic too so if you want to work on this then it would be good to
float an RFC that answers these questions.

