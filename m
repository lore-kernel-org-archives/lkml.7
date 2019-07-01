Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB0EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEE721850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfGAQrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:47:40 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45478 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfGAQrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:47:39 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hhzSp-0002F2-Iy; Mon, 01 Jul 2019 12:47:35 -0400
Message-ID: <757e0af14b714b596417b31c45098fc314ed7c8a.camel@surriel.com>
Subject: Re: [PATCH 03/10] sched,fair: redefine runnable_load_avg as the sum
 of task_h_load
From:   Rik van Riel <riel@surriel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Mon, 01 Jul 2019 12:47:35 -0400
In-Reply-To: <20190701162949.vhxjndychoamhkbq@MacBook-Pro-91.local.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
         <20190628204913.10287-4-riel@surriel.com>
         <20190701162949.vhxjndychoamhkbq@MacBook-Pro-91.local.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LsEV3kwy4f1vt8PWed1f"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LsEV3kwy4f1vt8PWed1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-01 at 12:29 -0400, Josef Bacik wrote:
> On Fri, Jun 28, 2019 at 04:49:06PM -0400, Rik van Riel wrote:
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
> >=20
>=20
> My memory on this stuff is very hazy, but IIRC we had the
> runnable_sum and the
> runnable_avg separated out because you could have the avg lag behind
> the sum.
> So like you enqueue a bunch of new entities who's avg may have
> decayed a bunch
> and so their overall load is not felt on the CPU until they start
> running, and
> now you've overloaded that CPU.  The sum was there to make sure new
> things
> coming onto the CPU added actual load to the queue instead of looking
> like there
> was no load.
>=20
> Is this going to be a problem now with this new code?

That is a good question!

On the one hand, you may well be right.

On the other hand, while I see the old code calculating
runnable_sum, I don't really see it _using_ it to drive
scheduling decisions.

It would be easy to define the CPU cfs_rq->runnable_load_sum
as being the sum of task_se_h_weight() of each runnable task
on the CPU (for example), but what would we use it for?

What am I missing?

> +static inline void
> > +update_runnable_load_avg(struct sched_entity *se)
> > +{
> > +	struct cfs_rq *root_cfs_rq =3D &cfs_rq_of(se)->rq->cfs;
> > +	long new_h_load, delta;
> > +
> > +	SCHED_WARN_ON(!entity_is_task(se));
> > +
> > +	if (!se->on_rq)
> > +		return;
> > =20
> > -	sub_positive(&cfs_rq->avg.runnable_load_avg, se-
> > >avg.runnable_load_avg);
> > -	sub_positive(&cfs_rq->avg.runnable_load_sum,
> > -		     se_runnable(se) * se->avg.runnable_load_sum);
> > +	new_h_load =3D task_se_h_load(se);
> > +	delta =3D new_h_load - se->enqueued_h_load;
> > +	root_cfs_rq->avg.runnable_load_avg +=3D delta;
>=20
> Should we use add_positive here?  Thanks,

Yes, we should use add_positive. I'll do that for v3.

--=20
All Rights Reversed.

--=-LsEV3kwy4f1vt8PWed1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0aOScACgkQznnekoTE
3oOC/QgAvPy+QlS5LkGPg4zE7GCmuXk3495qcGgnIimci49/vXyRgHiFAkVEPXb4
jhtq95LUNfWsz6R3LzGuZP5fYha2RTT8UrEdud/N5m8a6AVgrtos+lToH419vAzH
1QDVAeVYC0oFvz9f9/8FNw7Ru3jifngiYgkZr00u6KKgfJdBSQSotr6RrajcwzL0
4pZJRM8WAG/Eq3x90JEu1bO/zUTPHreFMdkolLauEkEDfWKxDcjDO56oBJ72itmr
o8eumf01O4bhK817LtyCg2+Pe9FYWgKzngBjG5xisHVHlEf49WlqIwX5gISMADCT
VZHvWNom+ybXGEPBqpnjVG52gf+3WA==
=SBp6
-----END PGP SIGNATURE-----

--=-LsEV3kwy4f1vt8PWed1f--

