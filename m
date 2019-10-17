Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39CFA3737
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D10521835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409258AbfJQK7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:59:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41679 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409238AbfJQK7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:59:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 092D6801B4; Thu, 17 Oct 2019 12:59:24 +0200 (CEST)
Date:   Thu, 17 Oct 2019 12:59:40 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 56/81] kernel/sysctl.c: do not override max_threads
 provided by userspace
Message-ID: <20191017105940.GA5966@amd>
References: <20191016214805.727399379@linuxfoundation.org>
 <20191016214842.621065901@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20191016214842.621065901@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Michal Hocko <mhocko@suse.com>
>=20
> commit b0f53dbc4bc4c371f38b14c391095a3bb8a0bb40 upstream.
>=20
> Partially revert 16db3d3f1170 ("kernel/sysctl.c: threads-max observe
> limits") because the patch is causing a regression to any workload which
> needs to override the auto-tuning of the limit provided by kernel.
>=20
> set_max_threads is implementing a boot time guesstimate to provide a
> sensible limit of the concurrently running threads so that runaways will
> not deplete all the memory.  This is a good thing in general but there
> are workloads which might need to increase this limit for an application
> to run (reportedly WebSpher MQ is affected) and that is simply not
> possible after the mentioned change.  It is also very dubious to
> override an admin decision by an estimation that doesn't have any direct
> relation to correctness of the kernel operation.
>=20
> Fix this by dropping set_max_threads from sysctl_max_threads so any
> value is accepted as long as it fits into MAX_THREADS which is important
> to check because allowing more threads could break internal robust futex
> restriction.  While at it, do not use MIN_THREADS as the lower boundary
> because it is also only a heuristic for automatic estimation and admin
> might have a good reason to stop new threads to be created even when
> below this limit.

Ok, why not, but I smell followup work could be done:

> @@ -2635,7 +2635,7 @@ int sysctl_max_threads(struct ctl_table
>  	if (ret || !write)
>  		return ret;
> =20
> -	set_max_threads(threads);
> +	max_threads =3D threads;
> =20

AFAICT set_max_threads can now become __init.

Plus, I don't see any locking here, should this be WRITE_ONCE() at
minimum?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXahJnAAKCRAw5/Bqldv6
8nnSAJ93EKfZiFpMOP6vxmg0xv4YDaJHZwCfSSzb0+Qy7cL+rT76+htVDXzStUw=
=uEos
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
