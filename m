Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10899C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E569520731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgAFPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:48:05 -0500
Received: from shelob.surriel.com ([96.67.55.147]:39764 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgAFPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:48:04 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ioUbN-0004jZ-Uy; Mon, 06 Jan 2020 10:47:33 -0500
Message-ID: <04033a63f11a9c59ebd2b099355915e4e889b772.camel@surriel.com>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v3
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 06 Jan 2020 10:47:18 -0500
In-Reply-To: <20200106144250.GA3466@techsingularity.net>
References: <20200106144250.GA3466@techsingularity.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XpltXy3SHHbmr7nTgcUV"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XpltXy3SHHbmr7nTgcUV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-06 at 14:42 +0000, Mel Gorman wrote:
>=20
> +
> +		/* Consider allowing a small imbalance between NUMA
> groups */
> +		if (env->sd->flags & SD_NUMA) {
> +			long imbalance_adj, imbalance_max;
> +
> +			/*
> +			 * imbalance_adj is the allowable degree of
> imbalance
> +			 * to exist between two NUMA domains.
> imbalance_pct
> +			 * is used to estimate the number of active
> tasks
> +			 * needed before memory bandwidth may be as
> important
> +			 * as memory locality.
> +			 */
> +			imbalance_adj =3D (100 / (env->sd->imbalance_pct
> - 100)) - 1;
> +
> +			/*
> +			 * Allow small imbalances when the busiest
> group has
> +			 * low utilisation.
> +			 */
> +			imbalance_max =3D imbalance_adj << 1;
> +			if (busiest->sum_nr_running < imbalance_max)
> +				env->imbalance -=3D min(env->imbalance,
> imbalance_adj);
> +		}
> +

Wait, so imbalance_max is a function only of
env->sd->imbalance_pct, and it gets compared
against busiest->sum_nr_running, which is related
to the number of CPUs in the node?

Lets see how this works out for different numbers
of CPUs in each node.

With imbalance_pct =3D=3D 115, we end up with=20
imbalance_adj =3D (100 / (115 - 100)) - 1 =3D 0.18,
which gets rounded down to 0.

Wait, never mind the different numbers of CPUs.

Am I overlooking something, or did you mean to have
a factor of number of CPUs in the imbalance_adj
calculation?

kind regards,

Rik
--=20
All Rights Reversed.

--=-XpltXy3SHHbmr7nTgcUV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl4TVoYACgkQznnekoTE
3oO5jggAuwBm1TeNZZs6lr/gw6VXGYhwcDrj2jR/XCVM1gStkxH7jbCC70zYWZVS
rUepu2W6da/d96+wtwjgXQ34zGy7Gwg+hWZ7d13Cv4+xk2YtXzpsG/1Nrn2hMpYt
zdBwdf0xSF8PKLmuK6PM1dIHZkVKnuvVcqLfCkW4dBFnZixw4Srdi6kD709xQuJF
S9rAzxFVFdIxfhEm8oYYT4aVkEtFLVME/bzVpmBbtIlOBGJzYpnIrhZFOgv9FDgi
D2HCJg18d2bqGu/z/U6nEN6dPl18KFh2IA8niW7dutIAGbpwr3CTDRTQe6QElzqP
037MA6M7nCsJo9Bj7QpKKArznPks4g==
=ew2e
-----END PGP SIGNATURE-----

--=-XpltXy3SHHbmr7nTgcUV--

