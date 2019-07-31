Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48B8C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FE8206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfGaPDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:03:15 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45606 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbfGaPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:03:15 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hsq85-0001Nv-Pn; Wed, 31 Jul 2019 11:03:01 -0400
Message-ID: <461f14cafabb7e6f78556f138b6aa619eff12dee.camel@surriel.com>
Subject: Re: [PATCH 09/14] sched,fair: refactor enqueue/dequeue_entity
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Wed, 31 Jul 2019 11:03:01 -0400
In-Reply-To: <20190731093525.GH31425@hirez.programming.kicks-ass.net>
References: <20190722173348.9241-1-riel@surriel.com>
         <20190722173348.9241-10-riel@surriel.com>
         <20190730093617.GV31398@hirez.programming.kicks-ass.net>
         <20190731093525.GH31425@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oXa4WWI8f1hjsu/vRrww"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oXa4WWI8f1hjsu/vRrww
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 11:35 +0200, Peter Zijlstra wrote:
> On Tue, Jul 30, 2019 at 11:36:17AM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 22, 2019 at 01:33:43PM -0400, Rik van Riel wrote:
> > > +static bool
> > > +enqueue_entity_groups(struct cfs_rq *cfs_rq, struct sched_entity
> > > *se, int flags)
> > > +{
> > > +	/*
> > > +	 * When enqueuing a sched_entity, we must:
> > > +	 *   - Update loads to have both entity and cfs_rq synced with
> > > now.
> > > +	 *   - Add its load to cfs_rq->runnable_avg
> > > +	 *   - For group_entity, update its weight to reflect the new
> > > share of
> > > +	 *     its group cfs_rq
> > > +	 *   - Add its new weight to cfs_rq->load.weight
> > > +	 */
> > > +	if (!update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH))
> > > +		return false;
> > > +
> > > +	update_cfs_group(se);
> > > +	return true;
> > > +}
> > No functional, but you did make update_cfs_group() conditional. Now
> > that
> > looks OK, but maybe you can do that part in a separate patch with a
> > little justification of its own.
>=20
> To record (and extend) our discussion from IRC yesterday; I now do
> think
> the above is in fact a problem.
>=20
> The thing is that update_cfs_group() does not soly rely on the tg
> state;
> it also contains magic to deal with ramp up; for which you later
> introduce that max_h_load thing.
>=20
> Specifically (re)read the second part of the comment describing
> calc_group_shares() where it explains the ramp up:
>=20
>  * The problem with it is that because the average is slow -- it was
> designed
>  * to be exactly that of course -- this leads to transients in
> boundary
>  * conditions. In specific, the case where the group was idle and we
> start the
>  * one task. It takes time for our CPU's grq->avg.load_avg to build
> up,
>  * yielding bad latency etc..
>=20
>  (and further)
>=20
> So by not always calling this (and not updating h_load) you fail to
> take
> advantage of this.
>=20
> So I would suggest keeping update_cfs_group() unconditional, and
> recomputing the h_load for the entire hierarchy on enqueue.

I think I understand the problem you are pointing
out, but if update_load_avg() keeps the load average
for the runqueue unchanged (because that is rate limited
to once a jiffy, and has been like that for a while),
why would calc_group_shares() result in a different value
than what it returned the last time?

What am I overlooking?

--=20
All Rights Reversed.

--=-oXa4WWI8f1hjsu/vRrww
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1BraUACgkQznnekoTE
3oOxoAgAwFOZGyaVohHl1N71K7Sxs/txPqDCXWskwEsXf2FP2a74KXGMDifkyUR9
otdJ/c+UvL5e3rXRdLEjoJMvvuMRSITTY8Y95bysxnFpiChBBfmEfkR0+UWzqmmH
rl+crbatn0Kh6HdENMtGfP2A2lyNApY2q42o1MB2oC0ktYFvIgtqR2z/WXpLMwEl
ltg3zt35OaMAYQZ1JbpU2aHQdqW1IAqUwbwBWdp2w+hq3fNehLMhzazTGM2OvQp5
+nChB75ZAHHJcW0Dfs9WSU1HFT3q9nlEgS7/zTvhss6nh366eww5YRIjKxrAZqxQ
Ks33MF8l9r9OXxlmjdxvygwxEvJe7g==
=l4Jy
-----END PGP SIGNATURE-----

--=-oXa4WWI8f1hjsu/vRrww--

