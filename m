Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C172087C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551895210;
	bh=gKXUJgtTS6AIBw7vEV/Mub5TOrGtfxQInsx8I4Q4MP4=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=wEaZDWGENYv19it9yjVg1bvBfv6D3PdRS1o6LwMzxYBDDM/6PWMz6hEdTSbFQoArB
	 RwwXQ+iKbianjBTBTv0QcYcifQMDw9dPXYGNpuN4eCZvYxIT/Vjp4QEGvmrQPjufrF
	 B6AISVbTGxkC4ji9EDrOjMedaHaQ0+g3v3+zzJ/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfCFSAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbfCFSAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:00:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49A720652;
        Wed,  6 Mar 2019 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551895206;
        bh=gKXUJgtTS6AIBw7vEV/Mub5TOrGtfxQInsx8I4Q4MP4=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=poPqh5QwHJ+lNcL8w8IYd4j4wKSfW8+yxNusZsoZcZZ3k3+twCAakuC3jXoZXpPtO
         rvIK4IHExO+LeJ3T50k+YykLuBxB+Zm4ngaRmo08B2TPdiWTES1hUQmLxR3tNZZ17k
         A2TTv67XccT/by2EE+9Gy3XCidw6FeGrsQ31bB7U=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <fc94b0cdd050d10ee9c83dc5f918fedab4fb0fc7.camel@baylibre.com>
References: <20190226223429.193873-1-sboyd@kernel.org> <20190226223429.193873-7-sboyd@kernel.org> <fc94b0cdd050d10ee9c83dc5f918fedab4fb0fc7.camel@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 6/8] clk: Allow parents to be specified without string names
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155189520594.20095.18225586788918924296@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 06 Mar 2019 10:00:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-03-02 10:40:42)
> On Tue, 2019-02-26 at 14:34 -0800, Stephen Boyd wrote:
> > The common clk framework is lacking in ability to describe the clk
> > topology without specifying strings for every possible parent-child
> > link. There are a few drawbacks to the current approach:
> >=20
> >  1) String comparisons are used for everything, including describing
> >  topologies that are 'local' to a single clock controller.
> >=20
> >  2) clk providers (e.g. i2c clk drivers) need to create globally unique
> >  clk names to avoid collisions in the clk namespace, leading to awkward
> >  name generation code in various clk drivers.
> >=20
> >  3) DT bindings may not fully describe the clk topology and linkages
> >  between clk controllers because drivers can easily rely on globally un=
ique
> >  strings to describe connections between clks.
> >=20
> > This leads to confusing DT bindings, complicated clk name generation
> > code, and inefficient string comparisons during clk registration just so
> > that the clk framework can detect the topology of the clk tree.
> > Furthermore, some drivers call clk_get() and then __clk_get_name() to
> > extract the globally unique clk name just so they can specify the parent
> > of the clk they're registering. We have of_clk_parent_fill() but that
> > mostly only works for single clks registered from a DT node, which isn't
> > the norm. Let's simplify this all by introducing two new ways of
> > specifying clk parents.
> >=20
> > The first method is an array of pointers to clk_hw structures
> > corresponding to the parents at that index. This works for clks that are
> > registered when we have access to all the clk_hw pointers for the
> > parents.
> >=20
> > The second method is a mix of clk_hw pointers and strings of local and
> > global parent clk names. If the .name member of the map is set we'll
> > look for that clk by performing a DT based lookup of the device the clk
> > is registered with and the .name specified in the map. If that fails,
> > we'll fallback to the .fallback member and perform a global clk name
> > lookup like we've always done before.
>=20
> Nitpick: I think you forgot to update the commit message when renaming the
> struct members

Fixed. Thanks!

>=20
> >=20
> > Using either one of these new methods is entirely optional. Existing
> > drivers will continue to work, and they can migrate to this new approach
> > as they see fit. Eventually, we'll want to get rid of the 'parent_names'
> > array in struct clk_init_data and use one of these new methods instead.
> >=20
>=20
> Being able to specify parents from DT is great addition !!! Thx !

Woohooo!

>=20
> Overall, it looks good but with such big patch on framework is not easy g=
et a
> clear idea. I'll try to give it a spin next week.

Ok. Please be aware that I found one bug already but there are probably
more lurking. I've also pushed the branch out to clk.git on kernel.org
if you're interested in looking at the mass conversions going on.

https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-parent-re=
write

