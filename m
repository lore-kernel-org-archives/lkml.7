Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E15C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE0C2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFZQPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:15:12 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58008 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:15:12 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hgAZd-0003CK-II; Wed, 26 Jun 2019 12:15:05 -0400
Message-ID: <80debf449017604657abd9086d81b8cfc0e0ad5e.camel@surriel.com>
Subject: Re: [PATCH 5/8] sched,cfs: use explicit cfs_rq of parent se helper
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.com, vincent.guittot@linaro.org
Date:   Wed, 26 Jun 2019 12:15:05 -0400
In-Reply-To: <0032016d-78d1-8338-96af-3077d3219f47@arm.com>
References: <20190612193227.993-1-riel@surriel.com>
         <20190612193227.993-6-riel@surriel.com>
         <0032016d-78d1-8338-96af-3077d3219f47@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wYMOZdD6INRRhzcHO2Cu"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wYMOZdD6INRRhzcHO2Cu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-26 at 17:58 +0200, Dietmar Eggemann wrote:
> On 6/12/19 9:32 PM, Rik van Riel wrote:
> > Use an explicit "cfs_rq of parent sched_entity" helper in a few
> > strategic places, where cfs_rq_of(se) may no longer point at the
> > right runqueue once we flatten the hierarchical cgroup runqueues.
> >=20
> > No functional change.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  kernel/sched/fair.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index dcc521d251e3..c6ede2ecc935 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -275,6 +275,15 @@ static inline struct cfs_rq
> > *group_cfs_rq(struct sched_entity *grp)
> >  	return grp->my_q;
> >  }
> > =20
> > +/* runqueue owned by the parent entity */
> > +static inline struct cfs_rq *group_cfs_rq_of_parent(struct
> > sched_entity *se)
> > +{
> > +	if (se->parent)
> > +		return group_cfs_rq(se->parent);
> > +
> > +	return &cfs_rq_of(se)->rq->cfs;
>=20
> The function name and the description is not 100% correct. For tasks
> running naturally (not in a flattened taskgroup) in the root
> taskgroup
> or for the se representing a first level taskgroup (e.g. /tg1 (with
> se->depth =3D 0)) it returns the root cfs_rq or easier se->cfs_rq.
>=20
> So you could replace
>=20
>     return &cfs_rq_of(se)->rq->cfs;
>=20
> with
>=20
>     return se->cfs_rq;
>=20
> or
>=20
>     return cfs_rq_of(se);

Good point. I will do that for the v2 series.


--=20
All Rights Reversed.

--=-wYMOZdD6INRRhzcHO2Cu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0TmgkACgkQznnekoTE
3oMhnQgAqlWTfa84qiBu5AU9Azs8y+MKl9j5ch2reI/vwTY/hQVnlNZyKkDlz4R9
Hbtvw+e/XPQt41P/bz64wLLbalMIkgkKQRtEdDlfNLm+kpM+l7d3T9oik+xACir3
whliujKCS1S6KglDFoM46/a110CCaCgemYorzZY1VWavY89vGSqqcEeLQGuS2Xm5
i+1haWrNJUr007PyvtyqPGAqhOC3gZ4n9Fb+OESMzOi5yB1kXeRSMT4Bv6XfBcBj
sKyqC+2AsCqdv5hjrlbLswgh1yN6iSoXtZrDzFwLnZp6hHwXGyG+CpDbTpo00EV+
/iDEi8D/6C80G5At/k6I7ay2puXi5g==
=dLeB
-----END PGP SIGNATURE-----

--=-wYMOZdD6INRRhzcHO2Cu--

