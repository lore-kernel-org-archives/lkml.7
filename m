Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA56AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3113206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfHXAFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:05:32 -0400
Received: from shelob.surriel.com ([96.67.55.147]:47754 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfHXAFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:05:32 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1i1JYW-0006O7-Np; Fri, 23 Aug 2019 20:05:20 -0400
Message-ID: <bd5caa4e0b49932b331ef405606bd344d474d911.camel@surriel.com>
Subject: Re: [PATCH 01/15] sched: introduce task_se_h_load helper
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, pjt@google.com, peterz@infradead.org,
        mingo@redhat.com, morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org,
        Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 23 Aug 2019 20:05:20 -0400
In-Reply-To: <c5c07c34-b46a-6956-2341-138a83c8c800@arm.com>
References: <20190822021740.15554-1-riel@surriel.com>
         <20190822021740.15554-2-riel@surriel.com>
         <c5c07c34-b46a-6956-2341-138a83c8c800@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ovuaKW0zKV5343Vj/qL9"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ovuaKW0zKV5343Vj/qL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-23 at 20:13 +0200, Dietmar Eggemann wrote:
>=20
>=20
> > @@ -1668,7 +1668,7 @@ static void task_numa_compare(struct
> > task_numa_env *env,
> >  	/*
> >  	 * In the overloaded case, try and keep the load balanced.
> >  	 */
> > -	load =3D task_h_load(env->p) - task_h_load(cur);
> > +	load =3D task_se_h_load(env->p->se) - task_se_h_load(cur->se);
>=20
> Shouldn't this be:
>=20
> load =3D task_se_h_load(&env->p->se) - task_se_h_load(&cur->se);

Yes indeed. Sorry I forgot to fix these after you
pointed them out last time.

They are now fixed in my tree.

--=20
All Rights Reversed.

--=-ovuaKW0zKV5343Vj/qL9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl1gf0AACgkQznnekoTE
3oNblAf/TUkLI0IYVU1co9vxIXAYxGuxm3QQCMs+oEhN6ex7MWJZWy0DL6p2Sb3M
gODE4zj3+C8OhNfdGcqhQf+0uO0AQfI1sZ+sEU7dOZgMZUUJQRDwsB0adCeuV6eK
qZoIBzUGbZdpVjx41wm156EWf/HajyXogGWnSNvsjAyGVVW/0pFmP3P51f1TEul4
a8SRQ/h3Swv3478G7M8042NYgmnQQSywYMk6ntUmnnB+z/QcR9BhX83UxmU9RK5S
/dF3lyYu8UMEGg3MGt9o6sk0dTVv0EjfrUXbyaSnCCcsb4+TmoVffWoIvE3q/GKn
kzwnz5bf17OcpHSE+nxxXAyg/CZTWA==
=d4I0
-----END PGP SIGNATURE-----

--=-ovuaKW0zKV5343Vj/qL9--

