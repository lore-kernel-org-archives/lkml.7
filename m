Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E60C2D0D5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9315121569
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577158598;
	bh=hKOk/K7hTl+yIynX4qaqBR8jYeq8G7LYQWQa8oBkIlg=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=jkLCLQGrAlL2imkfyQVz2GRpbaDcKUFsYKCRnwjjsPJCAfDPRqscK80K95gfyqt11
	 JWSk0jdBzZRXEz7FOgfw32tiT4rIWcncxNLpo8axR4L/hQX0lD5Yb+N2CaS0C5/zTS
	 R0M49Nbm34eLFXubGuDljwsMi6JPLRv6whkn/WbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLXDgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 22:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfLXDgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 22:36:37 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BB3F206B7;
        Tue, 24 Dec 2019 03:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577158596;
        bh=hKOk/K7hTl+yIynX4qaqBR8jYeq8G7LYQWQa8oBkIlg=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=hHtreC+yvNjl49/8yHJTSGyyOzkmVhJrs1i0vH3I48Q//kO9OhuqlsYbFZGZS7UD9
         qF0SxC4zVszjRT+VAwWZk0iEidiQxCbragcL3l+teGxjSjc766HzB2K4bdsAaELmKj
         qbAK1MUf9hu4AjzTbfwKLPgpXxAodx8v5psEzWvs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jlfrcaxmm.fsf@starbuckisacylon.baylibre.com>
References: <20191215210153.1449067-1-martin.blumenstingl@googlemail.com> <1jr214bpl0.fsf@starbuckisacylon.baylibre.com> <20191216175015.2A642206EC@mail.kernel.org> <1jlfrcaxmm.fsf@starbuckisacylon.baylibre.com>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Subject: Re: [PATCH 0/1] clk: Meson8/8b/8m2: fix the mali clock flags
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 19:36:35 -0800
Message-Id: <20191224033636.1BB3F206B7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-12-16 11:17:21)
>=20
> On Mon 16 Dec 2019 at 18:50, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > Quoting Jerome Brunet (2019-12-16 01:13:31)
> >>=20
> >> *updated last* which crucial to your use case.
> >>=20
> >> I just wonder if this crucial part something CCF guarantee and you can
> >> rely on it ... or if it might break in the future.
> >>=20
> >> Stephen, any thoughts on this ?
> >
> > We have problems with the order in which we call the set_rate clk_op.
> > Sometimes clk providers want us to call from leaf to root but instead we
> > call from root to leaf because of implementation reasons. Controlling
> > the order in which clk operations are done is an unsolved problem. But
> > yes, in the future I'd like to see us introduce the vaporware that is
> > coordinated clk rates that would allow clk providers to decide what this
> > order should be, instead of having to do this "root-to-leaf" update.
> > Doing so would help us with the clk dividers that have some parent
> > changing rate that causes the downstream device to be overclocked while
> > we change the parent before the divider.
> >
> > If there are more assumptions like this about how the CCF is implemented
> > then we'll have to be extra careful to not disturb the "normal" order of
> > operations when introducing something that allows clk providers to
> > modify it.
>=20
> I understand that CCR would, in theory, allow to define that sort of
> details. Still defining (and documenting) the default behavior would be
> nice.
>=20
> So the question is:
>  * Can we rely set_rate() doing a root-to-leaf update until CCR comes
>    around ?
>  * If not, for use cases like the one described by Martin, I guess we
>    are stuck with the notifier ? Or would you have something else to
>    propose ?

I suppose we should just state that clk_set_rate() should do a
root-to-leaf update. It's not like anyone is interested in changing
this behavior. The notifier is not ideal. I've wanted to add a new
clk_op that would cover some amount of the notifier users by having a
'pre_set_rate' clk op that can mux the clk over to something safe or
setup a divider to something that is known to be safe and work. Then we
can avoid having to register for a notifier just to do something right
before the root-to-leaf update happens.

>   =20
> >
> > Also, isn't CLK_SET_RATE_GATE broken in the case that clk_set_rate()
> > isn't called on that particular clk? I seem to recall that the flag only
> > matters when it's applied to the "leaf" or entry point into the CCF from
> > a consumer API.
>=20
> It did but not anymore
>=20
> > I've wanted to fix that but never gotten around to it.
>=20
> I fixed that already :P
> CLK_SET_RATE_GATE is a special case of clock protect. The clock is
> protecting itself so it is going down through the tree.
>=20

Ahaha ok. As you can see I'm trying to forget clock protect ;-)


>=20
> > The whole flag sort of irks me because I don't understand what consumers
> > are supposed to do when this flag is set on a clk. How do they discover
> > it?
>=20
> Actually (ATM) the consumer is not even aware of it. If a clock with
> CLK_SET_RATE_GATE is enabled, it will return the current rate to
> .round_rate() and .set_rate() ... as if it was fixed.

And then when the clk is disabled it will magically "unstick" and start
to accept the same rate request again?

>=20
> > They're supposed to "just know" and turn off the clk first and then
> > call clk_set_rate()?
>=20
> ATM, yes ... if CCF cannot switch to another "unlocked" subtree (the
> case here)
>=20
> > Why can't the framework do this all in the clk_set_rate() call?
>=20
> When there is multiple consumers the behavior would become a bit
> difficult to predict and drivers may have troubles anticipating that,
> maybe, the clock is locked.

Fun times!

