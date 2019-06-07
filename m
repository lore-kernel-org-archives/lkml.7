Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87220C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5E4208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559933186;
	bh=J0nw1E2EN/TtoXc1Q4Yuy9LdBjugC1jeuRsyc4v7azA=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=Roz9TGg2CtUVemYsmeGltd3zXkg2YXdP9aekYNa2HSZh+eWgQJcB3uUozNG7UwNUb
	 ETcoteGh3ZaTX+xJ5/diKpEdK/6pMg2mwSFzIy/zHhf/9SXDFBN1tnioTkIIojB/Mp
	 MM+WpAdLSItDnOI3NZnGGr5KFNmltq4Qatbb2aCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbfFGSqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:46:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbfFGSqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:46:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C3F212F5;
        Fri,  7 Jun 2019 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559933181;
        bh=J0nw1E2EN/TtoXc1Q4Yuy9LdBjugC1jeuRsyc4v7azA=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=Z47c1q/I05xsmjxvEUBEAn9G+zpsYmIOQeKwpy7p4Btrw2EpCxb0q8fJGbpPHUUmU
         aNTuF4bwgnnRPh1KEcMQ9msRSOofsnngKvr2604IcjxKCESd1FvjyA7KT3jARjeqSQ
         95Z/vIJbonxZgUyzNQ2EOd3GFUTSDOBC/uqGjPY0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGb2v64VnzXv1-fDDM1bBFWEH7NZp=s5Uw3qRP05WiDvbyqVJA@mail.gmail.com>
References: <20190520080421.12575-1-wens@kernel.org> <20190520090327.iejd3q7c3iwomzlz@flea> <CAGb2v64VnzXv1-fDDM1bBFWEH7NZp=s5Uw3qRP05WiDvbyqVJA@mail.gmail.com>
To:     Chen-Yu Tsai <wens@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 00/25] clk: sunxi-ng: clk parent rewrite part 1
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 11:46:21 -0700
Message-Id: <20190607184621.D5C3F212F5@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chen-Yu Tsai (2019-06-03 09:38:22)
> Hi Stephen,
>=20
> On Mon, May 20, 2019 at 5:03 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Mon, May 20, 2019 at 04:03:56PM +0800, Chen-Yu Tsai wrote:
> > > From: Chen-Yu Tsai <wens@csie.org>
> > >
> > > Hi everyone,
> > >
> > > This is series is the first part of a large series (I haven't done the
> > > rest) of patches to rewrite the clk parent relationship handling with=
in
> > > the sunxi-ng clk driver. This is based on Stephen's recent work allow=
ing
> > > clk drivers to specify clk parents using struct clk_hw * or parsing DT
> > > phandles in the clk node.
> > >
> > > This series can be split into a few major parts:
> > >
> > > 1) The first patch is a small fix for clk debugfs representation. This
> > >    was done before commit 1a079560b145 ("clk: Cache core in
> > >    clk_fetch_parent_index() without names") was posted, so it might or
> > >    might not be needed. Found this when checking my work using
> > >    clk_possible_parents.
> > >
> > > 2) A bunch of CLK_HW_INIT_* helper macros are added. These cover the
> > >    situations I encountered, or assume I will encounter, such as sing=
le
> > >    internal (struct clk_hw *) parent, single DT (struct clk_parent_da=
ta
> > >    .fw_name), multiple internal parents, and multiple mixed (internal=
 +
> > >    DT) parents. A special variant for just an internal single parent =
is
> > >    added, CLK_HW_INIT_HWS, which lets the driver share the singular
> > >    list, instead of having the compiler create a compound literal eve=
ry
> > >    time. It might even make sense to only keep this variant.
> > >
> > > 3) A bunch of CLK_FIXED_FACTOR_* helper macros are added. The rationa=
le
> > >    is the same as the single parent CLK_HW_INIT_* helpers.
> > >
> > > 4) Bulk conversion of CLK_FIXED_FACTOR to use local parent references,
> > >    either struct clk_hw * or DT .fw_name types, whichever the hardware
> > >    requires.
> > >
> > > 5) The beginning of SUNXI_CCU_GATE conversion to local parent
> > >    references. This part is not done. They are included as justificat=
ion
> > >    and examples for the shared list of clk parents case.
> >
> > That series is pretty neat. As far as sunxi is concerned, you can add my
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > > I realize this is going to be many patches every time I convert a clo=
ck
> > > type. Going forward would the people involved prefer I send out
> > > individual patches like this series, or squash them all together?
> >
> > For bisection, I guess it would be good to keep the approach you've
> > had in this series. If this is really too much, I guess we can always
> > change oru mind later on.
>=20
> Any thoughts on this series and how to proceed?
>=20

I have a few minor nitpicks but otherwise the series looks good to me.
I'm perfectly happy to see the individual patches unless you want to
squash them into one big patch. I can review the conversions either way.

Did you need me to apply any patches here? Or can I assume you'll resend
with a pull request so it can be merged into clk-next?

BTW, did you have to update any DT bindings or documentation? I didn't
see anything, so I'm a little surprised that all that stuff was already
in place.

