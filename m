Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76760C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FAF2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfEUOuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:50:50 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58885 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUOuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:50:50 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 033AB60006;
        Tue, 21 May 2019 14:50:47 +0000 (UTC)
Date:   Tue, 21 May 2019 16:50:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Convert vendor prefixes to json-schema
Message-ID: <20190521145047.dyfvrzxviqchmxp2@flea>
References: <20190510194018.28206-1-robh@kernel.org>
 <20190520131846.tqx7h7sjyw6sgka5@flea>
 <CAL_JsqLbuuO9YHYwTXV5ZEGOjzZHgVsWD=TCYk4cYpm0v1zHkQ@mail.gmail.com>
 <CAL_JsqKAP85+KnQtq-xaOdX-BetB0pA7+LT8vd6w=Yz4VWnQJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="chpalzxqydzs6tku"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKAP85+KnQtq-xaOdX-BetB0pA7+LT8vd6w=Yz4VWnQJg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--chpalzxqydzs6tku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 04:23:20PM -0500, Rob Herring wrote:
> On Mon, May 20, 2019 at 11:35 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, May 20, 2019 at 8:18 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Fri, May 10, 2019 at 02:40:18PM -0500, Rob Herring wrote:
> > > > Convert the vendor prefix registry to a schema. This will enable checking
> > > > that new vendor prefixes are added (in addition to the less than perfect
> > > > checkpatch.pl check) and will also check against adding other prefixes
> > > > which are not vendors.
> > > >
> > > > Converted vendor-prefixes.txt using the following sed script:
> > > >
> > > > sed -e 's/\([a-zA-Z0-9\-]*\)[[:space:]]*\([a-zA-Z0-9].*\)/  "^\1,\.\*\":\n    description: \2/'
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > > As vendor prefix updates come in via multiple trees, I plan to merge
> > > > this before -rc1 to avoid cross tree conflicts.
> > >
> > > I just tried this with the 5.2-rc1 release, and this very
> > > significantly slows down the validation.
> > >
> > > With a dtbs_check run on (arm's) sunxi_defconfig, on my core-i5 with 4
> > > threads, I go from 1.30 minutes to more than 12.
> >
> > Indeed. 6 min to 45 min for allmodconfig. However, it's only 5 min to
> > run checks with only this file. I'd expect a more linear hit. Maybe
> > we're exceeding some cache size and thrashing.
>
> Looks like the problem is a cache. The python regex cache. Changing
> re._MAXCACHE from 512 to 4096 fixes the problem. I can set this in the
> dtschema lib.

Awesome, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--chpalzxqydzs6tku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOQQRwAKCRDj7w1vZxhR
xdQuAP439mUERuocEuZCT95DT2OAX3WDau0S9oAgoQyBNYQh4gEAlvtU2tFlk5CI
wEVaeMJC4qe2gEhqPEta9eBgwK33NQM=
=JAGU
-----END PGP SIGNATURE-----

--chpalzxqydzs6tku--
