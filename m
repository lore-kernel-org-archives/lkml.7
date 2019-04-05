Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D691EC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AEA206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554497016;
	bh=EQcquGL/H8j873Qtr/IVEBdcoXwlt+4bAMRlTfGo12s=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=eu1CdQrXF2A8NUTuKZ7ylAATTUtnL6eBcKsr2mYPedmSPrcmXJmmbMaJaVkr0JPhc
	 rPjtBnyKCxqhD1PxD3no4VD4QCY7TrdKJVzcMxRLPLbkRbEcClgzTSJdZSpi3XeFRJ
	 +jQvKnjXU2ka6RCJbPoSh/8a4BLd7eIZiTkve3cA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfDEUnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfDEUnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:43:35 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1922C206BA;
        Fri,  5 Apr 2019 20:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554497014;
        bh=EQcquGL/H8j873Qtr/IVEBdcoXwlt+4bAMRlTfGo12s=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=wJ04X2qGwrxWuRA5ZaXcwkyxpSqJzNPOQSWve20yqQjwfyNo9+LJ/CZA25Ua+mBAM
         shl/v/8tCBD1zGHkJs/9tbu390a5iKAo+OcDVrHuvi372nF42VdGMc65jwwvIzhC4Q
         CeuJGQqlyhxmtTGXsyEG+hrUDGuQv6afz730JTYg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEG3pNCrANkLBeEA_wVU7n4U57X3sd-1EzhUZ_PHBryqPHoAaQ@mail.gmail.com>
References: <20190325111200.15940-1-jbrunet@baylibre.com> <20190325111200.15940-2-jbrunet@baylibre.com> <155353381842.20095.17915880223118004926@swboyd.mtv.corp.google.com> <8b6f0bc6210834af2aff2de7dc95692dd87db539.camel@baylibre.com> <155389767798.20095.10570017301900287354@swboyd.mtv.corp.google.com> <6ef984dabf626760ae606567facdc5245fbba984.camel@baylibre.com> <CAEG3pNCrANkLBeEA_wVU7n4U57X3sd-1EzhUZ_PHBryqPHoAaQ@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/4] clk: meson: mpll: add init callback and regs
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "Stephen Boyd <sboyd@codeaurora.org>, Emilio Lopez
        <emilio@elopez.com.ar>, Hans de Goede <hdegoede@redhat.com>, linux-clk
        <linux-clk@vger.kernel.org>, linux-arm-kernel" 
        <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155449701325.20095.2265240732374772927@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 05 Apr 2019 13:43:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michael Turquette (2019-04-05 08:43:40)
> Hi Jerome,
>=20
> On Fri, Mar 29, 2019 at 3:58 PM Jerome Brunet <jbrunet@baylibre.com> wrot=
e:
> >
> > On Fri, 2019-03-29 at 15:14 -0700, Stephen Boyd wrote:
> > > > > We actively discourage using init callbacks. Can you do this some=
 other
> > > > > way?
> > > >
> > > > Yes I'm aware of that but init it the right place to do this.
> > > > To be clear, this is not initializing the clock to some particular =
rate, the
> > > > rate is preserved.
> > > >
> > > > It just applies the necessary settings that needs to be done only o=
nce to make
> > > > sure the clock is in working order and that the rate calculated is =
actually
> > > > accurate.
> > >
> > > Ok, but can you do that in your driver's probe routine instead of
> > > attaching to the init callback? We want to get rid of "init" at some
> > > point so throwing the init sequence stuff into the driver probe around
> > > registration is a solution. Or we should think about not discouraging
> > > the init callback
> >
> > Is is callback really a problem after all ?
>=20
> It is a problem, insofar as Stephen and I want to remove .init some day.
>=20
> > I think we should actively prevent using it to set a particular rate.
> >
> > Here, the goal is put the clock in working order. The bootloader does n=
ot
> > always do that for us.
>=20
> The above two sentences make it sound like this sequence belongs in .prep=
are().
>=20
> I know that you're concerned with setting rate, but I guess it is safe
> to assume that you'll always complete .prepare() before you begin to
> execute .set_rate(), no? This also avoids the ugliness of putting it
> in the .probe(), which I agree doesn't feel like an accurate thing to
> do for a clock's own programming sequence.
>=20
> .probe() is an OK place to put policy (turn these clocks on or set
> them to this rate, for a known-good configuration).
>=20

Following along with this reasoning, maybe we need a 'prepare_once'
callback that does this the first time the clk is prepared or set_rate
is called on it. The problem I have with the init callback is that the
semantics of when it's called and what has happened before it's called
isn't clearly defined. I'm afraid to remove it and also afraid to move
around where it's called from. I've been itching to get it out of under
all the locks we're holding at registration time, but I don't know if
that's feasible, for example.

