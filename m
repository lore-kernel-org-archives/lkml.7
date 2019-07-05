Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC328C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA32F216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfGEPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:15:19 -0400
Received: from shelob.surriel.com ([96.67.55.147]:43280 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfGEPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:15:15 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hjPvS-0000YY-Fv; Fri, 05 Jul 2019 11:15:02 -0400
Message-ID: <be6edcebdcf97a2cc920fa46bd21ea92cb57e195.camel@surriel.com>
Subject: Re: [PATCH 07/10] sched,cfs: fix zero length timeslice calculation
From:   Rik van Riel <riel@surriel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>
Date:   Fri, 05 Jul 2019 11:15:01 -0400
In-Reply-To: <CAKfTPtDsh-VxTrwuhb88fi-L4j0ODnNOqhoQ=ZC6E8FVV7Kmkw@mail.gmail.com>
References: <20190628204913.10287-1-riel@surriel.com>
         <20190628204913.10287-8-riel@surriel.com>
         <CAKfTPtDsh-VxTrwuhb88fi-L4j0ODnNOqhoQ=ZC6E8FVV7Kmkw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HQs9BwCYBzovB6giR3c/"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HQs9BwCYBzovB6giR3c/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-07-05 at 16:51 +0200, Vincent Guittot wrote:
> On Fri, 28 Jun 2019 at 22:49, Rik van Riel <riel@surriel.com> wrote:
> > The way the time slice length is currently calculated, not only do
> > high
> > priority tasks get longer time slices than low priority tasks, but
> > due
> > to fixed point math, low priority tasks could end up with a zero
> > length
> > time slice. This can lead to cache thrashing and other
> > inefficiencies.
> >=20
> > Simplify the logic a little bit, and cap the minimum time slice
> > length
> > to sysctl_sched_min_granularity.
> >=20
> > Tasks that end up getting a time slice length too long for their
> > relative
> > priority will simply end up having their vruntime advanced much
> > faster than
> > other tasks, resulting in them receiving time slices less
> > frequently.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  kernel/sched/fair.c | 25 ++++++++-----------------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d48bff5118fc..8da2823401ca 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -671,22 +671,6 @@ static inline u64 calc_delta_fair(u64 delta,
> > struct sched_entity *se)
> >         return delta;
> >  }
> >=20
> > -/*
> > - * The idea is to set a period in which each task runs once.
> > - *
> > - * When there are too many tasks (sched_nr_latency) we have to
> > stretch
> > - * this period because otherwise the slices get too small.
> > - *
> > - * p =3D (nr <=3D nl) ? l : l*nr/nl
> > - */
> > -static u64 __sched_period(unsigned long nr_running)
> > -{
> > -       if (unlikely(nr_running > sched_nr_latency))
> > -               return nr_running * sysctl_sched_min_granularity;
> > -       else
> > -               return sysctl_sched_latency;
> > -}
> > -
> >  /*
> >   * We calculate the wall-time slice from the period by taking a
> > part
> >   * proportional to the weight.
> > @@ -695,7 +679,7 @@ static u64 __sched_period(unsigned long
> > nr_running)
> >   */
> >  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity
> > *se)
> >  {
> > -       u64 slice =3D __sched_period(cfs_rq->nr_running + !se-
> > >on_rq);
> > +       u64 slice =3D sysctl_sched_latency;
>=20
> Is the change above and the remove of __sched_period() really needed
> for fixing the null time slice problem ?
> This change impacts how tasks will preempt each other and as a result
> the throughput. It should have it dedicated patch so we can evaluate
> its impact

Good point. I will split this up into two patches for v3.

Thank you.

--=20
All Rights Reversed.

--=-HQs9BwCYBzovB6giR3c/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0faXYACgkQznnekoTE
3oO+dggAgoB+3g/SWJAfll6lTBKGPKfEb8144N6dPgqNBzcP0Upj5IYW8WKpZdFu
Ttpxxsz8OUnsjqiNNpe6WCowOsQXy8Iv1yIGsuA6wfvIjhjCG2Oz/mCWl3yMoSCd
jbrClNNzJCZ9k3jFFgLJEYyjSkpfS1th570w4XiMLcXbSUUw2FR32B0e7pDG4vrB
nLeDzizZNACvrl3jpDHsU+RYPrXSjRQi+YQ3qH3uvIQLcvqj4MWXyFsxUrrcsTOg
xX0WSCnC7ptD7LkfIhjRJXrPHKUMxJ2YfG8d7zO7zpknE9BazsjOgBoJLYZsIwtK
xgo/FJXLaUMe4j1BJbF88uaqTWntGg==
=9LJE
-----END PGP SIGNATURE-----

--=-HQs9BwCYBzovB6giR3c/--

