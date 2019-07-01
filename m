Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8BDC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D492020665
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfGAUxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:53:45 -0400
Received: from shelob.surriel.com ([96.67.55.147]:46210 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:53:45 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hi3Iv-0000qT-P3; Mon, 01 Jul 2019 16:53:37 -0400
Message-ID: <402b70ecb4d362ab6975b00a715872d585a18e35.camel@surriel.com>
Subject: Re: [PATCH 09/10] sched,fair: add helper functions for flattened
 runqueue
From:   Rik van Riel <riel@surriel.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Date:   Mon, 01 Jul 2019 16:53:37 -0400
In-Reply-To: <20190701202030.6sm7mdztyt6t5mui@macbook-pro-91.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
         <20190628204913.10287-10-riel@surriel.com>
         <20190701202030.6sm7mdztyt6t5mui@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/fJqEuLegJr6SIMQrnRg"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/fJqEuLegJr6SIMQrnRg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-01 at 16:20 -0400, Josef Bacik wrote:
>=20
>=20
> > +static unsigned long task_se_h_weight(struct sched_entity *se)
> > +{
> > +	struct cfs_rq *cfs_rq;
> > +
> > +	if (!task_se_in_cgroup(se))
> > +		return se->load.weight;
> > +
> > +	cfs_rq =3D group_cfs_rq_of_parent(se);
> > +	update_cfs_rq_h_load(cfs_rq);
> > +
> > +	/* Reduce the load.weight by the h_load of the group the task
> > is in. */
> > +	return (cfs_rq->h_load * se->load.weight) >>
> > SCHED_FIXEDPOINT_SHIFT;
>=20
> This should be
>=20
> scale_load_down(cfs_rq->h_load * se->load.weight);

That may be the same mathematically, but it is
different conceptually.

If we convert CFS to have full load resolution with
cgroups (which we probably want), then scale_load_down
becomes a noop, while this shift continues doing the
right thing.

--=20
All Rights Reversed.

--=-/fJqEuLegJr6SIMQrnRg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0actEACgkQznnekoTE
3oPlkgf/Uujb+s6pe36le/hbVdu/UijyO1aWgMjnXeAkjye8C3yuFErAVkwzJBW0
0sOawT1lubaA+ImmD6Bl77UI8zwvldxaRCUs8RE/ESb8wf73bmuUrwpzfoGlOpb3
tcSvCY5N+gJtrZGZxHLUQBR64uUcq0QUigfxBcTrc6RNXw+ZkixRkjukn0/poFOx
MQYP/Ks4QgNP0L0LF3V4bgiua/pLiXtMVni2rEPD5JeF+NfEGi88jpoR9As+3Iy8
gNuHzPkMVJQ2yx6NHAyKtDvzXM7zGYp7pzbw5Kk0ZPQb3sR08pdkc1BwjJRVa9U9
VMls7LdN4imt1/L1pYA1UGC3lbM95w==
=ujDc
-----END PGP SIGNATURE-----

--=-/fJqEuLegJr6SIMQrnRg--

