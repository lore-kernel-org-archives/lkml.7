Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7403C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A66208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfF1TgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:36:25 -0400
Received: from shelob.surriel.com ([96.67.55.147]:38268 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfF1TgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:36:25 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hgwfQ-0008Qs-D3; Fri, 28 Jun 2019 15:36:16 -0400
Message-ID: <27e1ce40c50a1b575527531bfc8dd562843b8ad5.camel@surriel.com>
Subject: Re: [PATCH 8/8] sched,fair: flatten hierarchical runqueues
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.com, vincent.guittot@linaro.org
Date:   Fri, 28 Jun 2019 15:36:15 -0400
In-Reply-To: <1146bbfd-ae1e-27d8-6b62-d68392d8130f@arm.com>
References: <20190612193227.993-1-riel@surriel.com>
         <20190612193227.993-9-riel@surriel.com>
         <1146bbfd-ae1e-27d8-6b62-d68392d8130f@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6PyMai3QXP/n3170GSeT"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6PyMai3QXP/n3170GSeT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-28 at 12:26 +0200, Dietmar Eggemann wrote:
> On 6/12/19 9:32 PM, Rik van Riel wrote:
> > Flatten the hierarchical runqueues into just the per CPU rq.cfs
> > runqueue.
> >=20
> > Iteration of the sched_entity hierarchy is rate limited to once per
> > jiffy
> > per sched_entity, which is a smaller change than it seems, because
> > load
> > average adjustments were already rate limited to once per jiffy
> > before this
> > patch series.
> >=20
> > This patch breaks CONFIG_CFS_BANDWIDTH. The plan for that is to
> > park tasks
> > from throttled cgroups onto their cgroup runqueues, and slowly
> > (using the
> > GENTLE_FAIR_SLEEPERS) wake them back up, in vruntime order, once
> > the cgroup
> > gets unthrottled, to prevent thundering herd issues.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  include/linux/sched.h |   2 +
> >  kernel/sched/fair.c   | 478 +++++++++++++++++---------------------
> > ----
> >  kernel/sched/pelt.c   |   6 +-
> >  kernel/sched/pelt.h   |   2 +-
> >  kernel/sched/sched.h  |   2 +-
> >  5 files changed, 194 insertions(+), 296 deletions(-)
> >=20
>=20
> [...]
>=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>=20
> [...]
>=20
> > @@ -3491,7 +3544,7 @@ static inline bool update_load_avg(struct
> > cfs_rq *cfs_rq, struct sched_entity *s
> >  	 * track group sched_entity load average for task_h_load calc
> > in migration
> >  	 */
> >  	if (se->avg.last_update_time && !(flags & SKIP_AGE_LOAD))
> > -		updated =3D __update_load_avg_se(now, cfs_rq, se);
> > +		updated =3D __update_load_avg_se(now, cfs_rq, se, curr,
> > curr);
>=20
> I wonder if task migration is still working correctly.
>=20
> migrate_task_rq_fair(p, ...) -> remove_entity_load_avg(&p->se) would
> use
> cfs_rq =3D se->cfs_rq (i.e. root cfs_rq). So load (and util) will not
> propagate through the taskgroup hierarchy.
>=20
> [...]

Good point. This should be the group cfs_rq, and
then on the next tick the load change will be=20
propagated up.

Let me add that change in for v2 as well.

--=20
All Rights Reversed.

--=-6PyMai3QXP/n3170GSeT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0WbDAACgkQznnekoTE
3oP9oQf/aeOsTlZQXSP/CpQs/0riPf9KL0PUIZ0PUsITghfB7jyFNBJKqdUldRVy
wrc6gwPv9TVow+zP9oFuOKIfF2hqHIyxHoKhrFkG4jAclR9fq4rqfDvI5AE/Kw7q
PT8iVWvsi90cF0SfmlaACPJ06hIj+48sehY0UdHY3j8CIWhqJgknLur3f14RKhU1
s7X+cefjXrPOXjqcIlRpMnAl3wg2Mz66rSJk1cLjDDtIMDds72LxGkc6ee822ei/
TyOj4zmHEdW3HwkQntg6yYi9hf07mekMhvmuvzkEucK5cWCODyEiWWoBuEPneEDp
xngncEsP0B5VKUyDX/MtTVXwSvX4Bg==
=wXrm
-----END PGP SIGNATURE-----

--=-6PyMai3QXP/n3170GSeT--

