Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB224C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DD32147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfFTQ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:29:32 -0400
Received: from shelob.surriel.com ([96.67.55.147]:33188 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfFTQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:29:31 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hdzwB-0001F7-B0; Thu, 20 Jun 2019 12:29:23 -0400
Message-ID: <c5c73fd374ed952eedc46a89af294e1d521609b2.camel@surriel.com>
Subject: Re: [PATCH 5/8] sched,cfs: use explicit cfs_rq of parent se helper
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
Date:   Thu, 20 Jun 2019 12:29:22 -0400
In-Reply-To: <55c0dc01-24b2-bb7f-6ceb-b65c52f7b46b@arm.com>
References: <20190612193227.993-1-riel@surriel.com>
         <20190612193227.993-6-riel@surriel.com>
         <55c0dc01-24b2-bb7f-6ceb-b65c52f7b46b@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-w2+WVxZ+bKnT+u83d5D+"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w2+WVxZ+bKnT+u83d5D+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-20 at 18:23 +0200, Dietmar Eggemann wrote:
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
> > +}
> > +
> >  static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >  {
> >  	struct rq *rq =3D rq_of(cfs_rq);
> > @@ -3298,7 +3307,7 @@ static inline int
> > propagate_entity_load_avg(struct sched_entity *se)
> > =20
> >  	gcfs_rq->propagate =3D 0;
> > =20
> > -	cfs_rq =3D cfs_rq_of(se);
> > +	cfs_rq =3D group_cfs_rq_of_parent(se);
> > =20
> >  	add_tg_cfs_propagate(cfs_rq, gcfs_rq->prop_runnable_sum);
> > =20
> > @@ -7779,7 +7788,7 @@ static void update_cfs_rq_h_load(struct
> > cfs_rq *cfs_rq)
> > =20
> >  	WRITE_ONCE(cfs_rq->h_load_next, NULL);
> >  	for_each_sched_entity(se) {
> > -		cfs_rq =3D cfs_rq_of(se);
> > +		cfs_rq =3D group_cfs_rq_of_parent(se);
>=20
> Why do you change this here? task_se_h_load() calls
> update_cfs_rq_h_load() with cfs_rq =3D group_cfs_rq_of_parent(se)
> because
> the task might not be on the cfs_rq yet.

Because patch 6 points cfs_rq_of(se) at the CPU's top level
cfs_rq for every task se ...

... but I guess since I have not changed where the cfs_rq_of
points for cgroup sched_entities, this change is not necessary
at this time, and I should be able to go without it, in this
function.

> But inside update_cfs_rq_h_load() the first se is derived from
> cfs_rq->tg->se[cpu_of(rq)] so in the first for_each_sched_entity()
> loop
> we should still start with group_cfs_rq() (se->my_q) ?
>=20
> The system doesn't barf with these two WARN_ON's in.
>=20
> @@ -7663,12 +7673,17 @@ static void update_cfs_rq_h_load(struct
> cfs_rq
> *cfs_rq)
>         unsigned long now =3D jiffies;
>         unsigned long load;
>=20
> +       WARN_ON(se && (se !=3D group_cfs_rq(se)->tg->se[cpu_of(rq)]));
> +
>         if (cfs_rq->last_h_load_update =3D=3D now)
>                 return;
>=20
>         WRITE_ONCE(cfs_rq->h_load_next, NULL);
>         for_each_sched_entity(se) {
>                 cfs_rq =3D group_cfs_rq_of_parent(se);
> +
> +               WARN_ON(se !=3D group_cfs_rq(se)->tg->se[cpu_of(rq)]);
> +
>                 WRITE_ONCE(cfs_rq->h_load_next, se);
>                 if (cfs_rq->last_h_load_update =3D=3D now)
>                         break;
>=20
>=20
> [...]
>=20
>=20
--=20
All Rights Reversed.

--=-w2+WVxZ+bKnT+u83d5D+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0LtGIACgkQznnekoTE
3oM9NAf/UnAL3DF59JnAtDhLL72d/rfmEppMfRJqrboF7soYC1GLtCFRqE3DyFxM
pwSDwrY4vcyU9owZEwnj/6cMPhX9XDKOYSZNvk5fBHL4Seevw5Cvg76F1drDy+lh
e9qhSf8j3L3DdkZMQAU8eRoJiTFn74H3LeEC82wtJ+2MMkfMr14CyWlAIRYTtIM5
72Y6OdgCkSi6ZULxGbW+XjBZBpl3M5LnNj1S3WRhF1AHxatjjfJMAvKuIcjgy8Su
qz1SietoyNbDG8iBgV/oCXe7keO68HPjKsuO/N4wx6uoC061m7//MOJi1H8z042x
K8HECKFygf+ksJqIvqgEUMgk2YMe9Q==
=OOl+
-----END PGP SIGNATURE-----

--=-w2+WVxZ+bKnT+u83d5D+--

