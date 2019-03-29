Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4134AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC9D218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553897681;
	bh=OTehbauQ08ahn/ZeqU6byAs8bHQqgTQZkfksTL07/k8=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=ed5NbpbPbVS1+2VMQio5tPkibkhbsQxJrCkEaK3oiP+MTQeOatI2bs3n6iv5kKPXy
	 yPRwBQ0xdS1vZKHF3gx26gjNXMAZM6Jqlfc3gcd15B52CfKDlKZgs5geqv08WkYbE2
	 jdGyWVXvINTHZ2LC4yNh/TT36Srymv+FX7XeJKs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfC2WOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbfC2WOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:14:39 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5B5218A2;
        Fri, 29 Mar 2019 22:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553897678;
        bh=OTehbauQ08ahn/ZeqU6byAs8bHQqgTQZkfksTL07/k8=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=HQuQ68VReNeDXM9JzyFwxJ2G4qiblnGkk3Ay3WGAOBxGzwvYKdsDJOkxcvILJv/dT
         1UfdPf7nmXFmBIyyndHqKZrYizTJKsIOKroL/hmlPEXzX/2VQmJ8+CPfqBb/cU0Nq+
         EH6yoU8NCbeXfi8XZa1lRFwgq2+6znBQr/gvolUk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8b6f0bc6210834af2aff2de7dc95692dd87db539.camel@baylibre.com>
References: <20190325111200.15940-1-jbrunet@baylibre.com> <20190325111200.15940-2-jbrunet@baylibre.com> <155353381842.20095.17915880223118004926@swboyd.mtv.corp.google.com> <8b6f0bc6210834af2aff2de7dc95692dd87db539.camel@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/4] clk: meson: mpll: add init callback and regs
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <155389767798.20095.10570017301900287354@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 29 Mar 2019 15:14:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-03-26 00:53:15)
> On Mon, 2019-03-25 at 10:10 -0700, Stephen Boyd wrote:
> > Quoting Jerome Brunet (2019-03-25 04:11:57)
> > > @@ -138,6 +129,27 @@ static int mpll_set_rate(struct clk_hw *hw,
> > >         return 0;
> > >  }
> > > =20
> > > +static void mpll_init(struct clk_hw *hw)
> > > +{
> > > +       struct clk_regmap *clk =3D to_clk_regmap(hw);
> > > +       struct meson_clk_mpll_data *mpll =3D meson_clk_mpll_data(clk);
> > > +
> > > +       if (mpll->init_count)
> > > +               regmap_multi_reg_write(clk->map, mpll->init_regs,
> > > +                                      mpll->init_count);
> > > +
> > > +       /* Enable the fractional part */
> > > +       meson_parm_write(clk->map, &mpll->sdm_en, 1);
> > > +
> > > +       /* Set additional fractional part enable if required */
> > > +       if (MESON_PARM_APPLICABLE(&mpll->ssen))
> > > +               meson_parm_write(clk->map, &mpll->ssen, 1);
> > > +
> > > +       /* Set the magic misc bit if required */
> > > +       if (MESON_PARM_APPLICABLE(&mpll->misc))
> > > +               meson_parm_write(clk->map, &mpll->misc, 1);
> > > +}
> > > +
> > >  const struct clk_ops meson_clk_mpll_ro_ops =3D {
> > >         .recalc_rate    =3D mpll_recalc_rate,
> > >         .round_rate     =3D mpll_round_rate,
> > > @@ -148,6 +160,7 @@ const struct clk_ops meson_clk_mpll_ops =3D {
> > >         .recalc_rate    =3D mpll_recalc_rate,
> > >         .round_rate     =3D mpll_round_rate,
> > >         .set_rate       =3D mpll_set_rate,
> > > +       .init           =3D mpll_init,
> >=20
> > We actively discourage using init callbacks. Can you do this some other
> > way?
>=20
> Yes I'm aware of that but init it the right place to do this.
> To be clear, this is not initializing the clock to some particular rate, =
the
> rate is preserved.
>=20
> It just applies the necessary settings that needs to be done only once to=
 make
> sure the clock is in working order and that the rate calculated is actual=
ly
> accurate.=20

Ok, but can you do that in your driver's probe routine instead of
attaching to the init callback? We want to get rid of "init" at some
point so throwing the init sequence stuff into the driver probe around
registration is a solution. Or we should think about not discouraging
the init callback.

