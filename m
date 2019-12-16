Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB708C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933F620700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518617;
	bh=g8/rjNCZq7LbHvZLvTNNpjZ1plcZnKZdtSsnrwvnKXs=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=mJSZ0fi3MGGknEtExwSIyE91KekBBAOc3xQhnbx9CiWJk0FqebXbjJhQ/Hw0BoNjf
	 uGNqYV8gCPzDpfDszoCAWec4L6W2uTYf15r04dQ7ufxmru4rcBuq6CCWQbUoihvEpL
	 OdmGIRZmovEUHLzhUyNyisg0tA73ascbyCmQ/5Pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfLPRuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPRuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:50:16 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A642206EC;
        Mon, 16 Dec 2019 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518615;
        bh=g8/rjNCZq7LbHvZLvTNNpjZ1plcZnKZdtSsnrwvnKXs=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=hyJriL7F96LxiYiCXXD6CLjvtW73yKVQDMHGaYpoy1QPMrmgRBbgjZQ2CFT5CAg+W
         +KrAVw6jQMk7TdXrDODjsWdn7uaXccTJfRVXit4cex32jK7jAeY7lAXuMDrm0lEvfi
         xm/9xn40U82jAhw/4ZBRdSf9wMSNHaoWdmQdIbhE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jr214bpl0.fsf@starbuckisacylon.baylibre.com>
References: <20191215210153.1449067-1-martin.blumenstingl@googlemail.com> <1jr214bpl0.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH 0/1] clk: Meson8/8b/8m2: fix the mali clock flags
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 09:50:14 -0800
Message-Id: <20191216175015.2A642206EC@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-12-16 01:13:31)
>=20
> On Sun 15 Dec 2019 at 22:01, Martin Blumenstingl <martin.blumenstingl@goo=
glemail.com> wrote:
>=20
> > While playing with devfreq support for the lima driver I experienced
> > sporadic (random) system lockups. It turned out that this was in
> > certain cases when changing the mali clock.
> >
> > The Amlogic vendor GPU platform driver (which is responsible for
> > changing the clock frequency) uses the following pattern when updating
> > the mali clock rate:
> > - at initialization: initialize the two mali_0 and mali_1 clock trees
> >   with a default setting and enable both clocks
> > - when changing the clock frequency:
> > -- set HHI_MALI_CLK_CNTL[31] to temporarily use the mali_1 clock output
> > -- update the mali_0 clock tree (set the mux, divider, etc.)
> > -- clear HHI_MALI_CLK_CNTL[31] to temporarily use the mali_0 clock
>                                       ^ no final setting then ? :P
> >    output again
> >
> > With the common clock framework we can even do better:
> > by setting CLK_SET_RATE_PARENT for the mali_0 and mali_1 output gates
>                 ^
> From your patch, I guess you mean CLK_SET_RATE_GATE ?
>=20
> > we can force the common clock framework to update the "inactive" clock
> > and then switch to it's output.
> >
> > I only tested this patch for a limited time only (approx. 2 hours).
> > So far I couldn't reproduce the sporadic system lockups with it.
> > However, broader testing would be great so I would like this to be
> > applied for -next.
>=20
> CLK_SET_RATE_GATE guarantees that a clock cannot be updated while in
> use. While it works at your advantage here, I'm not sure CCF guarantees
> the assumption this implementation is based on. Some explanation below:
>=20
> In your case, if it works as you expect when calling set_rate() on the
> top clock, it goes as this:
>=20
> - mali0 is use with rate X:
> - =3D> set_rate(mali_top, Y)
> - mali0 is in use, cannot change, will round rate Y to X
> - mali1 is not in use, can provide Y
> - mali1 is determined to be the new best parent for mali top
>=20
> So far so good.
>=20
> - CCF pick the mali1 subtree
>   *start updating the clock from the root to the leaf*
>=20
> So the mali top mux, which choose between mali0 and mali1, will be
> *updated last* which crucial to your use case.
>=20
> I just wonder if this crucial part something CCF guarantee and you can
> rely on it ... or if it might break in the future.
>=20
> Stephen, any thoughts on this ?

We have problems with the order in which we call the set_rate clk_op.
Sometimes clk providers want us to call from leaf to root but instead we
call from root to leaf because of implementation reasons. Controlling
the order in which clk operations are done is an unsolved problem. But
yes, in the future I'd like to see us introduce the vaporware that is
coordinated clk rates that would allow clk providers to decide what this
order should be, instead of having to do this "root-to-leaf" update.
Doing so would help us with the clk dividers that have some parent
changing rate that causes the downstream device to be overclocked while
we change the parent before the divider.

If there are more assumptions like this about how the CCF is implemented
then we'll have to be extra careful to not disturb the "normal" order of
operations when introducing something that allows clk providers to
modify it.

Also, isn't CLK_SET_RATE_GATE broken in the case that clk_set_rate()
isn't called on that particular clk? I seem to recall that the flag only
matters when it's applied to the "leaf" or entry point into the CCF from
a consumer API. I've wanted to fix that but never gotten around to it.
The whole flag sort of irks me because I don't understand what consumers
are supposed to do when this flag is set on a clk. How do they discover
it? They're supposed to "just know" and turn off the clk first and then
call clk_set_rate()? Why can't the framework do this all in the
clk_set_rate() call?

>=20
> PS: If CCF does guarantee "root-to-leaf" updates, I think this
> implementation is a clever trick to solve this usual glitch free clock
> update issue ... much more elegant that the notifier solution we have
> been using so far.
