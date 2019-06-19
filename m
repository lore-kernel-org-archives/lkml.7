Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C550C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D53FE205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbfFSN5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:57:22 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56634 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFSN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:57:22 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hdb5P-0001OE-GR; Wed, 19 Jun 2019 09:57:15 -0400
Message-ID: <c8c3a78884be6c1b3a5e0984750ed8968230c976.camel@surriel.com>
Subject: Re: [PATCH 1/8] sched: introduce task_se_h_load helper
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        dietmar.eggeman@arm.com, mgorman@techsingularity.com,
        vincent.guittot@linaro.org
Date:   Wed, 19 Jun 2019 09:57:14 -0400
In-Reply-To: <55d914d2-fba2-48c0-e7ff-3c7337c8cf8e@arm.com>
References: <20190612193227.993-1-riel@surriel.com>
         <20190612193227.993-2-riel@surriel.com>
         <55d914d2-fba2-48c0-e7ff-3c7337c8cf8e@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oEUOPJ5dbVg088eTgini"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oEUOPJ5dbVg088eTgini
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-19 at 14:52 +0200, Dietmar Eggemann wrote:

> > @@ -7833,14 +7834,19 @@ static void update_cfs_rq_h_load(struct
> > cfs_rq *cfs_rq)
> >  	}
> >  }
> > =20
> > -static unsigned long task_h_load(struct task_struct *p)
> > +static unsigned long task_se_h_load(struct sched_entity *se)
> >  {
> > -	struct cfs_rq *cfs_rq =3D task_cfs_rq(p);
> > +	struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> > =20
> >  	update_cfs_rq_h_load(cfs_rq);
> > -	return div64_ul(p->se.avg.load_avg * cfs_rq->h_load,
> > +	return div64_ul(se->avg.load_avg * cfs_rq->h_load,
> >  			cfs_rq_load_avg(cfs_rq) + 1);
> >  }
>=20
> I wonder if this is necessary. I placed a BUG_ON(!entity_is_task(se))
> into task_se_h_load() after I applied the whole patch-set and ran
> some
> taskgroup related testcases. It didn't hit.
>=20
> So why not use task_h_load(task_of(se)) instead?
>=20
> [...]

That would work, but task_h_load then dereferences
task->se to get the se->avg.load_avg value.

Going back to task from the se, only to then get the
se from the task seems a little unnecessary :)

Can you explain why you think task_h_load(task_of(se))
would be better? I think I may be overlooking something.

--=20
All Rights Reversed.

--=-oEUOPJ5dbVg088eTgini
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0KPzsACgkQznnekoTE
3oPx1ggAjy93qmakRLrYS2CAJyHGDnZX81xCQXR5YGmPKVmQ85rNmNBNAapP5FHC
UgRLZmPB1b8bA3gze3yiWeY/s6LLwvIa+LVXbxnhCnsWxATyRsbPOmtgcf1fpJ9+
rcWSAtCUxIMWUQcxcxHcHIyGdkaMfU0TYg45vB6D02tRuCMv+pRbzYNtEt05GWDH
iUlm7OtMlWaII43pad7U74QBsHr+2NCnsGxaf6e+9YL8lLDtxDfN4HJaN3qyomhD
Qawcf1ob6itUfqEbZ5HZZdQq2ha4D7cKplwwq88S0cqhN4Ow/rCLHnKkTFPUtfE0
avSSxATac/ldps74Pmd6dXTJY1WUew==
=gXED
-----END PGP SIGNATURE-----

--=-oEUOPJ5dbVg088eTgini--

