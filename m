Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4818C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC0420838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 22:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567807390;
	bh=JYOTkYYE3g9CREcW4Rr1oQgc7T/eq+7DhhZhFapLkq8=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=GZjgHV3PABZR4k4Qs7JEXBaT+tZOe/9pblIsYg7kkXEdJiqeT+6bvi1QQpB7F2zJM
	 xbiqm7bVwkxRm3oB8zSCpNfrY5PiSlntK7UyUWtRwRtxqv9pBjZ8yBYi0LIf8Xldgq
	 N/LCC5oA/g84n/qZKZ9PEiSYdKFLGVd6IF16ZE70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391961AbfIFWDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390045AbfIFWDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 18:03:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C8742081B;
        Fri,  6 Sep 2019 22:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567807388;
        bh=JYOTkYYE3g9CREcW4Rr1oQgc7T/eq+7DhhZhFapLkq8=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=sP6sCyo5xiItbKXA2QHUtl2blDkXsni7Mgxs4uuomLLMvb2Eib+I1px0DIRy7OMUA
         UzF5N1e9CJMlOgYUX0zcdjUxVoFEs5v/AZNeGj2DTaDvv4xNlGDr4ESI+s57DvxZD6
         JT2HajE5DVqfglx5YrEaoDDuPkkASHqo80KmRetU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CACPK8Xf3C36KMgDmmRtNFqVFHzZx81ko+=54PA4+d5xPitum3g@mail.gmail.com>
References: <20190816155806.22869-1-joel@jms.id.au> <20190816155806.22869-3-joel@jms.id.au> <20190816171441.3B8F720665@mail.kernel.org> <CACPK8Xf3C36KMgDmmRtNFqVFHzZx81ko+=54PA4+d5xPitum3g@mail.gmail.com>
To:     Joel Stanley <joel@jms.id.au>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] clk: Add support for AST2600 SoC
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 15:03:07 -0700
Message-Id: <20190906220308.6C8742081B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2019-08-18 19:03:54)
> On Fri, 16 Aug 2019 at 17:14, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Joel Stanley (2019-08-16 08:58:06)
> > > +static const char * const vclk_parent_names[] =3D {
> >
> > Can you use the new way of specifying clk parents instead of just using
> > strings?
>=20
> How does this work? I had a browse of the APIs in clk-provider.h and
> it appeared the functions all take char *s still.

Sorry I didn't reply earlier. I'm going to write a kernel-doc to
describe how to write a "modern" clk driver which should hopefully help
here.

The gist is that you can fill out a clk_parent_data array or a clk_hw
array and set the .name and .fw_name and .index in the clk_parent_data
array to indicate which clks to get from the DT node's "clocks" and
"clock-names" properties.

>=20
> > > +       hw =3D clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1=
, axi_div * ahb_div);

Take this one for example. If 'hpll' is actually a clk_hw pointer in
hand, then you could do something like:

	clk_hw_register_fixed_factor_parent_hw(NULL, "ahb", &hpll, 0, 1, axi_div *=
 ahb_div);

And if it's something like a clock from DT you could do

	struct clk_parent_data pdata =3D {
		.name =3D "hpll",
		.fw_name =3D <clock-names string>,
		.index =3D <whatever clock index it is>
	};

	clk_hw_register_fixed_factor_parent_data(NULL, "ahb", &pdata, 0, 1, axi_di=
v * ahb_div);

I haven't actually written the clk_hw_register_fixed_factor_*() APIs,
because I'm thinking that it would be better to register the pdata with
some more parameters so that the
clk_hw_register_fixed_factor_parent_data() API becomes more like:

	clk_hw_register_fixed_factor_parent_data(NULL, "ahb", "hpll",
		<clock-names string>, <whatever clock index it is>, 0, 1,
		axi_div * ahb_div);

Because there's only one parent. For the mux clk it will be a pointer to
parent_data because I don't see a way around it.

> >
> > There aren't checks for if these things fail. I guess it doesn't matter
> > and just let it fail hard?
>=20
> I think that's sensible here. If the system has run out of memory this
> early on then there's not going to be much that works.
>=20
> Thanks for the review. I've fixed all of the style issues you
> mentioned, but would appreciate some guidance on the parent API.
>=20

Cool! Thanks.

