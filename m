Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92487C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764E12147A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfE0QYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:24:12 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52766 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfE0QYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:24:12 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hVIPw-0002KK-32; Mon, 27 May 2019 12:24:08 -0400
Message-ID: <686351aab73911569a7c22a7e104d1b9f0d579b9.camel@surriel.com>
Subject: Re: [PATCH 7/7] sched/fair: Rename weighted_cpuload() to cpu_load()
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 May 2019 12:24:07 -0400
In-Reply-To: <20190527062116.11512-8-dietmar.eggemann@arm.com>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
         <20190527062116.11512-8-dietmar.eggemann@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1BIZliyhtxK7tTR1Ish4"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1BIZliyhtxK7tTR1Ish4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-05-27 at 07:21 +0100, Dietmar Eggemann wrote:
> This is done to align the per cpu (i.e. per rq) load with the util
> counterpart (cpu_util(int cpu)). The term 'weighted' is not needed
> since there is no 'unweighted' load to distinguish it from.

I can see why you want to make cpu_util() and cpu_load()
have the same parameter, but ...

> @@ -7931,7 +7928,7 @@ static inline void update_sg_lb_stats(struct
> lb_env *env,
>  		if ((env->flags & LBF_NOHZ_STATS) &&
> update_nohz_stats(rq, false))
>  			env->flags |=3D LBF_NOHZ_AGAIN;
> =20
> -		sgs->group_load +=3D weighted_cpuload(rq);
> +		sgs->group_load +=3D cpu_load(i);
>  		sgs->group_util +=3D cpu_util(i);
>  		sgs->sum_nr_running +=3D rq->cfs.h_nr_running;

... now we end up dereferencing cpu_rq(cpu) 3 times.

I guess per-cpu variables are so cheap that we should
never notice, but I thought I'd ask anyway while looking
over these patches :)

Thank you for removing a bunch of code that slowed down
my understanding of fair.c

--=20
All Rights Reversed.

--=-1BIZliyhtxK7tTR1Ish4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlzsDycACgkQznnekoTE
3oPOgAgAo1RMB85AKGO4kRE5mqnTAEqZ4XsVpWt82sdgqnEcRfcIBT65E2hnuNqL
I0bYLuK6CRgrVP2gM9aScBzjznLoTvuxnss0zN3N/MCeOzkn4Ab58om5ojLD61aq
WMW21wl0Hulm9Svwn/ZpN+KRPbdZrFpttcb7SdSIFVUvXz4g0YAe2kBlZ+8kfLp9
7oXe6JGAOLtQDx+Z2LNZhZHfQVP+VgCLmtCFbE95bS8bvz86dnCJ1Dl5ULphULN3
hMgeqGedAFgYX/CJgZoXhKWlox14pCA4ozeyKRiKhos5Uai/McBZkYr76W4FCtwY
5GfOV8IzhoqIsfoKPXf0bBWKBAR/1A==
=+DUJ
-----END PGP SIGNATURE-----

--=-1BIZliyhtxK7tTR1Ish4--

