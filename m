Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D041EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F54217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565239659;
	bh=y0710HmReVsBMWZ/XfSor0U2soY0toxlrShfhv6D9iA=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=SLZZOY562FVVkIZKMgIqsbhQrsNjDlkLQdel2r9Ih2+EaCYS90GG3tzfTqiRdEBvL
	 QbtEVl6VaQ6eTeJYb61C1vSakj9nAtxYP7Vnyk5r0qs5QM6tGwDax1INQEmv6L8X1B
	 +4R8zIXUQKr9/GKDDZ56LhOSYg1lzyifyc+F1y/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfHHEri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 00:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfHHErh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 00:47:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E83217D7;
        Thu,  8 Aug 2019 04:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565239656;
        bh=y0710HmReVsBMWZ/XfSor0U2soY0toxlrShfhv6D9iA=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=heRTJYGb+MKnfdifsw1aaCQ5Te73E3T+adwWyB2Qh8LsxkzkNb2+gHXK1Y9y7VVdO
         ttEq4DZqadJi6JBJlRK984Me6oF7tc8yhfyHyjYw7UuSPc0c970anKM8dtH2P9Tfdl
         W/A0NQDTkGsu91OWcxft8zXa33tPBgskXOJ37lzY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1j36iewvdo.fsf@starbuckisacylon.baylibre.com>
References: <20190731084019.8451-1-narmstrong@baylibre.com> <20190731084019.8451-2-narmstrong@baylibre.com> <1j36iewvdo.fsf@starbuckisacylon.baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 1/4] clk: core: introduce clk_hw_set_parent()
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 21:47:35 -0700
Message-Id: <20190808044736.A4E83217D7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-08-06 01:28:19)
> On Wed 31 Jul 2019 at 10:40, Neil Armstrong <narmstrong@baylibre.com> wro=
te:
>=20
> > Introduce the clk_hw_set_parent() provider call to change parent of
> > a clock by using the clk_hw pointers.
> >
> > This eases the clock reparenting from clock rate notifiers and
> > implementing DVFS with simpler code avoiding the boilerplates
> > functions as __clk_lookup(clk_hw_get_name()) then clk_set_parent().
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>=20
> Looks ok to me but we will obviously need Stephen's ack to apply it

Acked-by: Stephen Boyd <sboyd@kernel.org>

>=20
> > ---
> >  drivers/clk/clk.c            | 6 ++++++
> >  include/linux/clk-provider.h | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index c0990703ce54..c11b1781d24a 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -2487,6 +2487,12 @@ static int clk_core_set_parent_nolock(struct clk=
_core *core,
> >       return ret;
> >  }
> > =20
> > +int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *parent)
> > +{
> > +     return clk_core_set_parent_nolock(hw->core, parent->core);

I wonder if you really want to call all those things in
clk_core_set_parent_nolock(). For example, do you want notifiers to run
again and for rates to be speculated? Maybe all you want to do is
overwrite some value for the clk's parent by calling into the ops for
the clk and generically parse the value that's passed as the "parent"
here.

I ask because it may be good to avoid doing all that work and updating
bookkeeping when we're deep in a notifier. If we can clearly understand
what the driver wants to do from the notifier then it's simpler to
change in the future to use things such as the coordinated clk rate
vaporware.

