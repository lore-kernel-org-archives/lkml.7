Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D2BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD5621473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742807;
	bh=y4/V2zu09CDwajaerydJz2FxWhvpZjBBW3M/NvKWtPk=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=qnJO3yW6jpYFanPYyFTiyX6fSjDc1BOS8oG+wBrvUKQ6dude0xF6ph6wN6GIqmam2
	 GikSQTvln0JQ9+qDCooYncX4ULX+Lyq4hCChylVlG3sWS7seyLPCTHKCUGJG7EL55P
	 FwUMqFsCWfV87uf5fDLvCkvqyBnbe7FuSwt86JLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfDHRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbfDHRAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:00:05 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C1D20880;
        Mon,  8 Apr 2019 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554742804;
        bh=y4/V2zu09CDwajaerydJz2FxWhvpZjBBW3M/NvKWtPk=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=JqSY3Qz3ubyu+TKWxdRQD2TSvBvcNKT+imWhmZ8vize83tZWRNPTArw6AYUQD3+WM
         eUjEvVu4ZWKMxNrKasRHdyPfqlshi+YuYftuVye5ORSO31iUJZF6neJw4olG2DhkpZ
         IjpkDzd3xaz9Opr/kxucW5MqxSQMPM1s8VoHn+yE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190408104941.GB17594@localhost.localdomain>
References: <20190404215344.6330-1-sboyd@kernel.org> <20190404215344.6330-2-sboyd@kernel.org> <b3a3052056b787bde94178ed371417359a941f2d.camel@fi.rohmeurope.com> <155449664462.20095.10904772826291270300@swboyd.mtv.corp.google.com> <20190408104941.GB17594@localhost.localdomain>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating clocks list
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Message-ID: <155474280295.20095.182612336816713159@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 08 Apr 2019 10:00:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2019-04-08 03:49:41)
> On Fri, Apr 05, 2019 at 01:37:24PM -0700, Stephen Boyd wrote:
> > Quoting Vaittinen, Matti (2019-04-04 23:51:43)
> > > On Thu, 2019-04-04 at 14:53 -0700, Stephen Boyd wrote:
> > > > We recently introduced a change to support devm clk lookups. That
> > > > change
> > > > introduced a code-path that used clk_find() without holding the
> > > > 'clocks_mutex'. Unfortunately, clk_find() iterates over the 'clocks'
> > > > list and so we need to prevent the list from being modified while
> > > > iterating over it by holding the mutex. Similarly, we don't need to
> > > > hold
> > > > the 'clocks_mutex' besides when we're dereferencing the clk_lookup
> > > > pointer
> > >=20
> > > /// Snip
> > >=20
> > > > -out:
> > > > +static struct clk_lookup *clk_find(const char *dev_id, const char
> > > > *con_id)
> > > > +{
> > > > +     struct clk_lookup *cl;
> > > > +
> > > > +     mutex_lock(&clocks_mutex);
> > > > +     cl =3D __clk_find(dev_id, con_id);
> > > >       mutex_unlock(&clocks_mutex);
> > > > =20
> > > > -     return cl ? clk : ERR_PTR(-ENOENT);
> > > > +     return cl;
> > > > +}
> > >=20
> > > I am not an expert on this but reading commit message abowe and seeing
> > > the code for clk_find() looks a bit scary. If I understand it
> > > correctly, the clocks_mutex should be held when dereferencing the
> > > clk_lookup returned by clk_find. The clk_find implementation drops the
> > > lock before returning - which makes me think I miss something here. H=
ow
> > > can the caller ever safely dereference returned clk_lookup pointer?
> > > Just reading abowe makes me think that lock should be taken by whoever
> > > is calling the clk_find, and dropped only after caller has used the
> > > found clk_lookup for whatever caller intends to use it. Maybe I am
> > > missing something?
> > >=20
> >=20
> > The only user after this patch (devm) is doing a pointer comparison so
> > it looks OK. But yes, in general there shouldn't be users of clk_find()
> > that dereference the pointer because there isn't any protection besides
> > the mutex.
>=20
> If the only (intended) user for clk_find is devm_clk_release_clkdev,
> then we might want to write it in devm_clk_release_clkdev - just to
> avoid similar errors (as I did with devm) in the future? I might even
> consider renaming __clk_find to clk_find or to clk_find_unsafe - but
> that's all just nitpicking :) Go with what you like to maintain :D
>=20

Sure. I was thinking along the same lines after you asked.

