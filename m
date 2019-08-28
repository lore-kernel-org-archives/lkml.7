Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0385DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D645922CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfH1OsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:48:00 -0400
Received: from shelob.surriel.com ([96.67.55.147]:32774 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfH1OsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:48:00 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i2zEi-00018S-V1; Wed, 28 Aug 2019 10:47:48 -0400
Message-ID: <98dffa226df25fd0d3017605bc7343c330f79a7e.camel@surriel.com>
Subject: Re: [PATCH 03/15] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
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
Date:   Wed, 28 Aug 2019 10:47:48 -0400
In-Reply-To: <CAKfTPtAYBiYPQod4KTbk3dXL2zpkF3kOVG4oW6i-JCHO5sNNxQ@mail.gmail.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-4-riel@surriel.com>
         <CAKfTPtAYBiYPQod4KTbk3dXL2zpkF3kOVG4oW6i-JCHO5sNNxQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/JNyIUHGgxPk9J2Mpf6W"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/JNyIUHGgxPk9J2Mpf6W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-28 at 15:50 +0200, Vincent Guittot wrote:
> Hi Rik,
>=20
> On Thu, 22 Aug 2019 at 04:18, Rik van Riel <riel@surriel.com> wrote:
> > The runnable_load magic is used to quickly propagate information
> > about
> > runnable tasks up the hierarchy of runqueues. The runnable_load_avg
> > is
> > mostly used for the load balancing code, which only examines the
> > value at
> > the root cfs_rq.
> >=20
> > Redefine the root cfs_rq runnable_load_avg to be the sum of
> > task_h_loads
> > of the runnable tasks. This works because the hierarchical
> > runnable_load of
> > a task is already equal to the task_se_h_load today. This provides
> > enough
> > information to the load balancer.
> >=20
> > The runnable_load_avg of the cgroup cfs_rqs does not appear to be
> > used for anything, so don't bother calculating those.
> >=20
> > This removes one of the things that the code currently traverses
> > the
> > cgroup hierarchy for, and getting rid of it brings us one step
> > closer
> > to a flat runqueue for the CPU controller.
>=20
> I like your proposal but just wanted to clarify one thing with this
> patch.
> Although you removed the computation of runnable_load_avg of the
> cgroup cfs_rq, we are still traversing the hierarchy to update the
> root cfs_rq runnable_load_avg because we are traversing the hierarchy
> for computing the task_h_loads

The task_h_load hierarchy traversal in update_cfs_rq_h_load
is rate limited to once a jiffy, though.  Rate limiting the
hierarchy traversal significantly reduces overhead.

> That being said, if we manage to remove the need on using
> runnable_load_avg we will completely skip this traversal. I have a
> proposal to remove it from load balance and wake up path but i
> haven't
> look at numa stats which also use it

--=20
All Rights Reversed.

--=-/JNyIUHGgxPk9J2Mpf6W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1mlBQACgkQznnekoTE
3oOFkQf/bkexA5aKlLDWB+jCZChFVrZFJHgookxSOQ7SrsAze5zYeir8BRCJDEyE
60uxGiByPBTetwFYRexQKM7Q83Ny3QXB03gv3LYqzYI2sLYwDR+zl6C8eDZvOcLc
GYfbaNHj5gV0JoZ8i4BCg4pNzRTxOtVLLdcWBTCRi+TFiVLd2O5IZL0A1spmFoyc
mu+b7HwyRbbTp2qp9PJZNL7x1uyj/kDl9+Ofnti6VDEfHCrBA6PwvQ0DtFYT5/lA
5jjs3lXis3opt50pMytwN2FTN6G2FXV/kaWBkYwDDMe4uVXB4J1XG322o/NGlxJA
IadW9EJLhydE3ey+pofu8w4qM73gNA==
=g1cO
-----END PGP SIGNATURE-----

--=-/JNyIUHGgxPk9J2Mpf6W--

