Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C780C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DAB20665
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGAU6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:58:44 -0400
Received: from shelob.surriel.com ([96.67.55.147]:46240 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:58:44 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hi3Nq-0000rp-5Q; Mon, 01 Jul 2019 16:58:42 -0400
Message-ID: <5c59793c664eebfa872f9d5a99346fc6e1c68c7f.camel@surriel.com>
Subject: Re: [PATCH 10/10] sched,fair: flatten hierarchical runqueues
From:   Rik van Riel <riel@surriel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Mon, 01 Jul 2019 16:58:41 -0400
In-Reply-To: <20190701203407.4fmsavivebyrocmw@macbook-pro-91.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
         <20190628204913.10287-11-riel@surriel.com>
         <20190701203407.4fmsavivebyrocmw@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-77hZSnIfn9K8Hz5GpItv"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-77hZSnIfn9K8Hz5GpItv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-01 at 16:34 -0400, Josef Bacik wrote:
> On Fri, Jun 28, 2019 at 04:49:13PM -0400, Rik van Riel wrote:
> > @@ -2703,16 +2716,28 @@ static inline void
> > update_scan_period(struct task_struct *p, int new_cpu)
> >  static void
> >  account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity
> > *se)
> >  {
> > -	update_load_add(&cfs_rq->load, se->load.weight);
> > -	if (!parent_entity(se))
> > +	struct rq *rq;
> > +
> > +	if (task_se_in_cgroup(se)) {
> > +		struct cfs_rq *cgroup_rq =3D group_cfs_rq_of_parent(se);
> > +		unsigned long h_weight;
> > +
> > +		update_load_add(&cgroup_rq->load, se->load.weight);
> > +		cgroup_rq->nr_running++;
> > +
> > +		/* Add the hierarchical weight to the CPU rq */
> > +		h_weight =3D task_se_h_weight(se);
> > +		se->enqueued_h_weight =3D h_weight;
> > +		update_load_add(&rq_of(cfs_rq)->load, h_weight);
>=20
> Ok I think this is where we need to handle the newly enqueued se's
> potential
> weight.  Right now task_se_h_weight() is based on it's weight _and_
> its load.
> So it's really it's task_se_h_weighted_load_avg, and not really
> task_se_h_weight, right?  Instead we should separate these two things
> out, one
> gives us our heirarchal load, and one that gives us our heirarchal
> weight based
> purely on the ratio of (our weight) / (total se weight on
> parent).  Then we can
> take this number and max it with the heirarchal load avg and use that
> with the
> update_load_add.  Does that make sense?  Thanks,

Yes, I think that makes sense.

The hierarchical group weights can be computed periodically,
in the same way the hierarchical group load averages are.

We may still end up with stale values occasionally, if the
values were already computed the same jiffy, or when the
values of another group (with a shared parent) have not been
propagated up yet, but things should converge relatively
quickly.

It means update_cfs_rq_h_load() and update_blocked_averages()
will propagate both load averages and instantaneous weights,
which should be easy enough to add.

I'll give it a try!

--=20
All Rights Reversed.

--=-77hZSnIfn9K8Hz5GpItv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0adAEACgkQznnekoTE
3oPyTwf/RrUx1vQjfwdv+Ax1cHhIGTKW97RJS69sSLBWDdU//zMWTaPbSjX7b5Mo
U1nna3iqUFyTNJbO1yR2fRipEzHY6tTnGD1ox6mmvTVs2ICJMFhgAJyDFz/h5nPE
TzW1zFZakY7fp1WO7swWo7ZrpcRCDajk6LbUKKZAuhK/Ri5ealE3dF0renslL+71
PmTmQDVEf4OVxIF4Ag8cR05f12RjXOErCCAMG9hLhKfwW0GeecvJWY92fqsxw9C+
qB7+mvxjxk7uXi7dMJvhzGjKPSwXwG3RJ07DvvI6TXln59E7wV61eQF6THAIf5iz
2Xg1pKsAGu3d6gqjrDbgxPvI1V23Dw==
=cIGg
-----END PGP SIGNATURE-----

--=-77hZSnIfn9K8Hz5GpItv--

