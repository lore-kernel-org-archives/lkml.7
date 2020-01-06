Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6270C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974A42467F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgAFQpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:45:09 -0500
Received: from shelob.surriel.com ([96.67.55.147]:39924 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:45:09 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ioVUw-0005LM-18; Mon, 06 Jan 2020 11:44:58 -0500
Message-ID: <03ad3a0a1d8e84c12ad958e291040a32a49c9f0f.camel@surriel.com>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v3
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Jan 2020 11:44:57 -0500
In-Reply-To: <20200106163303.GC3466@techsingularity.net>
References: <20200106144250.GA3466@techsingularity.net>
         <04033a63f11a9c59ebd2b099355915e4e889b772.camel@surriel.com>
         <20200106163303.GC3466@techsingularity.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-sPn5r1noHxTQZJxPt3V5"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sPn5r1noHxTQZJxPt3V5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-06 at 16:33 +0000, Mel Gorman wrote:
> On Mon, Jan 06, 2020 at 10:47:18AM -0500, Rik van Riel wrote:
> > > +			imbalance_adj =3D (100 / (env->sd->imbalance_pct
> > > - 100)) - 1;
> > > +
> > > +			/*
> > > +			 * Allow small imbalances when the busiest
> > > group has
> > > +			 * low utilisation.
> > > +			 */
> > > +			imbalance_max =3D imbalance_adj << 1;
> > > +			if (busiest->sum_nr_running < imbalance_max)
> > > +				env->imbalance -=3D min(env->imbalance,
> > > imbalance_adj);
> > > +		}
> > > +
> >=20
> > Wait, so imbalance_max is a function only of
> > env->sd->imbalance_pct, and it gets compared
> > against busiest->sum_nr_running, which is related
> > to the number of CPUs in the node?
> >=20
>=20
> It's not directly related to the number of CPUs in the node. Are you
> thinking of busiest->group_weight?

I am, because as it is right now that if condition
looks like it might never be true for imbalance_pct 115.

Presumably you put that check there for a reason, and
would like it to trigger when the amount by which a node
is busy is less than 2 * (imbalance_pct - 100).

--=20
All Rights Reversed.

--=-sPn5r1noHxTQZJxPt3V5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl4TZAkACgkQznnekoTE
3oMU3ggAqglhu6aXyxYNartxLHIT5xSm8cCf4hEGUUYU8yUG1Ti+Q5XLV3LHltMa
k9YkG32W+H2zlnatDY8FCmZ/lxoF+R/6ZcoXIlTQhY8s6mbbv92lEqQxeyorX7P2
vwzRGz/gaEfOv5/CSoJu2wkNgyZ5r2gMxMDqRKYoevxg87XzNqrcy1D2YiNMqcH6
gFYc2PKSiT4krfuLPNMANLZp63vQnD0Nu6m4m4Z4GsiuaYqbJyU1GJWVQfihYZUc
v+mhzKopJtcShkj1SNwdNvZWpyA7wbpucNEleO/vx93hxG4TARgS7a6HL34i6HS1
LqkKwTetbXPkAwFX8dUcCDGfNUwy0g==
=OwY9
-----END PGP SIGNATURE-----

--=-sPn5r1noHxTQZJxPt3V5--

