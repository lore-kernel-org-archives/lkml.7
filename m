Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB79C282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDA721773
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554496648;
	bh=lkXfXLb6Nio46/ZeLdZm/xm+RmZFUfnRAf6GLw8hUmk=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=RJDnRqox8fXtOPowArmDaccjasf+srxWBuouSub6NusB3/PUwCdALde6nAfWOXryr
	 d8ZXMoM0nNRONcDhiNjlOhQFalluTPkbb/aA7lCsmzd/0uNqp4oz0rJq/wSf5Omb4q
	 Sj5y7f39Tbfw0N8V+ohGMWwvRCQUHUT3CngAPyY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDEUh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfDEUh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:37:26 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 690402146F;
        Fri,  5 Apr 2019 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554496645;
        bh=lkXfXLb6Nio46/ZeLdZm/xm+RmZFUfnRAf6GLw8hUmk=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=AYw4Tlw3wIBCb1rniLIcUhH+HKbKkRZvODn1sHsUfGEiFPZtVGQn4c4ElYolsIhw/
         OxsUqqV/R6CzTMiOerbeD34pR/oCkG2V9JfiW6XaH/Gyn86WNCG+QueQELTR8dPEPG
         fmbqODGYWD8TVvi1IMKRh4tCNAvQWye4PpBfwW28=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b3a3052056b787bde94178ed371417359a941f2d.camel@fi.rohmeurope.com>
References: <20190404215344.6330-1-sboyd@kernel.org> <20190404215344.6330-2-sboyd@kernel.org> <b3a3052056b787bde94178ed371417359a941f2d.camel@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/7] clkdev: Hold clocks_mutex while iterating clocks list
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "jhugo@codeaurora.org" <jhugo@codeaurora.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Message-ID: <155449664462.20095.10904772826291270300@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 05 Apr 2019 13:37:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vaittinen, Matti (2019-04-04 23:51:43)
> On Thu, 2019-04-04 at 14:53 -0700, Stephen Boyd wrote:
> > We recently introduced a change to support devm clk lookups. That
> > change
> > introduced a code-path that used clk_find() without holding the
> > 'clocks_mutex'. Unfortunately, clk_find() iterates over the 'clocks'
> > list and so we need to prevent the list from being modified while
> > iterating over it by holding the mutex. Similarly, we don't need to
> > hold
> > the 'clocks_mutex' besides when we're dereferencing the clk_lookup
> > pointer
>=20
> /// Snip
>=20
> > -out:
> > +static struct clk_lookup *clk_find(const char *dev_id, const char
> > *con_id)
> > +{
> > +     struct clk_lookup *cl;
> > +
> > +     mutex_lock(&clocks_mutex);
> > +     cl =3D __clk_find(dev_id, con_id);
> >       mutex_unlock(&clocks_mutex);
> > =20
> > -     return cl ? clk : ERR_PTR(-ENOENT);
> > +     return cl;
> > +}
>=20
> I am not an expert on this but reading commit message abowe and seeing
> the code for clk_find() looks a bit scary. If I understand it
> correctly, the clocks_mutex should be held when dereferencing the
> clk_lookup returned by clk_find. The clk_find implementation drops the
> lock before returning - which makes me think I miss something here. How
> can the caller ever safely dereference returned clk_lookup pointer?
> Just reading abowe makes me think that lock should be taken by whoever
> is calling the clk_find, and dropped only after caller has used the
> found clk_lookup for whatever caller intends to use it. Maybe I am
> missing something?
>=20

The only user after this patch (devm) is doing a pointer comparison so
it looks OK. But yes, in general there shouldn't be users of clk_find()
that dereference the pointer because there isn't any protection besides
the mutex.

