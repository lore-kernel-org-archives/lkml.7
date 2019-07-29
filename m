Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF00C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D592073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfG2VOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:14:02 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48766 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388272AbfG2VOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:14:02 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hsCxr-0005ve-07; Mon, 29 Jul 2019 17:13:51 -0400
Message-ID: <97675ac29db1339ff683bf7eacf97540b00bd2a1.camel@surriel.com>
Subject: Re: [PATCH 03/14] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Mon, 29 Jul 2019 17:13:50 -0400
In-Reply-To: <20190729200557.GR31398@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
         <20190722173348.9241-4-riel@surriel.com>
         <20190729200557.GR31398@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Me4KYEfemhtrh7ZeTQsr"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Me4KYEfemhtrh7ZeTQsr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 22:05 +0200, Peter Zijlstra wrote:
> On Mon, Jul 22, 2019 at 01:33:37PM -0400, Rik van Riel wrote:
> > @@ -3012,25 +2983,24 @@ static inline int
> > throttled_hierarchy(struct cfs_rq *cfs_rq);
> >  static void update_cfs_group(struct sched_entity *se)
> >  {
> >  	struct cfs_rq *gcfs_rq =3D group_cfs_rq(se);
> > -	long shares, runnable;
> > +	long shares;
> > =20
> > -	if (!gcfs_rq)
> > +	if (!gcfs_rq) {
> > +		update_runnable_load_avg(se);
> >  		return;
> > +	}
> > =20
> >  	if (throttled_hierarchy(gcfs_rq))
> >  		return;
> > =20
> >  #ifndef CONFIG_SMP
> > -	runnable =3D shares =3D READ_ONCE(gcfs_rq->tg->shares);
> > -
> >  	if (likely(se->load.weight =3D=3D shares))
>=20
> I'm thinking this uses @shares uninitialized...

Oops indeed. Let me put the shares =3D assignment
back for the !SMP case, and edit that comment.

> >  		return;
> >  #else
> >  	shares   =3D calc_group_shares(gcfs_rq);
> > -	runnable =3D calc_group_runnable(gcfs_rq, shares);
> >  #endif
> > =20
> > -	reweight_entity(cfs_rq_of(se), se, shares, runnable);
> > +	reweight_entity(cfs_rq_of(se), se, shares);
> >  }
--=20
All Rights Reversed.

--=-Me4KYEfemhtrh7ZeTQsr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0/YY4ACgkQznnekoTE
3oPu+QgAtD//6skWmvbZFIfUOWw/4hq1dgCOSNUon92qi/OyTFXLYFlNe+WLb00V
Oj37stqqWFnmCuVpNGKde1mfP+dW1Gbewi2N3NUHEr6CLWSFaWFAdYQPVMJEc8FF
cdVCIziMkFjZ2EXaezMRkCVQ09XN962agCiG68BGh5d77THopy7a+cDV/6dw+jjl
1V1IxeEKuWoBqVu+UJ1jjObUUtHjZOt0cosq5pvxtnAnNSPX/yBu8ZEoeWX49o5m
Yv+ihmDa+fY1tXIZ53kRzyLnsa8dPaT7q54k48qF4/6S/3ZNSN2n+CkS70bpF+Ta
IMZyz5gj8agjM3yawliTVx+hy7x27w==
=VvI1
-----END PGP SIGNATURE-----

--=-Me4KYEfemhtrh7ZeTQsr--

