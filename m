Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FEEC33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065A7218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578210652;
	bh=7Q/p9G5vrpR6n/+WVSba0TjeJuon3bHuu2sYZTOKUmM=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=EIsAg/6c/1emVXP4uKFya/8Q7nokcgU2dL0DDxGR4mkyt9tUYJXRVzXwbuCEf4LSa
	 GKC/2fewFZNMHbyFTWjEQxNkjYfrOPZ6dhM6XhhNWPW5YfJ+qUgfLDyePwv9aLjA66
	 JQHN9RMod5YD/Fa2c3m7zYyiY6sxT4dw95exNWZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgAEHuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 02:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAEHuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:50:51 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B93E20866;
        Sun,  5 Jan 2020 07:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578210650;
        bh=7Q/p9G5vrpR6n/+WVSba0TjeJuon3bHuu2sYZTOKUmM=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=tWjnMIs6hwsyGGYv90KbQ8PvnJnN2Bm8cuclA4qHS62a4p6cqJ9C0Kl09fncKBiXd
         XI2ff16m7cSUTrRktvTNQEoQ/N/ncj4MWmPHuNst42eV2ei4xEahPIWaKFt3g0uPb5
         ftn6d6BLn58aEAaIz9Jb9aELQLREuipcbA0S4dGI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jd0ffr1jh.fsf@starbuckisacylon.baylibre.com>
References: <20191001174439.182435-1-sboyd@kernel.org> <1jd0ffr1jh.fsf@starbuckisacylon.baylibre.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: Don't cache errors from clk_ops::get_phase()
To:     Jerome Brunet <jbrunet@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 23:50:49 -0800
Message-Id: <20200105075050.1B93E20866@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry I'm way behind on emails)

Quoting Jerome Brunet (2019-10-02 01:31:46)
>=20
> On Tue 01 Oct 2019 at 19:44, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > We don't check for errors from clk_ops::get_phase() before storing away
> > the result into the clk_core::phase member. This can lead to some fairly
> > confusing debugfs information if these ops do return an error. Let's
> > skip the store when this op fails to fix this. While we're here, move
> > the locking outside of clk_core_get_phase() to simplify callers from
> > the debugfs side.
>=20
> Function already under the lock seem to be marked with  "_nolock"
> Maybe one should added for get_phase() ?
>=20
> Also the debugfs side calls clk_core_get_rate() and
> clk_core_get_accuracy(). Both are taking the prepare_lock.

Yes both are taking the lock again when we're already holding the lock.
It is wasteful. I'll send another patch with the series to make those
calls in debugfs use the nolock variants. That will open up the question
of how we sometimes recalc rates and other times don't depending on if
the nolock or lock variant of the get_rate() API is used.

>=20
> So I don't get why clk_get_phase() should do thing differently from the
> others, and not take the lock ?

Got it.

>=20
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 1c677d7f7f53..16add5626dfa 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3349,10 +3366,7 @@ static int __clk_core_init(struct clk_core *core)
> >        * Since a phase is by definition relative to its parent, just
> >        * query the current clock phase, or just assume it's in phase.
> >        */
> > -     if (core->ops->get_phase)
> > -             core->phase =3D core->ops->get_phase(core->hw);
> > -     else
> > -             core->phase =3D 0;
> > +     clk_core_get_phase(core);
>=20
> Should the error be checked here as well ?

What error?

