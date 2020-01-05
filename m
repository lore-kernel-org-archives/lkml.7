Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F4C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07832085B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578210820;
	bh=gfLhoyg/XHQjl9yHoLrY3H9d5K6uiuHJKAhIOx66eVw=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=JAyWGm9P+m2P86Xc9ztGQaugDv2Cn9ZFcdCSDg04cdycZgGYtruqcLnn4kzy5uDHJ
	 g2TIHxY760a+tG94SViXRcVp9UnCwr+uMzWEkJA4drhMUyU0kTP00XQPxDK5VwvxQP
	 sONmmkDG4Gv1cDJkjrdPr4y4l3rTR3AEKjtuwmdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAEHxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 02:53:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAEHxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:53:39 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2943E2085B;
        Sun,  5 Jan 2020 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578210818;
        bh=gfLhoyg/XHQjl9yHoLrY3H9d5K6uiuHJKAhIOx66eVw=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=N2U2er6I/opSS35FxekK5DKcSO63NPsiac138OLFMsVApjeLOULc8c3/X0eU93UP9
         pVzobKwUdeFqEoLZgePgP75G4jFgXaGOAYpDbj5s0udQ7RRzHOwn+JvFDOGh48h4/H
         GYLib7VEZDSyOilvonfmRcdQwO3cvsOxTCeTNkCg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=VBWuMwLOCvUK0JRsFPSvkCu2RNAa4=2g5CpsGRS--1UA@mail.gmail.com>
References: <20191001174439.182435-1-sboyd@kernel.org> <CAD=FV=VBWuMwLOCvUK0JRsFPSvkCu2RNAa4=2g5CpsGRS--1UA@mail.gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: Don't cache errors from clk_ops::get_phase()
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 23:53:37 -0800
Message-Id: <20200105075338.2943E2085B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2019-10-01 14:20:50)
> Hi,
>=20
> On Tue, Oct 1, 2019 at 10:44 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > We don't check for errors from clk_ops::get_phase() before storing away
> > the result into the clk_core::phase member. This can lead to some fairly
> > confusing debugfs information if these ops do return an error. Let's
> > skip the store when this op fails to fix this. While we're here, move
> > the locking outside of clk_core_get_phase() to simplify callers from
> > the debugfs side.
> >
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >
> > Resending because I couldn't find this anywhere.
>=20
> It was at:
>=20
> https://lore.kernel.org/r/155692148370.12939.291938595926908281@swboyd.mt=
v.corp.google.com
>=20
>=20
> > @@ -2640,14 +2640,14 @@ EXPORT_SYMBOL_GPL(clk_set_phase);
> >
> >  static int clk_core_get_phase(struct clk_core *core)
> >  {
> > -       int ret;
> > +       int ret =3D 0;
> >
> > -       clk_prepare_lock();
> > +       lockdep_assert_held(&prepare_lock);
> >         /* Always try to update cached phase if possible */
> >         if (core->ops->get_phase)
> > -               core->phase =3D core->ops->get_phase(core->hw);
> > -       ret =3D core->phase;
> > -       clk_prepare_unlock();
> > +               ret =3D core->ops->get_phase(core->hw);
> > +       if (ret >=3D 0)
> > +               core->phase =3D ret;
>=20
> It doesn't matter much, but if it were me I'd add this under the "if
> (core->ops->get_phase)" statement.  Then we don't keep doing a memory
> write of 0 to "core->phase" all the time when "core->ops->get_phase"
> isn't there.  ...plus (to me) it makes more logical sense.
>=20
> I'd guess you were trying to make sure that core->phase got set to 0
> like the old code did in __clk_core_init().  ...but that really
> shouldn't be needed since the clk_core is initted with kzalloc().

Ok. I bail out early with return 0 now.

>=20
>=20
> > @@ -2661,10 +2661,16 @@ static int clk_core_get_phase(struct clk_core *=
core)
> >   */
> >  int clk_get_phase(struct clk *clk)
> >  {
> > +       int ret;
> > +
> >         if (!clk)
> >                 return 0;
> >
> > -       return clk_core_get_phase(clk->core);
> > +       clk_prepare_unlock();
> > +       ret =3D clk_core_get_phase(clk->core);
> > +       clk_prepare_unlock();
>=20
> Probably the first of these two should be clk_prepare_lock() unless
> you really really wanted the clock to be unlocked.

Thanks.

>=20
>=20
> > @@ -2878,13 +2884,21 @@ static struct hlist_head *orphan_list[] =3D {
> >  static void clk_summary_show_one(struct seq_file *s, struct clk_core *=
c,
> >                                  int level)
> >  {
> > -       seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu %5d %6d\n",
> > +       int phase;
> > +
> > +       seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
> >                    level * 3 + 1, "",
> >                    30 - level * 3, c->name,
> >                    c->enable_count, c->prepare_count, c->protect_count,
> > -                  clk_core_get_rate(c), clk_core_get_accuracy(c),
> > -                  clk_core_get_phase(c),
> > -                  clk_core_get_scaled_duty_cycle(c, 100000));
> > +                  clk_core_get_rate(c), clk_core_get_accuracy(c));
> > +
> > +       phase =3D clk_core_get_phase(c);
>=20
> Don't you need a clk_prepare_lock() / clk_prepare_unlock() around this no=
w?

Not really, we already hold the lock when this function is called so
locking it again is not useful.

>=20
>=20
> > @@ -3349,10 +3366,7 @@ static int __clk_core_init(struct clk_core *core)
> >          * Since a phase is by definition relative to its parent, just
> >          * query the current clock phase, or just assume it's in phase.
>=20
> Maybe update the comment to something like "clk_core_get_phase() will
> cache the phase for us".
>=20

Ok.

