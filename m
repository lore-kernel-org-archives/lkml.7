Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689CDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4239B21897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfICU16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:27:58 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45426 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfICU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:27:57 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i5FP8-0001rH-KK; Tue, 03 Sep 2019 16:27:54 -0400
Message-ID: <6d07046810f4a490960d0124e99fe9cf546e9d10.camel@surriel.com>
Subject: Re: [PATCH 09/15] sched,fair: refactor enqueue/dequeue_entity
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
Date:   Tue, 03 Sep 2019 16:27:54 -0400
In-Reply-To: <CAKfTPtAw1f89d4Sv+vSfytP8pJy-fy1hvpcz-=hoz4nrZXQV6A@mail.gmail.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-10-riel@surriel.com>
         <CAKfTPtAw1f89d4Sv+vSfytP8pJy-fy1hvpcz-=hoz4nrZXQV6A@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3KVupsFccgsyQp48m4rO"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3KVupsFccgsyQp48m4rO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-09-03 at 17:38 +0200, Vincent Guittot wrote:
> Hi Rik,
>=20
> On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
> > Refactor enqueue_entity, dequeue_entity, and update_load_avg, in
> > order
> > to split out the things we still want to happen at every level in
> > the
> > cgroup hierarchy with a flat runqueue from the things we only need
> > to
> > happen once.
> >=20
> > No functional changes.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> > ---
> >  kernel/sched/fair.c | 64 +++++++++++++++++++++++++++++----------
> > ------
> >  1 file changed, 42 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 74ee22c59d13..7b0d95f2e3a8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3502,7 +3502,7 @@ static void detach_entity_load_avg(struct
> > cfs_rq *cfs_rq, struct sched_entity *s
> >  #define DO_ATTACH      0x4
> >=20
> >  /* Update task and its cfs_rq load average */
> > -static inline void update_load_avg(struct cfs_rq *cfs_rq, struct
> > sched_entity *se, int flags)
> > +static inline bool update_load_avg(struct cfs_rq *cfs_rq, struct
> > sched_entity *se, int flags)
> >  {
> >         u64 now =3D cfs_rq_clock_pelt(cfs_rq);
> >         int decayed;
> > @@ -3531,6 +3531,8 @@ static inline void update_load_avg(struct
> > cfs_rq *cfs_rq, struct sched_entity *s
> >=20
> >         } else if (decayed && (flags & UPDATE_TG))
> >                 update_tg_load_avg(cfs_rq, 0);
> > +
> > +       return decayed;
>=20
> This is a functional change, isn't it ?
> update_cfs_group is now called only if decayed but we can we attach a
> task during the enqueue and there is no decay

Yes, it is, and patch 11 changes the way this functional
change is done.

If you want, I can change this patch to not have the
functional change, though in the end it should not make
any difference.

--=20
All Rights Reversed.

--=-3KVupsFccgsyQp48m4rO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1uzMoACgkQznnekoTE
3oMv+wgAqNXCpSJF1ZPAIUHl4zkkyGnlY3m1BdAG8td09jVmyyfZoNdsS3YokCID
7LyZJcfKG6qXQxxEZk04oWlRW481nRVPqU+iWVd49inCz4sFBiIw5vCtJekBZGnR
gX9XUhm11VKOuKAlmi3Bfr04XlL6N0nSFiLWqaDe7mztgUvzhx0cvjjSETn1+PUW
ZpnWvOsB6zHGbBovNitZK9W++X1el+mbB2pE8hQlRwqoUHMHh000pRS0kNG3t/2S
wqxkfm2p7ye6CCm6q+WCl/EzhYyv40L+RqbP2Q5jvlAnkFkM8v3fmvITi5KDmIeF
jFgyXR7vgwTzUqoGKH6oIW84YmYNqA==
=yO8L
-----END PGP SIGNATURE-----

--=-3KVupsFccgsyQp48m4rO--

